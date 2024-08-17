import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verification/service/database.dart';

class after extends StatefulWidget {
  final String d;

  after(this.d);

  @override
  State<after> createState() => _afterState();
}

class _afterState extends State<after> {
  @override
  Widget build(BuildContext context) {
    widget.d;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(255, 255, 253, 253),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 7, 33, 13),
        title: Text(
          "Accepted",
          style: TextStyle(
            color: const Color.fromARGB(255, 240, 238, 238),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("entred_${widget.d}")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No files available'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
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
                            Text("TAGID:=" + ds["TAGID"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal)),
                            Text("PNO:=" + ds["PHONE"].toString(),
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
