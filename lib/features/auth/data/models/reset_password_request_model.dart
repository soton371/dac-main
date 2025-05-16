

import 'dart:convert';


String resetPasswordRequestModelToJson(ResetPasswordRequestModel data) => json.encode(data.toJson());

class ResetPasswordRequestModel {
    final String password;
    String? token;

    ResetPasswordRequestModel({
        required this.password,
        this.token,
    });


    Map<String, dynamic> toJson() => {
        "password": password.trim(),
        "token": token?.trim(),
    };
}
