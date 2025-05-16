import 'package:flutter/material.dart';

class AppSizes {
  static const double paddingBody = 16;
  static const double paddingInside = 12;
  static const double radius = 10;

  static TextStyle labelSmall(context)    => Theme.of(context).textTheme.labelSmall!;

  static double height(context, double value)=>MediaQuery.sizeOf(context).height * (value/900);
  static double width(context, double value)=>MediaQuery.sizeOf(context).width * (value/300);
}