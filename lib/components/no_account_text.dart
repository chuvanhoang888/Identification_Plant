import 'package:rice_disease_detection/screens/forgot_password/forgot_password_screen.dart';
import 'package:rice_disease_detection/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bạn không cso tài khoản? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpscreen.routeName),
          child: Text(
            "Đăng ký",
            style: TextStyle(fontSize: 16, color: kPrimaryColor),
          ),
        )
      ],
    );
  }
}
