// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {super.key,
      required this.title,
      required this.bgColor,
      this.borderColor,
      required this.onTap,
      required this.foreColor, required double minWidth, required double borderRadius});
  final String title;
  final Color bgColor;
  final Color foreColor;

  Color? borderColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: borderColor == null
                  ? BorderSide.none
                  : BorderSide(
                      color: borderColor!,
                    ))),
          foregroundColor: MaterialStatePropertyAll(foreColor),
          backgroundColor: MaterialStatePropertyAll(bgColor)),
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w100, fontSize: 13),
      ),
    );
  }
}
