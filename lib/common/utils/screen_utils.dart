import 'package:flutter/material.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/navigator_service.dart';

enum ScreenType { mobile, tablet, desktop }

class ScreenUtils {
  static double get screenWidth {
    final context = locator<NavigatorService>().mainContext;
    if (context == null) return 0;
    return MediaQuery.sizeOf(context).width;
  }

  static double get screenHeight {
    final context = locator<NavigatorService>().mainContext;
    if (context == null) return 0;
    return MediaQuery.sizeOf(context).height;
  }

  static double get safePaddingTop {
    final context = locator<NavigatorService>().mainContext;
    if (context == null) return 0;
    return MediaQuery.of(context).padding.top;
  }

  static double get safePaddingBottom {
    final context = locator<NavigatorService>().mainContext;
    if (context == null) return 0;
    return MediaQuery.of(context).padding.bottom;
  }

  static double get homeIndicatorHeight {
    final context = locator<NavigatorService>().mainContext;
    if (context == null) return 0;
    return MediaQuery.paddingOf(context).bottom;
  }

  static bool get keyboardIsVisible {
    final context = locator<NavigatorService>().mainContext;
    if (context == null) return false;
    return !(MediaQuery.viewInsetsOf(context).bottom == 0.0);
  }

  static bool _isMobile(double minWidth) => minWidth < 650;

  static bool _isTablet(double minWidth) => minWidth < 1100;

  static ScreenType get returnScreenType {
    final width = screenWidth;
    if (_isMobile(width)) {
      return ScreenType.mobile;
    } else if (_isTablet(width)) {
      return ScreenType.tablet;
    } else {
      return ScreenType.desktop;
    }
  }

  static double returnTextScaleFactor(ScreenType screenType) {
    switch (screenType) {
      case ScreenType.mobile:
        return 1;
      case ScreenType.tablet:
        return 2;
      case ScreenType.desktop:
        return 3;
    }
  }

   static double get contentableHeight {
    final context = locator<NavigatorService>().mainContext;
    if (context == null) return 0;
    final screenHeight = MediaQuery.sizeOf(context).height;
    const appBarHeight = kToolbarHeight;
    final homeIndicatorHeight = MediaQuery.paddingOf(context).bottom;

    return screenHeight - appBarHeight - homeIndicatorHeight;
  }
}
