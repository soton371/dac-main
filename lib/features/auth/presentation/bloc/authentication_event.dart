part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class RegisterEvent extends AuthenticationEvent {
  final RegisterRequestModel registerRequestModel;

  RegisterEvent({required this.registerRequestModel});
}


//for login
class LoginEvent extends AuthenticationEvent {
  final LoginRequestModel loginRequestModel;

  LoginEvent({required this.loginRequestModel});
}

//for send otp
class SendOtpEvent extends AuthenticationEvent {
  final OtpSendRequestModel otpSendRequestModel;

  SendOtpEvent({required this.otpSendRequestModel});
}


//for verify otp
class VerifyOtpEvent extends AuthenticationEvent {
  final OtpVerifyRequestModel otpVerifyRequestModel;

  VerifyOtpEvent({required this.otpVerifyRequestModel});
}


//for reset password
class ResetPasswordEvent extends AuthenticationEvent {
  final ResetPasswordRequestModel resetPasswordRequestModel;

  ResetPasswordEvent({required this.resetPasswordRequestModel});
}


//for change password
class ChangePasswordEvent extends AuthenticationEvent {
  final ChangePasswordRequestModel changePasswordRequestModel;

  ChangePasswordEvent({required this.changePasswordRequestModel});
}