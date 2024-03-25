part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.onTapLogIn(
    BuildContext context,
    String username,
    String password,
  ) = _OnTapLogIn;

  const factory AuthEvent.onTapLogOut() = _OnTapLogOut;

  const factory AuthEvent.onUserInitialized() = _OnUserInitialized;
  const factory AuthEvent.onUserFetched() = _OnUserFetched;
  
  const factory AuthEvent.setAuthenticated(
    // ignore: avoid_positional_boolean_parameters
    bool isAuthenticate,
  ) = _SetAuthenticated;

  // ignore: strict_raw_type
  const factory AuthEvent.onUserPreferenceFetched({required Completer completer}) = _OnUserPreferenceFetched;
}
