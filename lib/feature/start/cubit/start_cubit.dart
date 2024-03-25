import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_mobile_app/feature/auth/auth_utils.dart';

part 'start_cubit.freezed.dart';
part 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit() : super(const StartState.initial());

  Future<void> initialize() async {
    emit(const StartState.loading());

    await Future<dynamic>.delayed(const Duration(seconds: 2));

    final isAuthenticated = await getAuthState();

    emit(
      StartState.loaded(isAuthenticated),
    );
  }
}
