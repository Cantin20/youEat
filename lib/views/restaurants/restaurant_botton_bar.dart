import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youeat/common/custom_buttom.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/views/restaurants/rating_page.dart';
import 'package:youeat/views/restaurants/restaurant_page.dart';

class RestaurantBottonBar extends StatelessWidget {
  const RestaurantBottonBar({
    super.key,
    required this.widget,
  });

  final RestaurantPage widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RatingBarIndicator(
            itemCount: 5,
            itemSize: 20,
            rating: widget.restaurant!.rating,
            itemBuilder: (context, i) => const Icon(
                  Icons.star,
                  color: Colors.yellow,
                )),
        CustomButtom(
            onTap: () {
              Get.to(() => const RatingPage());
            },
            btnColor: kSecondary,
            btnWidth: 120.w,
            text: "Rate Restaurant")
      ],
    );
  }
}
