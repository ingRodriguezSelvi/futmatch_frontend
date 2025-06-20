import 'package:flutter/material.dart';
import 'app_colors.dart';

InputDecoration customInputDecoration(String placeholder) {
  return InputDecoration(
    hintText: placeholder,
    filled: true,
    fillColor: AppColors.inputFill,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
  );
}

