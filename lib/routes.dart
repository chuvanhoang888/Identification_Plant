import 'package:rice_disease_detection/insert_data_for_firebase.dart';
import 'package:rice_disease_detection/screens/complete_profile/complete_profile_screen.dart';
import 'package:rice_disease_detection/screens/home/home_screen.dart';

import 'package:rice_disease_detection/screens/otp/otp_screen.dart';
import 'package:rice_disease_detection/screens/scanner/scanner_screen.dart';
import 'package:rice_disease_detection/screens/search/search_screen.dart';
import 'package:rice_disease_detection/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/widgets.dart';

import 'package:rice_disease_detection/screens/forgot_password/forgot_password_screen.dart';
import 'package:rice_disease_detection/screens/login_success/login_success_screen.dart';
import 'package:rice_disease_detection/screens/sign_in/sign_in_screen.dart';
import 'package:rice_disease_detection/screens/splash_3/splash_screen.dart';
import 'package:rice_disease_detection/screens/profile/profile_screen.dart';
import 'package:rice_disease_detection/screens/detail/detail_screen.dart';

//Chúng ta sử dụng tên route - we use name route
//tất cả các tuyến đường của chúng tôi sẽ có sẵn ở đây - all our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpscreen.routeName: (context) => SignUpscreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ScannerScreen.routeName: (context) => ScannerScreen(),
  InsertData.routeName: (context) => InsertData(),
  //DetailScreen.routeName: (context) => DetailScreen()
  SearchScreen.routeName: (context) => SearchScreen()
};
