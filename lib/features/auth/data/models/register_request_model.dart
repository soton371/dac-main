import 'dart:convert';

String registerRequestModelToJson(RegisterRequestModel data) => json.encode(data.toJson());

class RegisterRequestModel {
    final String userName;
    final String companyName;
    final String email;
    final String password;
    final String phone;

    RegisterRequestModel({
        required this.userName,
        required this.companyName,
        required this.email,
        required this.password,
        required this.phone,
    });


    Map<String, dynamic> toJson() => {
        "user_name": userName.trim(),
        "company_name": companyName.trim(),
        "email": email.trim(),
        "password": password.trim(),
        "phone": phone.trim(),
    };
}

