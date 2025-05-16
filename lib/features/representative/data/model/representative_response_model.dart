// To parse this JSON data, do
//
//     final representativeResponseModel = representativeResponseModelFromJson(jsonString);

import 'dart:convert';

RepresentativeResponseModel representativeResponseModelFromJson(String str) => RepresentativeResponseModel.fromJson(json.decode(str));

String representativeResponseModelToJson(RepresentativeResponseModel data) => json.encode(data.toJson());

class RepresentativeResponseModel {
    final int? id;
    final String? name;
    final String? photo;
    final String? email;
    final String? phone;
    final String? address;
    final String? designation;
    final int? memberId;
    final DateTime? createdAt;

    RepresentativeResponseModel({
        this.id,
        this.name,
        this.photo,
        this.email,
        this.phone,
        this.address,
        this.designation,
        this.memberId,
        this.createdAt,
    });

    factory RepresentativeResponseModel.fromJson(Map<String, dynamic> json) => RepresentativeResponseModel(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        designation: json["designation"],
        memberId: json["member_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "email": email,
        "phone": phone,
        "address": address,
        "designation": designation,
        "member_id": memberId,
        "created_at": createdAt?.toIso8601String(),
    };
}
