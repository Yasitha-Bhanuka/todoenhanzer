import 'package:flutter/material.dart';
import 'package:sqlflitetodo/core/responsive.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool showNewSplashScreen = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showNewSplashScreen = false;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Responsive sizes
    final logoSize = size.width *
        (Responsive.isDesktop(context)
            ? 0.15
            : Responsive.isTablet(context)
                ? 0.2
                : 0.25);
    final titleSize = size.width *
        (Responsive.isDesktop(context)
            ? 0.03
            : Responsive.isTablet(context)
                ? 0.04
                : 0.06);
    final spacing = size.height * 0.02;

    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: showNewSplashScreen
              ? _newSplashScreen(logoSize, titleSize, spacing)
              : _oldSplashScreen(size),
        ),
      ),
    );
  }

  Widget _oldSplashScreen(Size size) {
    return SizedBox(
      width: size.width * 0.1,
      height: size.width * 0.1,
      child: const CircularProgressIndicator(),
    );
  }

  Widget _newSplashScreen(double logoSize, double titleSize, double spacing) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlutterLogo(size: logoSize),
        SizedBox(height: spacing),
        Text(
          'Todo App',
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
