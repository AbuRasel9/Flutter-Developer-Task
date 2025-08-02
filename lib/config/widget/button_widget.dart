import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final double borderRadious, buttonWidth, buttonHeight;
  final Color buttonColor, buttonTextColor;
  final VoidCallback onPressed;

  const ButtonWidget(
      {super.key,
      required this.buttonText,
      this.borderRadious = 8,
      this.buttonWidth = double.infinity,
      this.buttonHeight = 40,
      this.buttonColor = AppColors.primaryColor,
      this.buttonTextColor = AppColors.whiteColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadious))),
          onPressed: (){
            onPressed();
          },
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: buttonTextColor,
            ),
          )),
    );
  }
}
