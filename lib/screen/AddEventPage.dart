import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:intl/intl.dart'; // Import date formatting package

class EventDetails {
  String username = '';
  String location = '';
  String eventName = '';
  String phoneNumber = '';
  String upiNo = '';
  DateTime date = DateTime.now();

  EventDetails({
    required this.username,
    required this.location,
    required this.eventName,
    required this.phoneNumber,
    required this.upiNo,
    required this.date,
  });
}

class AddEventForm extends StatefulWidget {
  @override
  _AddEventFormState createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _upiNoController = TextEditingController();
  DateTime _selectedDate = DateTime.now(); // Variable to store selected date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event',style: TextStyle(
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
                  controller: _eventNameController,
                  decoration: InputDecoration(
                    labelText: 'Event Name',
                    labelStyle: GoogleFonts.ubuntu(),
                  ),
                  style: GoogleFonts.nunito(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: GoogleFonts.ubuntu(),
                  ),
                  style: GoogleFonts.nunito(),
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
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: GoogleFonts.ubuntu(),
                  ),
                  style: GoogleFonts.nunito(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: GoogleFonts.ubuntu(),
                  ),
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.nunito(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    if (value.length != 10) {
                      return 'Phone number must be 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: GoogleFonts.ubuntu(),
                        ),
                        style: GoogleFonts.nunito(),
                        readOnly: true, // Make the field read-only
                        controller: TextEditingController(
                            text: DateFormat('yyyy-MM-dd').format(_selectedDate)), // Set initial date
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _upiNoController,
                  decoration: InputDecoration(
                    labelText: 'UPI No.',
                    labelStyle: GoogleFonts.ubuntu(),
                  ),
                  style: GoogleFonts.nunito(),
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
                        date: _selectedDate,
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
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
