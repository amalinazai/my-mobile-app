// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';

class KeyboardVisibilityBuilder extends StatefulWidget {
  const KeyboardVisibilityBuilder({
    required this.builder,
    this.child,
    super.key,
  });
  final Widget? child;
  final Widget Function(
    BuildContext context,
    Widget? child,
    bool isKeyboardVisible,
  ) builder;

  @override
  KeyboardVisibilityBuilderState createState() => KeyboardVisibilityBuilderState();
}

class KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder>
    with WidgetsBindingObserver {
  final ValueNotifier<bool> _isKeyboardVisible = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();

    _isKeyboardVisible.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    final newValue = bottomInset > 200;
    if (newValue != _isKeyboardVisible.value) {
      _isKeyboardVisible.value = newValue;
    }
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
    valueListenable: _isKeyboardVisible,
    builder: (context, isKeyboardVisible, child) => widget.builder(
      context,
      widget.child,
      isKeyboardVisible,
    ),
  );
}
