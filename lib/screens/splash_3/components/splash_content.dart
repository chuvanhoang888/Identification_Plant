import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
    this.tittle,
  }) : super(key: key);
  final String? tittle, text, image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              height: 300.0,
              width: 300.0,
              image: AssetImage(image!),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            tittle!,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w900, color: Colors.white),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            text!,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
