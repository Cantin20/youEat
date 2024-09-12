import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/custom_container.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/common/shimmers/foodlist_shimmer.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/controllers/login_controller.dart';
import 'package:youeat/hooks/fetch_cart.dart';
import 'package:youeat/models/cart_response.dart';
import 'package:youeat/models/login_response.dart';
import 'package:youeat/views/cart/widget/cart_tile.dart';
import 'package:youeat/views/login/login_redirect.dart';
import 'package:youeat/views/verification_page.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    LoginResponse? user;

    final box = GetStorage();
    final hookResults = fetchCart();
    final List<CartResponse> carts = hookResults.data ?? [];
    final isLoading = hookResults.isLoading;
    //final ApiError = hookResults.error;
    final refetch = hookResults.refetch;
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kOffWhite,
          title: Center(
            child: ReusableText(
              text: "Cart",
              style: appStyle(20, kGray, FontWeight.w600),
            ),
          ),
        ),
        body: SafeArea(
            child: CustomContainer(
          containerContent: isLoading
              ? const FoodsListShimmer()
              : Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
                child: SizedBox(
                    width: width,
                    height: height,
                    child: ListView.builder(
                        itemCount: carts.length,
                        itemBuilder: (context, i) {
                          var cart = carts[i];
                          return CartTile(
                            refetch: refetch,
                            color: kLightWhite,
                            cart: cart);
                        }),
                  ),
              ),
        )));
  }
}
