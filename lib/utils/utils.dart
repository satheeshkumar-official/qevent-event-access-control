import 'package:flutter/material.dart';

class Utils {
  static void displaySnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20.0),
        content: Text(msg),
      ),
    );
  }
}
