import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constant/app_exception_messages.dart';
import '../../../../core/models/common_models.dart';
import '../../data/datasources/company_remote_data_source.dart';
import '../../data/models/company_request_model.dart';
import '../../data/models/company_response_model.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(CompanyInitial()) {
    on<CompanyEventGetData>(getCompanyData);
    on<CompanyEventUpdateData>(updateCompanyData);
  }

  //for getting company data
  Future<void> getCompanyData(
    CompanyEventGetData event,
    Emitter<CompanyState> emit,
  ) async {
    emit(CompanyLoadingState());
    try {
      final result = await CompanyRemoteDataSource.getCompanyData();
      result.fold(
        (l) => emit(CompanyErrorState(l.message)),
        (r) => emit(CompanySuccessState(r)),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
      emit(CompanyErrorState(AppExceptionMessage.unknown));
    }
  }

  //for update company data
  Future<void> updateCompanyData(
    CompanyEventUpdateData event,
    Emitter<CompanyState> emit,
  ) async {
    emit(CompanyUpdateLoadingState());
    try {
      final body = companyRequestModelToJson(event.companyRequestModel);
      final result = await CompanyRemoteDataSource.updateCompanyData(
        body: body,
        file: event.file,
      );
      result.fold(
        (l) => emit(CompanyUpdateErrorState(l.message)),
        (r) => emit(CompanyUpdateSuccessState()),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
      emit(CompanyUpdateErrorState(AppExceptionMessage.unknown));
    }
  }
}
