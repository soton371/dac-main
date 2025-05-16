import 'package:flutter/material.dart';

import '../../../../core/constant/app_sizes.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.iconData, required this.title, this.color});

  final IconData iconData;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: color,),
        SizedBox(width: AppSizes.paddingBody,),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}