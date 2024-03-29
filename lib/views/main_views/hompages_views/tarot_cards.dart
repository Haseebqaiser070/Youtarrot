import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ok_tarrot/constants/app_svgs.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/tarrot_card_views/arcana_menu.dart';
import 'package:ok_tarrot/widgets/app_cached_image.dart';

import '../../../constants/app_spacing.dart';
import '../../../widgets/app_text.dart';
import '../../cards_combination_view.dart';
import '../homepage.dart';

class TarrotCards extends StatefulWidget {
  const TarrotCards({Key? key}) : super(key: key);

  @override
  State<TarrotCards> createState() => _TarrotCardsState();
}

class _TarrotCardsState extends State<TarrotCards> {
  Box box = Hive.box("cards");

  bool isFlipable = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List savedCards = box.get("savedCards");
    List savedCardsId = box.get("cardsIds");
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Go back to HomePage!"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(
                      () => const Homepage(),
                    );
                  },
                  child: const Text("Yes"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("No"),
                ),
              ],
            );
          },
        );
        return false;
      },
      child: DecoratedBox(
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(
                    savedCards.length,
                    (index) => SizedBox(
                      height: 190,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: FlipCard(
                              onFlip: () {
                                if (savedCards[index].contains("splash_logo")) {
                                  setState(() {
                                    isFlipable = false;
                                  });

                                  box.put("index", index);
                                  Get.to(
                                    () => const ArcanaMenu(),
                                  );
                                } else {
                                  setState(() {
                                    isFlipable = true;
                                  });
                                }
                              },
                              onFlipDone: (isFront) async {
                                if (!isFront) {
                                  savedCards.removeAt(index);
                                  savedCardsId.removeAt(index);
                                  savedCards.insert(index,
                                      "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Card_placeholder%2Fsplash_logo.png?alt=media&token=a0b30d99-3b99-478d-85d3-63aab6de24ec");
                                  savedCardsId.insert(index, "");
                                  var idList = [];
                                  var list = [];
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

                                  setState(() {});
                                }
                              },
                              side: CardSide.BACK,
                              back: Container(
                                height: 160,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                                child: AppCachedImage(
                                  height: 160,
                                  width: 100,
                                  url: savedCards[index],
                                  color: Colors.black,
                                  // decoration: BoxDecoration(
                                  //   color: Colors.black,
                                  //   image: DecorationImage(
                                  //     image: NetworkImage(
                                  //       savedCards[index],
                                  //     ),
                                  //     fit: savedCards.any((element) =>
                                  //             element.contains("splash_logo"))
                                  //         ? BoxFit.contain
                                  //         : BoxFit.fitHeight,
                                  //   ),
                                  // ),
                                ),
                              ),
                              front: Container(
                                height: 160,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/splash_logo.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          index == 0 || savedCards[index].contains("splash_logo.png")
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () async {
                                    savedCards.removeAt(index);
                                    savedCardsId.removeAt(index);
                                    savedCards.insert(index,
                                        "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Card_placeholder%2Fsplash_logo.png?alt=media&token=a0b30d99-3b99-478d-85d3-63aab6de24ec");
                                    savedCardsId.insert(index, "");
                                    var idList = [];
                                    var list = [];
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

                                    setState(() {});

                                    // Get.offAll(() => const TarrotCards());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText(
                                        text: "remove".tr,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: const Color(0xffBFB341),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.string(
                                        AppSvgs.arrow,
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      Get.to(
                        () => const CardsCombinationView(),
                      );
                    },
                    child: AppText(
                      text: "consult".tr,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
