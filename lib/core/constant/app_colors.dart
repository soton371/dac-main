import 'package:flutter/material.dart';

class AppColors {
  static const Color seed = Color(0xff023e63);


  static LinearGradient gradient(
      {AlignmentGeometry? begin, AlignmentGeometry? end}) => LinearGradient(
    colors: [seed, Color(0xff1488cc)],
    stops: [0, 1],
    begin: begin ?? Alignment.topLeft,
    end: end ?? Alignment.bottomRight,
  );

}