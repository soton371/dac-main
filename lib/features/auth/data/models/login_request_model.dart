
import 'dart:convert';


String loginRequestModelToJson(LoginRequestModel data) => json.encode(data.toJson());

class LoginRequestModel {
    final String? email;
    final String? password;

    LoginRequestModel({
        this.email,
        this.password,
    });

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
