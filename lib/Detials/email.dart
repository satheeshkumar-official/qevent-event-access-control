import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class UserDetails {
  final String username;
  final String Location;
  final String eventName;
  final String phoneNumber;
  final String upiNumber;
  final String eventdate;
  final String date; // Added date field as string

  UserDetails({
    required this.eventdate,
    required this.username,
    required this.Location,
    required this.eventName,
    required this.phoneNumber,
    required this.upiNumber,
    required this.date, // Added date field as string
  });
}

class UserDetailsForm extends StatefulWidget {
  final User user;
  UserDetailsForm({required this.user});
  // final String randomid; // Add randomid parameter

  // UserDetailsForm(
  //     {required this.randomid}); // Constructor with randomid parameter

  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _LocationController;
  late TextEditingController _eventNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _upiController;
  late TextEditingController _eventdate;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _LocationController = TextEditingController();
    _eventNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _upiController = TextEditingController();
    _eventdate = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _LocationController.dispose();
    _eventNameController.dispose();
    _phoneNumberController.dispose();
    _upiController.dispose();
    _eventdate.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final userDetails = UserDetails(
        username: _usernameController.text,
        Location: _LocationController.text,
        eventName: _eventNameController.text,
        phoneNumber: _phoneNumberController.text,
        upiNumber: _upiController.text,
        eventdate: _eventdate.text,
        date: _selectedDate.toString(), // Store selected date as string
      );

      // Show dialog to confirm submission
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Do you want to submit the details?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  String id1 = randomAlphaNumeric(10);
                  // Store data in Firestore with randomid value
                  var user = widget.user;
                  await FirebaseFirestore.instance
                      .collection('user_details')
                      .doc(user.uid)
                      .set({
                    'username': userDetails.username,
                    'Location': userDetails.Location,
                    'eventdate': userDetails.eventdate,
                    'eventname': userDetails.eventName,
                    'phonenumber': userDetails.phoneNumber,
                    'UPI no': userDetails.upiNumber,
                    'date': userDetails.date, // Store date in Firestore
                    'id': user.uid,
                    'selec': ''
                  });

                  Navigator.of(context).pop(); // Close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Details submitted successfully!')),
                  );
                },
                child: Text('Submit'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 187, 209, 161),
        title: Text('User Details Form'),
      ),
      backgroundColor: Color.fromARGB(255, 11, 20, 1),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _LocationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(color: Colors.white),
                      // filled: true, // Set filled to true
                      // fillColor: Colors
                      //     .grey[800], // Set fillColor to your desired color
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _eventdate,
                    decoration: InputDecoration(
                        labelText: 'EventDate',
                        labelStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                        labelText: 'Event Name',
                        labelStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _upiController,
                    decoration: InputDecoration(
                        labelText: 'UPI no',
                        labelStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your UPI number';
                      }
                      return null;
                    },
                  ),
                  ListTile(
                    title: Text(_selectedDate.toString()),
                    trailing: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != _selectedDate) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
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
