part of 'auth_cubit.dart';

class AuthState {
  final String userName;
  final String password;
  final String email;
  final ApiStatus<String> apiStatus;

  AuthState({
    this.apiStatus = const IdleStatus(),
    this.userName = '',
    this.password = '',
    this.email = '',
  });

  AuthState copyWith({
    String? userName,
    String? password,
    String? email,
    ApiStatus<String>? apiStatus,
  }) =>
      AuthState(
        userName: userName ?? this.userName,
        password: password ?? this.password,
        email: email ?? this.email,
        apiStatus: apiStatus ?? this.apiStatus,
      );
}
