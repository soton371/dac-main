
import 'dart:convert';


String otpVerifyRequestModelToJson(OtpVerifyRequestModel data) => json.encode(data.toJson());

class OtpVerifyRequestModel {
    final String email;
    final String otp;
    final String type;

    OtpVerifyRequestModel({
        required this.email,
        required this.otp,
        required this.type,
    });

    Map<String, dynamic> toJson() => {
        "email": email.trim(),
        "otp": otp.trim(),
        "type": type.trim(),
    };
}

