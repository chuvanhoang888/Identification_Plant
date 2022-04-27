import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../size_config.dart';

class TestScreen extends StatelessWidget {
  static String routeName = "/splash";
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => FirebaseFirestore.instance
            .collection("testing")
            .add({'timestamp': Timestamp.fromDate(DateTime.now())}),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('testing').snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (!snapshot.hasData) return const SizedBox.shrink();
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final docData = snapshot.data!.docs[index].data();
                final docd = docData as Map;
                final dataTime = (docd['timestamp'] as Timestamp).toDate();
                return ListTile(
                  title: Text(dataTime.toString()),
                );
              });
        },
      ),
    );
  }
}
