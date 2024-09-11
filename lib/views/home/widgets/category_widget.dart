import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/controllers/category_controller.dart';
import 'package:youeat/models/categories.dart';
import 'package:youeat/views/categories/all_categories.dart';

// ignore: must_be_immutable
class CategoryWidget extends StatelessWidget {
  CategoryWidget({
    super.key,
    required this.category,
  });

  CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return GestureDetector(
        onTap: () {
          if (controller.categoryValue == category.id) {
            controller.UpdateCategory = '';
            controller.UpdateTitle = '';
          } else if (category.value == 'more') {
            Get.to(() => const AllCategories(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 900));
          } else {
            controller.UpdateCategory = category.id;
            controller.UpdateTitle = category.title;
          }
        },
        child: Obx(
          () => Container(
            margin: EdgeInsets.only(right: 5.w),
            padding: EdgeInsets.only(top: 4.h),
            width: Get.width * 0.19,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                    color: controller.categoryValue == category.id
                        ? kSecondary
                        : kOffWhite,
                    width: .5.w)),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35.h / 2,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.network(
                      category.imageUrl,
                      width: 35.h,
                      height: 35.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ReusableText(
                  text: category.title,
                  style: appStyle(12, kDark, FontWeight.normal),
                ),
              ],
            ),
          ),
        ));
  }
}
