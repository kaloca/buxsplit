import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:buxsplit/screens/FinalScreen/final.screen.dart';

import 'components/people_indicator.dart';
import 'components/item_list.dart';

class Person {
  final String id;
  final Color color;
  final String? name;

  double cost;

  Person({required this.id, required this.color, this.cost = 0, this.name});
}

class SelectorScreen extends StatefulWidget {
  const SelectorScreen({Key? key}) : super(key: key);

  @override
  State<SelectorScreen> createState() => _SelectorScreenState();
}

class _SelectorScreenState extends State<SelectorScreen> {
  List<String> selectedCircles = [];
  List<Person> people = [
    Person(id: '0', color: Colors.blueGrey),
    Person(id: '1', color: Colors.purple),
  ];

  List<Color> colors = [
    Colors.blueGrey,
    Colors.purple,
    Colors.cyan,
    Colors.amber,
    Colors.lightGreen,
    Colors.blueAccent,
    Colors.pinkAccent,
  ];

  void selectCircle(String id) {
    setState(() {
      if (selectedCircles.contains(id)) {
        selectedCircles.remove(id);
      } else {
        selectedCircles.add(id);
      }
    });
  }

  void createPerson() {
    if (people.length < 7) {
      people.add(Person(
        id: people.length.toString(),
        color: colors[people.length],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text('Test'),
        ),
        body: NeumorphicBackground(
          // backendColor: Color.fromARGB(255, 209, 209, 209),
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PeopleIndicator(
                  selectCircle: selectCircle,
                  people: people,
                  createPerson: createPerson,
                ),
                ItemList(
                  people: people,
                  selectedPeopleId: selectedCircles,
                ),
                NeumorphicButton(
                    margin: const EdgeInsets.only(top: 10),
                    style: const NeumorphicStyle(
                      color: Color.fromARGB(255, 94, 93, 213),
                    ),
                    onPressed: () => Navigator.pushNamed(
                          context,
                          '/final',
                          arguments: FinalScreenArguments(people: people),
                        ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 80,
                      child: const Text(
                        'Continuar',
                        style: TextStyle(
                            color: Colors.white,
                            //color: NeumorphicColors.background,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
