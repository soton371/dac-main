
import 'dart:convert';


String changePasswordRequestModelToJson(ChangePasswordRequestModel data) => json.encode(data.toJson());

class ChangePasswordRequestModel {
    final String oldPassword;
    final String newPassword;

    ChangePasswordRequestModel({
        required this.oldPassword,
        required this.newPassword,
    });

    Map<String, dynamic> toJson() => {
        "old_password": oldPassword,
        "new_password": newPassword,
    };
}
