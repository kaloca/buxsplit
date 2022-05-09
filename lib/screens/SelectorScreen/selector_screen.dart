import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:buxsplit/screens/FinalScreen/final.screen.dart';

import 'components/people_indicator.dart';
import 'components/item_list.dart';
import 'components/item.dart';

import './types.dart';

class SelectorScreenArguments {
  var items;

  SelectorScreenArguments({this.items});
}

class SelectorScreen extends StatefulWidget {
  static final GlobalKey<_SelectorScreenState> globalKey = GlobalKey();

  SelectorScreen({Key? key}) : super(key: globalKey);

  @override
  State<SelectorScreen> createState() => _SelectorScreenState();
}

class _SelectorScreenState extends State<SelectorScreen> {
  List<String> selectedCircles = ['d'];
  List<Person> people = [];

  bool showDeleteError = false;

  List<Color> colors = [
    Colors.blueGrey,
    Colors.purple,
    Colors.cyan,
    Colors.blueAccent,
    Colors.pinkAccent,
    Colors.indigo,
    Colors.teal,
    const Color.fromARGB(255, 94, 93, 213)
  ];

  void selectCircle(String id) {
    // setState(() {
    //   if (selectedCircles.contains(id)) {
    //     selectedCircles.remove(id);
    //   } else {
    //     selectedCircles.add(id);
    //   }
    // });
    setState(() {
      selectedCircles[0] = id;
      // selectedCircles.add(id);
    });
  }

  void createPerson() {
    if (people.length < colors.length) {
      people.add(Person(
        id: people.length.toString(),
        color: colors[people.length],
      ));
    }
  }

  bool checkFU() {
    if (ItemList.globalKey.currentState != null &&
        ItemList.globalKey.currentState!.checkIfEmpty(people.last.id)) {
      return true;
    } else {
      return false;
    }
  }

  void removePerson() {
    if (people.isNotEmpty) {
      // ItemList.globalKey.currentState
      //     ?.removeCircleFromItems("${int.parse(people.last.id) + 1}");
      if (checkFU()) {
        people.remove(people.last);
      } else {
        setState(() => showDeleteError = true);
      }
    }
  }

  void deletePersonToDelete() {
    if (checkFU()) {
      setState(() => showDeleteError = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SelectorScreenArguments;

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
          title: const Text('Selecionar pratos'),
          actions: [
            InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                '/final',
                arguments: FinalScreenArguments(people: people),
              ),
              child: const Icon(Icons.check),
            )
          ],
        ),
        body: NeumorphicBackground(
          // backendColor: Color.fromARGB(255, 209, 209, 209),
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // NewPersonCard(colors: colors),
                PeopleIndicator(
                  selectCircle: selectCircle,
                  people: people,
                  createPerson: createPerson,
                  removePerson: removePerson,
                ),
                SizedBox(
                    child: showDeleteError
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 13),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Text(
                              'Por favor desselecionar os items com a pessoa que está tentando deletar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 144, 39, 32),
                              ),
                            ),
                          )
                        : null),

                SizedBox(
                  height: showDeleteError ? 560 : 600,
                  child: ItemList(
                    people: people,
                    selectedPeopleId: selectedCircles,
                    items: args.items,
                    index: args.items,
                  ),
                ),
                // NeumorphicButton(
                //     margin: const EdgeInsets.only(top: 10),
                //     style: const NeumorphicStyle(
                //       color: Color.fromARGB(255, 94, 93, 213),
                //     ),
                //     onPressed: () => Navigator.pushNamed(
                //           context,
                //           '/final',
                //           arguments: FinalScreenArguments(people: people),
                //         ),
                //     child: Container(
                //       alignment: Alignment.center,
                //       height: 30,
                //       width: 80,
                //       child: const Text(
                //         'Continuar',
                //         style: TextStyle(
                //             color: Colors.white,
                //             //color: NeumorphicColors.background,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
