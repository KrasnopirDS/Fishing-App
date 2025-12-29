import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD4D7B7),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 144,
          children: [
            Image.asset(
              'assets/fishing_logo.png',
              width: 244,
              height: 244,
              fit: BoxFit.cover,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffAEBE7C),
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(4),
                ),
                minimumSize: const Size(244, 60),
              ),
              child: const Text(
                'Start fishing',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: .w800,
                  color: Color(0xff15282F),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
