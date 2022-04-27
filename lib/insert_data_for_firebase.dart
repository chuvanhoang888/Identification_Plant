import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rice_disease_detection/constants.dart';

class InsertData extends StatefulWidget {
  static String routeName = "/insert_data";
  const InsertData({Key? key}) : super(key: key);

  @override
  _InsertDataState createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  Timer? _timer;
  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("Rice_disease");

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    //EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  void sendData() async {
    //EasyLoading.showProgress(0.3);
    EasyLoading.show(status: 'Insert Data...');
    database.push().set({
      "id": 8,
      "name": "Bệnh sâu cuốn lá",
      "images":
          "https://firebasestorage.googleapis.com/v0/b/rice-disease-detection-f7469.appspot.com/o/saucuonla.jpg?alt=media&token=b5b6f11a-a7a6-4dfa-8d2a-871365f2d985",
      "describe":
          "Lá lúa bị cuốn, sâu non ăn biểu bì mặt trên và diệp lục của lá dọc theo gân lá tạo thành những vệt trắng dài, các vệt này có thể nối liền với nhau thành từng mảng làm giảm diện tích quang hợp và đặc biệt là trên lá đòng hoặc lá công năng sẽ làm giảm năng suất rõ rệt.",
      "reasons":
          "Ngài trưởng thành hoạt động đẻ trứng về đêm, ban ngày ẩn nấp, có xu tính mạnh với ánh sáng, con cái mạnh hơn con đực. Ngài thường tìm những ruộng xanh tốt để đẻ trứng, mỗi con cái có thể đẻ trên 100 quả trứng, rải rác trên lá lúa.\nSâu non có 5 tuổi: Tuổi 1 rất linh hoạt có thể bò khắp trên lá, chui vào lá nõn, mặt trong bẹ lá hoặc bao lá cũ; tuổi 2, 3 trở đi nhả tơ để khâu 2 mép lá cuốn thành tổ nằm trong đó gây hại. Sâu có khả năng di chuyển ra khỏi bao cũ để phá hại lá mới, mỗi con sâu non có thể phá hại từ 5 -9 lá, thời gian di chuyển thường vào buổi chiều (từ 6 giờ - 9 giờ tối), ngày trời mưa hoặc râm mát thì có thể di chuyển bất cứ lúc nào trong ngày. Sâu non đẫy sức chuyển màu vàng hồng chui ra khỏi bao bò xuống gốc lúa, bẹ lá dệt kén mỏng hoá nhộng hoặc hoá nhộng ngay trong bao cũ.",
      "solution":
          "Biện pháp sinh học: Chú ý bảo vệ hoặc bổ sung thiên địch như ong mắt đỏ Trichogramma sp., nấm… Ký sinh thiên địch của sâu cuốn lá nhỏ rất đa dạng từ các loài ong, nấm, các loài ăn thịt…\nBiện pháp hóa học: Dùng các loại thuốc Padan 95SP, Regent 800WP, Sumithion 50EC, Karate 2.5EC... phun khi sâu còn tuổi 1-2, sâu đã lớn cần phá bao lá trước khi phun mới có hiệu quả."
    });
    EasyLoading.showSuccess('Insert Success!');
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Insert Data Firebase",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          sendData();
        },
      ),
    );
  }
}
