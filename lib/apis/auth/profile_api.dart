import 'package:my_mobile_app/common/exceptions/network_exceptions.dart';
import 'package:my_mobile_app/common/models/result.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/network_service.dart';
import 'package:my_mobile_app/feature/user/model/user_model.dart';

class ProfileAPI {
  static Future<Result<User, String>> get() async {
    try {
      final response = await locator<NetworkService>().get(
        '/auth/me',
        isRequireAuth: true,
      ) as Map<String, dynamic>;

      final profileResponse = ProfileResponse.fromJson(response);

      return Success(profileResponse.user);
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

class ProfileResponse {
  ProfileResponse({required this.user});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      user: User.fromJson(json),
    );
  }
  final User user;
}
