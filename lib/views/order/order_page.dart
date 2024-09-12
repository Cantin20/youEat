import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/back_ground_container.dart';
import 'package:youeat/common/custom_buttom.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/foods_model.dart';
import 'package:youeat/models/order_request.dart';
import 'package:youeat/models/restaurant_model.dart';
import 'package:youeat/views/order/widget/order_tile.dart';
import 'package:youeat/views/restaurants/widget/row_text.dart';

class OrderPage extends StatefulWidget {
  const OrderPage(
      {super.key, this.restaurant, required this.food, required this.item});
  final RestaurantsModel? restaurant;
  final FoodsModel food;
  final OrderItem item;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
            backgroundColor: kPrimary,
            title: Center(
              child: ReusableText(
                text: "Complete Ordering",
                style: appStyle(13, kLightWhite, FontWeight.w600),
              ),
            )),
        body: BackGroundContainer(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                OrderTile(food: widget.food),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  width: width,
                  height: height / 2.5,
                  decoration: BoxDecoration(
                      color: kOffWhite,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                              text: widget.restaurant!.title,
                              style: appStyle(20, kGray, FontWeight.bold)),
                          CircleAvatar(
                            radius: 18.r,
                            backgroundColor: kPrimary,
                            backgroundImage:
                                NetworkImage(widget.restaurant!.logoUrl),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      RowText(first: "Hours", second: widget.restaurant!.time),
                      SizedBox(
                        height: 5.h,
                      ),
                      const RowText(
                          first: "Distance from Restaurant", second: " 1.5 Km"),
                      SizedBox(
                        height: 5.h,
                      ),
                      const RowText(
                          first: "Delivery Price", second: "1000.0 FcFa"),
                      SizedBox(
                        height: 5.h,
                      ),
                      RowText(
                          first: "Order Total",
                          second: widget.item.price.toString() + "FcFa"),
                      SizedBox(
                        height: 5.h,
                      ),
                      ReusableText(
                          text: "Additives",
                          style: appStyle(18, kGray, FontWeight.bold)),
                      SizedBox(
                        width: width,
                        height: 15.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.item.additives.length,
                            itemBuilder: (context, i) {
                              String additive = widget.item.additives[i];
                              return Container(
                                margin: EdgeInsets.only(right: 5.w),
                                decoration: BoxDecoration(
                                  color: kSecondaryLight,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(9.r),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(2.h),
                                    child: ReusableText(
                                        text: additive,
                                        style: appStyle(
                                            10, kGray, FontWeight.w400)),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButtom(
                  text: "Proceed to payment",
                  btnHeigth: 40,
                  onTap: () {},
                )
              ],
            ),
          ),
        ));
  }
}
