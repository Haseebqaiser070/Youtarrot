import 'package:get/get.dart';
import 'package:ok_tarrot/services/payment_services.dart';
import 'package:ok_tarrot/views/main_views/homepage.dart';

class ProfileController extends GetxController {
  final PaymentServices _services = PaymentServices();
  bool isRefunding = false;

  refundSubscription({
    required String userId,
  }) async {
    isRefunding = true;
    update();
    await _services.cancelSubscription(userId);

    Get.offAll(
      () => const Homepage(),
    );

    isRefunding = false;
    update();
  }
}
