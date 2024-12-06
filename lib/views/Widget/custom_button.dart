import 'package:flutter/material.dart';
import 'package:sqlflitetodo/providers/theme_provider.dart';

class CustomSaveButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;

  const CustomSaveButton(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 55),
            backgroundColor: Pallete.transparentColor,
            shadowColor: Pallete.transparentColor,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Pallete.whiteColor,
            ),
          )),
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? Colors.white : Colors.black;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // Set the background color to transparent
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: borderColor, width: 2), // Add a border
      ),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(97, 52),
            backgroundColor: Colors
                .transparent, // Set the button background color to transparent
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide(
                color: borderColor,
                width: 2,
              ),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: textColor, // Set the text color based on the theme
            ),
          )),
    );
  }
}
