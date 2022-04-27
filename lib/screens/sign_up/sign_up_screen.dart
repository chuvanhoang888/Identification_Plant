import 'package:flutter/material.dart';
import 'package:rice_disease_detection/constants.dart';

import '../../size_config.dart';
import 'components/body.dart';

class SignUpscreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Đăng ký"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
