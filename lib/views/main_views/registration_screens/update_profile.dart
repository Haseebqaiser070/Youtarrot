import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ok_tarrot/controllers/registration_controllers/update_profile_controller.dart';
import 'package:ok_tarrot/models/user_model.dart';
import 'package:ok_tarrot/widgets/app_cached_image.dart';
import 'package:ok_tarrot/widgets/app_text.dart';

import '../../../constants/app_spacing.dart';
import '../../../constants/app_svgs.dart';
import '../../../main.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_field.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final UpdateProfileController _controller = Get.put(UpdateProfileController());
  UserModel userData = UserModel();
  initializeData() {
    var stringMap = jsonEncode(box.get("userData"));
    userData = UserModel.fromMap(
      jsonDecode(stringMap),
    );
    _controller.email.text = userData.email.toString();
    _controller.name.text = userData.name.toString();
    _controller.phoneNumber.text = userData.phoneNumber.toString();
    _controller.gender.text = userData.gender.toString();
    _controller.picUrl = userData.profile.toString();
    _controller.selectedVal = userData.gender.toString();
    _controller.phoneCode = userData.phoneCode.toString();
    _controller.phoneCountry = userData.phoneCountry.toString();
  }

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: AppSpacing.defaultPadding,
          child: SingleChildScrollView(
            child: GetBuilder<UpdateProfileController>(
              init: UpdateProfileController(),
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSpacing.heightSpace30,
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff621921),
                          image: _.image == null
                              ? null
                              : DecorationImage(
                                  image: FileImage(
                                    _.image!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: Stack(
                          children: [
                            _.image != null
                                ? const SizedBox()
                                : Center(
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
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () async {
                                  await _.pickImage();
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(1, 1),
                                        blurRadius: 15,
                                        spreadRadius: 1.5,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff621921),
                                  ),
                                  child: Center(
                                    child: SvgPicture.string(
                                      AppSvgs.pencil,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSpacing.heightSpace30,
                    AppField(
                      controller: _.name,
                      hintText: "Username",
                    ),
                    AppSpacing.heightSpace30,
                    AppField(
                      controller: _.email,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Email",
                    ),
                    AppSpacing.heightSpace30,
                    IntlPhoneField(
                      initialCountryCode: _.phoneCountry,
                      controller: _.phoneNumber,
                      onChanged: (value) {
                        _.phoneCode = value.countryCode;
                        _.phoneCountry = value.countryISOCode;
                      },
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Phone",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    AppText(
                      text: "select_gender".tr,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    RadioListTile.adaptive(
                      value: "Male",
                      title: const AppText(
                        text: "Male",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      groupValue: _.selectedVal,
                      onChanged: (value) {
                        _.selectGender(value!);
                      },
                    ),
                    RadioListTile.adaptive(
                      value: "Female",
                      title: const AppText(
                        text: "Female",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      groupValue: _.selectedVal,
                      onChanged: (value) {
                        _.selectGender(value!);
                      },
                    ),
                    RadioListTile.adaptive(
                      value: "Other",
                      title: const AppText(
                        text: "Other",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      groupValue: _.selectedVal,
                      onChanged: (value) {
                        _.selectGender(value!);
                      },
                    ),
                    AppSpacing.heightSpace30,
                    AppButton(
                      isLoading: _.isLoading,
                      onTap: () async {
                        await _.updateProfile(
                          userData.id.toString(),
                        );
                      },
                      text: "update".tr,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
