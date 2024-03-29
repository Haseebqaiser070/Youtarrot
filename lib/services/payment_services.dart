import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ok_tarrot/utils/app_snackbar.dart';

import '../main.dart';
import '../models/user_model.dart';

class PaymentServices {
  bool isDone = false;
  UserModel userData = UserModel();
  makePayment({
    required String cardNumber,
    required String month,
    required String year,
    required String cvc,
    required String amount,
    required String name,
  }) async {
    var stringMap = jsonEncode(box.get("userData"));
    userData = UserModel.fromMap(
      jsonDecode(stringMap),
    );
    var data = jsonEncode({
      "number": cardNumber,
      "month": month,
      "year": year,
      "cvc": cvc,
      "amount": (double.parse(amount) * 100).toInt(),
      'name': name,
    });

    await post(
      Uri.parse("https://us-central1-cardapp-96d5d.cloudfunctions.net/payNow"),
      headers: {'Content-Type': 'application/json'},
      body: data,
    ).then((value) async {
      var data = jsonDecode(value.body);
      if (data['result'] != null) {
        await FirebaseFirestore.instance.collection("subscriptions").add({
          "id": "",
          "createdOn": DateTime.now().toString(),
          "time": amount == "4.99" ? "monthly" : "yearly",
          "price": amount,
          "paymentId": data['result']['id'],
          "user": userData.id,
        }).then((value) {
          isDone = true;
          FirebaseFirestore.instance.collection("subscriptions").doc(value.id).update({"id": value.id});
        }).catchError((err) {
          AppSnackbar.snackBar(
            title: "Error",
            message: err.toString(),
          );
        });
      } else {
        debugPrint("Error is ${data['error']}");
        AppSnackbar.snackBar(
          title: "Error",
          message: data['error'].toString(),
        );
      }
    }).catchError((err) {
      debugPrint("Request Error $err");
    });
  }

  bool cancelled = false;
  cancelSubscription(String userId) async {
    await FirebaseFirestore.instance
        .collection("subscriptions")
        .where(
          "user",
          isEqualTo: userId,
        )
        .get()
        .then(
      (value) async {
        if (value.docs.isEmpty) {
          AppSnackbar.snackBar(title: "Message", message: "You are not subscribe to any offer yet!");
        } else {
          String paymentId = value.docs.first.data()["paymentId"].toString();
          String docId = value.docs.first.data()["id"].toString();
          await post(
            Uri.parse("https://us-central1-cardapp-96d5d.cloudfunctions.net/cancelPayment"),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode(
              {
                "paymentId": paymentId,
              },
            ),
          ).then((value) async {
            var data = jsonDecode(value.body);

            if (data['success'] != null && data['success']) {
              cancelled = true;
              await FirebaseFirestore.instance.collection("subscriptions").doc(docId).delete().then((value) {});

              AppSnackbar.snackBar(title: "Message", message: data['message'].toString());
            } else if (data['success'] != null && !data['success']) {
              AppSnackbar.snackBar(title: "Message", message: data['message'].toString());
            }
          });
        }
      },
    ).catchError((err) {
      debugPrint("Request Error $err");
    });
  }
}
