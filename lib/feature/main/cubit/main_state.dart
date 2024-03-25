// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_cubit.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default(0) int tabIndex,
  }) = _MainState;
}
