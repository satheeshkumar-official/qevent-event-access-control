// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:random_string/random_string.dart';
// import 'package:verification/Detials/afterentry.dart';
// import 'package:verification/service/database.dart';
// import 'package:verification/user_detail.dart';

// class excel extends StatefulWidget {
//   final String _d;

//   const excel(this._d, {Key? key}) : super(key: key);

//   @override
//   State<excel> createState() => _excel(_d);
// }

// class _excel extends State<excel> {
//   TextEditingController view = TextEditingController();
//   final String _d;

//   _excel(this._d);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 154, 195, 108),
//         title: Text(
//           "Detail",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: <Widget>[
//           // IconButton(
//           //   onPressed: () async {
//           //     // DatabaseMethod().deletecustomermaster(_d); // You need to implement this method
//           //   },
//           //   icon: Icon(Icons.delete),
//           //   color: Colors.amber,
//           // ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(10.0),
//             child: TextFormField(
//               controller: view,
//               decoration: InputDecoration(
//                   labelText: 'Tag Id',
//                   labelStyle: TextStyle(color: Colors.black)),
//               style: TextStyle(color: Colors.black),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the event name';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 setState(() {}); // Trigger a rebuild when the value changes
//               },
//             ),
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => after()));
//               },
//               child: Icon((Icons.arrow_forward))),
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance.collection(_d).snapshots(),
//               builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (snapshot.data.docs.isEmpty) {
//                   return Center(child: Text('No files available'));
//                 } else {
//                   return ListView.builder(
//                     itemCount: snapshot.data.docs.length,
//                     itemBuilder: (context, index) {
//                       DocumentSnapshot ds = snapshot.data.docs[index];
//                       if (ds["TAGEID"] != view.text) {
//                         return Container(); // Skip if tagid doesn't match
//                       }
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 20.0),
//                         child: Material(
//                           elevation: 5.0,
//                           borderRadius: BorderRadius.circular(10),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20)),
//                             padding: EdgeInsets.all(10.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text("Name: ${ds["NAME"]}",
//                                         style: TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 8, 49, 1),
//                                             fontSize: 20.0,
//                                             fontWeight: FontWeight.bold)),
//                                     SizedBox(
//                                       width: 30,
//                                     ),
//                                     Visibility(
//                                         visible: ds?['selec'] != 'ok',
//                                         child: ElevatedButton(
//                                             onPressed: () {
//                                               String id =
//                                                   randomAlphaNumeric(10);
//                                               String name = ds["NAME"];
//                                               String age = ds["AGE"];
//                                               String phone = ds["PNO"];
//                                               String tagid = ds["TAGEID"];
//                                               // Add the data to the Firebase Firestore collection
//                                               addData(
//                                                   name, age, phone, tagid, id);
//                                               DatabaseMethod().select(_d, ds);
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       AnimationPage(
//                                                     animationAsset:
//                                                         'assets/animations/tick.json.json',
//                                                     duration:
//                                                         Duration(seconds: 2),
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                             child: Icon(Icons.check))),
//                                     SizedBox(
//                                       width: 60,
//                                     ),
//                                     Visibility(
//                                         visible: ds?["selec"] == 'ok',
//                                         child: Text(
//                                           "Accepted",
//                                           style: TextStyle(
//                                               color: Color.fromRGBO(
//                                                   44, 220, 38, 0.831)),
//                                         ))
//                                   ],
//                                 ),
//                                 Text("Age: ${ds["AGE"]}",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.normal)),
//                                 Text("Place: ${ds["PLACE"]}",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.normal)),
//                                 Text("Phone: ${ds["PNO"]}",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.normal)),
//                                 Text("TAGEID: ${ds["TAGEID"]}",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.normal)),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void addData(String name, String age, String phone, String tagid, String id) {
//     FirebaseFirestore.instance.collection("myCollection").doc(id).set({
//       "NAME": name,
//       "AGE": age,
//       "PHONE": phone,
//       "TAGID": tagid,
//     });
//   }
// }
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:verification/Detials/afterentry.dart';
import 'package:verification/service/database.dart';
import 'package:verification/user_detail.dart';

class excel extends StatefulWidget {
  final String _d;

  const excel(this._d, {Key? key}) : super(key: key);

  @override
  State<excel> createState() => _excel(_d);
}

class _excel extends State<excel> {
  TextEditingController view = TextEditingController();
  final String _d;
  int counter = 1; // Add a variable to store the counter value

  _excel(this._d);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 254, 254),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 7, 33, 13),
        title: Text(
          "Detail",
          style: TextStyle(
            color: const Color.fromARGB(255, 239, 235, 235),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          // IconButton(
          //   onPressed: () async {
          //     // DatabaseMethod().deletecustomermaster(_d); // You need to implement this method
          //   },
          //   icon: Icon(Icons.delete),
          //   color: Colors.amber,
          // ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: view,
              decoration: InputDecoration(
                  labelText: 'Tag Id',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.black)),
              style: TextStyle(color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the event name';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {}); // Trigger a rebuild when the value changes
              },
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => after(_d)));
            },
            icon: Icon(Icons.arrow_forward_ios),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 81, 196, 87),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Expanded(
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
                      if (ds["TAGEID"] != view.text) {
                        return Container(); // Skip if tagid doesn't match
                      }
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 27, 159, 32),
                                Colors.black
                              ]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Name: ${ds["NAME"]}",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 254, 255, 254),
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Visibility(
                                        visible: ds?['selec'] != 'ok',
                                        child: ElevatedButton(
                                          onPressed: () {
                                            String id = randomAlphaNumeric(10);
                                            String name = ds["NAME"];
                                            String age = ds["AGE"];
                                            String phone = ds["PNO"];
                                            String tagid = ds["TAGEID"];
                                            // Add the data to the Firebase Firestore collection
                                            addData(
                                                name, age, phone, tagid, _d);
                                            DatabaseMethod().select(_d, ds);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AnimationPage(
                                                  animationAsset:
                                                      'assets/animations/tick.json.json',
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.check),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Color.fromARGB(255, 81, 196, 87),
                                            ),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Visibility(
                                        visible: ds?["selec"] == 'ok',
                                        child: Text(
                                          "Accepted",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  44, 220, 38, 0.831)),
                                        ))
                                  ],
                                ),
                                Text("Age: ${ds["AGE"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal)),
                                Text("Place: ${ds["PLACE"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal)),
                                Text("Phone: ${ds["PNO"]}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal)),
                                Text("TAGEID: ${ds["TAGEID"]}",
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
        ],
      ),
    );
  }

  void addData(
      String name, String age, String phone, String tagid, String iid) {
    String id = randomAlphaNumeric(10);
    String ss = "counter";
    FirebaseFirestore.instance.collection("entred_${iid}").doc(id).set({
      "NAME": name,
      "AGE": age,
      "PHONE": phone,
      "TAGID": tagid,
    });
    String sss = "counter";
    FirebaseFirestore.instance.collection("counter_${iid}").doc(sss).set({
      "COUNTER":
          counter++, // Add the counter field and increment it for each new document
    });
  }
}
