import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ok_tarrot/constants/app_spacing.dart';
import 'package:ok_tarrot/constants/app_svgs.dart';

import 'package:ok_tarrot/utils/app_snackbar.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/languages.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/music.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/tarot_cards.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/tutorial.dart';
import 'package:ok_tarrot/views/main_views/registration_screens/sign_in.dart';
import 'package:ok_tarrot/views/main_views/subscription_views/profile_view.dart';
import 'package:ok_tarrot/widgets/app_text.dart';
import 'package:share_plus/share_plus.dart';

import '../../controllers/ad_controller.dart';
import '../../main.dart';
import '../../widgets/my_appbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AdController _controller = Get.put(AdController());

  String shortUrl = "short url";
  createLink() async {
    String url = "https://oktarrot.page.link";
    var dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(url),
      uriPrefix: url,
      androidParameters: const AndroidParameters(packageName: "com.example.ok_tarrot"),
      iosParameters: const IOSParameters(bundleId: "com.example.ok_tarrot"),
    );
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams).then((value) {
      shortUrl = value.shortUrl.toString();
      setState(() {});
    }).catchError((err) {
      debugPrint("error creating link => $err");
    });
  }

  @override
  void initState() {
    _controller.loadAd();

    createLink();

    super.initState();
  }

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
        appBar: MyAppbar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Hero(
              tag: "logo",
              child: Image.asset(
                "assets/images/splash_logo.png",
                width: 80,
              ),
            ),
          ),
          // title: const AppText(
          //   text: "Ok Tarrot",
          //   fontSize: 16,
          //   fontWeight: FontWeight.w500,
          // ),
          action: InkWell(
            onTap: () {
              if (box.get("userData") != null) {
                Get.to(
                  () => const ProfileView(),
                );
              } else {
                AppSnackbar.snackBar(title: "Message", message: "You are not logged in please login first!");
                Get.offAll(
                  () => const SignIn(),
                );
              }
            },
            child: Image.asset(
              "assets/images/eye_logo.png",
              height: 40,
              width: 40,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 280,
                width: Get.width,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/face_logo.png",
                        height: 150,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: GlassmorphicContainer(
                            width: 500,
                            height: 500,
                            borderRadius: 0,
                            blur: 10,
                            border: 0,
                            linearGradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                const Color(0xFF151515).withOpacity(0.05),
                                const Color(0xFF151515).withOpacity(0.05),
                              ],
                            ),
                            borderGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFffffff).withOpacity(0.2),
                                const Color((0xFFFFFFFF)).withOpacity(0.2),
                              ],
                            ),
                            child: null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: AppSpacing.defaultPadding,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => Get.to(
                        () => const Tutorial(),
                      ),
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/hm_img1.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText(
                              text: "tutorial".tr,
                              fontSize: 20,
                            ),
                            SvgPicture.string(
                              AppSvgs.arrowForward,
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSpacing.heightSpace30,
                    InkWell(
                      onTap: () => Get.to(
                        () => const TarrotCards(),
                      ),
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/hm_img2.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText(
                              text: "tarrot_cards".tr,
                              fontSize: 20,
                            ),
                            SvgPicture.string(
                              AppSvgs.arrowForward,
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSpacing.heightSpace30,
                    InkWell(
                      onTap: () => Get.to(
                        () => const Languages(),
                      ),
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/hm_img1.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText(
                              text: "language".tr,
                              fontSize: 20,
                            ),
                            SvgPicture.string(
                              AppSvgs.arrowForward,
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSpacing.heightSpace30,
                    InkWell(
                      onTap: () => Get.to(
                        () => const Music(),
                      ),
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/hm_img2.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppText(
                              text: "music".tr,
                              fontSize: 20,
                            ),
                            SvgPicture.string(
                              AppSvgs.arrowForward,
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSpacing.heightSpace30,
                    AppSpacing.heightSpace20,
                    InkWell(
                      onTap: () async {
                        await Share.share(shortUrl);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          AppText(
                            text: "share".tr,
                            letterSpacing: 5,
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () {
            if (_controller.isAdLoaded.value) {
              return SizedBox(
                height: 60,
                width: double.maxFinite,
                child: AdWidget(
                  ad: _controller.ad!,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
