

import 'dart:convert';


String companyRequestModelToJson(CompanyRequestModel data) => json.encode(data.toJson());

class CompanyRequestModel {
    final DateTime? yearOfEstablishment;
    final String? addressOfCorrespondence;
    final String? phoneNumber;
    final String? faxNumber;
    final String? website;
    String? companyEmail;

    CompanyRequestModel({
        this.yearOfEstablishment,
        this.addressOfCorrespondence,
        this.phoneNumber,
        this.faxNumber,
        this.website,
        this.companyEmail,
    });


    Map<String, dynamic> toJson() => {
        "year_of_establishment": yearOfEstablishment?.toIso8601String(),
        "address_of_correspondence": addressOfCorrespondence,
        "phone_number": phoneNumber,
        "fax_number": faxNumber,
        "website": website,
        if(companyEmail != null)
        "company_email": companyEmail,
    };
}
