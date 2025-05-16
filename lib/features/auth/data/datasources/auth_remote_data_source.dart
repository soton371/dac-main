import 'package:dartz/dartz.dart';

import '../../../../core/constant/app_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/local_db/auth_db.dart';
import '../../../../core/network/api_client.dart';

class AuthRemoteDataSource {
  static Future<Either<Failure, bool>> register(String payload) async {
    try {
      await ApiClient.post(url: AppUrls.registerUrl, body: payload);
      return Right(true);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

  //for login
  static Future<Either<Failure, bool>> login(String payload) async {
    try {
      await ApiClient.post(url: AppUrls.loginUrl, body: payload);
      return Right(true);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

  //for send otp
  static Future<Either<Failure, bool>> sendOtp(String payload) async {
    try {
      await ApiClient.post(url: AppUrls.sendOtpUrl, body: payload);
      return Right(true);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

  //for verify otp
  static Future<Either<Failure, bool>> verifyOtp(String payload) async {
    try {
      await ApiClient.post(url: AppUrls.verifyOtpUrl, body: payload);
      return Right(true);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

  //for reset password
  static Future<Either<Failure, bool>> resetPassword(String payload) async {
    try {
      await ApiClient.post(url: AppUrls.resetPasswordUrl, body: payload);
      return Right(true);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

  //for change password
  static Future<Either<Failure, bool>> changePassword(String payload) async {
    try {
      final token = await AuthLocalDB().getToken();
      await ApiClient.post(url: AppUrls.changePasswordUrl, body: payload, token: token);
      return Right(true);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
}
