import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:verification/service/database.dart';
import 'package:random_string/random_string.dart';

class customer extends StatefulWidget {
  const customer({super.key});

  @override
  State<customer> createState() => _customerState();
}

class _customerState extends State<customer> {
  TextEditingController namecontoller = new TextEditingController();
  TextEditingController eventnamecontoller = new TextEditingController();
  TextEditingController phonenumbercontoller = new TextEditingController();
  TextEditingController datecontoller = new TextEditingController();
  TextEditingController locationcontoller = new TextEditingController();
  TextEditingController upinocontoller = new TextEditingController();
  TextEditingController eventdate = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => customer()));
      //   },
      //   child: Icon(Icons.add),
      // ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 154, 195, 108),
        title: Text(
          "enter--",
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: namecontoller,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(left: 10.0),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: TextField(
                  //       controller: namecontoller,
                  //       decoration: InputDecoration(border: InputBorder.none),
                  //     )),
                  TextFormField(
                    controller: eventnamecontoller,
                    decoration: InputDecoration(labelText: 'Event Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: eventdate,
                    decoration: InputDecoration(labelText: 'event date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(left: 10.0),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: TextField(
                  //       controller: eventnamecontoller,
                  //       decoration: InputDecoration(border: InputBorder.none),
                  //     )),
                  // Text(
                  //   "place",
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 24.0,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(left: 10.0),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: TextField(
                  //       decoration: InputDecoration(border: InputBorder.none),
                  //     )),
                  TextFormField(
                    controller: phonenumbercontoller,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(left: 10.0),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: TextField(
                  //       controller: phonenumbercontoller,
                  //       decoration: InputDecoration(border: InputBorder.none),
                  //     )),
                  TextFormField(
                    controller: datecontoller,
                    decoration: InputDecoration(labelText: 'date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(left: 10.0),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: TextField(
                  //       controller: datecontoller,
                  //       decoration: InputDecoration(border: InputBorder.none),
                  //     )),
                  TextFormField(
                    controller: locationcontoller,
                    decoration: InputDecoration(labelText: 'Location'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(left: 10.0),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: TextField(
                  //       controller: locationcontoller,
                  //       decoration: InputDecoration(border: InputBorder.none),
                  //     )),
                  TextFormField(
                    controller: upinocontoller,
                    decoration: InputDecoration(labelText: 'UPI no'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(left: 10.0),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: TextField(
                  //       controller: upinocontoller,
                  //       decoration: InputDecoration(border: InputBorder.none),
                  //     )),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(255, 154, 195, 108)),
                        onPressed: () async {
                          String id1 = randomAlphaNumeric(10);
                          Map<String, dynamic> customerInfoMap = {
                            "username": namecontoller.text,
                            "eventname": eventnamecontoller.text,
                            "phonenumber": phonenumbercontoller.text,
                            "date": datecontoller.text,
                            "Location": locationcontoller.text,
                            "id": id1,
                            "UPI no": upinocontoller.text
                          };
                          await DatabaseMethod()
                              .addCustomerDetails(customerInfoMap, id1)
                              .then((value) {
                            Fluttertoast.showToast(
                              msg: "inserted",
                              // toastLength: Toast.LENGTH_SHORT,
                              // gravity: ToastGravity.CENTER,
                              // timeInSecForIosWeb: 1,
                              // backgroundColor: Colors.amberAccent,
                              // textColor: Colors.black,
                              // fontSize: 16.0
                            );
                          });
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
