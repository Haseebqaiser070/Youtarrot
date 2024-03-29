import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ok_tarrot/constants/app_spacing.dart';
import 'package:ok_tarrot/constants/app_svgs.dart';
import 'package:ok_tarrot/controllers/profile_controller.dart';
import 'package:ok_tarrot/main.dart';
import 'package:ok_tarrot/models/user_model.dart';
import 'package:ok_tarrot/services/fetch_data.dart';
import 'package:ok_tarrot/utils/app_snackbar.dart';
import 'package:ok_tarrot/views/main_views/homepage.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/languages.dart';
import 'package:ok_tarrot/views/main_views/registration_screens/update_profile.dart';
import 'package:ok_tarrot/views/main_views/subscription_views/subscription.dart';
import 'package:ok_tarrot/widgets/app_button.dart';
import 'package:ok_tarrot/widgets/app_cached_image.dart';
import 'package:ok_tarrot/widgets/app_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FetchData _fetchData = FetchData();
  UserModel userData = UserModel();

  bool isLoading = false;

  getData() async {
    setState(() {
      isLoading = true;
    });
    await _fetchData.getSubscription(userData.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    var stringMap = jsonEncode(box.get("userData"));
    userData = UserModel.fromMap(
      jsonDecode(stringMap),
    );
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(
          const Homepage(),
        );
        return true;
      },
      child: DecoratedBox(
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
              leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Get.off(
                    () => const Homepage(),
                  );
                },
              ),
            ),
            body: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : GetBuilder<ProfileController>(
                    init: ProfileController(),
                    builder: (_) {
                      return Padding(
                        padding: AppSpacing.defaultPadding,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff621921),
                              ),
                              child: Center(
                                child: userData.profile == null || userData.profile!.isEmpty
                                    ? SvgPicture.string(
                                        AppSvgs.person,
                                        height: 50,
                                        width: 50,
                                      )
                                    : AppCachedImage(
                                        shape: BoxShape.circle,
                                        height: 120,
                                        width: 120,
                                        url: userData.profile.toString(),
                                      ),
                              ),
                            ),
                            AppSpacing.heightSpace30,
                            AppText(
                              text: userData.name.toString(),
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            AppSpacing.heightSpace10,
                            AppText(
                              text: userData.email.toString(),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            AppSpacing.heightSpace30,
                            ListTile(
                              onTap: () {
                                Get.to(
                                  () => const UpdateProfile(),
                                );
                              },
                              contentPadding: EdgeInsets.zero,
                              leading: SvgPicture.string(
                                AppSvgs.personOutlined,
                              ),
                              title: AppText(text: "edit_profile".tr),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                if (_fetchData.subscriptionModel.id == null) {
                                  AppSnackbar.snackBar(title: "Message", message: "You have no subscription yet!");
                                } else {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        width: double.maxFinite,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Center(
                                                child: SvgPicture.string(
                                                  AppSvgs.dragHandle,
                                                ),
                                              ),
                                              Center(
                                                child: AppText(
                                                  text: "subscription_details".tr,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "${"ends_on".tr} ${DateFormat("dd/MM/yyyy").format(DateTime.parse(_fetchData.subscriptionModel.createdOn.toString()))}",
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: "\n${DateFormat("dd MMM yyyy").format(
                                                        DateTime.parse(_fetchData.subscriptionModel.createdOn.toString()).add(
                                                          Duration(days: _fetchData.subscriptionModel.price == "4.99" ? 30 : 365),
                                                        ),
                                                      )} - ${"next_payment".tr}",
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              AppText(
                                                text: _fetchData.subscriptionModel.price == "4.99" ? "billed_monthly".tr : "billed_annually".tr,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                              RawMaterialButton(
                                                onPressed: () {},
                                                fillColor: const Color(0xff621921),
                                                shape: const StadiumBorder(),
                                                child: Center(
                                                  child: AppText(text: "€ ${_fetchData.subscriptionModel.price}"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              contentPadding: EdgeInsets.zero,
                              leading: SvgPicture.string(
                                AppSvgs.card,
                              ),
                              title: AppText(
                                text: "subscription_details".tr,
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Get.to(
                                  () => const Languages(),
                                );
                              },
                              contentPadding: EdgeInsets.zero,
                              leading: SvgPicture.string(
                                AppSvgs.language,
                              ),
                              title: AppText(text: "language".tr),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            AppSpacing.heightSpace30,
                            AppButton(
                              onTap: () {
                                if (_fetchData.subscriptionModel.id != null) {
                                  AppSnackbar.snackBar(title: "Message", message: "You are already subscribe!");
                                } else {
                                  Get.to(
                                    () => const Subscription(),
                                  );
                                }
                              },
                              text: "buy_subscription".tr,
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: _.isRefunding
                                    ? null
                                    : () async {
                                        await _.refundSubscription(
                                          userId: userData.id.toString(),
                                        );
                                      },
                                child: _.isRefunding
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : AppText(
                                        text: "cancel_subscription".tr,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
