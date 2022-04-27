import 'dart:async';
import 'dart:io';
import 'dart:convert' show utf8;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rice_disease_detection/components/default_button.dart';
import 'package:rice_disease_detection/constants.dart';
import 'package:rice_disease_detection/model/list_rice_diease_data.dart';
import 'package:rice_disease_detection/screens/profile/components/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:rice_disease_detection/screens/detail/detail_screen.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Timer? _timer;
  File? _imageFile;
  String? _nameX;
  String? _idRice;
  String? _url;
  //PickedFile _imageFile;
  final _picker = ImagePicker();
  final _amountController = TextEditingController();
  final List<RiceDisease> listRiceDisease = [];

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    getListRiceDisease();
    //EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  Future<void> getListRiceDisease() async {
    //setState(() => isLoading = true);
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
            listRiceDisease.add(riceDiseases);
          });
        }
      }
    }).whenComplete(() {
      print('Length : ${listRiceDisease.length}');
      setState(() {
        // wait = false;
        // setState(() => isLoading = false);
      });
    });
  }

  void _asyncFileUpload(File file) async {
    var uploadURL = "$_url" + "/file/";
    var uri = Uri.parse(uploadURL);
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", uri);
    //add text fields
    //request.fields["text_field"] = text;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("file", file.path);
    //add multipart to request
    request.files.add(pic);
    EasyLoading.show(status: 'Detect...');
    var response = await request.send();

    //Get the response from the server
    if (response.statusCode == 200) {
      EasyLoading.showSuccess('Detected Success!');
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      // var encoded = utf8.encode(responseString);
      // var decoded = utf8.decode(encoded);
      var result = utf8.decode(responseString.runes.toList());
      var result_2 = result.split("_");
      setState(() {
        _nameX = result_2[0];
        _idRice = result_2[1];
      });
      print(result_2);
      print("id -> ${_idRice}");
      EasyLoading.dismiss();
    }
  }

  void takePhoto(ImageSource source) async {
    final picture = await _picker.getImage(source: source);
    setState(() {
      _nameX = null;
      _imageFile = File(picture!.path);
      //_imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Widget _decideImageView() {
    if (_imageFile == null) {
      return Container(
        padding: EdgeInsets.all(60),
        child: SvgPicture.asset(
          "assets/icons/barcode-scanner (1).svg",
          width: 100,
          height: 100,
        ),
      );
    } else {
      return Image.file(_imageFile!);
      //return Image.file(File(_imageFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: kPrimaryColor,
      //   onPressed: () async => newMethod(context),
      //   child: Icon(Icons.camera_alt_outlined),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 360,
                  height: 50,
                  //color: Colors.black,
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    controller: _amountController,
                    onChanged: (value) {
                      //Search value
                      //getURL(value);
                      setState(() {
                        _url = value;
                      });
                    },
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "HTTP URL",
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 360,
                  width: 360,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 4), // changes position of shadow
                        )
                      ],
                    ),
                    child: _decideImageView(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.3,
                  child: DefaultButton(
                    text: "Thêm ảnh",
                    press: () async {
                      newMethod(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.3,
                  child: DefaultButton(
                    text: "Kiểm tra",
                    press: () {
                      _asyncFileUpload(_imageFile!);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _nameX != null
                ? ProfileMenu(
                    text: '$_nameX',
                    icon: "assets/icons/bug.svg",
                    press: () {
                      if (listRiceDisease != null) {
                        listRiceDisease.forEach((element) {
                          print("id:${element.idRice}");
                          if (_idRice == element.idRice) {
                            RiceDisease rice = new RiceDisease(
                                element.describe,
                                element.images,
                                element.name,
                                element.reasons,
                                element.solution,
                                element.idRice);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(rice)));
                          } else {
                            print("mmm");
                          }
                        });
                      }
                    })
                : Text(""),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> newMethod(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Make a choice!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      takePhoto(ImageSource.camera);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
