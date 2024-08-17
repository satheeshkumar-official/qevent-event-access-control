// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FormTextFieldWidget extends StatelessWidget {
  FormTextFieldWidget(
      {super.key,
      required this.placeholder,
      required this.inputType,
      required this.avatar,
      required this.initialValue,
      required this.isRequired,
      required this.suffix,
      this.onChanged,
      required this.prefix,
      this.controller,
      required this.field,
      required bool isObscureText});
  String placeholder;
  String avatar;
  TextInputType inputType;
  bool isRequired;
  String initialValue;
  String field;
  String suffix;
  String prefix;
  TextEditingController? controller;
  Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FormBuilderTextField(
        controller: controller,
        name: field,
        initialValue:
            initialValue == '' || initialValue == '0' ? null : initialValue,
        keyboardType: inputType,
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Please $placeholder';
                }
                if (inputType == TextInputType.emailAddress) {
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  return !emailValid
                      ? 'Please Enter valid email address'
                      : null;
                }
                return null;
              }
            : null,
        onChanged: onChanged,

        minLines: inputType == TextInputType.multiline ? 4 : null, // Set this
        maxLines: inputType == TextInputType.multiline ? 5 : null, // and this
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 13),
        decoration: InputDecoration(
          hoverColor: Colors.grey.shade500,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.grey.shade400),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(92, 124, 124, 1))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(92, 124, 124, 1))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(92, 124, 124, 1))),
          prefixIcon: avatar != ''
              ? Padding(
                  padding: const EdgeInsets.all(1),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(3),
                              bottomLeft: Radius.circular(3))),
                      child: CachedNetworkImage(
                        imageUrl: avatar,
                      )),
                )
              : null,
          prefixIconConstraints: const BoxConstraints(),
          suffixIconConstraints: const BoxConstraints(),
          contentPadding: const EdgeInsets.only(left: 10, top: 20, bottom: 4),
          floatingLabelStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          label: placeholder == "%"
              ? null
              : Text(
                  placeholder,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      color: Colors.white),
                ),
        ),
      ),
    );
  }
}
