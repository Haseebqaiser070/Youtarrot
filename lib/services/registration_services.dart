import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ok_tarrot/main.dart';
import 'package:ok_tarrot/utils/app_snackbar.dart';
import 'package:ok_tarrot/views/main_views/subscription_views/profile_view.dart';

import '../views/main_views/homepage.dart';
import '../views/main_views/registration_screens/password_changed.dart';

class RegistrationServices {
  final fireStore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final fbStorage = FirebaseStorage.instance;
  register({
    required String userName,
    required String email,
    required String password,
  }) async {
    await fireStore
        .collection("users")
        .where(
          "email",
          isEqualTo: email,
        )
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        await auth
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((user) {
          fireStore.collection("users").doc(user.user!.uid).set({
            "id": user.user!.uid,
            "email": email,
            "name": userName,
            'created_at': DateTime.now().toString(),
            'gender': "",
            'phone_number': "",
            'profile_picture': "",
            'updated': "",
            'diabled': false,
          }).then((val) async {
            await auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
              AppSnackbar.snackBar(title: "Message", message: "Profile has been created successfully!");
              box.put("isLoaggedIn", true);
              Get.offAll(() => const Homepage());
            });
            await fireStore.collection("users").doc(user.user!.uid).get().then((doc) {
              box.put("userData", doc.data());
            });
          });
        }).catchError((err) {
          AppSnackbar.snackBar(
            title: "Error",
            message: err.toString(),
          );
        });
      } else {
        AppSnackbar.snackBar(title: "Message", message: "User has already registered!");
      }
    }).catchError((err) {
      AppSnackbar.snackBar(
        title: "Error",
        message: err.toString(),
      );
    });
  }

  login({
    required String email,
    required String password,
  }) async {
    await auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      box.put("isLoggedIn", true);
      AppSnackbar.snackBar(title: "Message", message: "Logged In successfully!");
      Get.offAll(
        () => const Homepage(),
      );
      await fireStore.collection("users").doc(value.user!.uid).get().then((value) {
        box.put("userData", value.data());
      });
    }).catchError((err) {
      AppSnackbar.snackBar(
        title: "Error",
        message: err.toString(),
      );
    });
  }

  forgetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      Get.offAll(
        () => const PasswordChanged(),
      );
    } catch (err) {
      AppSnackbar.snackBar(
        title: "Error",
        message: err.toString(),
      );
    }
  }

  updateProfile({
    required String userName,
    required String email,
    required String gender,
    required String phoneNumber,
    File? profile,
    required String picUrl,
    required String id,
    required String phoneCode,
    required String phoneCountry,
  }) async {
    String url = picUrl;
    if (profile != null) {
      await fbStorage.ref("users").child(id).putFile(profile).then((p0) async {
        url = await p0.ref.getDownloadURL();
      }).catchError((err) {
        debugPrint("Storage Error=> $err");
        AppSnackbar.snackBar(
          title: "Error",
          message: err.toString(),
        );
      });
    }
    await fireStore.collection("users").doc(id).set(
      {
        "id": id,
        "email": email,
        "name": userName,
        'gender': gender,
        'phone_number': phoneNumber,
        "phoneCode": phoneCode,
        "phone_country": phoneCountry,
        'profile_picture': url,
        'updated': DateTime.now().toString(),
        'diabled': false,
      },
      SetOptions(
        merge: true,
      ),
    ).then((value) async {
      await fireStore.collection("users").doc(id).get().then((doc) async {
        box.put("userData", doc.data());

        AppSnackbar.snackBar(title: "Message", message: "Profile has been updated successfully!");
        Get.off(
          () => const ProfileView(),
        );
      });
    }).catchError((err) {
      AppSnackbar.snackBar(
        title: "Error",
        message: err.toString(),
      );
      debugPrint("data Error=> $err");
    });
  }

  GoogleSignIn googleSignIn = GoogleSignIn();
  googleLogin() async {
    await googleSignIn.signOut();
    await googleSignIn.signIn().then((doc) async {
      var signInAuthentication = await doc!.authentication;
      var credential = GoogleAuthProvider.credential(
        accessToken: signInAuthentication.accessToken,
        idToken: signInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential).then((user) async {
        await fireStore.collection("users").where("email", isEqualTo: user.user!.email).get().then((value) async {
          if (value.docs.isEmpty) {
            await fireStore.collection("users").doc(user.user!.uid).set({
              "id": user.user!.uid,
              "email": doc.email,
              "name": doc.displayName,
              'created_at': DateTime.now().toString(),
              'gender': "",
              'phone_number': "",
              'profile_picture': doc.photoUrl,
              'updated': "",
              'diabled': false,
            }).then((val) async {
              await fireStore.collection("users").doc(user.user!.uid).get().then((doc) {
                box.put("userData", doc.data());
                AppSnackbar.snackBar(title: "Message", message: "Profile has been created successfully!");
                box.put("isLoaggedIn", true);
                Get.offAll(() => const Homepage());
              });
            });
          } else {
            await fireStore.collection("users").doc(user.user!.uid).get().then((doc) {
              box.put("userData", doc.data());
              AppSnackbar.snackBar(title: "Message", message: "Profile has been created successfully!");
              box.put("isLoaggedIn", true);
              Get.offAll(() => const Homepage());
            });
          }
        });
      }).catchError((err) {
        AppSnackbar.snackBar(
          title: "Error",
          message: err.toString(),
        );
        googleSignIn.signOut();
      });
    }).catchError((err) {
      AppSnackbar.snackBar(
        title: "Error",
        message: err.toString(),
      );
    });
  }
}
