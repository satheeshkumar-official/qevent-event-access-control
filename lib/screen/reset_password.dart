// import 'package:flutter/material.dart';
// import 'package:verification/screen/login_screen.dart';
// import 'package:verification/screen/theme.dart';

// class ResetPasswordScreen extends StatefulWidget {
//   const ResetPasswordScreen({Key? key}) : super(key: key);

//   @override
//   _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   String? _password;
//   String? _confirmPassword;
//   bool _isResetting = false;

//   String? passwordValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a password';
//     } else if (value.length < 8) {
//       return 'Password must be at least 8 characters long';
//     }
//     return null;
//   }

//   String? confirmPasswordValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please confirm your password';
//     } else if (value != _passwordController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   void _togglePasswordVisibility() {
//     setState(() {
//       _obscurePassword = !_obscurePassword;
//     });
//   }

//   void _toggleConfirmPasswordVisibility() {
//     setState(() {
//       _obscureConfirmPassword = !_obscureConfirmPassword;
//     });
//   }

//   void _resetPassword() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isResetting = true;
//       });
//       print('Password Reset Started');
//       // Simulate delay (replace this with actual reset process)
//       Future.delayed(const Duration(seconds: 2), () {
//         setState(() {
//           _isResetting = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Password reset is successful'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
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
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: MediaQuery.of(context).size.height -
//                     kToolbarHeight -
//                     MediaQuery.of(context).padding.top -
//                     MediaQuery.of(context).padding.bottom,
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 40),
//                     const Text(
//                       'Enter your new password',
//                       style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 40),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.8,
//                       child: TextFormField(
//                         controller: _passwordController,
//                         onChanged: (value) => _password = value,
//                         validator: passwordValidator,
//                         decoration: InputDecoration(
//                           labelText: 'New Password',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: Colors.white),
//                           ),
//                           prefixIcon:
//                               const Icon(Icons.lock, color: Colors.white),
//                           suffixIcon: GestureDetector(
//                             onTap: _togglePasswordVisibility,
//                             child: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: Colors.white,
//                             ),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 15),
//                           filled: true,
//                           fillColor: Colors.white.withOpacity(0.1),
//                         ),
//                         obscureText: _obscurePassword,
//                         style:
//                             const TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.8,
//                       child: TextFormField(
//                         controller: _confirmPasswordController,
//                         onChanged: (value) => _confirmPassword = value,
//                         validator: confirmPasswordValidator,
//                         decoration: InputDecoration(
//                           labelText: 'Confirm Password',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: Colors.white),
//                           ),
//                           prefixIcon:
//                               const Icon(Icons.lock, color: Colors.white),
//                           suffixIcon: GestureDetector(
//                             onTap: _toggleConfirmPasswordVisibility,
//                             child: Icon(
//                               _obscureConfirmPassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: Colors.white,
//                             ),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 15),
//                           filled: true,
//                           fillColor: Colors.white.withOpacity(0.1),
//                         ),
//                         obscureText: _obscureConfirmPassword,
//                         style:
//                             const TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     Column(
//                       children: [
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.35,
//                           child: ElevatedButton(
//                             onPressed: _isResetting ? null : _resetPassword,
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                 const Color.fromARGB(255, 81, 196, 87),
//                               ),
//                               foregroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.white),
//                               shape: MaterialStateProperty.all<
//                                   RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20.0),
//                                 ),
//                               ),
//                               minimumSize: MaterialStateProperty.all<Size>(
//                                   Size(120, 40)),
//                               // Adjust the padding as needed
//                             ),
//                             child: Text(
//                               'Reset',
//                               style: const TextStyle(fontSize: 18),
//                             ),
//                           ),
//                         ),
//                         if (_isResetting) const SizedBox(height: 20),
//                         if (_isResetting)
//                           const Center(
//                             child: CircularProgressIndicator(
//                               valueColor:
//                                   AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
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
