import 'package:stump/stump.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:stack_trace/stack_trace.dart';

import 'stump_printer.dart';

class DebugPrinter implements StumpPrinter {
  static const ansiEsc = '\x1B[';
  static const ansiDefault = '${ansiEsc}0m';
  static const grey = 244;
  static const yellow = 3;
  static const red = 1;
  final dateFormat = DateFormat('kk:mm:ss');

  @override
  void onMessage(
    StumpLevel level,
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    String time = dateFormat.format(DateTime.now());
    tag = tag ?? _getCaller();
    String prefix = _colorize(grey, '[$time][$tag]');

    if (level == StumpLevel.warning) {
      message = _colorize(yellow, message);
    } else if (level == StumpLevel.error) {
      message = _colorize(red, message);
    }

    debugPrint('$prefix $message');
    if (stackTrace != null) {
      _debugPrintStack(level, stackTrace);
    }
  }

  String _getCaller() => Trace.current()
      .frames[3]
      .uri
      .path
      .split('/')
      .last
      .replaceAll('.dart', '');

  _colorize(int color, String text) =>
      '${ansiEsc}38;5;${color}m$text$ansiDefault';

  _debugPrintStack(StumpLevel level, StackTrace stackTrace) {
    stackTrace = FlutterError.demangleStackTrace(stackTrace);

    Iterable<String> lines = stackTrace.toString().trimRight().split('\n');
    if (kIsWeb && lines.isNotEmpty) {
      lines = lines.skipWhile((String line) {
        return line.contains('StackTrace.current') ||
            line.contains('dart-sdk/lib/_internal') ||
            line.contains('dart:sdk_internal');
      });
    }

    int color = grey;
    if (level == StumpLevel.warning) {
      color = yellow;
    } else if (level == StumpLevel.error) {
      color = red;
    }

    debugPrint(
      _colorize(
        color,
        FlutterError.defaultStackFilter(lines).join('\n'),
      ),
    );
  }
}
