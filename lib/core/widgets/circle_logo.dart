import 'package:flutter/material.dart';

class CircleLogo extends StatelessWidget {
  final double size;
  final String assetPath;

  const CircleLogo({super.key, required this.assetPath, this.size = 90});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFF5F7FC),
      ),
      child: Image.asset(assetPath),
    );
  }
}
