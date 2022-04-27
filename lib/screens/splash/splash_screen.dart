import 'package:rice_disease_detection/screens/splash/components/body.dart';
import 'package:rice_disease_detection/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/spllash";
  //gox stl
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // bạn phải gọi nó trên màn hình bắt đầu của bạn
    return Scaffold(
      body: Body(),
    );
  }
}
