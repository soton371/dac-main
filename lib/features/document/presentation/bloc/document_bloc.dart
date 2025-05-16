import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/datasources/document_remote_data_source.dart';
import '../../data/models/document_response_model.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc() : super(DocumentInitial()) {
    on<DocumentGetEvent>(_documentGetEvent);
  }

  //for get document
  Future<void> _documentGetEvent(DocumentGetEvent event, Emitter<DocumentState> emit) async {
    emit(DocumentLoadingState());
    final result = await DocumentRemoteDataSource.getDocumentData();
    result.fold((l) => emit(DocumentFailureState(l.message)), (r) => emit(DocumentSuccessState(r)));
  }
}
