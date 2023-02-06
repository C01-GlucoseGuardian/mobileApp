import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:glucose_guardian/constants/colors.dart';

class Loading extends StatelessWidget {
  final Widget child;

  const Loading({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AvatarGlow(
        glowColor: kOrangePrimary,
        endRadius: 180.0,
        duration: const Duration(milliseconds: 1000),
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: const Duration(milliseconds: 20),
        child: Material(
          shape: const CircleBorder(),
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey[100],
            child: child,
          ),
        ),
      ),
    );
  }
}
