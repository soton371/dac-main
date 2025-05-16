part of 'document_bloc.dart';

@immutable
sealed class DocumentEvent {}

class DocumentGetEvent extends DocumentEvent {}
