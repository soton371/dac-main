import 'package:bloc/bloc.dart';
import 'package:dac/core/constant/app_exception_messages.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/local_db/auth_db.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/models/change_password_request_model.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/otp_send_request_model.dart';
import '../../data/models/otp_verify_request_model.dart';
import '../../data/models/register_request_model.dart';
import '../../data/models/reset_password_request_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<RegisterEvent>(register);
    on<LoginEvent>(login);
    on<SendOtpEvent>(sendOtp);
    on<VerifyOtpEvent>(verifyOtp);
    on<ResetPasswordEvent>(resetPassword);
  }


  //for registration
  void register(RegisterEvent event, Emitter<AuthenticationState> emit) async {
    emit(RegisterLoading());
    try {
      // Call your registration method here
      final payload = registerRequestModelToJson(event.registerRequestModel);
      final result = await AuthRemoteDataSource.register(payload);
      result.fold(
        (l) => emit(RegisterFailure(errorMessage: l.message)),
        (r) => emit(RegisterSuccess()),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
      emit(RegisterFailure(errorMessage: AppExceptionMessage.unknown));
    }
  }

  //for login
  void login(LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoading());
    try {
      // Call your login method here
      final payload = loginRequestModelToJson(event.loginRequestModel);
      final result = await AuthRemoteDataSource.login(payload);
      result.fold(
        (l) => emit(LoginFailure(errorMessage: l.message)),
        (r) => emit(LoginSuccess()),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
      emit(LoginFailure(errorMessage: AppExceptionMessage.unknown));
    }
  }

  //for send otp
  void sendOtp(SendOtpEvent event, Emitter<AuthenticationState> emit) async {
    emit(OtpLoading());
    try {
      // Call your send otp method here
      final payload = otpSendRequestModelToJson(event.otpSendRequestModel);
      final result = await AuthRemoteDataSource.sendOtp(payload);
      result.fold(
        (l) => emit(OtpFailure(errorMessage: l.message)),
        (r) => emit(OtpSuccess()),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
      emit(OtpFailure(errorMessage: AppExceptionMessage.unknown));
    }
  }

  //for verify otp
  void verifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(OtpVerifyLoading());
    try {
      // Call your verify otp method here
      final payload = otpVerifyRequestModelToJson(event.otpVerifyRequestModel);
      final result = await AuthRemoteDataSource.verifyOtp(payload);
      result.fold(
        (l) => emit(OtpVerifyFailure(errorMessage: l.message)),
        (r) => emit(OtpVerifySuccess()),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
      emit(OtpVerifyFailure(errorMessage: AppExceptionMessage.unknown));
    }
  }

  //for reset password
  void resetPassword(
    ResetPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(ResetPasswordLoading());
    try {
      final token = await AuthLocalDB().getToken();
      if(token == null){
        emit(ResetPasswordFailure(errorMessage: "Token not found"));
        return;
      }
      event.resetPasswordRequestModel.token = token;
      final payload =
          resetPasswordRequestModelToJson(event.resetPasswordRequestModel);
      final result = await AuthRemoteDataSource.resetPassword(payload);
      result.fold(
        (l) => emit(ResetPasswordFailure(errorMessage: l.message)),
        (r) => emit(ResetPasswordSuccess()),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
      emit(ResetPasswordFailure(errorMessage: AppExceptionMessage.unknown));
    }
  }

  //for change password 
  void changePassword(
    ChangePasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(ChangePasswordLoading());
    try {
      final payload =
          changePasswordRequestModelToJson(event.changePasswordRequestModel);
      final result = await AuthRemoteDataSource.changePassword(payload);
      result.fold(
        (l) => emit(ChangePasswordFailure(errorMessage: l.message)),
        (r) => emit(ChangePasswordSuccess()),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
      emit(ChangePasswordFailure(errorMessage: AppExceptionMessage.unknown));
    }
  }
}
