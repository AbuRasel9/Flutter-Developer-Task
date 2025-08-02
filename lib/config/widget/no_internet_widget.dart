import 'package:bloc_clean_architecture/config/widget/button_widget.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onTap;

  const NoInternetWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/no_internet_image.jpg",
              height: 220,
              width: 220,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "We are unable to show result.\nPlease check your data connection",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 50,
            ),
            ButtonWidget(
              buttonWidth:150,
              buttonText: 'Refresh',
              onPressed: onTap,
            )
          ],
        ),
      ),
    );
  }
}
