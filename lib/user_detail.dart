import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import the Lottie package
import 'package:verification/Detials/Home.dart';
import 'package:verification/Detials/exel.dart';
import 'dart:ui' as ui;

import 'package:verification/home.dart';

class UserDetailsPage extends StatelessWidget {
  final Map<String, String> user;

  const UserDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 27, 159, 32),
      ),
      body: Stack(
        children: [
          // Background Image with Blur Effect
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/${user['username']}.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // User Image with Padding
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/${user['username']}.png',
                      width: MediaQuery.of(context).size.width *
                          0.8, // Half of the screen width
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // User Details
                Text(
                  'Username: ${user['username']}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Location: ${user['place']}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 16),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimationPage(
                              animationAsset:
                                  'assets/animations/tick.json.json',
                              duration: Duration(seconds: 2),
                            ),
                          ),
                        );
                      },
                      child: Text('Accept',
                          style: TextStyle(
                              color: Color.fromARGB(255, 238, 231, 231))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimationPage(
                              animationAsset:
                                  'assets/animations/DmWRNPH009.json',
                              duration: Duration(seconds: 2),
                            ),
                          ),
                        );
                      },
                      child:
                          Text('Reject', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimationPage extends StatefulWidget {
  final String animationAsset;
  final Duration duration;

  const AnimationPage(
      {Key? key, required this.animationAsset, required this.duration})
      : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  @override
  void initState() {
    super.initState();
    // Automatically navigate back after the specified duration
    Future.delayed(widget.duration, () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          widget.animationAsset,
          width: 200,
          height: 200,
          fit: BoxFit.contain,
          animate: true,
        ),
      ),
    );
  }
}
