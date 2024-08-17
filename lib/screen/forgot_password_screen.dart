// import 'package:flutter/material.dart';
// import 'package:verification/screen/otp_verification_screen.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:verification/screen/theme.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({Key? key}) : super(key: key);

//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   String? emailValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your email';
//     } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//       return 'Please enter a valid email';
//     }
//     return null;
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
//         backgroundColor: appBarTheme.backgroundColor,
//         iconTheme: appBarTheme.iconTheme,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: appBackgroundGradient,
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(40),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 40),
//                     Text(
//                       'Forgot Your Password',
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                         fontSize: 34,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     Text(
//                       'Enter your email address below to receive an OTP.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                     const SizedBox(height: 40),
//                     TextFormField(
//                       controller: _emailController,
//                       validator: emailValidator,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         hintText: 'Enter your email',
//                         hintStyle: TextStyle(color: Colors.white),
//                         filled: true,
//                         fillColor: Colors.white.withOpacity(0.1),
//                         prefixIcon:
//                             Icon(Icons.alternate_email, color: Colors.white),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     SizedBox(height: 10),
//                     if (_formKey.currentState != null &&
//                         _formKey.currentState!.validate() &&
//                         _emailController.text.isNotEmpty &&
//                         !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                             .hasMatch(_emailController.text))
//                       Text(
//                         'Please enter a valid email',
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     SizedBox(height: 40),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => OTPVerificationScreen(),
//                             ),
//                           );
//                         }
//                       },
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           Color.fromARGB(255, 81, 196, 87),
//                         ),
//                         foregroundColor:
//                             MaterialStateProperty.all<Color>(Colors.white),
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                         ),
//                         minimumSize:
//                             MaterialStateProperty.all<Size>(Size(120, 40)),
//                       ),
//                       child: Text('Next'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
