import 'package:my_mobile_app/common/utils/token_store_utils.dart';

/// Check if user token exists. If yes, return true.
Future<bool> getAuthState() async {
  final token = await TokenStoreUtils.get();
  return token != null;
}
