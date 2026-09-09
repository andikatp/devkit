import 'package:flutter/foundation.dart';

abstract final class Utils {
  static void log(String message) {
    if (kDebugMode) {
      debugPrint('[DevKit Log] $message');
    }
  }
}
