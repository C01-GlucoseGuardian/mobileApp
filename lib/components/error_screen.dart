import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glucose_guardian/constants/assets.dart';

class ErrorScreen extends StatelessWidget {
  final String text;

  const ErrorScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          kUndrawError,
          width: 400,
        ),
        const SizedBox(height: 20),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
