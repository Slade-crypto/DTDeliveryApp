import 'package:flutter/material.dart';

class GlobalContext {
  late final GlobalKey<NavigatorState> _navigatiorKey;

  static GlobalContext? _instance;

  GlobalContext._();

  static GlobalContext get i {
    _instance ??= GlobalContext._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatiorKey = key;
}
