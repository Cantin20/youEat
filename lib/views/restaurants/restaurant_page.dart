import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/restaurant_model.dart';
import 'package:youeat/views/restaurants/direction_page.dart';
import 'package:youeat/views/restaurants/widget/explore_widget.dart';
import 'package:youeat/views/restaurants/widget/restaurant_menu.dart';

import 'restaurant_botton_bar.dart';
import 'widget/row_text.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.restaurant});
  final RestaurantsModel? restaurant;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: kLightWhite,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  // Restaurant Image
                  SizedBox(
                    height: 230.h,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.restaurant!.imageUrl,
                    ),
                  ),
                  // Top Navigation Row
                  Positioned(
                    top: 30.h,
                    left: 10.w,
                    right: 10.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Ionicons.chevron_back_circle,
                            size: 24,
                            color: kLightWhite,
                          ),
                        ),
                        ReusableText(
                          text: widget.restaurant!.title,
                          style: appStyle(16, kLightWhite, FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const DirectionPage());
                          },
                          child: const Icon(
                            Ionicons.location,
                            size: 24,
                            color: kLightWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Restaurant Bottom Bar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      width: double.infinity,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: kPrimary.withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.r),
                          topLeft: Radius.circular(8.r),
                        ),
                      ),
                      child: RestaurantBottonBar(widget: widget),
                    ),
                  ),
                ],
              ),
              // Restaurant Information Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RowText(
                      first: "Distance to restaurant",
                      second: "2.7km",
                    ),
                    SizedBox(height: 3.h),
                    const RowText(
                      first: "Estimated Price",
                      second: "1000FCFA",
                    ),
                    SizedBox(height: 3.h),
                    const RowText(
                      first: "Estimated Time",
                      second: "15 Mins",
                    ),
                    const Divider(
                      thickness: 0.7,
                      color: kGrayLight,
                    ),
                  ],
                ),
              ),
              // Tab Bar

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Container(
                  height: 40.h,
                  width: width,
                  decoration: BoxDecoration(
                    color: kOffWhite,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    labelColor: kLightWhite,
                    labelPadding: EdgeInsets.zero,
                    unselectedLabelColor: kGrayLight,
                    labelStyle: appStyle(12, kLightWhite, FontWeight.normal),
                    tabs: [
                      Tab(
                        child: SizedBox(
                          width: width / 2,
                          height: 25,
                          child: Center(
                            child: Text("Menu"),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: width / 2,
                          height: 25,
                          child: Center(
                            child: Text("Explore"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SizedBox(
                  height: height,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      RestaurantMenu(restaurantId: widget.restaurant!.id),
                      ExploreWidget(code: widget.restaurant!.code),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
