import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:ok_tarrot/firebase_options.dart';
import 'package:ok_tarrot/utils/audio_player_handler.dart';
import 'package:ok_tarrot/views/splash_screens/splash_screen.dart';
import 'package:get/get.dart';

import 'translation/app_translation.dart';

late AudioHandler audioHandler;
void main() async {
  await Hive.initFlutter();
  Box box = await Hive.openBox("cards");

  box.put(
    "savedCards",
    [
      "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Card_placeholder%2Fsplash_logo.png?alt=media&token=a0b30d99-3b99-478d-85d3-63aab6de24ec",
      "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Card_placeholder%2Fsplash_logo.png?alt=media&token=a0b30d99-3b99-478d-85d3-63aab6de24ec",
      "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Card_placeholder%2Fsplash_logo.png?alt=media&token=a0b30d99-3b99-478d-85d3-63aab6de24ec",
      "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Card_placeholder%2Fsplash_logo.png?alt=media&token=a0b30d99-3b99-478d-85d3-63aab6de24ec",
      "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Card_placeholder%2Fsplash_logo.png?alt=media&token=a0b30d99-3b99-478d-85d3-63aab6de24ec",
    ],
  );

  box.put(
    "cardsIds",
    [
      "",
      "",
      "",
      "",
      "",
    ],
  );

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    debugPrint(e.toString());
    runApp(const MyApp());
  }
}

Box box = Hive.box("cards");
initiaLizePlayer() async {
  audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Box box = Hive.box("cards");
  @override
  void initState() {
    initiaLizePlayer();
    box.put("pageIndex", 0);

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      box.put("pageIndex", 0);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OK Tarrot',
      translations: AppTranslation(),
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}
