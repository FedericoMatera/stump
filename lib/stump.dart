library stump;

import 'package:stump/stump_printer.dart';

export 'package:stump/debug_printer.dart';
export 'package:stump/stump.dart';
export 'package:stump/stump_printer.dart';

enum StumpLevel { info, debug, warning, error }

class Stump {
  static final List<StumpPrinter> _printers = [];

  /// Global Stump log level
  static StumpLevel logLevel = StumpLevel.info;

  /// Adds a printer to Stump
  static addPrinter(StumpPrinter printer) {
    _printers.add(printer);
  }

  /// Prints a info message on each installed printer.
  /// It does nothing if Stump.logLevel is debug, warning or error
  static i(String message) {
    if (logLevel.index > StumpLevel.info.index) return;
    for (var printer in _printers) {
      printer.onMessage(StumpLevel.info, message);
    }
  }

  /// Prints a debug message on each installed printer.
  /// It does nothing if Stump.logLevel is warning or error
  static d(String message) {
    if (logLevel.index > StumpLevel.debug.index) return;
    for (var printer in _printers) {
      printer.onMessage(StumpLevel.debug, message);
    }
  }

  /// Prints a warning message on each installed printer.
  /// It does nothing if Stump.logLevel is error
  static w(String message) {
    if (logLevel.index > StumpLevel.warning.index) return;
    for (var printer in _printers) {
      printer.onMessage(StumpLevel.warning, message);
    }
  }

  /// Prints an error message on each installed printer.
  static e(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    for (var printer in _printers) {
      printer.onMessage(
        StumpLevel.error,
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
