import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:ok_tarrot/models/card_model.dart';
import 'package:ok_tarrot/models/combination_model.dart';
import 'package:ok_tarrot/models/subscription_model.dart';
import 'package:ok_tarrot/models/tutorial_model.dart';
import 'package:ok_tarrot/utils/app_snackbar.dart';

class FetchData {
  List<TutorialModel> allTutorials = [];
  getAllTutorials() async {
    allTutorials.clear();
    try {
      await FirebaseFirestore.instance.collection("tutorials").orderBy("order").get().then(
        (value) {
          for (var i in value.docs) {
            allTutorials.add(
              TutorialModel.fromJson(
                i.data(),
              ),
            );
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.snackBar(
        title: "Error",
        message: e.toString(),
      );
    }
  }

  List<CardModel> allCards = [];
  getCards() async {
    allCards.clear();
    try {
      await FirebaseFirestore.instance.collection("cards").get().then(
        (value) {
          for (var i in value.docs) {
            allCards.add(
              CardModel.fromJson(
                i.data(),
              ),
            );
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.snackBar(
        title: "Error",
        message: e.toString(),
      );
    }
  }

  CardModel cardData = CardModel();
  Future<CardModel> getCardData(String id) async {
    try {
      await FirebaseFirestore.instance.collection("cards").doc(id).get().then(
        (value) {
          cardData = CardModel.fromJson(value.data()!);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
    return cardData;
  }

  List<CombinationModel> allCombinations = [];

  getCombination() async {
    allCombinations.clear();
    try {
      await FirebaseFirestore.instance.collection("combinations").get().then(
        (value) {
          for (var i in value.docs) {
            allCombinations.add(
              CombinationModel.fromJson(
                i.data(),
              ),
            );
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }

  SubscriptionModel subscriptionModel = SubscriptionModel();
  getSubscription(userId) async {
    await FirebaseFirestore.instance
        .collection("subscriptions")
        .where(
          "user",
          isEqualTo: userId,
        )
        .get()
        .then((value) {
      var data = value.docs.first.data();
      subscriptionModel = SubscriptionModel.fromJson(data);
    }).catchError((err) {
      debugPrint("Error getting subsctription $err");
    });
  }
}
