import 'dart:convert';

import 'package:dac/core/models/common_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constant/app_exception_messages.dart';
import '../errors/exceptions.dart';
import '../local_db/auth_db.dart';

class ApiClient {
  static Future<dynamic> get({required String url, String? token}) async {
    final Map<String, String> header = {
      "Content-Type": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print("========================== GET METHOD ==========================");
      print("url => $url");
      print("header => $header");
    }

    final response = await http.get(Uri.parse(url), headers: header);

    if (kDebugMode) {
      print("response.body => ${response.body}");
      print(
          "========================== END GET METHOD ==========================");
    }

    final responseData = jsonDecode(response.body);

    if (responseData['success'] == true) {
      if(responseData['data'] != null){
        return responseData['data'];
      }else{
        throw ServerException(AppExceptionMessage.empty);
      }
    } else {
      throw ServerException(
          responseData['message'] ?? AppExceptionMessage.serverDefault);
    }
  }

  //for post method
  static Future<dynamic> post(
      {required String url, String? body, String? token}) async {
    final Map<String, String> header = {
      "Content-Type": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print("######################## POST METHOD ########################");
      print("url => $url");
      print("header => $header");
      print("body => $body");
    }
    final response =
        await http.post(Uri.parse(url), body: body, headers: header);

    if (kDebugMode) {
      print("response.body => ${response.body}");
      print(
          "######################## END POST METHOD ########################");
    }

    final responseData = jsonDecode(response.body);

    if (responseData['success'] == true) {
      if (responseData['token'] != null) {
        //store token
        AuthLocalDB().setToken(responseData['token']);
      }
      return responseData['data'];
    } else {
      throw ServerException(
          responseData['message'] ?? AppExceptionMessage.serverDefault);
    }
  }


  static Future<dynamic> multipartRequestPatch(
      {required String url,
      required String? token,
      String? body,
      List<SendFileModel>? files}) async {
    final Map<String, String> header = {
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print(
          "*********************** MULTIPART REQUEST PATCH ***********************");
      print("url => $url");
      print("header => $header");
      print("body => $body");
    }
    final request = http.MultipartRequest("PATCH", Uri.parse(url));

    if (token != null) {
      request.headers.addAll(header);
    }

    if (body != null) {
      final Map<String, dynamic> payload = jsonDecode(body);
      final Map<String, String> stringPayload = {};

      payload.forEach((key, value) {
        if (value != null) {
          stringPayload[key.toString()] = value.toString();
        }
      });
      request.fields.addAll(stringPayload);
    }

    if ((files ?? []).isNotEmpty) {
      for (var file in files!) {
        final multipartFile =
            await http.MultipartFile.fromPath(file.key, file.filePath);
        request.files.add(multipartFile);
        // print("object multipartFile => ${multipartFile.filename}");
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (kDebugMode) {
      print("response.body => ${response.body}");
      print(
          "*********************** END MULTIPART REQUEST PATCH ***********************");
    }

    final responseData = jsonDecode(response.body);

    if (responseData['success'] == true) {
      if (responseData['data'] != null) {
        return responseData['data'];
      }

      //when need only success or not
      return responseData['success'];
    } else {
      throw ServerException(
          responseData['message'] ?? AppExceptionMessage.serverDefault);
    }
  }
}

