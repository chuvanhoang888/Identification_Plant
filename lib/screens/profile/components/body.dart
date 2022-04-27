import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rice_disease_detection/components/default_button.dart';
import 'package:rice_disease_detection/constants.dart';
import 'package:rice_disease_detection/screens/profile/profile_screen.dart';
import 'package:rice_disease_detection/screens/sign_in/components/google_sign_in.dart';
import 'package:rice_disease_detection/screens/sign_in/sign_in_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    GoogleSignInProvider googleSignInProvider =
        Provider.of<GoogleSignInProvider>(
      context,
    );
    return user != null
        ? SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                ProfilePic(),
                SizedBox(height: 10),
                Text(
                  user != null ? user!.displayName.toString() : "Account",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  user != null ? user!.email.toString() : "account@gmail.com",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                ProfileMenu(
                  text: "My Account",
                  icon: "assets/icons/User Icon.svg",
                  press: () => {},
                ),
                ProfileMenu(
                  text: "Notifications",
                  icon: "assets/icons/Bell.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Settings",
                  icon: "assets/icons/Settings.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Help Center",
                  icon: "assets/icons/Question mark.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  press: () {
                    googleSignInProvider.logout();
                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  },
                ),
              ],
            ))
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: SvgPicture.asset(
                            "assets/icons/undraw_Access_account_re_8spm.svg"),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: kPrimaryColor,
                              //side: BorderSide(width: 2, color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              //padding: EdgeInsets.symmetric(vertical: 15),
                              minimumSize: Size(200, 50)),
                          onPressed: () => Navigator.pushNamed(
                              context, SignInScreen.routeName),
                          child: Text("Đăng nhập")),
                    ],
                  ),
                ],
              )
            ],
          );
  }
}
