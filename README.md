Stump is a Flutter logger inspired by Timber.
It provides a set of static methods to easily log messages and the support to multiple and custom printers.

## Getting started

Initialize Stump by adding StumpPrinter implementations to it in the main() of your app.
The library come with a printer implementation, DebugPrinter, that prints messages by using `debugPrint`, with automatic tag inference and color based on log level.
You can add as many StumpPrinter as you want.

### Example: basic setup
```dart
Stump.addPrinter(DebugPrinter());
````

### Example: DebugPrinter in debug only (no logs in release)
```dart
if (kDebugMode) {
  Stump.addPrinter(DebugPrinter());
}
````
### Example: DebugPrinter in debug and a custom printer in release
```dart
if (kDebugMode) {
  Stump.addPrinter(DebugPrinter());
} else {
  Stump.addPrinter(MyCustomPrinter());
}
````

## Usage

```dart
Stump.i('My info log message');
Stump.d('My debug log message');
Stump.w('My warning log message');
Stump.e('My error log message');
```

The result, if launched with DebugPrinter installed, will be similar to:
![Stump DebugPrinter example](/example/stump_example.png "Stump DebugPrinter example")

You can optionally provide error and stacktrace to errors:
```dart
try {
  throw 'A very bad error';
} catch (error, stackTrace) {
  Stump.e('My error log message', error: error, stackTrace: stackTrace);
}
```
