// To parse this JSON data, do
//
//     final appliciantResponseModel = appliciantResponseModelFromJson(jsonString);

import 'dart:convert';

AppliciantResponseModel appliciantResponseModelFromJson(String str) => AppliciantResponseModel.fromJson(json.decode(str));

String appliciantResponseModelToJson(AppliciantResponseModel data) => json.encode(data.toJson());

class AppliciantResponseModel {
    final int? id;
    final int? memberId;
    final String? applicantSignature;
    final DateTime? createdAt;
    final String? applicantName;
    final String? applicantDesignation;
    final DateTime? applicationDate;
    final String? address;

    AppliciantResponseModel({
        this.id,
        this.memberId,
        this.applicantSignature,
        this.createdAt,
        this.applicantName,
        this.applicantDesignation,
        this.applicationDate,
        this.address,
    });

    factory AppliciantResponseModel.fromJson(Map<String, dynamic> json) => AppliciantResponseModel(
        id: json["id"],
        memberId: json["member_id"],
        applicantSignature: json["applicant_signature"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        applicantName: json["applicant_name"],
        applicantDesignation: json["applicant_designation"],
        applicationDate: json["application_date"] == null ? null : DateTime.parse(json["application_date"]),
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "member_id": memberId,
        "applicant_signature": applicantSignature,
        "created_at": createdAt?.toIso8601String(),
        "applicant_name": applicantName,
        "applicant_designation": applicantDesignation,
        "application_date": applicationDate?.toIso8601String(),
        "address": address,
    };
}
