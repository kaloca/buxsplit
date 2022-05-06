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
  double _tipAmount = 10;

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
          actions: [
            GestureDetector(
              child: const Icon(Icons.home),
              onTap: () => Navigator.pushNamed(
                context,
                '/',
              ),
            )
          ],
        ),
        body: NeumorphicBackground(
          child: Container(
            // color: Colors.blue,
            padding: const EdgeInsets.all(15),
            child: ListView(children: [
              Container(
                margin: const EdgeInsets.only(left: 10, bottom: 10),
                child: Text(
                  'Gorjeta: ${_tipAmount.round()}%',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.grey[700]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: NeumorphicSlider(
                  // thumb: Container(width: 40, height: 40, color: Colors.red),
                  min: 0,
                  max: 20,
                  height: 20,
                  value: _tipAmount,
                  onChanged: (value) => setState(() {
                    _tipAmount = value.roundToDouble();
                  }),
                ),
              ),
              ...args.people
                  .map((person) => TotalCost(person, _tipAmount))
                  .toList()
            ]),
          ),
        ),
      ),
    );
  }
}
