import 'package:stump/stump.dart';

abstract class StumpPrinter {
  void onMessage(
    StumpLevel level,
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  });
}
