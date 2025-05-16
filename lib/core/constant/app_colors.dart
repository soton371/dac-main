import 'package:flutter/material.dart';

class AppColors {
  static const Color seed = Color(0xff023e63);

  static Color disabledColor(context) => Theme.of(context).disabledColor;
  static Color onSurface(context) => Theme.of(context).colorScheme.onSurface;
  static Color focusColor(context) => Theme.of(context).focusColor; //shadow
  static Color primary(context) => Theme.of(context).colorScheme.primary;
  static Color outline(context) => Theme.of(context).colorScheme.outline;
  static Color onInverseSurface(context) =>
      Theme.of(context).colorScheme.onInverseSurface;
  static Color onPrimary(context) => Theme.of(context).colorScheme.onPrimary;

  static LinearGradient gradient({
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
  }) => LinearGradient(
    colors: [seed, Color(0xff1488cc)],
    stops: [0, 1],
    begin: begin ?? Alignment.topLeft,
    end: end ?? Alignment.bottomRight,
  );
}
