import 'package:rice_disease_detection/constants.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: getProportionateScreenHeight(60),
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: kPrimaryColor,
                //side: BorderSide(width: 2, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                //padding: EdgeInsets.symmetric(vertical: 15),
                minimumSize: Size(350, 50)),

            //color: kPrimaryColor,
            onPressed: press,
            child: Text(
              text!,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
