// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class FormDropdownWidget extends StatefulWidget {
  const FormDropdownWidget({
    super.key,
    required this.callBack,
    required this.items,
    required this.initialValue,
    required this.text,
    required this.field,
  });
  final Function callBack;
  final List<String> items;
  final String initialValue;
  final String field;
  final String text;
  @override
  State<FormDropdownWidget> createState() => _FormDropdownWidgetState();
}

class _FormDropdownWidgetState extends State<FormDropdownWidget> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35,
        child: SimpleAutoCompleteTextField(
          key: key,
          suggestions: widget.items,
          controller: TextEditingController(text: widget.initialValue),
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey.shade500,
                size: 20,
              ),
              hintText: widget.text,
              hoverColor: Colors.grey.shade500,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.grey.shade400),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade300)),
              contentPadding: const EdgeInsets.all(10),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              label: Text(
                widget.text,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                    color: Colors.grey.shade400),
              ),
              border: InputBorder.none,
              floatingLabelStyle: const TextStyle(color: Colors.grey)),
          textChanged: (text) => {
            setState(() {
              widget.callBack(text);
            })
          },
          clearOnSubmit: false,
        ));
  }
}
