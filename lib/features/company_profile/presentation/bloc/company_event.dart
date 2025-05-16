part of 'company_bloc.dart';

@immutable
sealed class CompanyEvent {}

class CompanyEventGetData extends CompanyEvent {}

class CompanyEventUpdateData extends CompanyEvent {
  final CompanyRequestModel companyRequestModel;
  final SendFileModel? file;

  CompanyEventUpdateData({required this.companyRequestModel, this.file});
}
