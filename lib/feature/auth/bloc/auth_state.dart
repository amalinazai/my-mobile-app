part of 'auth_bloc.dart';

enum AuthStatus { idle, loading, success, loginFailure, loggedOut }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.idle) AuthStatus status,
    @Default(false) bool isAuthenticate,
    User? user,
    String? error,
  }) = _AuthState;
}
