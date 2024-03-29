import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_tarrot/constants/app_spacing.dart';
import 'package:ok_tarrot/views/main_views/subscription_views/card_details.dart';
import 'package:ok_tarrot/widgets/app_text.dart';

class Subscription extends StatelessWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/splash_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: const BackButton(
              color: Colors.white,
            ),
          ),
          body: Padding(
            padding: AppSpacing.defaultPadding,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/splash_logo.png",
                  height: 100,
                  width: 100,
                ),
                AppSpacing.heightSpace50,
                AppText(
                  text: "subscription".tr,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
                AppSpacing.heightSpace10,
                AppText(
                  text: "buy_a_premium_version_and_remove_ads".tr,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                AppSpacing.heightSpace50,
                AppText(
                  text: "select_your_plan".tr,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
                AppSpacing.heightSpace20,
                Container(
                  height: 130,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xff242424),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 25,
                            width: 105,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffB08933),
                                  Color(0xffDADADA),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Center(
                              child: AppText(
                                text: "monthly".tr,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          AppSpacing.heightSpace10,
                          const AppText(
                            text: "€4.99",
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xff272727),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            AppText(
                                              text: "your_subscription_order".tr,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                            AppSpacing.heightSpace30,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                AppText(
                                                  text: "monthly".tr,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                                const AppText(
                                                  text: "€4.99",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ],
                                            ),
                                            AppSpacing.heightSpace30,
                                            const Divider(
                                              thickness: 1.5,
                                              color: Color(0xff878787),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateColor.resolveWith(
                                            (states) => Colors.black,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                AppText(
                                                  text: "total".tr,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                const AppText(
                                                  text: "€4.99",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.to(
                                            () => CardDetails(
                                              amount: (4.99).toStringAsFixed(2),
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateColor.resolveWith(
                                            (states) => Colors.white,
                                          ),
                                        ),
                                        child: Center(
                                          child: AppText(
                                            text: "pay_now".tr,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 45,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: AppText(
                              text: "buy_package".tr,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.heightSpace20,
                Container(
                  height: 130,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xff242424),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 25,
                            width: 105,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffB08933),
                                  Color(0xffDADADA),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Center(
                              child: AppText(
                                text: "annually".tr,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          AppSpacing.heightSpace10,
                          const AppText(
                            text: "€7.99",
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xff272727),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            AppText(
                                              text: "your_subscription_order".tr,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                            AppSpacing.heightSpace30,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                AppText(
                                                  text: "annually".tr,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                                const AppText(
                                                  text: "€7.99",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ],
                                            ),
                                            AppSpacing.heightSpace30,
                                            const Divider(
                                              thickness: 1.5,
                                              color: Color(0xff878787),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateColor.resolveWith(
                                            (states) => Colors.black,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                AppText(
                                                  text: "total".tr,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                const AppText(
                                                  text: "€7.99",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.to(
                                            () => CardDetails(
                                              amount: (7.99).toStringAsFixed(2),
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateColor.resolveWith(
                                            (states) => Colors.white,
                                          ),
                                        ),
                                        child: Center(
                                          child: AppText(
                                            text: "pay_now".tr,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 45,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: AppText(
                              text: "buy_package".tr,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
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
