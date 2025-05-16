part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class RegisterLoading extends AuthenticationState {}
final class RegisterSuccess extends AuthenticationState {}
final class RegisterFailure extends AuthenticationState {
  final String errorMessage;

  RegisterFailure({required this.errorMessage});
}


//for login
final class LoginLoading extends AuthenticationState {}
final class LoginSuccess extends AuthenticationState {}
final class LoginFailure extends AuthenticationState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}


//for send otp
final class OtpLoading extends AuthenticationState {}
final class OtpSuccess extends AuthenticationState {}
final class OtpFailure extends AuthenticationState {
  final String errorMessage;

  OtpFailure({required this.errorMessage});
}

//for verify otp
final class OtpVerifyLoading extends AuthenticationState {}
final class OtpVerifySuccess extends AuthenticationState {} 
final class OtpVerifyFailure extends AuthenticationState {
  final String errorMessage;

  OtpVerifyFailure({required this.errorMessage});
}

//for reset password
final class ResetPasswordLoading extends AuthenticationState {}
final class ResetPasswordSuccess extends AuthenticationState {}
final class ResetPasswordFailure extends AuthenticationState {
  final String errorMessage;

  ResetPasswordFailure({required this.errorMessage});
}


//for change password
final class ChangePasswordLoading extends AuthenticationState {}
final class ChangePasswordSuccess extends AuthenticationState {}
final class ChangePasswordFailure extends AuthenticationState {
  final String errorMessage;

  ChangePasswordFailure({required this.errorMessage});
}