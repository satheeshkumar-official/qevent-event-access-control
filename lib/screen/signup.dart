import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verification/Detials/Home.dart';
import 'package:verification/customs/button.dart';
import 'package:verification/screen/login_screen.dart';
import 'package:verification/screen/master/masterlogin.dart';
import 'package:verification/screen/theme.dart';
import 'package:random_string/random_string.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 38, 24),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          decoration: BoxDecoration(
            gradient: appBackgroundGradient,
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 150,
                        height: 150,
                        child: Image(
                          image: AssetImage('assets/images/logos4.png'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Signup',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          labelText: 'Username or Email',
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon:
                              Icon(Icons.alternate_email, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter email address';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: !_isConfirmPasswordVisible,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter confirm password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: _createNewUser,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 81, 196, 87),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: Text('Signup'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'or connect with',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.g_translate),
                            onPressed: () {
                              // Google login logic
                            },
                            color: Colors.white,
                          ),
                          IconButton(
                            icon: Icon(Icons.login),
                            onPressed: () {
                              // AppID login logic
                            },
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  Future<void> _createNewUser() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      try {
        // Create user in Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // Generate random ID
        String randomId = randomAlphaNumeric(10);

        // Store user details in Firestore
        await FirebaseFirestore.instance
            .collection('users1')
            .doc(randomId)
            .set({
          'email': email,
          'password': password,
          'id': randomId,
        });

        // Navigate to login screen with randomId parameter
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
                // randomId: randomId,
                ),
          ),
        );
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }
}
