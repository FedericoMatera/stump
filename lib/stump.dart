library stump;

import 'package:stump/stump_printer.dart';

export 'package:stump/debug_printer.dart';
export 'package:stump/stump.dart';
export 'package:stump/stump_printer.dart';

enum StumpLevel { info, debug, warning, error }

class Stump {
  static final List<StumpPrinter> _printers = [];
  static StumpLevel logLevel = StumpLevel.info;

  static addPrinter(StumpPrinter printer) {
    _printers.add(printer);
  }

  static i(String message) {
    if (logLevel.index > StumpLevel.info.index) return;
    for (var printer in _printers) {
      printer.onMessage(StumpLevel.info, message);
    }
  }

  static d(String message) {
    if (logLevel.index > StumpLevel.debug.index) return;
    for (var printer in _printers) {
      printer.onMessage(StumpLevel.debug, message);
    }
  }

  static w(String message) {
    if (logLevel.index > StumpLevel.warning.index) return;
    for (var printer in _printers) {
      printer.onMessage(StumpLevel.warning, message);
    }
  }

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
