import 'package:get_it/get_it.dart';
import 'package:my_mobile_app/common/services/database_service.dart';
import 'package:my_mobile_app/common/services/navigator_service.dart';
import 'package:my_mobile_app/common/services/network_service.dart';
import 'package:my_mobile_app/common/services/secure_storage_service.dart';
import 'package:my_mobile_app/settings/app_prefs_service.dart';

GetIt locator = GetIt.instance;

/// https://codewithandrea.com/articles/flutter-singletons/
///
/// When creating service classes, initialize them using GetIt
/// to ensure that only one instance of the service class is created.
///
/// [setupLocator] is called before runApp in [lib/main.dart] to ensure
/// all services required to run the app is initialized.
///
/// How to set up service classes:
/// 1. Declare a service class in [lib/common/service] folder
/// 2. Register a singleton using GetIt
/// 3. To call any functions from any of this service class, call
/// [locator<service_name>().{function_name}] from anywhere in the app
Future<void> setupLocator() async {
  locator
    ..registerSingleton<DatabaseService>(await DatabaseService().init())
    ..registerSingleton<AppPrefsService>(await AppPrefsService().init())
    ..registerSingleton<NetworkService>(NetworkService().init())
    ..registerSingleton<SecureStorageService>(SecureStorageService())
    ..registerLazySingleton(NavigatorService.new);
}
