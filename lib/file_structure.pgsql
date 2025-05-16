lib/
|── app/
│   ├── routes/
│   ├── theme/
│   ├── app.dart
├── core/
│   ├── errors/
│   │   ├── exceptions.dart
│   │   ├── failures.dart
│   ├── network/
│   │   ├── api_client.dart
│   ├── usecase/
│   │   ├── usecase.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_data_source.dart
│   │   │   ├── models/
│   │   │   │   ├── auth_response_model.dart
│   │   │   ├── repositories/
│   │   │   │   ├── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── user.dart
│   │   │   ├── repositories/
│   │   │   │   ├── auth_repository.dart
│   │   │   ├── usecases/
│   │   │   │   ├── login_usecase.dart
│   │   ├── presentation/
│   │   │   ├── bloc/
│   │   │   │   ├── auth_bloc.dart
│   │   │   │   ├── auth_event.dart
│   │   │   │   ├── auth_state.dart
│   │   │   ├── pages/
│   │   │   │   ├── login_page.dart
│   │   │   ├── widgets/


1. Models
2. Repository
3. Use Case
4. Data Source
5. Repository IMPL
6. Bloc
7. DI
