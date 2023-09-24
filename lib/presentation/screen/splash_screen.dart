import 'package:flutter/material.dart';
import 'package:newtronic_banking/presentation/screen/auth/authentication_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateToOtherScreen() => Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(
          context,
          AuthenticationScreen.routeName,
        ),
      );

  @override
  void initState() {
    super.initState();
    navigateToOtherScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'lib/assets/images/logo.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
