import 'package:flutter/material.dart';

InputDecoration customInputDecoration(String placeholder) {
  return InputDecoration(
    hintText: placeholder,
    filled: true,
    fillColor: const Color(0xFFF5F7FC),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
  );
}