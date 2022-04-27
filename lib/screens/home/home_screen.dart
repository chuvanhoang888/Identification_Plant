import 'package:flutter/material.dart';
import 'package:rice_disease_detection/model/list_rice_diease_data.dart';
import 'package:rice_disease_detection/widgets/app_bar_home.dart';
import 'package:rice_disease_detection/widgets/bottom_nav_bar.dart';
import 'package:rice_disease_detection/widgets/buid_rice_shimmer.dart';
import 'package:rice_disease_detection/screens/detail/detail_screen.dart';
import 'package:rice_disease_detection/widgets/header_top.dart';
import 'package:rice_disease_detection/widgets/item_card.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../constants.dart';
import '../../enums.dart';
import '../../size_config.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RiceDisease> riceDiseaseList = [];
  bool wait = true;
  bool isLoading = false;

  Future<void> getListRiceDisease() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 1), () {});
    FirebaseDatabase.instance
        .reference()
        .child("Rice_disease")
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        var keys = snapshot.value.keys;
        var data = snapshot.value;
        //print(data);
        for (var individualKey in keys) {
          RiceDisease riceDiseases =
              new RiceDisease.fromValues(data[individualKey]);
          setState(() {
            riceDiseaseList.add(riceDiseases);
          });
        }
        setState(() {
          print('Length : $riceDiseaseList.length');
        });
      }
    }).whenComplete(() {
      setState(() {
        wait = false;
        setState(() => isLoading = false);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getListRiceDisease();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarHome(),
      body: Stack(
        children: [
          Container(
            //here the height of the container is 45% of our total height
            height: size.height * .50,
            decoration: BoxDecoration(
                color: kBlueLightColor_2,
                image: DecorationImage(
                    image: AssetImage("assets/images/virus.png"))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SafeArea(
                child: Column(
              children: [
                HeaderTop(size: size),
                Expanded(
                    child: ListView.builder(
                        itemCount: isLoading ? 7 : riceDiseaseList.length,
                        itemBuilder: (context, index) {
                          if (isLoading) {
                            return BuidRiceShimmer();
                          } else {
                            return ItemCard(
                                title: riceDiseaseList[index].name,
                                image: riceDiseaseList[index].images,
                                text: riceDiseaseList[index].describe,
                                press: () {
                                  RiceDisease riceDisease = new RiceDisease(
                                      riceDiseaseList[index].describe,
                                      riceDiseaseList[index].images,
                                      riceDiseaseList[index].name,
                                      riceDiseaseList[index].reasons,
                                      riceDiseaseList[index].solution,
                                      riceDiseaseList[index].idRice);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailScreen(riceDisease)));
                                });
                          }
                        }))
              ],
            )),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.home,
      ),
    );
  }
}
