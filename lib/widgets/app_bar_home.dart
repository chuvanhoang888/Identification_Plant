import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rice_disease_detection/screens/scanner/scanner_screen.dart';

import '../size_config.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const AppBarHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg", color: Colors.white),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, ScannerScreen.routeName),
          icon: SvgPicture.asset(
            "assets/icons/scan.svg",
            color: Colors.white,
            height: SizeConfig.defaultSize * 2.4,
          ),
        ),
        Center(
          child: Text(
            "Scan",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: SizeConfig.defaultSize,
        )
      ],
    );
  }
}
