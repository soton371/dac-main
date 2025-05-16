part of 'applicant_bloc.dart';

@immutable
sealed class ApplicantState {}

final class ApplicantInitial extends ApplicantState {}

final class ApplicantLoadingState extends ApplicantState {}

final class ApplicantSuccessState extends ApplicantState {
  final ApplicantResponseModel applicantResponseModel;

  ApplicantSuccessState(this.applicantResponseModel);
}

final class ApplicantErrorState extends ApplicantState {
  final String errorMessage;

  ApplicantErrorState(this.errorMessage);
}
