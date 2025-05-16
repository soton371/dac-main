import 'package:bloc/bloc.dart';
import 'package:dac/features/applicant/data/datasource/applicant_remote_data_source.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/constant/app_exception_messages.dart';
import '../../data/model/applicant_response_model.dart';

part 'applicant_event.dart';
part 'applicant_state.dart';

class ApplicantBloc extends Bloc<ApplicantEvent, ApplicantState> {
  ApplicantBloc() : super(ApplicantInitial()) {
    on<GetApplicantDataEvent>(_getApplicantDataEvent);
  }

  //for get applicant data
  Future<void> _getApplicantDataEvent(
    GetApplicantDataEvent event,
    Emitter<ApplicantState> emit,
  ) async {
    emit(ApplicantLoadingState());
    try {
      final result = await ApplicantRemoteDataSource.getApplicantData();
      result.fold(
        (l) => emit(ApplicantErrorState(l.message)),
        (r) => emit(ApplicantSuccessState(r)),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
      emit(ApplicantErrorState(AppExceptionMessage.unknown));
    }
  }
}
