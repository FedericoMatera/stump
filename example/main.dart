import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stump/stump.dart';

void main() {
  if (kDebugMode) {
    Stump.addPrinter(DebugPrinter());
  }

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stump.d('App build started');

    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          ElevatedButton(
            child: Text('Warning'),
            onPressed: () => Stump.w('This is a warning'),
          ),
          ElevatedButton(
            child: Text('Error'),
            onPressed: () => Stump.e('This is an error'),
          ),
        ]),
      ),
    );
  }
}
