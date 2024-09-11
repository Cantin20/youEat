import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/back_ground_container.dart';
import 'package:youeat/common/custom_buttom.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/registration_model.dart';
import 'package:youeat/views/login/email_textfield.dart';
import 'package:youeat/views/login/password_textfield.dart';
import 'package:youeat/views/login/registration_controller.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _usernameController =
      TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimary,
          title: Center(
            child: ReusableText(
              text: "YOUEAT",
              style: appStyle(20, kLightWhite, FontWeight.bold),
            ),
          ),
        ),
        body: BackGroundContainer(
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r)),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Lottie.asset("assets/anime/delivery.json"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      EmailTextField(
                        hintText: " username",
                        prefixIcon: const Icon(
                          Icons.near_me_outlined,
                          size: 22,
                          color: kGrayLight,
                        ),
                        controller: _usernameController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      EmailTextField(
                        hintText: "Enter Email",
                        prefixIcon: const Icon(
                          CupertinoIcons.mail,
                          size: 22,
                          color: kGrayLight,
                        ),
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      PasswordTextField(
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButtom(
                        text: "R E G I S T E R",
                        onTap: () {
                          if (_emailController.text.isNotEmpty &&
                              _usernameController.text.isNotEmpty &&
                              _passwordController.text.length >= 8) {
                            RegistrationModel model = RegistrationModel(
                                username: _usernameController.text,
                                email: _emailController.text,
                                password: _passwordController.text);

                            String data = registrationModelToJson(model);

                            controller.registrationFunction(data);
                          }
                        },
                        btnHeigth: 40.h,
                        btnWidth: width,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
