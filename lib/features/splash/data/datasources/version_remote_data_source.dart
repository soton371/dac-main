import 'dart:convert';

import 'package:dac/core/network/api_client.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constant/app_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../models/version_response_model.dart';

class VersionRemoteDataSource {
  static Future<Either<Failure, VersionResponseModel>> getVersion() async {
    try {
      final response = await ApiClient.get(url: AppUrls.appVersionUrl);
      final result = versionResponseModelFromJson(jsonEncode(response));
      return Right(result);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
}
