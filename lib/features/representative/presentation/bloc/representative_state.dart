part of 'representative_bloc.dart';

@immutable
sealed class RepresentativeState {}

final class RepresentativeInitial extends RepresentativeState {}


final class RepresentativeLoadingState extends RepresentativeState {}

final class RepresentativeSuccessState extends RepresentativeState {
  final RepresentativeResponseModel representativeResponseModel;

   RepresentativeSuccessState(this.representativeResponseModel);
}


final class RepresentativeFailedState extends RepresentativeState {
  final String errorMessage;

  RepresentativeFailedState(this.errorMessage);
}