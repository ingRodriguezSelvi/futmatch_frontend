import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(text, style: theme.textTheme.titleMedium);
  }
}
