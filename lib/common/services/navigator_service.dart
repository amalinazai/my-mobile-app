import 'package:flutter/material.dart';

/// A class used to store navigator state global keys
/// to allow contextless navigation whenever necessary.
class NavigatorService {

  factory NavigatorService() => instance;

  NavigatorService._();
  
  static final NavigatorService instance = NavigatorService._();

  final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();
  NavigatorState? get mainRouter => mainKey.currentState;
  BuildContext? get mainContext => mainKey.currentContext;
}
