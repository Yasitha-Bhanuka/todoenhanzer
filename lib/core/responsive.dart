import 'package:flutter/material.dart';
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? mobileLarge;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.mobileLarge,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 480;

  static bool isMobileLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= 480 &&
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 992;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 992;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 992) {
      return desktop;
    } else if (size.width >= 768 && tablet != null) {
      return tablet!;
    } else if (size.width >= 480 && mobileLarge != null) {
      return mobileLarge!;
    } else {
      return mobile;
    }
  }
}
