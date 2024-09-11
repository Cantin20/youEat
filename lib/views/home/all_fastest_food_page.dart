import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/back_ground_container.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/common/shimmers/foodlist_shimmer.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/hooks/fetch_all_foods.dart';
import 'package:youeat/models/foods_model.dart';
import 'package:youeat/views/home/widgets/food_tile.dart';

class AllFastestFood extends HookWidget {
  const AllFastestFood({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchAllFoods('41007428');
    List<FoodsModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
        backgroundColor: kSecondary,
        appBar: AppBar(
          backgroundColor: kSecondary,
          elevation: 0,
          title: ReusableText(
            text: "Fastest Foods",
            style: appStyle(13, kLightWhite, FontWeight.w600),
          ),
        ),
        body: BackGroundContainer(
          color: Colors.white,
          child: isLoading
                ? const FoodsListShimmer()
                : Padding(
            padding: EdgeInsets.all(12.h),
            child:  ListView(
                    children: List.generate(foods!.length, (i) {
                      FoodsModel food = foods[i];
                      return FoodTile(
                        food: food,
                      );
                    }),
                  ),
          ),
        ));
  }
}
