part of 'version_bloc.dart';

@immutable
sealed class VersionState {}

final class VersionInitial extends VersionState {}


final class VersionFailure extends VersionState {
  final String message;
  VersionFailure(this.message);
}

final class AppPausedState extends VersionState {}
final class AppRunningState extends VersionState {}
final class AppForceUpdateState extends VersionState {
  final String url;
  final String? message;

  AppForceUpdateState({required this.url, required this.message});
}
final class UpdateAvailableState extends VersionState {
  final String url;
  final String? message;

  UpdateAvailableState({required this.url, required this.message});
}
