import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ok_tarrot/models/card_model.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/tarot_cards.dart';
import 'package:ok_tarrot/widgets/app_cached_image.dart';

import '../../../../../constants/app_spacing.dart';
import '../../../../../widgets/app_text.dart';

class MajorArcanaCards extends StatefulWidget {
  final List<CardModel> majorArcana;
  const MajorArcanaCards({
    Key? key,
    required this.majorArcana,
  }) : super(key: key);

  @override
  State<MajorArcanaCards> createState() => _MajorArcanaCardsState();
}

class _MajorArcanaCardsState extends State<MajorArcanaCards> {
  Box box = Hive.box("cards");

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
                      widget.majorArcana.length,
                      (index) => InkWell(
                        onTap: () async {
                          savedCards.removeAt(box.get("index"));
                          savedCards.insert(box.get("index"),
                              widget.majorArcana[index].cardImage);
                          savedCardsId.removeAt(box.get("index"));
                          savedCardsId.insert(
                            box.get("index"),
                            widget.majorArcana[index].id,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppCachedImage(
                                url: widget.majorArcana[index].cardImage
                                    .toString(),
                                height: 170,
                                width: 110,
                              )
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
