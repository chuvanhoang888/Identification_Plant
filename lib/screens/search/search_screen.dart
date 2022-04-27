import 'package:diacritic/diacritic.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rice_disease_detection/model/list_rice_diease_data.dart';
import 'package:rice_disease_detection/screens/detail/detail_screen.dart';
import 'package:rice_disease_detection/widgets/item_card.dart';

import '../../constants.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<RiceDisease> listDisease = [];
  List<RiceDisease> listSearch = [];
  bool showListview = false;
  Future<void> getListRiceDisease() async {
    listDisease.clear();
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
            listDisease.add(riceDiseases);
          });
        }
      }
    });
  }

  //Hàm xịn xò
  List<RiceDisease> listRiceSearch(String value) {
    //Get values từ cái thanh search, Bỏ hết dấu đi, So sánh với cái list bệnh
    listSearch.clear();
    for (RiceDisease rice in listDisease) {
      //Hàm remove nớ là bỏ dấu đó
      //Nếu rice name trong list có cái nào chứa (giống) values search thì add vô list mới
      if (removeDiacritics(rice.name.toLowerCase())
          .contains(removeDiacritics(value))) {
        listSearch.add(rice);
      }
    }
    return listSearch;
  }

  @override
  void initState() {
    super.initState();
    getListRiceDisease();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop()),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Colors.white, width: 1.0)),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10)),
                    SvgPicture.asset(
                      'assets/icons/search.svg',
                      color: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(
                        child: TextField(
                      onChanged: (String value) {
                        if (value.trim().isNotEmpty) {
                          value = value.trim().toLowerCase();
                          setState(() {
                            showListview = true;
                            listSearch = listRiceSearch(value);
                          });
                        } else {
                          setState(() {
                            showListview = false;
                          });
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tìm kiếm...',
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding:
                            EdgeInsets.only(left: 0, top: 12, bottom: 5),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: showListview == true
            ? listSearch.length == 0
                ? Center(
                    child: Text('Không tìm thấy gì!'),
                  )
                : Container(
                    // child: ListView(
                    padding: EdgeInsets.all(8.0),
                    //   children: listSearch.map((rice) => ItemCard()).toList(),
                    // ),
                    child: ListView.builder(
                        itemCount: listSearch.length,
                        itemBuilder: (context, index) {
                          return ItemCard(
                              title: listSearch[index].name,
                              image: listSearch[index].images,
                              text: listSearch[index].describe,
                              press: () {
                                RiceDisease riceDisease = new RiceDisease(
                                    listSearch[index].describe,
                                    listSearch[index].images,
                                    listSearch[index].name,
                                    listSearch[index].reasons,
                                    listSearch[index].solution,
                                    listSearch[index].idRice);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(riceDisease)));
                              });
                        }))
            : Container(),
      ),
    );
  }
}
