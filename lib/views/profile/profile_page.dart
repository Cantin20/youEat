import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youeat/common/custom_buttom.dart';
import 'package:youeat/common/custom_container.dart';
import 'package:youeat/common/profile_appbar.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/controllers/login_controller.dart';
import 'package:youeat/models/login_response.dart';
import 'package:youeat/views/login/login_redirect.dart';
import 'package:youeat/views/profile/profile_tile.dart';
import 'package:youeat/views/profile/shipping_address.dart';
import 'package:youeat/views/profile/user_info_widget.dart';
import 'package:youeat/views/verification_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;
    final controller = Get.put(LoginController());

    final box = GetStorage();
    String? token = box.read('token');

    if (token != null) {
      user = controller.getUserInfo();
    }

    if (token == null) {
      return const LoginRedirect();
    }

    if (user != null && user.verification == false) {
      return const VerificationPage();
    }
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.h), child: const ProfileAppBar()),
        body: SafeArea(
            child: CustomContainer(
          containerContent: Column(
            children: [
              UserInfoWidget(
                user: user,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 175.h,
                decoration: const BoxDecoration(
                  color: kLightWhite,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTile(
                      title: "My Orders",
                      icon: Ionicons.fast_food_outline,
                      onTap: () {
                        Get.to(() => const LoginRedirect());
                      },
                    ),
                    ProfileTile(
                      title: "My Favorite Places",
                      icon: Ionicons.heart_outline,
                      onTap: () {},
                    ),
                    ProfileTile(
                      title: "Reviews",
                      icon: Ionicons.chatbubble_outline,
                      onTap: () {},
                    ),
                    ProfileTile(
                      title: "Coupons",
                      icon: MaterialCommunityIcons.tag_outline,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 175.h,
                decoration: const BoxDecoration(
                  color: kLightWhite,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTile(
                      title: "Shipping Address",
                      icon: SimpleLineIcons.location_pin,
                      onTap: () {
                        Get.to(() => const ShippingAddress(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 900));
                      },
                    ),
                    ProfileTile(
                      title: "Service Center",
                      icon: AntDesign.customerservice,
                      onTap: () {},
                    ),
                    ProfileTile(
                      title: "FeedBack",
                      icon: MaterialIcons.rss_feed,
                      onTap: () {},
                    ),
                    ProfileTile(
                      title: "Settings",
                      icon: AntDesign.setting,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButtom(
                onTap: () {
                  controller.logout();
                },
                btnColor: kRed,
                text: "Logout",
                raduis: 0,
              )
            ],
          ),
        )));
  }
}
