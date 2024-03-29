import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ok_tarrot/models/card_model.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/tarot_cards.dart';
import 'package:ok_tarrot/widgets/app_cached_image.dart';

import '../../../../../constants/app_spacing.dart';
import '../../../../../widgets/app_text.dart';

class MinorArcanaCards extends StatefulWidget {
  final List<CardModel> minorArcana;
  const MinorArcanaCards({
    Key? key,
    required this.minorArcana,
  }) : super(key: key);

  @override
  State<MinorArcanaCards> createState() => _MinorArcanaCardsState();
}

class _MinorArcanaCardsState extends State<MinorArcanaCards> {
  Box box = Hive.box("cards");
  List<String> get allCardImg => List.generate(
        widget.minorArcana.length,
        (index) => widget.minorArcana[index].cardImage.toString(),
      );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List savedCards = box.get("savedCards");
    List savedCardsId = box.get("cardsIds");
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xff151515),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [
            0.6,
            1.0,
          ],
          colors: [
            const Color(0xff151515),
            const Color(0xff9DADDF).withOpacity(0.5),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: AppSpacing.defaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppSpacing.heightSpace30,
                AppSpacing.heightSpace20,
                AppText(
                  text: "tarrot_cards".tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 34,
                  decoration: TextDecoration.underline,
                ),
                AppSpacing.heightSpace30,
                Center(
                  child: Wrap(
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(
                      allCardImg.length,
                      (index) => InkWell(
                        onTap: () async {
                          savedCards.removeAt(box.get("index"));
                          savedCards.insert(box.get("index"),
                              widget.minorArcana[index].cardImage);
                          savedCardsId.removeAt(box.get("index"));
                          savedCardsId.insert(
                            box.get("index"),
                            widget.minorArcana[index].id,
                          );
                          var list = [];
                          var idList = [];
                          List.generate(
                            5,
                            (index) {
                              list.add(
                                savedCards[index],
                              );
                            },
                          );
                          List.generate(
                            5,
                            (index) {
                              idList.add(
                                savedCardsId[index],
                              );
                            },
                          );

                          await box.put("savedCards", list);
                          await box.put("cardsIds", idList);

                          Get.offAll(() => const TarrotCards());
                        },
                        child: SizedBox(
                          height: 200,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppCachedImage(
                                url: allCardImg[index],
                                height: 170,
                                width: 110,
                              )
                              // AppText(
                              //   text: "hello",
                              //   fontSize: 15,
                              //   fontWeight: FontWeight.w500,
                              // ),
                            ],
                          ),
                        ),
                      ),
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
