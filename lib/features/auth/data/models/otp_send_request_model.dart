
import 'dart:convert';


String otpSendRequestModelToJson(OtpSendRequestModel data) => json.encode(data.toJson());

class OtpSendRequestModel {
    final String email;
    final String type;

    OtpSendRequestModel({
        required this.email,
        required this.type,
    });

    Map<String, dynamic> toJson() => {
        "email": email.trim(),
        "type": type.trim(),
    };
}
