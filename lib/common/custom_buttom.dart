import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom(
      {super.key, this.onTap, this.btnHeigth, this.btnColor, this.btnWidth, this.raduis, required this.text});

  final void Function()? onTap;
  final double? btnWidth;
  final double? btnHeigth;
  final Color? btnColor;
  final double? raduis;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: btnWidth ?? width,
          height: btnHeigth ?? 28.h,
          decoration: BoxDecoration(
            color: btnColor ?? kPrimary,
            borderRadius: BorderRadius.circular(raduis ?? 9.r),
          ),
          child: Center(child: ReusableText(style:appStyle(12, kLightWhite, FontWeight.w500), text: text,)),
        ));
  }
}
