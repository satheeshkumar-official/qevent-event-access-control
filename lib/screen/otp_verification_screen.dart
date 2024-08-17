// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:verification/customs/button.dart'; // Import ButtonWidget
// import 'dart:async';
// import 'package:verification/screen/reset_password.dart';
// import 'package:verification/screen/theme.dart';

// class OTPVerificationScreen extends StatefulWidget {
//   const OTPVerificationScreen({Key? key}) : super(key: key);

//   @override
//   _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
// }

// class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
//   int _counter = 60;
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_counter > 0) {
//           _counter--;
//         } else {
//           _timer.cancel();
//           // Implement logic for handling expired OTP
//         }
//       });
//     });
//   }

//   void _resetTimer() {
//     setState(() {
//       _counter = 60; // Reset the timer
//     });
//     _startTimer(); // Start the timer again
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         // Set app bar background color and icon color using appBarTheme
//         backgroundColor: appBarTheme.backgroundColor,
//         iconTheme: appBarTheme.iconTheme,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: appBackgroundGradient, // Use appBackgroundGradient here
//         ),
//         padding: EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             Text(
//               'OTP Verification',
//               style: GoogleFonts.montserrat(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 30.0, // Adjusted font size for better fit
//                 color: Colors.white,
//                 // Matching text color with Login page
//               ),
//             ),
//             const SizedBox(height: 50),
//             Text(
//               // Add the specified text
//               'Please enter the 4-digit verification code sent to your email:',
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//             const SizedBox(height: 40),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     OtpTextField(
//                       keyboardType: TextInputType
//                           .number, // Setting keyboard type to numeric
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       numberOfFields: 4,
//                       fillColor: Colors.white.withOpacity(
//                           0.1), // Matching field background with Login page
//                       filled: true,
//                       borderColor: Colors
//                           .white, // Matching field border color with Login page
//                       textStyle: TextStyle(
//                           color: Colors
//                               .white), // Matching text color with Login page
//                     ),
//                     const SizedBox(height: 40.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Resend OTP in $_counter seconds',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         const SizedBox(width: 10),
//                         TextButton(
//                           onPressed: _counter > 0
//                               ? null
//                               : _resetTimer, // Reset timer if counter is 0
//                           child: Text(
//                             'Resend OTP',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 40.0),
//                     ButtonWidget(
//                       title: 'Verify OTP',
//                       bgColor: Color.fromARGB(255, 81, 196, 87),
//                       foreColor: Colors.white,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   ResetPasswordScreen()), // Navigate to ResetPasswordScreen
//                         );

//                         // Handle button tap
//                       },
//                       borderRadius: 20.0, // Rounded corners
//                       minWidth: 120.0,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
