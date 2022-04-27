import 'package:flutter/material.dart';
import 'package:rice_disease_detection/constants.dart';

import '../../size_config.dart';
import 'components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: SizedBox(), //khiến nút back trở về biến mất
        title: Text("Login Success"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
