import 'package:flutter/material.dart';

abstract final class DemoColors {
  static const background = Color(0xFF101211);
  static const surface = Color(0xFF191C1A);
  static const border = Color(0xFF30352F);
  static const text = Color(0xFFF2F0E9);
  static const muted = Color(0xFF9BA398);
  static const gold = Color(0xFFD6B984);
}

const editorialFont = TextStyle(
  fontFamily: 'DM Serif Display',
  fontWeight: FontWeight.w400,
);

enum CreditLook {
  cinema(
    label: 'Cinema',
    background: Color(0xFF111914),
    foreground: Color(0xFFF2F0E9),
    accent: Color(0xFFD6B984),
    muted: Color(0xFF9FAE9F),
  ),
  paper(
    label: 'Paper',
    background: Color(0xFFF0EBDF),
    foreground: Color(0xFF29362D),
    accent: Color(0xFF79613D),
    muted: Color(0xFF70796C),
  );

  const CreditLook({
    required this.label,
    required this.background,
    required this.foreground,
    required this.accent,
    required this.muted,
  });

  final String label;
  final Color background;
  final Color foreground;
  final Color accent;
  final Color muted;
}
