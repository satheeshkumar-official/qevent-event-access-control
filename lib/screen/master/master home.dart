import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:verification/Detials/email.dart';
import 'package:verification/Detials/viewfile.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:verification/Detials/customer.dart';
import 'package:verification/Detials/view1.dart';
import 'package:verification/main.dart';
import 'package:verification/screen/master/masterviewfile.dart';
import 'package:verification/screen/theme.dart';
import 'package:verification/service/database.dart';

import 'package:verification/Detials/Home.dart';
import 'package:random_string/random_string.dart';

class Home2 extends StatefulWidget {
  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  TextEditingController nameController = TextEditingController();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController upiNoController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();

  Stream? customerStream;

  getOnTheLoad() async {
    customerStream = await DatabaseMethod().getcustomerdetail();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allCustomerDetails() {
    return StreamBuilder(
      stream: customerStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 27, 159, 32),
                              Colors.black
                            ])),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.all(10),
                          title: Column(
                            children: [
                              Center(
                                child: Text(
                                  ds["eventname"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ds["username"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    ds["eventdate"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    ds["phonenumber"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    ds["Location"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    ds["UPI no"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    ds["date"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  viewfile1(ds["id"])));
                                      // Add functionality for your button
                                    },
                                    child: Text("viewfile"),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 13, 38, 26),
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload File"),
                                            content: Text(
                                                "Do you want to upload the file?"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  DatabaseMethod()
                                                      .pickAndSaveFile(
                                                          ds["id"]);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Upload"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancel"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.upload_file),
                                    color: Color.fromARGB(255, 13, 38, 26),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: ds['selec'] != 'ok',
                                child: IconButton(
                                  onPressed: () {
                                    DatabaseMethod().ok(ds['id']);
                                  },
                                  icon: Icon(Icons.check),
                                ),
                              ),
                              Row(
                                children: [
                                  Visibility(
                                      visible: ds['selec'] == 'ok',
                                      child: IconButton(
                                        onPressed: () {
                                          DatabaseMethod().cancel(ds['id']);
                                        },
                                        icon: Icon(Icons.cancel),
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [],
                          ),
                        ),
                      ));
                },
              )
            : Container();
      },
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Text(
      "$label: $value",
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String userid;

    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 248, 252, 250), // Your existing background color

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 34, 17),
        title: Text(
          "Customer Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(child: allCustomerDetails()),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
