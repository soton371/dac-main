part of 'version_bloc.dart';

@immutable
sealed class VersionEvent {}


final class CheckAppVersionEvent extends VersionEvent{}
