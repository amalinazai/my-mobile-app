import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerUtils extends LogFilter {
  static final Logger _logger = Logger();

  static void info(dynamic message) {
    _logger.i(message);
  }

  static void debug(dynamic message) {
    _logger.d(message);
  }

  static void warn(dynamic log) {
    _logger.w(log);
  }

  static void error(dynamic message) {
    _logger.e(message);
  }

  @override
  bool shouldLog(LogEvent event) {
    return !kReleaseMode;
  }
}
