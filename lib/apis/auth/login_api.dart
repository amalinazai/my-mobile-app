import 'package:my_mobile_app/common/exceptions/network_exceptions.dart';
import 'package:my_mobile_app/common/models/result.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/network_service.dart';
import 'package:my_mobile_app/feature/user/model/user_model.dart';

// Refer to https://dummyjson.com/users for a list of valid credentials
class LoginAPI {
  static Future<Result<(User user, String token), String>> fetch({
    required String username,
    required String password,
  }) async {
    try {
      final response = await locator<NetworkService>().post(
        '/auth/login',
        isRequireAuth: false,
        body: {
          'username': username,
          'password': password,
        },
      ) as Map<String, dynamic>;

      // Directly parse the API response into LoginResponse
      final loginResponse = LoginResponse.fromJson(response);

      return Success((loginResponse.user, loginResponse.token));
    } catch (e) {
      return Failure(
        getNetworkErrorMessage(
          e,
          badResponseMessage: (data) {
            return (data as Map<String, dynamic>?)?['message'] as String?;
          },
        ),
      );
    }
  }
}

class LoginResponse {
  LoginResponse({required this.user, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: User.fromJson(json),
      token: json['token'] as String,
    );
  }
  final User user;
  final String token;
}
