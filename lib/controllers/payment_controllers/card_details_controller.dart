import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:ok_tarrot/utils/app_snackbar.dart';
import 'package:ok_tarrot/views/main_views/homepage.dart';

import '../../services/payment_services.dart';
import '../../widgets/app_text.dart';

class CardDetailsController extends GetxController {
  final PaymentServices _services = PaymentServices();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cvc = TextEditingController();
  TextEditingController name = TextEditingController();
  DateTime? expiryDateTime;
  pickExpiryDate(context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      expiryDateTime = value;
      expiryDate.text = DateFormat("MM/yyyy").format(value!);
    });
  }

  bool isChecked = true;
  changeCheck(bool value) {
    isChecked = value;
    update();
  }

  bool isLoading = false;
  makePayment(
    String amount, {
    required AnimationController controller,
    required context,
  }) async {
    if (cardNumber.text.isEmpty || cardNumber.text.length < 19) {
      AppSnackbar.snackBar(title: "Error", message: "Please enter a valid card number!");
    } else if (expiryDateTime == null) {
      AppSnackbar.snackBar(title: "Error", message: "Please select a card expiry date!");
    } else if (cvc.text.isEmpty || cvc.text.length < 3) {
      AppSnackbar.snackBar(title: "Error", message: "Please enter a valid cvc code!");
    } else if (name.text.isEmpty || name.text.length < 3) {
      AppSnackbar.snackBar(title: "Error", message: "Please enter your card name!");
    } else {
      isLoading = true;
      update();
      await _services.makePayment(
        name: name.text,
        amount: amount,
        cardNumber: cardNumber.text,
        cvc: cvc.text,
        month: expiryDateTime!.month.toString(),
        year: expiryDateTime!.year.toString(),
      );
      isLoading = false;
      update();
      if (_services.isDone) {
        showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 400,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: const Color(0xff272727),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child: CloseButton(
                          color: Colors.white,
                        ),
                      ),
                      Lottie.asset(
                        "assets/animations/checked.json",
                        controller: controller,
                        repeat: false,
                        onLoaded: (composition) {
                          controller
                            ..duration = composition.duration
                            ..forward();
                          Timer(
                            composition.duration,
                            () {
                              Get.offAll(
                                () => const Homepage(),
                              );
                            },
                          );
                        },
                      ),
                      const Spacer(),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: AppText(
                          text: "Payment Successful",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    }
  }
}
