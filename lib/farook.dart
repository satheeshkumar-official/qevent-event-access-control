import 'package:flutter/material.dart';
import 'package:verification/main.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 27, 159, 32),
        title: Text('Events'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(10)),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 27, 159, 32),
                    Colors.black
                  ])),
              width: double.infinity,
              padding: EdgeInsets.all(9),
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: Text(
                      'Subramani Marriage',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'futura'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => Home(context as String)),
                          );
                        },
                        child: const Text(
                          'Entry',
                          style: TextStyle(
                              color: Color.fromARGB(255, 27, 159, 32)),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
