import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:verification/service/database.dart';
import 'package:random_string/random_string.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class viewfile1 extends StatefulWidget {
  final String _d;

  const viewfile1(this._d, {Key? key}) : super(key: key);

  @override
  State<viewfile1> createState() => _viewfile1State(_d);
}

class _viewfile1State extends State<viewfile1> {
  final String _d;

  _viewfile1State(this._d);

  Future<void> _downloadData(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Retrieve data from Firestore
    QuerySnapshot querySnapshot = await firestore.collection(_d).get();

    // Convert data to List<List<String>> format (CSV)
    List<List<dynamic>> csvData = [
      // Add header row
      //  ['AGE', 'NAME', 'PLACE', 'PNO', 'id'], // Replace with your field names
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

    // Check if data is empty
    if (csvData.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Download Error'),
          content: Text('No data available to download.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return;
    }

    // Convert CSV data to a String
    String csvString = const ListToCsvConverter().convert(csvData);
    String fileName = 'excelfile_${DateTime.now().millisecondsSinceEpoch}.csv';

    // Get the device's downloads directory to save the file
    Directory? downloadsDirectory = await getDownloadsDirectory();
    String filePath = '${downloadsDirectory?.path}/$fileName';

    // Write data to a file
    File file = File(filePath);
    await file.writeAsString(csvString);

    // Show a dialog with download link
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Download Complete'),
        content: Text('File downloaded successfully to $filePath'),
        actions: <Widget>[
          // TextButton(
          //   child: Text('Open'),
          //   onPressed: () async {
          //     // Launch the file using the default file opener application
          //     if (await canLaunch(filePath)) {
          //       await launch(filePath);
          //     } else {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(
          //           content: Text('Could not open the file'),
          //         ),
          //       );
          //     }
          //   },
          //),
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    widget._d;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 2, 34, 17),
        title: Text(
          "people",
          style: TextStyle(
            color: const Color.fromARGB(255, 252, 249, 249),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await _downloadData(context);
            },
            icon: Icon(Icons.download),
            color: Colors.amber,
          ),
          IconButton(
            onPressed: () {
              DatabaseMethod().deletecustomermaster(_d);
            },
            icon: Icon(Icons.delete),
            color: const Color.fromARGB(255, 225, 3, 3),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(_d).snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data.docs.isEmpty) {
              return Center(child: Text('No files available'));
            } else {
              return ListView.builder(
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
                },
              );
            }
          },
        ),
      ),
    );
  }
}
