import 'package:rice_disease_detection/constants.dart';
import 'package:rice_disease_detection/widgets/bottom_nav_bar.dart';
import 'package:rice_disease_detection/screens/scanner/components/body.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class ScannerScreen extends StatelessWidget {
  static String routeName = "/scanner";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Rice Disease Detection",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      key: _scaffoldKey,
      body: Body(),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.detection,
      ),
    );
  }
}
