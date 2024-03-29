import 'package:audio_service/audio_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ok_tarrot/main.dart';

import '../../../constants/app_spacing.dart';
import '../../../widgets/app_text.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final CarouselController _carouselController = CarouselController();
  Box box = Hive.box("cards");
  List<String> musicNames = [
    "AMAZING FUTURE",
    "ECHOES OF IRELAND",
    "EURYNOME",
    "IN THE MEMORY",
    "OCEANS OF SAND",
    "RETURNING HOME",
    "VULCAN",
    "YOU",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xff151515),
        image: const DecorationImage(
          image: AssetImage(
            "assets/images/music_bg.png",
          ),
          fit: BoxFit.cover,
        ),
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
                AppSpacing.heightSpace30,
                Center(
                  child: AppText(
                    text: "music".tr.toUpperCase(),
                    fontWeight: FontWeight.w500,
                    fontSize: 45,
                  ),
                ),
                AppSpacing.heightSpace30,
                InkWell(
                  onTap: () async {
                    await audioHandler.stop();
                    // await _player.stop();
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: AppText(
                        text: "Without Sound",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                AppSpacing.heightSpace30,
                AppText(
                  text: "sounds".tr,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
                AppSpacing.heightSpace30,
                AppSpacing.heightSpace10,
                CarouselSlider.builder(
                  disableGesture: true,
                  carouselController: _carouselController,
                  itemCount: musicNames.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: AppText(
                          text: musicNames[index],
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    onPageChanged: (index, reason) async {
                      await box.put("pageIndex", index);
                    },
                    autoPlay: false,
                    height: 75,
                    enlargeCenterPage: true,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    initialPage: box.get("pageIndex") ?? 0,
                  ),
                ),
                AppSpacing.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RawMaterialButton(
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        _carouselController.previousPage();
                        await audioHandler.skipToPrevious();
                        await audioHandler.play();
                      },
                      child: const Icon(
                        Icons.skip_previous_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    StreamBuilder(
                      stream: audioHandler.playbackState,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return RawMaterialButton(
                            shape: const StadiumBorder(
                              side: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (snapshot.data!.playing) {
                                await audioHandler.pause();
                              } else {
                                await audioHandler.play();
                              }
                            },
                            child: snapshot.data!.processingState ==
                                        AudioProcessingState.ready ||
                                    snapshot.data!.processingState ==
                                        AudioProcessingState.idle
                                ? Icon(
                                    snapshot.data!.playing
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : const SpinKitThreeBounce(
                                    size: 10,
                                    color: Colors.white,
                                  ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    RawMaterialButton(
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        _carouselController.nextPage();
                        await audioHandler.skipToNext();
                        await audioHandler.play();
                      },
                      child: const Icon(
                        Icons.skip_next_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
