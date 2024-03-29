import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ok_tarrot/constants/app_spacing.dart';
import 'package:ok_tarrot/models/card_model.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/tarrot_card_views/minor_arcana/minor_arcana_cards.dart';

import '../../../../../widgets/app_text.dart';

class MinorArcanaMenu extends StatefulWidget {
  final List<CardModel> minorArcana;
  const MinorArcanaMenu({
    Key? key,
    required this.minorArcana,
  }) : super(key: key);

  @override
  State<MinorArcanaMenu> createState() => _MinorArcanaMenuState();
}

class _MinorArcanaMenuState extends State<MinorArcanaMenu> {
  List<String> cardNames = [
    "OROS",
    "COPAS",
    "BASTOS",
    "ESPADES",
  ];
  @override
  void initState() {
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
                const Center(
                  child: AppText(
                    text: "Tarrot Cards",
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                    fontSize: 45,
                  ),
                ),
                AppSpacing.heightSpace50,
                Column(
                  children: List.generate(
                    cardNames.length,
                    (index) => Column(
                      children: [
                        AppSpacing.heightSpace30,
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => MinorArcanaCards(
                                minorArcana: widget.minorArcana
                                    .where(
                                      (element) => element.subCategory!
                                          .toLowerCase()
                                          .contains(
                                            cardNames[index].toLowerCase(),
                                          ),
                                    )
                                    .toList(),
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
                                text: cardNames[index],
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
