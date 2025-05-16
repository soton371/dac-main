import 'package:bloc/bloc.dart';
import 'package:dac/features/representative/data/datasources/representative_remote_data_source.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/constant/app_exception_messages.dart';
import '../../data/model/representative_response_model.dart';

part 'representative_event.dart';
part 'representative_state.dart';

class RepresentativeBloc extends Bloc<RepresentativeEvent, RepresentativeState> {
  RepresentativeBloc() : super(RepresentativeInitial()) {
    on<GetRepresentativeEvent>(_getRepresentative);
  }

  //for get representative data
  Future<void> _getRepresentative(
    GetRepresentativeEvent event,
    Emitter<RepresentativeState> emit,
  ) async {
    emit(RepresentativeLoadingState());
    try {
      final result = await RepresentativeRemoteDataSource.getRepresentativeData();
      result.fold(
        (l) => emit(RepresentativeFailedState(l.message)),
        (r) => emit(RepresentativeSuccessState(r)),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
      emit(RepresentativeFailedState(AppExceptionMessage.unknown));
    }
  }
}

