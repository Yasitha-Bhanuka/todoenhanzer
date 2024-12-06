import 'package:flutter/material.dart';
import 'package:sqlflitetodo/core/app_pallete.dart';
import 'package:sqlflitetodo/core/responsive.dart';

class CustomSaveButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;

  const CustomSaveButton(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonHeight = size.height * 0.07;
    final buttonWidth =
        Responsive.isDesktop(context) ? size.width * 0.1 : size.width * 0.25;
    final fontSize = size.width * 0.035;
    final borderRadius = size.width * 0.015;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(buttonWidth, buttonHeight),
          backgroundColor: Pallete.transparentColor,
          shadowColor: Pallete.transparentColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Pallete.whiteColor,
          ),
        ),
      ),
    );
  }
}

class CustomCancelButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;

  const CustomCancelButton(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? Colors.white : Colors.black;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    final buttonHeight = size.height * 0.07;
    final buttonWidth =
        Responsive.isDesktop(context) ? size.width * 0.1 : size.width * 0.25;
    final fontSize = size.width * 0.035;
    final borderRadius = size.width * 0.015;

    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        fixedSize: Size(buttonWidth, buttonHeight),
        backgroundColor: Colors.transparent,
        side: BorderSide(color: borderColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
