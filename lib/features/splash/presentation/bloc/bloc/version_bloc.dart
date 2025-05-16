import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/constant/app_urls.dart';
import '../../../../../core/utilities/version_utils.dart';
import '../../../data/datasources/version_remote_data_source.dart';

part 'version_event.dart';
part 'version_state.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc() : super(VersionInitial()) {
    on<CheckAppVersionEvent>(checkVersion);
  }

  // This method checks the app version and emits the appropriate state
  Future<void> checkVersion(
    CheckAppVersionEvent event,
    Emitter<VersionState> emit,
  ) async {
    final result = await VersionRemoteDataSource.getVersion();
    result.fold(
      (failure) {
        emit(VersionFailure(failure.message));
      },
      (versionResponse) {
        String url = '';
        if (Platform.isIOS) {
          url = versionResponse.appStoreLink.toString().trim();
        } else {
          url = versionResponse.playStoreLink.toString().trim();
        }

        final platformVersion = getPlatformVersion(versionResponse);

        if (getIsPause(versionResponse) == true) {
          emit(AppPausedState());
        } else if (AppUrls.currentVersion == platformVersion) {
          emit(AppRunningState());
        } else {
          if (getForceUpdate(versionResponse) == true) {
            //?Force update
            emit(AppForceUpdateState(url: url, message: versionResponse.updateMessage));
          } else {
            //?Normal Update
            emit(UpdateAvailableState(url: url, message: versionResponse.updateMessage));
          }
        }
      },
    );
  }
}
