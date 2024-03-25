part of 'start_cubit.dart';

@freezed
class StartState with _$StartState {
  const factory StartState.initial() = _Initial;
  const factory StartState.loading() = _Loading;
  // ignore: avoid_positional_boolean_parameters
  const factory StartState.loaded(bool isAuthenticated) = _Loaded;
}
