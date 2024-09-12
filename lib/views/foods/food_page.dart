// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/custom_buttom.dart';
import 'package:youeat/common/custom_text_field.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/controllers/cart_controller.dart';
import 'package:youeat/controllers/foods_controller.dart';
import 'package:youeat/controllers/login_controller.dart';
import 'package:youeat/hooks/fetch_restaurant.dart';
import 'package:youeat/models/cart_request.dart';
import 'package:youeat/models/foods_model.dart';
import 'package:youeat/models/login_response.dart';
import 'package:youeat/models/order_request.dart';
import 'package:youeat/models/restaurant_model.dart';
import 'package:youeat/views/auth/phone_verication_page.dart';
import 'package:youeat/views/login/login_redirect.dart';
import 'package:youeat/views/order/order_page.dart';
import 'package:youeat/views/restaurants/restaurant_page.dart';

class FoodPage extends StatefulHookWidget {
  const FoodPage({super.key, required this.food});

  final FoodsModel food;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final TextEditingController _preferences = TextEditingController();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartContrller());
    LoginResponse? user;
    final hookResult = useFetchRestaurant(widget.food.restaurant);
    RestaurantsModel? restaurant = hookResult.data;
    final controller = Get.put(FoodController());
    final loginController = Get.put(LoginController());
    user = loginController.getUserInfo();
    controller.loadAdditives(widget.food.additives);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.r),
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: 230.h,
                  child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (i) {
                        controller.changedPage(i);
                      },
                      itemCount: widget.food.imageUrl.length,
                      itemBuilder: (context, i) {
                        return Container(
                          width: width,
                          height: 230.h,
                          color: kLightWhite,
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.food.imageUrl[i]),
                        );
                      }),
                ),
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.food.imageUrl.length,
                          (index) {
                            return Container(
                              margin: EdgeInsets.all(4.h),
                              width: 10.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.currentPage == index
                                      ? kSecondary
                                      : kGrayLight),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  left: 12.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Ionicons.chevron_back_circle,
                      color: kPrimary,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    right: 12.w,
                    child: CustomButtom(
                      onTap: () {
                        Get.to(
                            () => RestaurantPage(restaurant: hookResult.data));
                      },
                      text: "Open Restaurant",
                      btnWidth: 120.w,
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: widget.food.title,
                        style: appStyle(18, kDark, FontWeight.w600)),
                    Obx(
                      () => ReusableText(
                          text:
                              " ${(widget.food.price + controller.additivePrice) * controller.count.value} FCFA",
                          style: appStyle(18, kPrimary, FontWeight.w500)),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  widget.food.description,
                  textAlign: TextAlign.justify,
                  maxLines: 8,
                  style: appStyle(14, kGray, FontWeight.w400),
                ),
                SizedBox(
                  height: 8.h,
                ),
                SizedBox(
                  height: 18.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        List.generate(widget.food.foodTags.length, (index) {
                      final tag = widget.food.foodTags[index];
                      return Container(
                        margin: EdgeInsets.only(right: 5.w),
                        decoration: BoxDecoration(
                            color: kPrimary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: ReusableText(
                              text: tag,
                              style: appStyle(11, kWhite, FontWeight.w400)),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ReusableText(
                    text: "Additives and Toppings",
                    style: appStyle(18, kDark, FontWeight.w600)),
                SizedBox(
                  height: 10.h,
                ),
                Obx(
                  () => Column(
                    children:
                        List.generate(controller.additivesList.length, (index) {
                      final additive = controller.additivesList[index];

                      return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          activeColor: kPrimary,
                          tristate: false,
                          value: additive.isChecked.value,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReusableText(
                                  text: additive.title,
                                  style: appStyle(11, kDark, FontWeight.w400)),
                              SizedBox(
                                width: 5.w,
                              ),
                              ReusableText(
                                  text: additive.price + "FCFA",
                                  style:
                                      appStyle(11, kPrimary, FontWeight.w600)),
                            ],
                          ),
                          onChanged: (bool? value) {
                            additive.toggleChecked();
                            controller.getTotalPrice();
                            controller.getCartAdditive();
                          });
                    }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: "Qauntity",
                        style: appStyle(15, kDark, FontWeight.w500)),
                    SizedBox(
                      width: 5.w,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.increment();
                          },
                          child: Icon(AntDesign.pluscircleo),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Obx(
                              () => ReusableText(
                                  text: "${controller.count.value}",
                                  style: appStyle(14, kDark, FontWeight.w600)),
                            )),
                        GestureDetector(
                          onTap: () {
                            controller.decrement();
                          },
                          child: Icon(AntDesign.minuscircleo),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                ReusableText(
                    text: "Preferences",
                    style: appStyle(15, kDark, FontWeight.w600)),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  height: 65.h,
                  child: CustomTextWidget(
                    controller: _preferences,
                    hintText: "Add a note with your preferences",
                    maxlines: 3,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (user == null) {
                            Get.to(() => LoginRedirect());
                          } else if (user.phoneVerification == false) {
                            //print("Place Order");
                            showVerificationSheet(context);
                          }
                          {
                            double price =
                                (widget.food.price + controller.additivePrice) *
                                    controller.count.value;

                            OrderItem item = OrderItem(
                                foodId: widget.food.id,
                                quantity: controller.count.value,
                                price: price,
                                additives: controller.getCartAdditive(),
                                instructions: _preferences.text);

                            //Create OrderItem

                            Get.to(
                                () => OrderPage(
                                      item: item,
                                      restaurant: restaurant,
                                      food: widget.food,
                                    ),
                                transition: Transition.cupertino,
                                duration: Duration(milliseconds: 900));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: ReusableText(
                              text: "Place Order",
                              style:
                                  appStyle(18, kLightWhite, FontWeight.w600)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          double price =
                              (widget.food.price + controller.additivePrice) *
                                  controller.count.value;
                          var data = CartModel(
                              productId: widget.food.id,
                              additives: controller.getCartAdditive(),
                              quantity: controller.count.value,
                              totalPrice: price);

                          String cart = cartModelToJson(data);

                          cartController.addToCart(cart);
                        },
                        child: CircleAvatar(
                          backgroundColor: kSecondary,
                          radius: 20.r,
                          child: Icon(
                            Ionicons.cart,
                            color: kLightWhite,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> showVerificationSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        showDragHandle: true,
        builder: (BuildContext context) {
          return Container(
            height: 500.h,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/restaurant_bk.png"),
                    fit: BoxFit.fill),
                color: kLightWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r))),
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  ReusableText(
                      text: "Verify Your Phone Number",
                      style: appStyle(18, kPrimary, FontWeight.w600)),
                  SizedBox(
                      height: 250.h,
                      child: Column(
                        children:
                            List.generate(verificationReasons.length, (index) {
                          return ListTile(
                            leading: Icon(
                              Icons.check_circle_outline,
                              color: kPrimary,
                            ),
                            title: Text(
                              verificationReasons[index],
                              textAlign: TextAlign.justify,
                              style:
                                  appStyle(11, kGrayLight, FontWeight.normal),
                            ),
                          );
                        }),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButtom(
                    text: "Verify Phone number",
                    btnHeigth: 35.h,
                    onTap: () {
                      Get.to(() => const PhoneVerificationPage());
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
