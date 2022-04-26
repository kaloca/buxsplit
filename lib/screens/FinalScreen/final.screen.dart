import 'package:buxsplit/screens/FinalScreen/total_cost.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../SelectorScreen/types.dart';

class FinalScreenArguments {
  final List<Person> people;

  FinalScreenArguments({required this.people});
}

class FinalScreen extends StatefulWidget {
  const FinalScreen({Key? key}) : super(key: key);

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as FinalScreenArguments;

    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        baseColor: Color.fromARGB(255, 245, 245, 245),
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        appBarTheme: NeumorphicAppBarThemeData(
          buttonStyle: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
          textStyle: TextStyle(color: Colors.black54),
          iconTheme: IconThemeData(color: Colors.black54, size: 30),
          color: Color.fromARGB(255, 245, 245, 245),
        ),
        depth: 4,
        intensity: 0.9,
      ),
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: const Text('Total'),
        ),
        body: NeumorphicBackground(
          child: Container(
            // color: Colors.blue,
            padding: const EdgeInsets.all(15),
            child: ListView(
                children:
                    args.people.map((person) => TotalCost(person)).toList()),
          ),
        ),
      ),
    );
  }
}
