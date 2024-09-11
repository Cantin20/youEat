import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_otp_verification/phone_verification.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/controllers/phone_verification.dart';
import 'package:youeat/services/verification_services.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  VerificationService _verificationService = VerificationService();
  String _verificationId = '';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneVerificationController());
    return PhoneVerification(
      isFirstPage: false,
      enableLogo: false,
      themeColor: kPrimary,
      backgroundColor: kLightWhite,
      initialPageText: "Verify Phone Number",
      initialPageTextStyle: appStyle(20, kPrimary, FontWeight.bold),
      textColor: kDark,
      onSend: (String value) {
        controller.setPhoneNumber = value;
        _verifyPhoneNumber(value);
      },
      onVerification: (String value) {
        _submitVerificationCode(value);
      },
    );
  }

  void _verifyPhoneNumber(String phoneNumber) async {
    final controller = Get.put(PhoneVerificationController());

    await _verificationService.verifyPhoneNumber(controller.phone,
        codeSent: (String verificationId, int? resendToken) {
      setState(() {
        _verificationId = verificationId;
      });
    });
  }

  void _submitVerificationCode(String code) async {
    await _verificationService.verifySmsCode(_verificationId, code);
  }
}
