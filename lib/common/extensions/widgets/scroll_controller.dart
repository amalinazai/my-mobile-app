import 'package:flutter/material.dart';

extension ScrollControllerExtensions on ScrollController {
  bool get isScrollToEnd => position.pixels == position.maxScrollExtent;

  void animateToStart() {
    animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void animateToEnd() {
    animateTo(
      position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
