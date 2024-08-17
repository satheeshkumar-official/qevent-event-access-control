import 'package:flutter/material.dart';
import 'AddEventPage.dart'; // Import the AddEventForm widget

class EditEventPage extends StatefulWidget {
  final EventDetails eventDetails;

  EditEventPage({required this.eventDetails});

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _upiNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.eventDetails.username;
    _locationController.text = widget.eventDetails.location;
    _eventNameController.text = widget.eventDetails.eventName;
    _phoneNumberController.text = widget.eventDetails.phoneNumber;
    _upiNoController.text = widget.eventDetails.upiNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Event',style: TextStyle(
          fontSize: 18.0,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),),
        
  backgroundColor: Colors.transparent,
  elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _eventNameController,
                  decoration: const InputDecoration(labelText: 'Event Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _upiNoController,
                  decoration: const InputDecoration(labelText: 'UPI No.'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter UPI No.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final eventDetails = EventDetails(
                        username: _usernameController.text,
                        location: _locationController.text,
                        eventName: _eventNameController.text,
                        phoneNumber: _phoneNumberController.text,
                        upiNo: _upiNoController.text,
                        date: widget.eventDetails.date,
                      );
                      Navigator.pop(context, eventDetails);
                    }
                  },
                  style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 81, 196, 87), // background color
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // foreground color
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}