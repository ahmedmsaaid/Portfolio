import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Alerts {
  static showMassage(BuildContext context, List<String> titles) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent.withOpacity(.6),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 220.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
            child: GridView.builder(
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "https://github.com/ahmedmsaaid/assets/blob/main/${titles[index]}/$index.jpeg"),
                        fit: BoxFit.cover),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
            ),
          ),
        );
      },
    );
  }
}
