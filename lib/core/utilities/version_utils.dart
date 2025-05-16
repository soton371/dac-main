import 'dart:io';

import 'package:dac/features/splash/data/models/version_response_model.dart';

String? getPlatformVersion(VersionResponseModel appVersionModel) {
    if (Platform.isAndroid) {
      return appVersionModel.playStoreVersion?.split("+").first.trim();
    } else if (Platform.isIOS) {
      return appVersionModel.appStoreVersion?.split("+").first.trim();
    } else {
      return null;
    }
  }

  bool? getIsPause(VersionResponseModel appVersionModel) {
    if (Platform.isAndroid) {
      return appVersionModel.isPausePlayStore;
    } else if (Platform.isIOS) {
      return appVersionModel.isPauseAppStore;
    } else {
      return null;
    }
  }

  bool? getForceUpdate(VersionResponseModel appVersionModel) {
    if (Platform.isAndroid) {
      return appVersionModel.forceUpdatePlayStore;
    } else if (Platform.isIOS) {
      return appVersionModel.forceUpdateAppStore;
    } else {
      return null;
    }
  }