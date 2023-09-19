import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/utils/color.dart';

Widget customButton(void Function() onpressed, String title) {
  return SizedBox(
    height: 20.h,
    width: ScreenUtil().screenWidth,
    child: ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
          backgroundColor: blueColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
      child: FittedBox(child: Text(title)),
    ),
  );
}
