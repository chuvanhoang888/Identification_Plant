import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rice_disease_detection/constants.dart';
import 'package:rice_disease_detection/screens/home/home_screen.dart';

import 'package:rice_disease_detection/screens/login_success/login_success_screen.dart';

import '../../size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Có lỗi!"),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kBlueLightColor_2,
              centerTitle: true,
              title: Text("Đăng nhập"),
            ),
            body: Body(),
          );
        }
      },
    );
  }
}
