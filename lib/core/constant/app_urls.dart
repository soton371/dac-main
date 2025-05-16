class AppUrls {
  static const String appName = 'Dhaka Airline Club';
  static const String currentVersion = '1.0.0';
  static String appVersionUrl =
      "https://raw.githubusercontent.com/M360-ICT-App-Team/all_version_manager/refs/heads/main/dac.json";

  static const String imageBaseUrl = 'https://m360ict.s3.ap-south-1.amazonaws.com/dac-membership-files';
  static const String apiBaseUrl = 'http://10.10.220.45:8888/api/v1';


  static const String baseUrl = apiBaseUrl;
  static const String loginUrl = '$baseUrl/auth/login';
  static const String registerUrl = '$baseUrl/auth/register';
  static const String sendOtpUrl = '$baseUrl/auth/send-otp';
  static const String verifyOtpUrl = '$baseUrl/auth/verify-otp';
  static const String resetPasswordUrl = '$baseUrl/auth/reset-password';
  static const String changePasswordUrl = '$baseUrl/auth/change-password';

  // Company Profile
  static const String companyProfileUrl = '$baseUrl/member/company';

  //for document
  static const String documentUrl = '$baseUrl/member/document';

  //for representative
  static const String representativeUrl = '$baseUrl/member/company/representative';

  //for applicant
  static const String applicantUrl = '$baseUrl/member/company/applicant';
}