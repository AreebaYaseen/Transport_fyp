import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'SlidingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    _startTextAnimation();
    _startNavigationTimer();
  }

  void _startTextAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showText = true;
      });
    });
  }

  void _startNavigationTimer() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  const SlidingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie Animation
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Lottie.asset(
                    'assets/lottie/Van.json',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32),

                // Text with simple animation
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: _showText ? 1.0 : 0.0,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 800),
                    scale: _showText ? 1.0 : 0.7,
                    child: const Text(
                      'EduTransit',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}