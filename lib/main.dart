import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_mobile_app/app.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/utils/bloc/app_bloc_observer.dart';
import 'package:my_mobile_app/settings/debug_settings.dart';
import 'package:my_mobile_app/settings/localization/locales.dart';


/// Used to setup the services required to run the app.
/// This function is called in the other main_{flavor} classes.
///
/// Note: The setup codes should be done here rather in the
/// respective main_{flavor} classes.
Future<void> initializeApp() async {
  /// Prevents debug logs from being printed in release mode
  if (kReleaseMode) {
    debugPrint = (_, {int? wrapWidth}) {};
  }

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  await EasyLocalization.ensureInitialized();

  await setupLocator();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode && showDeviceBuilder,
      builder: (context) => EasyLocalization(
        supportedLocales: Locales.supportedLangs,
        path: 'assets/lang',
        fallbackLocale: Locales.enUS,
        child: const App(),
      ),
    ),
  );
}
