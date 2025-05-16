import 'dart:io';

import 'package:dac/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_images.dart';
import '../../../../core/utilities/app_launcher.dart';
import '../../../../core/widgets/app_show_info.dart';
import '../bloc/bloc/version_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<VersionBloc>().add(CheckAppVersionEvent());
    return Scaffold(
      body: BlocListener<VersionBloc, VersionState>(
        listener: (context, state) {
          if (state is AppPausedState) {
            appShowInfo(
              context,
              title: "Maintenance Mode",
              content:
                  "This app is currently under maintenance. Please come back later",
              defaultDismissAction: false,
              actions: [
                TextButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: const Text("Close")),
              ],
            );
          } else if (state is AppForceUpdateState) {
            appShowInfo(
              context,
              title: "Update Required",
              content: state.message ?? "You must update the app to proceed further",
              defaultDismissAction: false,
              actions: [
                TextButton(
                  onPressed: () {
                    appLaunchUrl(url: state.url);
                  },
                  child: const Text("Update"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //route next page
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=> LoginPage()));
                  },
                  child: const Text("Later"),
                ),
              ],
            );
          } else if (state is UpdateAvailableState) {
            appShowInfo(
              context,
              title: "New Version Available",
              content: state.message ??
                  "A new version of the app is available. Would you like to update now?",
              defaultDismissAction: false,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //route next page
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=> LoginPage()));
                  },
                  child: const Text("Later"),
                ),
                TextButton(
                  onPressed: () {
                    appLaunchUrl(url: state.url);
                  },
                  child: const Text("Update"),
                ),
              ],
            );
          } else {
            //route next page
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=> LoginPage()));
          }
        },
        child: Center(child: Image.asset(AppImages.logo)),
      ),
    );
  }
}
