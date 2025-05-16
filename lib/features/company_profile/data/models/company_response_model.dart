// To parse this JSON data, do
//
//     final companyResponseModel = companyResponseModelFromJson(jsonString);

import 'dart:convert';

CompanyResponseModel companyResponseModelFromJson(String str) => CompanyResponseModel.fromJson(json.decode(str));


class CompanyResponseModel {
    final int? id;
    final String? companyName;
    final dynamic companyLogo;
    final DateTime? yearOfEstablishment;
    final String? addressOfCorrespondence;
    final String? phoneNumber;
    final bool? isApplied;
    final String? companyEmail;
    final String? faxNumber;
    final String? website;
    final DateTime? createdAt;

    CompanyResponseModel({
        this.id,
        this.companyName,
        this.companyLogo,
        this.yearOfEstablishment,
        this.addressOfCorrespondence,
        this.phoneNumber,
        this.isApplied,
        this.companyEmail,
        this.faxNumber,
        this.website,
        this.createdAt,
    });

    factory CompanyResponseModel.fromJson(Map<String, dynamic> json) => CompanyResponseModel(
        id: json["id"],
        companyName: json["company_name"],
        companyLogo: json["company_logo"],
        yearOfEstablishment: json["year_of_establishment"] == null ? null : DateTime.parse(json["year_of_establishment"]),
        addressOfCorrespondence: json["address_of_correspondence"],
        phoneNumber: json["phone_number"],
        isApplied: json["is_applied"],
        companyEmail: json["company_email"],
        faxNumber: json["fax_number"],
        website: json["website"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

}
