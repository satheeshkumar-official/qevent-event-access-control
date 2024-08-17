import 'package:flutter/material.dart';

final LinearGradient appBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color.fromARGB(255, 13, 38, 26), // Your existing background color
    Colors.black, // Add additional color stops as needed
  ],
);


final AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: appBackgroundGradient.colors[0],
  iconTheme: IconThemeData(color: Colors.white),
);
