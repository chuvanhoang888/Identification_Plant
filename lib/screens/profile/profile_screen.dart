import 'package:rice_disease_detection/constants.dart';

import 'package:rice_disease_detection/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:rice_disease_detection/enums.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Body(),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}
