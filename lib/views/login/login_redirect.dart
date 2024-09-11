import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/custom_buttom.dart';
import 'package:youeat/common/custom_container.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/views/login/login_page.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: kSecondary,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kLightWhite,
          title: Center(
            child: ReusableText(
              text: "Please login to access this page",
              style: appStyle(15, kDark, FontWeight.w300),
            ),
          ),
        ),
        body: SafeArea(
            child: CustomContainer(
                containerContent: Column(
          children: [
            Container(
              width: width,
              height: height / 2,
              color: Colors.white,
              child: LottieBuilder.asset(
                "assets/anime/delivery.json",
                width: width,
                height: height / 2,
              ),
            ),
            CustomButtom(
              text: " L O G I N",
              onTap: () {
                Get.to(() => const LoginPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 900));
              },
              btnHeigth: 40.h,
              btnWidth: width - 20,
            ),
          ],
        ))));
  }
}
