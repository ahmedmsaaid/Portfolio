import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Alerts {
  static showMassage(BuildContext context, Widget widgets) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.withAlpha(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 0,
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 250,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r), // نصف الدائرة
              // لون الخلفية مع شفافية ), // لون الخلفية مع شفافية
            ),
            child: Center(child: widgets),
          ),
        );
      },
    );
  }
}
