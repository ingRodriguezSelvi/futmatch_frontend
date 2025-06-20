import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class FutButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final String? loadingText;
  final Color color;
  final Color textColor;
  final Color? borderColor;

  const FutButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.loadingText,
    this.color = AppColors.primary,
    this.textColor = Colors.white,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
        ),
        onPressed: loading ? null : onPressed,
        child: Text(
          loading ? (loadingText ?? text) : text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

