import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ok_tarrot/utils/ad_helper.dart';

class AdController extends GetxController {
  RxBool isAdLoaded = false.obs;
  BannerAd? ad;
  loadAd() {
    ad = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint("Successfully Loaded");
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          isAdLoaded.value = false;

          ad.dispose();
          debugPrint("ad error => $error");
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  RewardedAd? rewardedAd;
  loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: AdHelper.rewardAdId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint("rewarded ad loading faild=>$error");
          rewardedAd!.dispose();
        },
      ),
    );
  }

  showRewardedAd() {
    loadRewardedAd();
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdClicked: (ad) {
          debugPrint("ad clicked ${ad.adUnitId}");
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          debugPrint("Failed to load ad=> $error");
          rewardedAd!.dispose();
          loadRewardedAd();
        },
      );
      rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          debugPrint("Earned reward => ${reward.amount}");
        },
      );
      rewardedAd = null;
    }
  }
}
