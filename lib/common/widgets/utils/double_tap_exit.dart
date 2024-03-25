import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_mobile_app/common/widgets/snackbars/common_snackbar.dart';
import 'package:my_mobile_app/constants/settings.dart';
import 'package:my_mobile_app/settings/localization/locale_keys.g.dart';

/// Wrap around a widget to prevent a user from accidentally closing the app
/// by accident. This widget will display a snackbar informing users to tap 
/// the exit button again if they are looking to quit. 
class DoubleTapExit extends StatefulWidget {
  const DoubleTapExit({
    required this.child,
    this.onWillPopOverride,
    super.key,
  });
  final Widget child;
  final Future<bool> Function()? onWillPopOverride;

  @override
  DoubleTapExitState createState() => DoubleTapExitState();
}

class DoubleTapExitState extends State<DoubleTapExit> {
  int? _lastTimeBackButtonWasTapped;

  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return PopScope(
        onPopInvoked: (didPop) async => widget.onWillPopOverride != null
            ? widget.onWillPopOverride!()
            : _handleWillPop(),
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  Future<bool> _handleWillPop() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (_lastTimeBackButtonWasTapped != null &&
        (currentTime - _lastTimeBackButtonWasTapped!) <
            androidDoubleTapExitDelayMs) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      exit(1);
    } else {
      _lastTimeBackButtonWasTapped = DateTime.now().millisecondsSinceEpoch;
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      CommonSnackbar.show(
        title: LocaleKeys.double_tap_exit_title.tr(),
      );
      return false;
    }
  }
}
