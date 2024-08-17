import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verification/Detials/Home.dart';
import 'package:verification/customs/index.dart';
import 'package:verification/screen/master/masterlogin.dart';

import 'package:verification/screen/theme.dart';
import 'package:verification/utils/utils.dart';
import 'package:verification/screen/signup.dart';
import 'package:verification/screen/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  // final String randomId; // Declare randomId as a parameter in the constructor

  // const LoginScreen({Key? key, required this.randomId}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isConfirmPasswordVisible = false;
  bool _isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController masterPasswordController =
      TextEditingController(); // Add controller for master password
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var _masterPassword = "123456"; // Define your master password here

  Future<void> userValidation() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      try {
        setState(() {
          _isLoading = true;
        });

        UserCredential? userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        setState(() {
          _isLoading = false;
        });

        if (userCredential != null && userCredential.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home1(user: userCredential.user!)),
          );
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });

        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          Utils.displaySnackBar(context, 'Invalid email or password');
        } else {
          Utils.displaySnackBar(context, 'Error: ${e.message}');
        }
      } catch (e) {
        Utils.displaySnackBar(context, 'Error: $e');
      }
    }
  }

  void masterValidation() {
    String _mm = "qoresys";
    String enteredPassword = masterPasswordController.text;
    if (enteredPassword == _mm) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => masterlogin()),
      );
    } else {
      Utils.displaySnackBar(context, 'Incorrect master password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: appBackgroundGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/3.png',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Login',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.email, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                          return 'Enter Email';
                        }
                        if (value != emailController.text) {
                          return 'Email not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter confirm password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: userValidation,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 81, 196, 87),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      child: Text('Login'),
                    ),
                    if (_isLoading) CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //   "Don't have an account? ",
                        //   style: TextStyle(color: Colors.white54),
                        // ),
                        // TextButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => SignupScreen(),
                        //       ),
                        //     );
                        //   },
                        //   child: Text('Sign Up'),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Master Login"),
                              content: TextFormField(
                                controller: masterPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Master Password',
                                  hintText: 'Enter master password',
                                  prefixIcon: Icon(Icons.lock),
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                                style: TextStyle(color: Colors.black),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter master password';
                                  }
                                  return null;
                                },
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: masterValidation,
                                  child: Text("Submit"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "Master Login?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
