import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youeat/common/shimmers/nearby_shimmer.dart';
import 'package:youeat/hooks/fetch_restaurants.dart';
import 'package:youeat/models/restaurant_model.dart';
import 'package:youeat/views/home/widgets/restaurant_widget.dart';
import 'package:youeat/views/restaurants/restaurant_page.dart';

class NearbyRestaurants extends HookWidget {
  const NearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchRestaurants("41007428");
    List<RestaurantsModel>? restaurants = hookResults.data;
    final isLoading = hookResults.isLoading;
    return isLoading
        ? const NearbyShimmer()
        : Container(
            height: 190.h,
            padding: EdgeInsets.only(left: 12.w, top: 10.h),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(restaurants!.length, (i) {
                RestaurantsModel restaurant = restaurants[i];
                return RestaurantWidget(
                    onTap: () {
                      Get.to(() => RestaurantPage(restaurant: restaurant));
                    },
                    image: restaurant.imageUrl,
                    logo: restaurant.logoUrl,
                    title: restaurant.title,
                    time: restaurant.time,
                    rating: restaurant.ratingCount);
              }),
            ),
          );
  }
}
