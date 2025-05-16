import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_images.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class HeadWidget extends StatelessWidget {
  const HeadWidget({
    super.key, required this.title, required this.subtitle, this.instruction, this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String? instruction;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.gradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: EdgeInsets.all(AppSizes.paddingBody),
      child: Column(
        children: [
          SizedBox(height: 50),
          //for name and image
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                      color: Colors.white,
                    ),
                  ),
                  Text(subtitle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => ProfilePage()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(AppImages.logo, height: 40, width: 40),
                ),
              ),
            ],
          ),
        SizedBox(height: AppSizes.paddingInside),
        ],
      ),
    );
  }
}