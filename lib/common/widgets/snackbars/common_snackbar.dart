import 'package:flutter/material.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/navigator_service.dart';

class CommonSnackbar {
  static void show({
    required String title,
    bool isSuccess = true,
  }) {
    final context = locator<NavigatorService>().mainContext;
    if (context == null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      _snackbar(
        isSuccess: isSuccess,
        title: title,
      ),
    );
  }

  static SnackBar _snackbar({
    required String title,
    bool isSuccess = true,
  }) {
    return SnackBar(
      content: Text(title),
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 5),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      showCloseIcon: true,
    );
  }
}
