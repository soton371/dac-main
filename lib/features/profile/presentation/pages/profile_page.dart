import 'package:dac/core/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constant/app_sizes.dart';
import '../../../auth/presentation/pages/change_password.dart';
import '../widgets/profile_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("You")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSizes.paddingBody),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.paddingBody),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(gradient: AppColors.gradient()),
                    alignment: Alignment.center,
                    child: Text(
                      "SA",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // child: Image.asset(
                  //   AppImages.logo,
                  //   height: 60,
                  //   width: 60,
                  // ),
                ),
                SizedBox(width: AppSizes.paddingInside * 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Soton Ahmed",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.headlineSmall!.fontSize,
                      ),
                    ),
                    Text(
                      "soton.m360ict@gmail.com",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 0.5),
          Padding(
            padding: EdgeInsets.all(AppSizes.paddingBody),
            child: Column(
              children: [
                ProfileTile(
                  iconData: HugeIcons.strokeRoundedUserSquare,
                  title: "View profile",
                ),
                SizedBox(height: AppSizes.paddingInside * 2),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (_) => ChangePasswordPage()),
                    );
                  },
                  child: ProfileTile(
                    iconData: HugeIcons.strokeRoundedLockPassword,
                    title: "Change password",
                  ),
                ),
                SizedBox(height: AppSizes.paddingInside * 2),
                ProfileTile(
                  iconData: HugeIcons.strokeRoundedLogoutSquare02,
                  title: "Logout",
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
