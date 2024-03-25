// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/navigator_service.dart';
import 'package:my_mobile_app/common/utils/log_utils.dart';
import 'package:my_mobile_app/common/utils/token_store_utils.dart';
import 'package:my_mobile_app/common/widgets/snackbars/common_snackbar.dart';
import 'package:my_mobile_app/config/env.dart';
import 'package:my_mobile_app/feature/login/pages/login_page.dart';

const String _requiresTokenKey = 'requires_token';

/// Service class for API calls.
class NetworkService {
//============================================================
// ** Properties **
//============================================================

  factory NetworkService() => instance;

  NetworkService._();

  static final NetworkService instance = NetworkService._();

  static late Dio _dio;

//============================================================
// ** Init **
//============================================================

  NetworkService init() {
    _dio = Dio();
    _setupDio();

    return instance;
  }

//============================================================
// ** Private Functions **
//============================================================

  Options get _requiresTokenHeader => Options(
        headers: {_requiresTokenKey: true},
      );

  /// Used to setup the Dio interceptors and options. This function will be called
  /// every time a different baseURL than the one that is specified is used.
  ///
  /// Refer to the [get] function as an example. [_setupDio()] is called whenever
  /// [baseUrlOverride] is provided to replace the default baseUrl with the provided
  /// [baseUrlOverride], then called again to reset the baseUrl the default url.
  ///
  /// To set up interceptors (i.e. functions that are also executed before/after an API
  /// call), refer to the [official documentation](https://pub.dev/packages/dio#interceptors).
  void _setupDio({
    String? baseUrlOverride,
  }) {
    _dio.interceptors.clear();
    _dio
      ..options.baseUrl = baseUrlOverride ?? Env().BASE_URL
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.validateStatus = (status) {
        if (status == null) {
          return false;
        }

        return status >= 200 && status <= 299;
      }
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'}
      ..httpClientAdapter;

    if (baseUrlOverride == null) {
      _dio.interceptors.add(_AuthenticationInterceptor());
    }
    _dio.interceptors.add(_LoggerInterceptor());
  }

//============================================================
// ** Public API functions **
//============================================================

  /// Used for GET API calls.
  ///
  /// If [isRequireAuth] is true, the user's bearer token
  /// is passed in via [_AuthenticationInterceptor].
  Future<dynamic> get(
    String url, {
    required bool isRequireAuth,
    String? baseUrlOverride,
    Map<String, dynamic>? queryParams,
    void Function(int progress, int total)? onReceiveProgress,
  }) async {
    try {
      if (baseUrlOverride != null) {
        _setupDio(baseUrlOverride: baseUrlOverride);
      }

      final response = await _dio.get<dynamic>(
        url,
        queryParameters: queryParams,
        options: isRequireAuth ? _requiresTokenHeader : null,
        onReceiveProgress: onReceiveProgress,
      );

      if (baseUrlOverride != null) {
        _setupDio();
      }

      return response.data;
    } catch (e) {
      if (baseUrlOverride != null) {
        _setupDio();
      }
      rethrow;
    }
  }

  /// Used for POST API calls.
  /// To set the body for the API call, pass in a Map into [body].
  ///
  /// If [isRequireAuth] is true, the user's bearer token
  /// is passed in via [_AuthenticationInterceptor].
  Future<dynamic> post(
    String url, {
    required bool isRequireAuth,
    String? baseUrlOverride,
    Map<String, dynamic>? queryParams,
    Object? body,
    void Function(int progress, int total)? onSendProgress,
  }) async {
    try {
      if (baseUrlOverride != null) {
        _setupDio(baseUrlOverride: baseUrlOverride);
      }

      final response = await _dio.post<dynamic>(
        url,
        queryParameters: queryParams,
        data: body,
        options: isRequireAuth ? _requiresTokenHeader : null,
        onSendProgress: onSendProgress,
      );

      if (baseUrlOverride != null) {
        _setupDio();
      }

      return response.data;
    } catch (e) {
      if (baseUrlOverride != null) {
        _setupDio();
      }
      rethrow;
    }
  }

  /// Used for PUT API calls.
  /// To set the body for the API call, pass in a Map into [body].
  ///
  /// If [isRequireAuth] is true, the user's bearer token
  /// is passed in via [_AuthenticationInterceptor].
  Future<dynamic> put(
    String url, {
    required bool isRequireAuth,
    String? baseUrlOverride,
    Map<String, dynamic>? queryParams,
    Object? body,
    void Function(int progress, int total)? onSendProgress,
  }) async {
    try {
      if (baseUrlOverride != null) {
        _setupDio(baseUrlOverride: baseUrlOverride);
      }

      final response = await _dio.put<dynamic>(
        url,
        queryParameters: queryParams,
        data: body,
        options: isRequireAuth ? _requiresTokenHeader : null,
        onSendProgress: onSendProgress,
      );

      if (baseUrlOverride != null) {
        _setupDio();
      }

      return response.data;
    } catch (e) {
      if (baseUrlOverride != null) {
        _setupDio();
      }
      rethrow;
    }
  }

  /// Used for DELETE API calls.
  /// To set the body for the API call, pass in a Map into [body].
  ///
  /// If [isRequireAuth] is true, the user's bearer token
  /// is passed in via [_AuthenticationInterceptor].
  Future<dynamic> delete(
    String url, {
    required bool isRequireAuth,
    String? baseUrlOverride,
    Map<String, dynamic>? queryParams,
    Object? body,
  }) async {
    try {
      if (baseUrlOverride != null) {
        _setupDio(baseUrlOverride: baseUrlOverride);
      }

      final response = await _dio.delete<dynamic>(
        url,
        queryParameters: queryParams,
        data: body,
        options: isRequireAuth ? _requiresTokenHeader : null,
      );

      if (baseUrlOverride != null) {
        _setupDio();
      }

      return response.data;
    } catch (e) {
      if (baseUrlOverride != null) {
        _setupDio();
      }
      rethrow;
    }
  }
}

//============================================================
// ** Interceptors **
//============================================================

class _LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerUtils.debug(
        '--> [${options.method}] ${options.baseUrl}${options.path}\n'
        'API Headers: ${options.headers}\n'
        'API Params: ${options.queryParameters}\n'
        'API Body: ${options.data ?? ''}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    LoggerUtils.info(
        'RESPONSE[${response.statusCode}] ${response.requestOptions.baseUrl}${response.requestOptions.path}\n'
        '${json.encode(response.data)}\n');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LoggerUtils.error(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.baseUrl}${err.requestOptions.path}\n'
        '${err.response ?? '(No response)'}\n');
    return super.onError(err, handler);
  }
}


class _AuthenticationInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers[_requiresTokenKey] == true) {
      //remove the auxiliary header
      options.headers.remove(_requiresTokenKey);

      final userToken = await TokenStoreUtils.get();
      if (userToken != null) {
        options.headers.putIfAbsent('Authorization', () => 'Bearer $userToken');
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      /// If user is not authorized to proceed, display an error message forcing users to log out.
      _redirectToLoginWithSnackbar();
    }
    return super.onError(err, handler);
  }

  void _redirectToLoginWithSnackbar() {
    locator<NavigatorService>().mainRouter?.pushAndRemoveUntil(
      MaterialPageRoute<LoginPage>(
        builder: (context) => const LoginPage(),
      ), (route) => false,);
    CommonSnackbar.show(
      title: 'session_expired'.tr(),
      isSuccess: false,
    );
  }
}
