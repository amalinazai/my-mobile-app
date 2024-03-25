import 'package:isar/isar.dart';
import 'package:my_mobile_app/feature/user/model/user_model.dart';
import 'package:path_provider/path_provider.dart';

/// Local storage using Isar. 
/// Please refer to the official documentation for more on 
/// how to use Isar.
/// 
/// https://isar.dev/crud.html#opening-isar
class DatabaseService {
//============================================================
// ** Properties **
//============================================================

  factory DatabaseService() => instance;

  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  static late Isar _isar;

  // NOTE: This is where you add additional Isar schemas
  static final List<CollectionSchema<dynamic>> _collectionSchemas = [
    UserSchema,
  ];

  Isar get isar => _isar;

//============================================================
// ** Init **
//============================================================

  Future<DatabaseService> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      _collectionSchemas,
      directory: dir.path,
    );

    return instance;
  }

//============================================================
// ** Public functions  **
//============================================================

  Future<void> deleteAllData() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
    
  }
}
