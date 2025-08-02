import 'package:bloc_clean_architecture/config/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarHelper {
  static toastMessage(
      {required String message,required BuildContext context, Color? backgroundColor}) {
    Flushbar(
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor:backgroundColor?? Colors.green,

      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
      ),
    ).show(context);
  }
}
