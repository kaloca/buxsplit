import 'package:flutter/material.dart';

import 'components/people_indicator.dart';
import 'components/item_list.dart';

class Person {
  final String id;
  final Color color;

  Person({required this.id, required this.color});
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
    Person(id: '2', color: Colors.cyan),
    Person(id: '3', color: Colors.amber),
    Person(id: '4', color: Colors.lightGreenAccent),
  ];

  void selectCircle(String id) {
    print('ng');
    setState(() {
      if (selectedCircles.contains(id)) {
        selectedCircles.remove(id);
      } else {
        selectedCircles.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        //color: Colors.white,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PeopleIndicator(selectCircle: selectCircle, people: people),
            ItemList(
              people: people,
              selectedPeopleId: selectedCircles,
            ),
            GestureDetector(
                onTap: () => print(selectedCircles),
                child: Container(
                  width: 10,
                  height: 10,
                  color: Colors.green,
                ))
          ],
        ),
      ),
    );
  }
}
