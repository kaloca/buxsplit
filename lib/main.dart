import 'package:flutter/material.dart';

import './screens/InitialScreen/initial_screen.dart';
import './screens/ScanScreen/scan_screen.dart';
import './screens/SelectorScreen/selector_screen.dart';

void main() => runApp(myApp);

MaterialApp myApp = MaterialApp(
  title: 'BuxSplit',
  initialRoute: '/',
  routes: {
    '/': (context) => const InitialScreen(),
    '/scan': (context) => const ScanScreen(),
    '/selector': (context) => const SelectorScreen(),
  },
);
