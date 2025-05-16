part of 'company_bloc.dart';

@immutable
sealed class CompanyState {}

final class CompanyInitial extends CompanyState {}

final class CompanySuccessState extends CompanyState {
  final CompanyResponseModel companyResponseModel;
  CompanySuccessState(this.companyResponseModel);
}
final class CompanyLoadingState extends CompanyState {}

final class CompanyErrorState extends CompanyState {
  final String errorMessage;
  CompanyErrorState(this.errorMessage);
}


//for update company data
final class CompanyUpdateLoadingState extends CompanyState {}
final class CompanyUpdateSuccessState extends CompanyState {
}
final class CompanyUpdateErrorState extends CompanyState {
  final String errorMessage;
  CompanyUpdateErrorState(this.errorMessage);
}

