import 'package:rice_disease_detection/constants.dart';
import 'package:rice_disease_detection/screens/sign_in/sign_in_screen.dart';
import 'package:rice_disease_detection/size_config.dart';
import 'package:flutter/material.dart';

//đây là cách thực hành tốt nhất
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"image": "assets/images/lua.png", "text": "Chào mừng đến với ứng dụng !"},
    {
      "image": "assets/images/lua2.png",
      "text": "Chúng tôi giúp mọi người \nNhận dạng sâu bệnh trên cây lúa"
    },
    {
      "image": "assets/images/lua3.png",
      "text": "Dễ sử dụng. \nNhận dạng sâu bệnh nhanh chóng"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Dùng khi màn tai thỏ
      child: SizedBox(
        width: double
            .infinity, //dùng sizedBox với thuộc tính width giúp đưa nó ra giữa màn hình
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]["text"],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(splashData.length,
                            (index) => buildDot(index: index)),
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      DefaultButton(
                        text: "Continue",
                        press: () {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
