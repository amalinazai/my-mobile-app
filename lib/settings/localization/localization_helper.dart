import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/navigator_service.dart';
import 'package:my_mobile_app/settings/app_prefs_service.dart';
import 'package:my_mobile_app/settings/localization/cubit/localization_cubit.dart';
import 'package:my_mobile_app/settings/localization/locales.dart';

class LocalizationHelper {
//============================================================
// ** Keys **
//============================================================

  static const String localeKey = 'locale';

//============================================================
// ** Locale Strings **
//============================================================

  static const String enUs = 'en-US';


//============================================================
// ** Functions **
//============================================================

  static Future<void> changeLanguage(String localeStr) async {
    /// Converts the [localeStr] string to a [Locale] object
    final locale = _mapStringToLocale(localeStr);

    /// Stores [localeStr] in shared preferences
    await _setLocaleStr(localeStr);

    /// Changes the language of the app. If [LocalizationBloc] is
    /// set up, the app should change languages automatically
    await _setLocale(locale);
  }

  static Locale currentLocale(LocalizationState state) {
    return switch (state) {
      LocalizationInitial() => Locales.enUS,
      LocalizationEnUs() => Locales.enUS,
    };
  }

//============================================================
// ** Helper Functions **
//============================================================

  /// Get the string value stored in shared preferences.
  static Future<String?> getLocaleStr() async {
    final appPrefs = locator<AppPrefsService>();
    final locale = appPrefs.getString(localeKey);
    return locale;
  }

  /// Set the string value to be stored in shared preferences.
  static Future<void> _setLocaleStr(String localeStr) async {
    final appPrefs = locator<AppPrefsService>();
    await appPrefs.setString(
      localeKey,
      value: localeStr,
    );
  }

  /// Sets the locale of the context.
  static Future<void> _setLocale(Locale locale) async {
    final context = locator<NavigatorService>().mainContext;
    if (context == null) return;
    await context.setLocale(locale);
  }

  static Locale _mapStringToLocale(String localeStr) {
    return switch (localeStr) {
      enUs => Locales.enUS,
      _ => Locales.enUS,
    };
  }
}
