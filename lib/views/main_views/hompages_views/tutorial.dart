import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ok_tarrot/services/fetch_data.dart';
import 'package:ok_tarrot/views/main_views/hompages_views/tutorial_views/definition.dart';

import '../../../constants/app_spacing.dart';
import '../../../constants/app_svgs.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/my_appbar.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  final FetchData _fetchData = FetchData();
  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });
    await _fetchData.getAllTutorials();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
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
            child: Image.asset(
              "assets/images/splash_logo.png",
              height: 60,
              width: 60,
            ),
          ),
          action: InkWell(
            onTap: () => Get.back(),
            child: SvgPicture.string(
              AppSvgs.arrowBackward,
            ),
          ),
        ),
        body: Padding(
          padding: AppSpacing.defaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppSpacing.heightSpace30,
                AppText(
                  text: "tutorial".tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 34,
                ),
                AppSpacing.heightSpace30,
                isLoading
                    ? const Center(
                        child: SpinKitThreeBounce(
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    : Column(
                        children: List.generate(
                          _fetchData.allTutorials.length,
                          (index) => InkWell(
                            onTap: () => Get.to(
                              () => Definition(
                                description: _fetchData
                                    .allTutorials[index].description
                                    .toString(),
                              ),
                            ),
                            child: Column(
                              children: [
                                AppSpacing.heightSpace30,
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      AppText(
                                        text: _fetchData
                                            .allTutorials[index].title
                                            .toString(),
                                        fontSize: 15,
                                      ),
                                      SvgPicture.string(
                                        AppSvgs.arrowForward,
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
