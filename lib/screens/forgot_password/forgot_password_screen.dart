import 'package:flutter/material.dart';
import 'package:rice_disease_detection/constants.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
