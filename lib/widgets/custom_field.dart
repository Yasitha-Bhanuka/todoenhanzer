import 'package:flutter/material.dart';
import 'package:sqlflitetodo/core/responsive.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.035;
    final padding = size.width * 0.04;
    final borderRadius = size.width * 0.02;

    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: fontSize),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: fontSize),
        contentPadding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: padding * 0.8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
      validator: (val) {
        if (val!.trim().isEmpty) {
          return 'Please enter $hintText';
        } else if (val.trim().length > 50) {
          return 'Please remove ${val.trim().length - 50} characters.';
        }
        return null;
      },
      maxLines: Responsive.isDesktop(context) ? 2 : 3,
    );
  }
}
