import 'package:flutter/material.dart';
import 'package:sqlflitetodo/theme/responsive.dart';
import 'home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 7), () {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: _splashScreenContent(logoSize, titleSize, spacing),
            ),
            SizedBox(height: spacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _controller.value,
                    backgroundColor: Colors.grey[300],
                    color: Theme.of(context).primaryColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _splashScreenContent(
      double logoSize, double titleSize, double spacing) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icon/l.png', // Path to your app icon
          width: logoSize,
          height: logoSize,
        ),
        SizedBox(height: spacing),
        Text(
          'Taskenhanz App',
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spacing),
        Text(
          'Manage your tasks efficiently',
          style: TextStyle(
            fontSize: titleSize * 0.6,
          ),
        ),
        SizedBox(height: spacing),
        Text(
          'Get started now!',
          style: TextStyle(
            fontSize: titleSize * 0.6,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
