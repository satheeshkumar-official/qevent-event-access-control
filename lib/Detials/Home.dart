// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:verification/Detials/email.dart';
// import 'package:verification/Detials/viewfile.dart';
// import 'package:csv/csv.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:verification/Detials/customer.dart';
// import 'package:verification/Detials/view1.dart';
// import 'package:verification/screen/theme.dart';
// import 'package:verification/service/database.dart';

// import 'package:verification/Detials/Home.dart';
// import 'package:random_string/random_string.dart';

// class Home1 extends StatefulWidget {
//   final String userid;

//   const Home1(this.userid, {Key? key}) : super(key: key);

//   @override
//   State<Home1> createState() => _Home1State();
// }

// class _Home1State extends State<Home1> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController eventNameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController locationController = TextEditingController();
//   TextEditingController upiNoController = TextEditingController();
//   TextEditingController eventDateController = TextEditingController();

//   Stream? customerStream;

//   getOnTheLoad() async {
//     customerStream = await DatabaseMethod().getcustomerdetail();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     getOnTheLoad();
//     super.initState();
//   }

//   Widget allCustomerDetails() {
//     return StreamBuilder(
//       stream: customerStream,
//       builder: (context, AsyncSnapshot snapshot) {
//         return snapshot.hasData
//             ? ListView.builder(
//                 itemCount: snapshot.data.docs.length,
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot ds = snapshot.data.docs[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: ListTile(
//                       dense: true,
//                       tileColor: Color.fromARGB(255, 150, 208, 176),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       contentPadding: EdgeInsets.all(10),
//                       title: Column(
//                         children: [
//                           Center(
//                             child: Text(
//                               ds["eventname"],
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 35,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["username"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["eventdate"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["phonenumber"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["Location"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["UPI no"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["date"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(width: 8),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               viewfile(ds["id"])));
//                                   // Add functionality for your button
//                                 },
//                                 child: Text("viewfile"),
//                                 style: ButtonStyle(
//                                   backgroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                     Color.fromARGB(255, 13, 38, 26),
//                                   ),
//                                   foregroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                     Color.fromARGB(255, 150, 208, 176),
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   nameController.text = ds["username"];
//                                   eventDateController.text = ds['eventdate'];
//                                   phoneNumberController.text =
//                                       ds['phonenumber'];
//                                   locationController.text = ds['Location'];
//                                   eventNameController.text = ds['eventname'];
//                                   upiNoController.text = ds['UPI no'];
//                                   dateController.text = ds['date'];
//                                   editCustomerDetail(ds['id']);
//                                 },
//                                 icon: Icon(Icons.edit),
//                                 color: Color.fromARGB(255, 13, 38, 26),
//                                 iconSize: 20,
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         title: Text("Upload File"),
//                                         content: Text(
//                                             "Do you want to upload the file?"),
//                                         actions: <Widget>[
//                                           TextButton(
//                                             onPressed: () {
//                                               DatabaseMethod()
//                                                   .pickAndSaveFile(ds["id"]);
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Text("Upload"),
//                                           ),
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Text("Cancel"),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                                 icon: Icon(Icons.upload_file),
//                                 color: Color.fromARGB(255, 13, 38, 26),
//                               ),
//                               IconButton(
//                                 onPressed: () async {
//                                   await DatabaseMethod()
//                                       .deletecustomer(ds["id"]);
//                                 },
//                                 icon: Icon(Icons.delete),
//                                 color: Colors.red,
//                                 iconSize: 20,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [],
//                       ),
//                     ),
//                   );
//                 },
//               )
//             : Container();
//       },
//     );
//   }

//   Widget buildDetailRow(String label, String value) {
//     return Text(
//       "$label: $value",
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 14,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     String userid;

//     return Scaffold(
//       backgroundColor:
//           Color.fromARGB(255, 13, 38, 26), // Your existing background color
//       // Add additional color stops as needed

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => UserDetailsForm(),
//             ),
//           );
//         },
//         child: Icon(
//           Icons.add,
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 187, 209, 161),
//         title: Text(
//           "Customer Details",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             Expanded(child: allCustomerDetails()),
//           ],
//         ),
//       ),
//     );
//   }

//   Future editCustomerDetail(String id) => showDialog(
//         barrierDismissible: true,
//         barrierColor: Colors.black38,
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Edit Customer Details"),
//           backgroundColor: Color.fromARGB(255, 202, 244, 207),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 buildTextField(nameController, "Username"),
//                 buildTextField(eventDateController, "Event Date"),
//                 buildTextField(eventNameController, "Event Name"),
//                 buildTextField(phoneNumberController, "Phone Number"),
//                 buildTextField(dateController, "Date"),
//                 buildTextField(locationController, "Location"),
//                 buildTextField(upiNoController, "UPI no"),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () async {
//                         Map<String, dynamic> updateInfo = {
//                           "username": nameController.text,
//                           "eventdate": eventDateController.text,
//                           "phonenumber": phoneNumberController.text,
//                           "eventname": eventNameController.text,
//                           "UPI no": upiNoController.text,
//                           "date": dateController.text,
//                           "Location": locationController.text,
//                           "id": id,
//                         };
//                         await DatabaseMethod()
//                             .updatecustomer(id, updateInfo)
//                             .then((value) {
//                           Navigator.pop(context);
//                         });
//                       },
//                       child: Text("update"),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           Color.fromARGB(255, 13, 38, 26),
//                         ),
//                         foregroundColor: MaterialStateProperty.all<Color>(
//                           Color.fromARGB(255, 150, 208, 176),
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text("cancel"),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           Color.fromARGB(255, 13, 38, 26),
//                         ),
//                         foregroundColor: MaterialStateProperty.all<Color>(
//                           Color.fromARGB(255, 150, 208, 176),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );

//   Widget buildTextField(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:verification/Detials/email.dart';
import 'package:verification/Detials/exel.dart';
import 'package:verification/Detials/viewfile.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:verification/Detials/customer.dart';
import 'package:verification/Detials/view1.dart';
import 'package:verification/main.dart';
import 'package:verification/screen/theme.dart';
import 'package:verification/service/database.dart';

import 'package:verification/Detials/Home.dart';

import 'package:random_string/random_string.dart';

class Home1 extends StatefulWidget {
  final User user;
  Home1({required this.user});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  TextEditingController nameController = TextEditingController();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController upiNoController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();

  Stream<DocumentSnapshot>? customerStream;

  get user => widget.user;

  getOnTheLoad() async {
    var userCredential;
    customerStream = FirebaseFirestore.instance
        .collection('user_details')
        .doc(user!.uid)
        .snapshots();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allCustomerDetails() {
    var user = widget.user;
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user_details')
          .doc(user!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot<Object?>? ds = snapshot.data;

          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: ds?['selec'] == 'ok',
                                child: Icon(
                                  Icons.check,
                                  color: Color.fromARGB(255, 130, 209, 110),
                                  size: 30,
                                ),
                              ),
                              Visibility(
                                visible: ds?['selec'] != 'ok',
                                child: Icon(
                                  Icons.check,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),

                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ds?["eventname"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 60,
                          ),
                          // Visibility(
                          //   visible: ds?['selec'] == 'ok',
                          //   child: Icon(
                          //     Icons.check,
                          //     color: const Color.fromARGB(255, 75, 146, 78),
                          //     size: 30,
                          //   ),
                          // ),
                          // Visibility(
                          //   visible: ds?['selec'] != 'ok',
                          //   child: Icon(
                          //     Icons.check,
                          //     color: Colors.red,
                          //     size: 30,
                          //   ),
                          // ),
                          Row(
                            children: [
                              Text(
                                ds?["username"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       ds?["eventdate"],
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       ds?["phonenumber"],
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              Text(
                                ds?["Location"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       ds?["UPI no"],
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       ds?["date"],
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(),
                              Visibility(
                                visible: ds?['selec'] != 'ok',
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                viewfile(ds?["id"])));
                                    // Add functionality for your button
                                  },
                                  child: Text("View File"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Color.fromARGB(255, 13, 38, 26),
                                    ),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Color.fromARGB(255, 254, 255, 254),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: ds?['selec'] != 'ok',
                                child: IconButton(
                                  onPressed: () {
                                    nameController.text = ds?["username"];
                                    eventDateController.text = ds?['eventdate'];
                                    phoneNumberController.text =
                                        ds?['phonenumber'];
                                    locationController.text = ds?['Location'];
                                    eventNameController.text = ds?['eventname'];
                                    upiNoController.text = ds?['UPI no'];
                                    dateController.text = ds?['date'];

                                    editCustomerDetail(ds?['id']);
                                  },
                                  icon: Icon(Icons.edit),
                                  color: Color.fromARGB(255, 246, 251, 249),
                                  iconSize: 20,
                                ),
                              ),
                              Visibility(
                                visible: ds?['selec'] != 'ok',
                                child: IconButton(
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
                                                    .pickAndSaveFile(ds?["id"]);
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
                                  color: Color.fromARGB(255, 251, 255, 253),
                                ),
                              ),
                              Visibility(
                                visible: ds?['selec'] != 'ok',
                                child: IconButton(
                                  onPressed: () async {
                                    await DatabaseMethod()
                                        .deletecustomer(ds?["id"]);
                                  },
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  iconSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              // IconButton(
                              //   onPressed: () {
                              //     if (ds?['selec'] == 'ok') {
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 DashboardScreen()),
                              //       );
                              //     } else {
                              //       Fluttertoast.showToast(
                              //         msg: "not accepted",
                              //         toastLength: Toast.LENGTH_SHORT,
                              //         gravity: ToastGravity.BOTTOM,
                              //         timeInSecForIosWeb: 1,
                              //         backgroundColor: Colors.black,
                              //         textColor: Colors.white,
                              //         fontSize: 16.0,
                              //       );
                              //     }
                              //   },
                              //   icon: Icon(Icons.arrow_forward_ios),
                              //   color: Colors.white,
                              // ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => excel(ds?["id"])));
                              // Add functionality for your button
                            },
                            child: Text("Entry->"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 13, 38, 26),
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 254, 255, 254),
                              ),
                            ),
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
          );
        } else {
          return Center(child: Text("No data available"));
        }
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
    return Scaffold(
      backgroundColor: Colors.white, // Your existing background color
      // Add additional color stops as needed

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => UserDetailsForm(user: user),
      //       ),
      //     );
      //   },
      //   child: Icon(
      //     Icons.add,
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 33, 13),
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
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body:
          Container(margin: EdgeInsets.all(10.0), child: allCustomerDetails()),
    );
  }

  Future editCustomerDetail(String id) => showDialog(
        barrierDismissible: true,
        barrierColor: Colors.black38,
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit Customer Details"),
          backgroundColor: Color.fromARGB(255, 202, 244, 207),
          content: SingleChildScrollView(
            child: Column(
              children: [
                buildTextField(nameController, "Username"),
                buildTextField(eventDateController, "Event Date"),
                buildTextField(eventNameController, "Event Name"),
                buildTextField(phoneNumberController, "Phone Number"),
                buildTextField(dateController, "Date"),
                buildTextField(locationController, "Location"),
                buildTextField(upiNoController, "UPI no"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> updateInfo = {
                          "username": nameController.text,
                          "eventdate": eventDateController.text,
                          "phonenumber": phoneNumberController.text,
                          "eventname": eventNameController.text,
                          "UPI no": upiNoController.text,
                          "date": dateController.text,
                          "Location": locationController.text,
                          "id": id,
                        };
                        await DatabaseMethod()
                            .updatecustomer(id, updateInfo)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Text("update"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 13, 38, 26),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 150, 208, 176),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("cancel"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 13, 38, 26),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 150, 208, 176),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

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

Future accepte(ds) async {
  if (ds['selec'] == 'ok') {
    Icon(Icons.abc);
  } else {
    Icon(Icons.abc_outlined);
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:verification/Detials/email.dart';
// import 'package:verification/Detials/viewfile.dart';
// import 'package:csv/csv.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:verification/Detials/customer.dart';
// import 'package:verification/Detials/view1.dart';
// import 'package:verification/screen/theme.dart';
// import 'package:verification/service/database.dart';

// import 'package:verification/Detials/Home.dart';
// import 'package:random_string/random_string.dart';

// class Home1 extends StatefulWidget {
//   // final String userid;

//   // const Home1(this.userid, {Key? key}) : super(key: key);

//   @override
//   State<Home1> createState() => _Home1State();
// }

// class _Home1State extends State<Home1> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController eventNameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController locationController = TextEditingController();
//   TextEditingController upiNoController = TextEditingController();
//   TextEditingController eventDateController = TextEditingController();

//   Stream? customerStream;

//   getOnTheLoad() async {
//     customerStream = await DatabaseMethod().getcustomerdetail();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     getOnTheLoad();
//     super.initState();
//   }

//   Widget allCustomerDetails() {
//     return StreamBuilder(
//       stream: customerStream,
//       builder: (context, AsyncSnapshot snapshot) {
//         return snapshot.hasData
//             ? ListView.builder(
//                 itemCount: snapshot.data.docs.length,
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot ds = snapshot.data.docs[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: ListTile(
//                       dense: true,
//                       tileColor: Color.fromARGB(255, 150, 208, 176),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       contentPadding: EdgeInsets.all(10),
//                       title: Column(
//                         children: [
//                           Center(
//                             child: Text(
//                               ds["eventname"],
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 35,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["username"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["eventdate"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["phonenumber"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["Location"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["UPI no"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 ds["date"],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(width: 8),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               viewfile(ds["id"])));
//                                   // Add functionality for your button
//                                 },
//                                 child: Text("viewfile"),
//                                 style: ButtonStyle(
//                                   backgroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                     Color.fromARGB(255, 13, 38, 26),
//                                   ),
//                                   foregroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                     Color.fromARGB(255, 150, 208, 176),
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   nameController.text = ds["username"];
//                                   eventDateController.text = ds['eventdate'];
//                                   phoneNumberController.text =
//                                       ds['phonenumber'];
//                                   locationController.text = ds['Location'];
//                                   eventNameController.text = ds['eventname'];
//                                   upiNoController.text = ds['UPI no'];
//                                   dateController.text = ds['date'];
//                                   editCustomerDetail(ds['id']);
//                                 },
//                                 icon: Icon(Icons.edit),
//                                 color: Color.fromARGB(255, 13, 38, 26),
//                                 iconSize: 20,
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         title: Text("Upload File"),
//                                         content: Text(
//                                             "Do you want to upload the file?"),
//                                         actions: <Widget>[
//                                           TextButton(
//                                             onPressed: () {
//                                               DatabaseMethod()
//                                                   .pickAndSaveFile(ds["id"]);
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Text("Upload"),
//                                           ),
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Text("Cancel"),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                                 icon: Icon(Icons.upload_file),
//                                 color: Color.fromARGB(255, 13, 38, 26),
//                               ),
//                               IconButton(
//                                 onPressed: () async {
//                                   await DatabaseMethod()
//                                       .deletecustomer(ds["id"]);
//                                 },
//                                 icon: Icon(Icons.delete),
//                                 color: Colors.red,
//                                 iconSize: 20,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [],
//                       ),
//                     ),
//                   );
//                 },
//               )
//             : Container();
//       },
//     );
//   }

//   Widget buildDetailRow(String label, String value) {
//     return Text(
//       "$label: $value",
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 14,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     getOnTheLoad(); // Fetch customer details every time the widget is built
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 13, 38, 26),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => UserDetailsForm(),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 187, 209, 161),
//         title: Text(
//           "Customer Details",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(10.0),
//         child: allCustomerDetails(),
//       ),
//     );
//   }

//   Future editCustomerDetail(String id) => showDialog(
//         barrierDismissible: true,
//         barrierColor: Colors.black38,
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Edit Customer Details"),
//           backgroundColor: Color.fromARGB(255, 202, 244, 207),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 buildTextField(nameController, "Username"),
//                 buildTextField(eventDateController, "Event Date"),
//                 buildTextField(eventNameController, "Event Name"),
//                 buildTextField(phoneNumberController, "Phone Number"),
//                 buildTextField(dateController, "Date"),
//                 buildTextField(locationController, "Location"),
//                 buildTextField(upiNoController, "UPI no"),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () async {
//                         Map<String, dynamic> updateInfo = {
//                           "username": nameController.text,
//                           "eventdate": eventDateController.text,
//                           "phonenumber": phoneNumberController.text,
//                           "eventname": eventNameController.text,
//                           "UPI no": upiNoController.text,
//                           "date": dateController.text,
//                           "Location": locationController.text,
//                           "id": id,
//                         };
//                         await DatabaseMethod()
//                             .updatecustomer(id, updateInfo)
//                             .then((value) {
//                           Navigator.pop(context);
//                         });
//                       },
//                       child: Text("update"),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           Color.fromARGB(255, 13, 38, 26),
//                         ),
//                         foregroundColor: MaterialStateProperty.all<Color>(
//                           Color.fromARGB(255, 150, 208, 176),
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text("cancel"),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           Color.fromARGB(255, 13, 38, 26),
//                         ),
//                         foregroundColor: MaterialStateProperty.all<Color>(
//                           Color.fromARGB(255, 150, 208, 176),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );

//   Widget buildTextField(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }
