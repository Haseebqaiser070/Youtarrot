import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ok_tarrot/controllers/ad_controller.dart';
import 'package:ok_tarrot/models/card_model.dart';
import 'package:ok_tarrot/models/combination_model.dart';
import 'package:ok_tarrot/services/fetch_data.dart';
import 'package:ok_tarrot/widgets/app_cached_image.dart';
import 'package:ok_tarrot/widgets/app_text.dart';

import '../constants/app_spacing.dart';

class CardsCombinationView extends StatefulWidget {
  const CardsCombinationView({
    Key? key,
  }) : super(key: key);

  @override
  State<CardsCombinationView> createState() => _CardsCombinationViewState();
}

class _CardsCombinationViewState extends State<CardsCombinationView> {
  final AdController _adController = AdController();
  Box box = Hive.box("cards");
  final FetchData _fetchData = FetchData();
  List<CombinationModel> combinationModel = [];
  bool isLoading = false;
  getCombination() async {
    setState(() {
      isLoading = true;
    });
    await AdController().showRewardedAd();
    List ids = box.get("cardsIds");
    await _adController.showRewardedAd();
    await _fetchData.getCombination();
    List cardsList = ids
        .where(
          (element) => element.toString() != "",
        )
        .toList();

    var list = _fetchData.allCombinations.where(
      (element) {
        if (cardsList.length == 2) {
          return (element.card1 == ids[0].toString() && element.card2 == ids[1].toString());
        } else if (cardsList.length == 3) {
          return (element.card1 == ids[0].toString() && element.card2 == ids[1].toString() || element.card1 == ids[1].toString() && element.card2 == ids[2].toString());
        } else {
          return false;
        }
      },
    ).toList();

    if (list.isNotEmpty) {
      combinationModel = list;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCombination();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List ids = box.get("cardsIds");
    List cardId = ids
        .where(
          (e) => e != "",
        )
        .toList();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xff151515),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff151515),
            const Color(0xff9DADDF).withOpacity(0.4),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: AppSpacing.defaultPadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.heightSpace20,
                  Center(
                    child: AppText(
                      text: "tarrot_cards".tr,
                      fontWeight: FontWeight.w500,
                      fontSize: 34,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  AppSpacing.heightSpace30,
                  Center(
                    child: Wrap(
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        cardId.length,
                        (index) => FutureBuilder<CardModel>(
                          future: _fetchData.getCardData(
                            cardId[index],
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return AppCachedImage(
                                url: snapshot.data!.cardImage.toString(),
                                height: 170,
                                width: 110,
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.heightSpace30,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      cardId.length,
                      (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<CardModel>(
                            future: _fetchData.getCardData(
                              cardId[index],
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: "${index + 1}. ${snapshot.data!.cardName}",
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    AppText(
                                      text: "${snapshot.data!.description}",
                                    ),
                                    AppSpacing.heightSpace10,
                                  ],
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.heightSpace10,
                  isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            combinationModel.length,
                            (index) {
                              return AppText(
                                text: combinationModel[index].message ?? "",
                                fontSize: 17,
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
