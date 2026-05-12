import 'package:flutter/material.dart';

abstract final class AppColors {
  static const seed = Color.fromARGB(255, 244, 122, 40);

  static const backgroundGradientTop = Color(0xFFF3EEE8);
  static const backgroundGradientBottom = Color(0xFFEDE6DF);

  static const primaryAccent = Color(0xFFB84E2A);
  static const primaryAccentLight = Color(0xFFEB6B3F);
  static const primaryAccentSoft = Color(0xFFF39A61);
  static const cardHighlightBorder = Color(0xFFE6B8A5);

  static const surface = Colors.white;
  static const surfaceMuted = Colors.white70;
  static const textPrimary = Colors.black;
  static const error = Colors.redAccent;
  static const textMuted = Colors.grey;

  static final avatarBackground = Colors.grey.shade300;
  static final textSecondary = Colors.grey.shade700;
  static final textTertiary = Colors.grey.shade600;
  static final borderSubtle = Colors.grey.shade300;
}
