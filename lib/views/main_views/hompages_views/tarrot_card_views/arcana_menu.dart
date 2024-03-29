import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ok_tarrot/constants/app_spacing.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/tarrot_card_views/major_arcana/major_arcana_cards.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/tarrot_card_views/minor_arcana/minor_arcana_menu.dart';

import '../../../../models/card_model.dart';
import '../../../../services/fetch_data.dart';
import '../../../../widgets/app_text.dart';

class ArcanaMenu extends StatefulWidget {
  const ArcanaMenu({Key? key}) : super(key: key);

  @override
  State<ArcanaMenu> createState() => _ArcanaMenuState();
}

class _ArcanaMenuState extends State<ArcanaMenu> {
  final FetchData _fetchData = FetchData();
  List<CardModel> majorArcana = [];
  List<CardModel> minorArcana = [];
  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });
    await _fetchData.getCards();
    majorArcana = _fetchData.allCards
        .where(
          (element) => element.category!.toLowerCase().contains("major arcana"),
        )
        .toList();
    minorArcana = _fetchData.allCards
        .where(
          (element) => element.category!.toLowerCase().contains("minor arcana"),
        )
        .toList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xff151515),
        image: DecorationImage(
          image: AssetImage(
            "assets/images/card_result_bg.png",
          ),
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff151515),
            Color.fromARGB(162, 157, 174, 223),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: AppSpacing.defaultPadding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.heightSpace30,
                Center(
                  child: Image.asset(
                    "assets/images/splash_logo.png",
                    height: 150,
                    width: 150,
                  ),
                ),
                AppSpacing.heightSpace30,
                Center(
                  child: AppText(
                    text: "tarrot_cards".tr,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                  ),
                ),
                AppSpacing.heightSpace50,
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => MajorArcanaCards(
                                  majorArcana: majorArcana,
                                ),
                              );
                            },
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: AppText(
                                  text: "major_arcana".tr,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          AppSpacing.heightSpace30,
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => MinorArcanaMenu(
                                  minorArcana: minorArcana,
                                ),
                              );
                            },
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: AppText(
                                  text: "minor_arcana".tr,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
