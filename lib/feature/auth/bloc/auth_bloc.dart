import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_mobile_app/apis/auth/login_api.dart';
import 'package:my_mobile_app/apis/auth/profile_api.dart';
import 'package:my_mobile_app/common/models/result.dart';
import 'package:my_mobile_app/common/services/database_service.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/secure_storage_service.dart';
import 'package:my_mobile_app/common/utils/bloc/bloc_transformer.dart';
import 'package:my_mobile_app/common/utils/token_store_utils.dart';
import 'package:my_mobile_app/feature/user/model/user_model.dart';
import 'package:my_mobile_app/feature/user/user_utils.dart';
import 'package:my_mobile_app/settings/app_prefs_service.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with BlocTransformer {
  AuthBloc() : super(const AuthState()) {
    on<_OnTapLogIn>(_onTapLogIn);
    on<_OnTapLogOut>(_onTapLogOut);
    on<_OnUserInitialized>(_onUserInitialized);
    on<_OnUserFetched>(_onUserFetched);
    on<_SetAuthenticated>(_setAuthenticated);
  }

  Future<void> _onTapLogIn(
    _OnTapLogIn event,
    Emitter<AuthState> emit,
  ) async {
    FocusScope.of(event.context).requestFocus(FocusNode());
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    final loginFetch = await LoginAPI.fetch(
      username: event.username,
      password: event.password,
    );

    switch (loginFetch) {
      case Success(value: (final User user, final String token)):

        /// store token
        await TokenStoreUtils.set(token);

        /// store user object
        await UserUtils.set(user);

         emit(
          state.copyWith(
            status: AuthStatus.success,
            user: user,
            isAuthenticate: true,
          ),
        );

      case Failure(message: final String error):
        emit(
          state.copyWith(
            status: AuthStatus.loginFailure,
            error: error,
          ),
        );
    }
  }

  Future<void> _onTapLogOut(
    _OnTapLogOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    await locator<DatabaseService>().deleteAllData();
    await locator<SecureStorageService>().deleteAll();
    await locator<AppPrefsService>().clearAll();

    emit(
      state.copyWith(
        status: AuthStatus.loggedOut,
      ),
    );
  }

  Future<void> _onUserInitialized(
    _OnUserInitialized event,
    Emitter<AuthState> emit,
  ) async {
    // get user data from cache first
    emit(
      state.copyWith(
        user: await UserUtils.get(),
      ),
    );

    // fetch user data from API on initialize
    add(const AuthEvent.onUserFetched());
  }

  Future<void> _onUserFetched(
    _OnUserFetched event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    final profileFetch = await ProfileAPI.get();

    switch (profileFetch) {
      case Success(value: final User user):
        emit(
          state.copyWith(
            status: AuthStatus.success,
            user: user,
          ),
        );

        // save user data into isar to cache
        await UserUtils.set(user);

      case Failure(message: final String error):
        emit(
          state.copyWith(
            status: AuthStatus.loginFailure,
            error: error,
          ),
        );
    }
  }

  void _setAuthenticated(
    _SetAuthenticated event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        isAuthenticate: event.isAuthenticate,
      ),
    );
  }
}
