import 'package:flutter/material.dart';

class TextFieldUsed extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final Color? color;
  final  void Function(String)? onFieldSubmitted;
 final TextEditingController? controller;
 final bool obscureText;
  const TextFieldUsed({
    Key? key,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.validator,
    this.suffixIcon,
    this.color = Colors.white,
    this.onFieldSubmitted,
    this.controller,
    this.obscureText=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText,
      controller:controller ,
      onFieldSubmitted:onFieldSubmitted ,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
        labelText: labelText,
        hintStyle: TextStyle(color: color),
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.white),

      ),
    );
  }
}
