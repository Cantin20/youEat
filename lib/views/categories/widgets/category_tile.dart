import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/controllers/category_controller.dart';
import 'package:youeat/models/categories.dart';
import 'package:youeat/views/categories/category_page.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return ListTile(
      onTap: () {
        controller.UpdateCategory = category.id;
        controller.UpdateTitle = category.title;
        Get.to(() => const CategoryPage(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 900));
      },
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: kGrayLight,
        child: ClipOval(
          // Ensure the image is clipped to a circle
          child: Image.network(
            category.imageUrl,
            width: 36
                .r, // Ensure the width and height match the diameter of the CircleAvatar
            height: 36.r,
            fit: BoxFit
                .cover, // Make sure the image covers the entire CircleAvatar
          ),
        ),
      ),
      title: ReusableText(
        text: category.title,
        style: appStyle(12, kGray, FontWeight.normal),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: kGray,
        size: 15.r,
      ),
    );
  }
}
