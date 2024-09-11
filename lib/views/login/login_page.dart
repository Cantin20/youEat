import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/back_ground_container.dart';
import 'package:youeat/common/custom_buttom.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/controllers/login_controller.dart';
import 'package:youeat/models/login_model.dart';
import 'package:youeat/views/login/email_textfield.dart';
import 'package:youeat/views/login/password_textfield.dart';
import 'package:youeat/views/login/registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
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
    final controller = Get.put(LoginController());
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
                        hintText: "Enter Email",
                        prefixIcon: const Icon(
                          CupertinoIcons.mail,
                          size: 22,
                          color: kGrayLight,
                        ),
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      PasswordTextField(
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButtom(
                        text: " L O G I N",
                        onTap: () {
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.length >= 8) {
                            LoginModel model = LoginModel(
                                email: _emailController.text,
                                password: _passwordController.text);

                            String data = loginModelToJson(model);

                            controller.loginFunction(data);
                          }
                        },
                        btnHeigth: 40.h,
                        btnWidth: width,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.to(() => const RegistrationPage(),
                                    transition: Transition.fadeIn,
                                    duration:
                                        const Duration(milliseconds: 900));
                              },
                              child: ReusableText(
                                  text: "Resgister now",
                                  style: appStyle(
                                      12, Colors.blue, FontWeight.bold))),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
