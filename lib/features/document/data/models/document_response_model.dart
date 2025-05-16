// To parse this JSON data, do
//
//     final documentResponseModel = documentResponseModelFromJson(jsonString);

import 'dart:convert';

DocumentResponseModel documentResponseModelFromJson(String str) => DocumentResponseModel.fromJson(json.decode(str));


class DocumentResponseModel {
    final int? id;
    final String? licenseCopy;
    final String? tradeLicenseCopy;
    final String? memorandumCopy;
    final String? articlesAssociationCopy;
    final DateTime? createdAt;
    final int? memberId;
    final String? tinNumber;
    final String? licenseNo;
    final String? tradeLicenseNo;
    final DateTime? tradeLicenseExpiresIn;
    final String? companyType;

    DocumentResponseModel({
        this.id,
        this.licenseCopy,
        this.tradeLicenseCopy,
        this.memorandumCopy,
        this.articlesAssociationCopy,
        this.createdAt,
        this.memberId,
        this.tinNumber,
        this.licenseNo,
        this.tradeLicenseNo,
        this.tradeLicenseExpiresIn,
        this.companyType,
    });

    factory DocumentResponseModel.fromJson(Map<String, dynamic> json) => DocumentResponseModel(
        id: json["id"],
        licenseCopy: json["license_copy"],
        tradeLicenseCopy: json["trade_license_copy"],
        memorandumCopy: json["memorandum_copy"],
        articlesAssociationCopy: json["articles_association_copy"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        memberId: json["member_id"],
        tinNumber: json["tin_number"],
        licenseNo: json["license_no"],
        tradeLicenseNo: json["trade_license_no"],
        tradeLicenseExpiresIn: json["trade_license_expires_in"] == null ? null : DateTime.parse(json["trade_license_expires_in"]),
        companyType: json["company_type"],
    );

}
