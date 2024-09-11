import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youeat/common/custom_appbar.dart';
import 'package:youeat/common/custom_container.dart';
import 'package:youeat/common/heading.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/controllers/category_controller.dart';
import 'package:youeat/views/home/all_fastest_food_page.dart';
import 'package:youeat/views/home/all_nearby_restaurants.dart';
import 'package:youeat/views/home/recommendation_page.dart';
import 'package:youeat/views/home/widgets/category_foods_widget.dart';
import 'package:youeat/views/home/widgets/category_list.dart';
import 'package:youeat/views/home/widgets/food_list.dart';
import 'package:youeat/views/home/widgets/nearby_restaurant_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(130.h), child: const CustomAppBar()),
        body: SafeArea(
            child: CustomContainer(
          containerContent: Column(
            children: [
              const CategoryList(),
              Obx(
                () => controller.categoryValue == '' ?Column(
                  children: [
                    Heading(
                      text: "Try Something New",
                      onTap: () {
                        Get.to(() => const Recommendations(),
                            transition: Transition.cupertino,
                            duration: const Duration(milliseconds: 900));
                      },
                    ),
                    const FoodsList(),
                    Heading(
                      text: "NearBy Restaurants",
                      onTap: () {
                        Get.to(() => const AllNearByRestaurants(),
                            transition: Transition.cupertino,
                            duration: const Duration(milliseconds: 900));
                      },
                    ),
                    const NearbyRestaurants(),
                    Heading(
                      text: "Food closer to you",
                      onTap: () {
                        Get.to(() => const AllFastestFood(),
                            transition: Transition.cupertino,
                            duration: const Duration(milliseconds: 900));
                      },
                    ),
                    const FoodsList(),
                  ],
                ): CustomContainer(
                  containerContent: Column(
                    children: [
                       Heading(
                        more: true,
                      text: "Explore ${controller.titleValue} Category",
                      onTap: () {
                        Get.to(() => const Recommendations(),
                            transition: Transition.cupertino,
                            duration: const Duration(milliseconds: 900));
                      },
                    ),

                    const CategoryFoodsList()
                    ],))
              ),
            ],
          ),
        )));
  }
}
