import 'package:isar/isar.dart';
import 'package:my_mobile_app/common/services/database_service.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/feature/user/model/user_model.dart';

class UserUtils {
  /// Creates an entry for [user] if it does not exist.
  /// Else, replace the existing entry.
  static Future<void> set(User user) async {
    final isar = locator<DatabaseService>().isar;
    
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  /// Get the current user that is being stored.
  /// Since only one user is being stored in the table,
  /// retrieve the first object from the table.
  static Future<User?> get() async {
    final isar = locator<DatabaseService>().isar;

    final self = await isar.users.where().findFirst();
    return self;
  }

  static Future<void> delete() async {
    final isar = locator<DatabaseService>().isar;

    // checks if there are any users in the table.
    final currentUser = await get();

    // if yes, delete user from table.
    if (currentUser != null) {
      await isar.writeTxn(() async {
        await isar.users.delete(currentUser.isarId);
      });
    }
  }
}
