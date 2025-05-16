part of 'document_bloc.dart';

@immutable
sealed class DocumentState {}

final class DocumentInitial extends DocumentState {}


final class DocumentLoadingState extends DocumentState {}

final class DocumentSuccessState extends DocumentState {
  final DocumentResponseModel documentResponseModel;
  DocumentSuccessState(this.documentResponseModel);
}

final class DocumentFailureState extends DocumentState {
  final String errorMessage;
  DocumentFailureState(this.errorMessage);
}
