import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/back_ground_container.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/common/shimmers/foodlist_shimmer.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/controllers/category_controller.dart';
import 'package:youeat/hooks/fetch_category_foods.dart';
import 'package:youeat/models/foods_model.dart';
import 'package:youeat/views/home/widgets/food_tile.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    final hookResults = useFetchFoodsByCategory('41007428');
    List<FoodsModel>? foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kOffWhite,
        leading: IconButton(
          onPressed: () {
            controller.UpdateCategory = '';
            controller.UpdateTitle = '';
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kDark,
          ),
          color: kGray,
        ),
        title: ReusableText(
          style: appStyle(
            13,
            kGray,
            FontWeight.w600,
          ),
          text: "${controller.titleValue} Category",
        ),
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: SizedBox(
          height: height,
          child: isLoading
              ? const FoodsListShimmer()
              : Padding(
                  padding: EdgeInsets.all(12.h),
                  child: ListView(
                    children: List.generate(foods!.length, (i) {
                      FoodsModel food = foods[i];
                      return FoodTile(
                        food: food,
                      );
                    }),
                  ),
                ),
        ),
      ),
    );
  }
}
