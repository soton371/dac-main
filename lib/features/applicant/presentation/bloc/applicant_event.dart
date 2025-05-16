part of 'applicant_bloc.dart';

@immutable
sealed class ApplicantEvent {}

class GetApplicantDataEvent extends ApplicantEvent {}
