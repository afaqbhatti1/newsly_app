import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsly_app/Routes/routes_name.dart';
import 'package:newsly_app/sevices/data_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startDelay();
    debugPrint("Splash init");
  }

  startDelay() {
    Future.delayed(const Duration(seconds: 2), () async {
      debugPrint("Time End");
      if (FirebaseAuth.instance.currentUser != null) {
        await DataService.getMyUser();

        Navigator.pushReplacementNamed(context, bottomNavBar);
      } else {
        Navigator.pushReplacementNamed(context, onBoardingScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
          ),
        ],
      ),
    );
  }
}
