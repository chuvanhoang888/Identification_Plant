import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:rice_disease_detection/components/default_button.dart';
import 'package:rice_disease_detection/screens/home/home_screen.dart';
import 'package:rice_disease_detection/screens/sign_in/sign_in_screen.dart';

import 'package:rice_disease_detection/screens/splash_3/components/splash_content.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "image": "assets/images/onboarding0.png",
      "tittle": "Chào mừng đến với ứng dụng !",
      "text": "Ứng dụng giúp mọi người nhận dạng sâu bệnh trên cây lúa"
    },
    {
      "image": "assets/images/onboarding1.png",
      "tittle": "Giao diện thân thiện !",
      "text": "Chúng tôi giúp mọi người nhận dạng sâu bệnh trên cây lúa"
    },
    {
      "image": "assets/images/onboarding2.png",
      "tittle": "Nhận dạng !",
      "text": "Dễ sử dụng nhận dạng sâu bệnh nhanh chóng"
    }
  ];

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < splashData.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void confirmed() {
    print('Slider confirmed!');
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
              0.1,
              0.4,
              0.7,
              0.9
            ],
                colors: [
              Color(0xFF3594DD),
              Color(0xFF4563DB),
              Color(0xFF5036D5),
              Color(0xFF5B16D0),
            ])),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, HomeScreen.routeName),
                    child: Text(
                      "Skip",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  //height: 500.0,
                  child: PageView.builder(
                    itemCount: splashData.length,
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) => SplashContent(
                        image: splashData[index]["image"],
                        text: splashData[index]["text"],
                        tittle: splashData[index]["tittle"]),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    _currentPage != splashData.length - 1
                        ? BuildNextButton(pageController: _pageController)
                        : Text(''),
                    //end buil Next button
                    _currentPage == splashData.length - 1
                        ? SizedBox(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                DefaultButton(
                                  text: "Đăng nhập",
                                  press: () => Navigator.pushNamed(
                                      context, SignInScreen.routeName),
                                ),
                              ],
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),
              //Buil button Next
            ],
          ),
        ),
      ),
    );
  }
}

class BuildNextButton extends StatelessWidget {
  const BuildNextButton({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomRight,
      child: TextButton(
        onPressed: () {
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        child: Container(
          width: 50,
          height: 50,
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.black,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
