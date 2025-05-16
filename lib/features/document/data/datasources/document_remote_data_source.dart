import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/constant/app_urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/local_db/auth_db.dart';
import '../../../../core/network/api_client.dart';
import '../models/document_response_model.dart';

class DocumentRemoteDataSource {
  static Future<Either<Failure, DocumentResponseModel>> getDocumentData() async {
    try {
      final token = await AuthLocalDB().getToken();
      final response = await ApiClient.get(url: AppUrls.documentUrl, token: token);
      final result = documentResponseModelFromJson(jsonEncode(response));
      return Right(result);
    } catch (e, stackTrace) {
      return Left(handleException(e, stackTrace));
    }
  }
}