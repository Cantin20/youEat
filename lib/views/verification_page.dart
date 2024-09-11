import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/custom_buttom.dart';
import 'package:youeat/common/custom_container.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:youeat/controllers/login_controller.dart';
import 'package:youeat/controllers/verification_controller.dart';
import 'package:youeat/models/login_response.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;
    final controllerlo = Get.put(LoginController());
    final controller = Get.put(VerificationController());
    final box = GetStorage();
    String? token = box.read('token');
    if (token != null) {
      user = controllerlo.getUserInfo();
    }
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        title: ReusableText(
            text: "Please Verify Your Account",
            style: appStyle(14, kGray, FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: CustomContainer(
          color: Colors.white,
          containerContent: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: height,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Lottie.asset("assets/anime/delivery.json"),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: ReusableText(
                        text: "Please Verify Your Account",
                        style: appStyle(19, kGray, FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ReusableText(
                      text: "Enter the 6-digits code sent to your email",
                      style: appStyle(10, kGray, FontWeight.bold)),
                  SizedBox(
                    height: 20.h,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: kPrimary,
                    borderWidth: 2.0,
                    textStyle: appStyle(16, kDark, FontWeight.w600),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      controller.setCode = verificationCode;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButtom(
                    text: "V E R I F Y   A C C O U N T",
                    onTap: () {
                      controller.verificationFunction();
                    },
                    btnHeigth: 40.h,
                    btnWidth: width,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButtom(
                    onTap: () {
                      controllerlo.logout();
                    },
                    btnColor: kRed,
                    text: "Logout",
                    raduis: 0,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
