import 'dart:convert';

import 'package:dac/core/local_db/auth_db.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constant/app_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/common_models.dart';
import '../../../../core/network/api_client.dart';
import '../models/company_response_model.dart';

class CompanyRemoteDataSource {
  static Future<Either<Failure, CompanyResponseModel>> getCompanyData() async {
    try {
      final token = await AuthLocalDB().getToken();
      final response = await ApiClient.get(url: AppUrls.companyProfileUrl, token: token);
      final result = companyResponseModelFromJson(jsonEncode(response));
      return Right(result);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }

  //for update company data
  static Future<Either<Failure, bool>> updateCompanyData({required String body, SendFileModel? file}) async {
    try {
      final token = await AuthLocalDB().getToken();
      final response = await ApiClient.multipartRequestPatch(url: AppUrls.companyProfileUrl, body: body, token: token, files: file == null ? null : [file]);
      return Right(response);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
}