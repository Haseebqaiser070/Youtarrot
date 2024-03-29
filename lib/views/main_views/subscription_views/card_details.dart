import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ok_tarrot/constants/app_spacing.dart';
import 'package:ok_tarrot/constants/app_svgs.dart';
import 'package:ok_tarrot/controllers/payment_controllers/card_details_controller.dart';
import 'package:ok_tarrot/views/main_views/subscription_views/subscription.dart';
import 'package:ok_tarrot/widgets/app_text.dart';

import '../../../utils/card_field_formatter.dart';

class CardDetails extends StatefulWidget {
  final String amount;
  const CardDetails({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/splash_bg.png",
          ),
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
            child: GetBuilder<CardDetailsController>(
              init: CardDetailsController(),
              builder: (_) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "credit_card_information".tr,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                      AppSpacing.heightSpace50,
                      AppText(
                        text: "card_number".tr,
                      ),
                      AppSpacing.heightSpace10,
                      TextFormField(
                        controller: _.cardNumber,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CardNumberFormatter(),
                        ],
                        maxLength: 19,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: "",
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "0000 0000 0000 0000",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                          ),
                          contentPadding: const EdgeInsets.all(18),
                          border: InputBorder.none,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.string(
                              AppSvgs.masterCard,
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.heightSpace30,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "expiry_date".tr,
                                ),
                                AppSpacing.heightSpace10,
                                TextFormField(
                                  controller: _.expiryDate,
                                  readOnly: true,
                                  onTap: () {
                                    _.pickExpiryDate(context);
                                  },
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "MM/YY",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                    ),
                                    contentPadding: const EdgeInsets.all(18),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "security_code".tr,
                                ),
                                AppSpacing.heightSpace10,
                                TextFormField(
                                  controller: _.cvc,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                  ),
                                  maxLength: 3,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "CVC",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                    ),
                                    contentPadding: const EdgeInsets.all(18),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.heightSpace30,
                      AppText(
                        text: "name_on_card".tr,
                      ),
                      AppSpacing.heightSpace10,
                      TextFormField(
                        controller: _.name,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Name",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                          ),
                          contentPadding: const EdgeInsets.all(18),
                          border: InputBorder.none,
                        ),
                      ),
                      AppSpacing.heightSpace30,
                      CheckboxListTile(
                        value: _.isChecked,
                        onChanged: (value) {
                          _.changeCheck(value!);
                        },
                        title: AppText(text: "save_information_for_future_use".tr),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.blue,
                        contentPadding: EdgeInsets.zero,
                      ),
                      AppSpacing.heightSpace30,
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                            (states) => const EdgeInsets.all(15),
                          ),
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xff2A3E44),
                          ),
                        ),
                        onPressed: _.isLoading
                            ? null
                            : () async {
                                await _.makePayment(
                                  widget.amount,
                                  context: context,
                                  controller: _controller,
                                );
                              },
                        child: Center(
                          child: _.isLoading
                              ? const SpinKitThreeBounce(
                                  size: 15,
                                  color: Colors.white,
                                )
                              : AppText(
                                  text: "pay_now".tr,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                        ),
                      ),
                      AppSpacing.heightSpace30,
                      TextButton(
                        onPressed: () {
                          Get.off(
                            () => const Subscription(),
                          );
                        },
                        child: Center(
                          child: AppText(text: "cancel".tr),
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
