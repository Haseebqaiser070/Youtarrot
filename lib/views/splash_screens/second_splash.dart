import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ok_tarrot/constants/app_spacing.dart';
import 'package:ok_tarrot/views/main_views/homepage.dart';
import 'package:ok_tarrot/widgets/app_text.dart';

import '../../main.dart';
import '../main_views/registration_screens/sign_in.dart';

class SecondSplash extends StatefulWidget {
  const SecondSplash({Key? key}) : super(key: key);

  @override
  State<SecondSplash> createState() => _SecondSplashState();
}

class _SecondSplashState extends State<SecondSplash> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: AppSpacing.defaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Center(
                  child: Hero(
                    tag: "logo",
                    child: Image.asset(
                      "assets/images/splash_logo.png",
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 2000),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          if (box.get("userData") == null) {
                            return const SignIn();
                          } else {
                            return const Homepage();
                          }
                        },
                      ),
                    ),
                    child: const AppText(
                      text: "Start",
                      fontSize: 22,
                      letterSpacing: 10,
                    ),
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
