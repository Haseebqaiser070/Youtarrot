import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_tarrot/constants/app_spacing.dart';

import '../../../widgets/app_text.dart';

class Languages extends StatefulWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  List<String> flagNames = [
    "Español",
    "English",
    "Français",
    "Deutschland",
  ];
  List<String> allFlags = [
    "assets/images/spain.png",
    "assets/images/england.png",
    "assets/images/france.png",
    "assets/images/germany.png",
  ];
  List<Locale> allLocales = [
    const Locale("es", "US"),
    const Locale("en", "US"),
    const Locale("fr", "FR"),
    const Locale("de", "DE"),
  ];
  @override
  Widget build(BuildContext context) {
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
                AppSpacing.heightSpace10,
                const Center(
                  child: AppText(
                    text: "YouTarot",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSpacing.heightSpace30,
                Center(
                  child: AppText(
                    text: "select".tr,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    fontSize: 45,
                  ),
                ),
                Center(
                  child: AppText(
                    text: "language".tr,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    fontSize: 45,
                  ),
                ),
                AppSpacing.heightSpace30,
                Center(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 20,
                    children: List.generate(
                      allFlags.length,
                      (index) => InkWell(
                        onTap: () {
                          Get.updateLocale(
                            allLocales[index],
                          );
                          Get.back();
                        },
                        child: SizedBox(
                          height: 140,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      allFlags[index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              AppText(
                                text: flagNames[index],
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
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
