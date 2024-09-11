import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(int size, Color color, FontWeight fw) {
  return GoogleFonts.poppins(color: color, fontWeight: fw, fontSize: size.sp);
}
