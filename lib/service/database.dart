import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:random_string/random_string.dart';
import 'package:verification/Detials/Home.dart';

class DatabaseMethod {
  Future ok(d) async {
    String okk = 'ok';
    FirebaseFirestore.instance
        .collection('user_details')
        .doc(d)
        .update({"selec": okk}).then((value) => Fluttertoast.showToast(
              msg: "accept",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 11, 11, 11),
              textColor: Colors.white,
              fontSize: 16.0,
            ));
  }

  Future select(d, d1) async {
    String okk = 'ok';
    FirebaseFirestore.instance
        .collection(d)
        .doc(d1["id"])
        .update({"selec": okk});
    await {
      FirebaseFirestore.instance.collection("skkk").doc(d1["id"]).set({
        "NAME": d["NAME"],
      })
    };
  }

  Future cancel(d) async {
    String okk = '';
    FirebaseFirestore.instance
        .collection('user_details')
        .doc(d)
        .update({"selec": okk}).then((value) => Fluttertoast.showToast(
              msg: "Rejected",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 10, 10, 10),
              textColor: Colors.white,
              fontSize: 16.0,
            ));
  }

  Future deletecustomermaster(String id1) async {
    FirebaseFirestore.instance.collection(id1).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        result.reference.delete();
      });
    });
  }

  Future addUser(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(userId)
        .set(userInfoMap);
  }

  Future addCustomerDetails(
      Map<String, dynamic> customerInfoMap, String id1) async {
    return await FirebaseFirestore.instance
        .collection("customerdetail")
        .doc(id1)
        .set(customerInfoMap);
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      getcustomerdetail() async {
    return await FirebaseFirestore.instance
        .collection("user_details")
        .snapshots();
  }

  // Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getcsvdetail(String ) async {
  //   return await FirebaseFirestore.instance
  //       .doc("")
  //       .collection("customerdetail11")
  //       .snapshots();
  // }
  // Future<Stream<QuerySnapshot<Map<String, dynamic>>>> views(String id) async {
  //   return await FirebaseFirestore.instance
  //       .doc(id)
  //       .collection("customerdetail")
  //       .snapshots();
  // }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getcsvdetail() async {
    return await FirebaseFirestore.instance
        .collection("customerdetail")
        .doc("XT9F5M68ht")
        .collection("csvdetail")
        .snapshots();
  }

  Future updatecustomer(String id1, Map<String, dynamic> updateinfo) async {
    return await FirebaseFirestore.instance
        .collection("customerdetail")
        .doc(id1)
        .update(updateinfo)
        .then((value) {
      Fluttertoast.showToast(msg: "update");
    });
  }

  Future deletecustomer(String id1) async {
    return await FirebaseFirestore.instance
        .collection("customerdetail")
        .doc(id1)
        .delete()
        .then((value) {
      Fluttertoast.showToast(msg: "deleted");
    });
  }

  // Future deletecustomercsv(String id) async {
  //   return await FirebaseFirestore.instance
  //       .collection(id)

  //       .delete()
  //       .then((value) {
  //     Fluttertoast.showToast(msg: "deleted");
  //   });
  // }
  Future<void> deletecustomercsv(String id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(id)
        .where('id', isEqualTo: id)
        .get();

    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future getcsv() async {
    return await FirebaseFirestore.instance
        .collection("customerdetail")
        .doc("XT9F5M68ht")
        .collection("csvdetail")
        .snapshots();
  }

  Future<void> pickAndSaveFile(String id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx'], // Allow CSV and Excel files
    );

    if (result != null) {
      try {
        String? filePath = result.files.single.path;
        if (filePath != null) {
          if (filePath.endsWith('.csv')) {
            // Handle CSV file
            await _processCSVFile(filePath, id);
          } else if (filePath.endsWith('.xlsx')) {
            // Handle Excel file
            await _processExcelFile(filePath, id);
          } else {
            throw UnsupportedError('Unsupported file format');
          }
        } else {
          // Unable to get file path
          _showToast("Failed to get file path");
        }
      } catch (e) {
        print("Error: $e");
        // Handle error
        _showToast("An error occurred");
      }
    } else {
      // User canceled file picking
      _showToast("File selection canceled");
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      textColor: Colors.black,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
  }

  Future<void> _processCSVFile(String filePath, String id) async {
    try {
      File file = File(filePath);
      String csvString = await file.readAsString();
      List<List<dynamic>> csvData = CsvToListConverter().convert(csvString);

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      for (List<dynamic> row in csvData) {
        String id1 = randomAlpha(10);
        await firestore.collection(id).doc(id1).set({
          'NAME': row[0],
          'AGE': row[1],
          'PLACE': row[2],
          'PNO': row[3],
          'TAGEID': row[4],
          "id": id1,
          'selec': "null"
        });
      }

      _showToast("CSV file uploaded successfully");
    } catch (e) {
      print("Error processing CSV file: $e");
      _showToast("Error processing CSV file");
    }
  }

  Future<void> _processExcelFile(String filePath, String id) async {
    try {
      var bytes = File(filePath).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      if (excel.tables.isNotEmpty) {
        var sheet = excel.tables[excel.tables.keys.first]!;
        List<List<dynamic>> excelData = [];

        for (var row in sheet.rows) {
          List<dynamic> rowData = [];
          for (var cell in row) {
            rowData.add(cell?.value); // Extract cell value only
          }
          excelData.add(rowData);
        }

        FirebaseFirestore firestore = FirebaseFirestore.instance;

        for (List<dynamic> row in excelData) {
          if (row.isNotEmpty) {
            String id1 = randomAlpha(10);
            Map<String, dynamic> data = {
              'NAME': row.length > 0 ? row[0].toString() : null,
              'AGE': row.length > 1 ? row[1].toString() : null,
              'PLACE': row.length > 2 ? row[2].toString() : null,
              'PNO': row.length > 3 ? row[3].toString() : null,
              'TAGEID': row.length > 4 ? row[4].toString() : null,
              "id": id1,
              "selec": "null"
            };

            // Filter out null values from the data
            data.removeWhere((key, value) => value == null);

            await firestore.collection(id).doc(id1).set(data);
          }
        }

        _showToast("Excel file uploaded successfully");
      } else {
        _showToast("No data found in Excel file");
      }
    } catch (e, stackTrace) {
      print("Error processing Excel file: $e\n$stackTrace");
      _showToast("Error processing Excel file: $e");
    }
  }
}
