import 'dart:io';
import 'dart:js';

import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:verification/service/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class Viewcsv extends StatefulWidget {
  const Viewcsv({super.key});

  @override
  State<Viewcsv> createState() => _ViewcsvState();
}

class _ViewcsvState extends State<Viewcsv> {
  TextEditingController namecontoller = new TextEditingController();
  TextEditingController eventnamecontoller = new TextEditingController();
  TextEditingController phonenumbercontoller = new TextEditingController();
  TextEditingController datecontoller = new TextEditingController();
  TextEditingController locationcontoller = new TextEditingController();
  TextEditingController upinocontoller = new TextEditingController();

  // Stream? getcsvfile;
  // getontheload() async {
  //   getcsvfile = await DatabaseMethod().getcsvdetail();
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   getontheload();
  //   super.initState();
  // }

  // Widget allcsvdetails() {
  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance
  //         .collection("customerdetail")
  //         .doc("XT9F5M68ht")
  //         .collection("csvdetail")
  //         .snapshots(),
  //     builder: (context, AsyncSnapshot snapshot) {
  //       return snapshot.hasData
  //           ? ListView.builder(
  //               itemCount: snapshot.data.docs.length,
  //               itemBuilder: (context, index) {
  //                 DocumentSnapshot ds = snapshot.data.docs[index];
  //                 return Container(
  //                   margin: EdgeInsets.only(bottom: 20.0),
  //                   child: Material(
  //                     elevation: 5.0,
  //                     borderRadius: BorderRadius.circular(10),
  //                     child: Container(
  //                       width: MediaQuery.of(context).size.width,
  //                       decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(20)),
  //                       child: Column(
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Spacer(),
  //                               SizedBox(
  //                                 width: 5.0,
  //                               ),
  //                               GestureDetector(
  //                                   onTap: () async {
  //                                     await DatabaseMethod()
  //                                         .deletecustomercsv(ds["id"]);
  //                                   },
  //                                   child: Icon(Icons.delete,
  //                                       color: Colors.amber)),
  //                             ],
  //                           ),
  //                           Text("NAME:" + ds["NAME"],
  //                               style: TextStyle(
  //                                   color: Color.fromARGB(255, 8, 49, 1),
  //                                   fontSize: 20.0,
  //                                   fontWeight: FontWeight.bold)),
  //                           Text("AGE:=" + ds["AGE"].toString(),
  //                               style: TextStyle(
  //                                   color: Colors.black,
  //                                   fontSize: 20.0,
  //                                   fontWeight: FontWeight.normal)),
  //                           Text("PLACE:=" + ds["PLACE"],
  //                               style: TextStyle(
  //                                   color: Colors.black,
  //                                   fontSize: 20.0,
  //                                   fontWeight: FontWeight.normal)),
  //                           Text("PNO:=" + ds["PNO"].toString(),
  //                               style: TextStyle(
  //                                   color: Colors.black,
  //                                   fontSize: 20.0,
  //                                   fontWeight: FontWeight.normal)),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               })
  //           : Container();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 158, 158, 158),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 154, 195, 108),
        title: Text(
          "detail",
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("customerdetail")
                .doc("XT9F5M68ht")
                .collection("csvdetail")
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.docs[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Spacer(),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            await _downloadData();
                                          },
                                          child: Icon(Icons.download,
                                              color: Colors.amber)),
                                    ],
                                  ),
                                  Text("NAME:" + ds["NAME"],
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 8, 49, 1),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("AGE:=" + ds["AGE"].toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal)),
                                  Text("PLACE:=" + ds["PLACE"],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal)),
                                  Text("PNO:=" + ds["PNO"].toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : Container();
            },
          )),
    );
  }
}

Future<void> _downloadData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Retrieve data from Firestore
  QuerySnapshot querySnapshot = await firestore.collection("07t98c4134").get();

  // Convert data to List<List<String>> format (CSV)
  List<List<dynamic>> csvData = [
    // Add header row
    ['AGE', 'NAME', 'PLACE', 'PNO', 'id'], // Replace with your field names
    // Add data rows
    ...querySnapshot.docs.map((DocumentSnapshot document) {
      return [
        document['AGE'], // Replace with your field names
        document['NAME'],
        document['PLACE'],
        document['PNO'],
        document['id']
      ];
    }),
  ];

  // Convert CSV data to a String
  String csvString = const ListToCsvConverter().convert(csvData);

  // Get the device's downloads directory to save the file
  Directory? downloadsDirectory = await getDownloadsDirectory();
  String filePath = '${downloadsDirectory?.path}/data.csv';

  // Write data to a file
  File file = File(filePath);
  await file.writeAsString(csvString);

  // Show a dialog with download link
  Fluttertoast.showToast(msg: 'File downloaded successfully to $filePath');
}
