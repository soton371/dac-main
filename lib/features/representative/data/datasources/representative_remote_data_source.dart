import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/constant/app_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/local_db/auth_db.dart';
import '../../../../core/network/api_client.dart';
import '../model/representative_response_model.dart';

class RepresentativeRemoteDataSource {
  static Future<Either<Failure, RepresentativeResponseModel>> getRepresentativeData() async {
    try {
      final token = await AuthLocalDB().getToken();
      final response = await ApiClient.get(url: AppUrls.representativeUrl, token: token);
      final result = representativeResponseModelFromJson(jsonEncode(response));
      return Right(result);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
}
