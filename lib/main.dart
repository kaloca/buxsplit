import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import './screens/InitialScreen/initial_screen.dart';
import './screens/ScanScreen/scan_screen.dart';
import './screens/SelectorScreen/selector_screen.dart';
import './screens/FinalScreen/final.screen.dart';

void main() => runApp(myApp);

NeumorphicApp myApp = NeumorphicApp(
  debugShowCheckedModeBanner: false,
  title: 'BuxSplit',
  themeMode: ThemeMode.light,
  theme: const NeumorphicThemeData(
    baseColor: Color(0xFFFFFFFF),
    lightSource: LightSource.topLeft,
    depth: 10,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => const InitialScreen(),
    '/scan': (context) => const ScanScreen(),
    '/selector': (context) => const SelectorScreen(),
    '/final': (context) => const FinalScreen(),
  },
);
