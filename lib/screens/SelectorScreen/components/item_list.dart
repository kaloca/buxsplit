import 'package:flutter/material.dart';

import './item.dart';
import '../selector_screen.dart';

class ItemList extends StatefulWidget {
  final List<Person> people;
  final List<String> selectedPeopleId;

  const ItemList(
      {Key? key, required this.people, required this.selectedPeopleId})
      : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Item> items = [];

  @override
  void initState() {
    super.initState();

    items = [
      Item('Temaki de Salmão', 27, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
      Item('Uramaki', 45, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
      Item('Combinado para uma pessoa', 123, widget.people,
          widget.selectedPeopleId, calculateTotalCosts)
    ];
  }

  void calculateTotalCosts() {
    for (var person in widget.people) {
      person.cost = 0;
    }

    for (var item in items) {
      var selectedPeople = item.indicatorCircles;
      selectedPeople.forEach((person) {
        widget.people.firstWhere((p) => p.id == person.id).cost += person.cost;

        //print("Item: ${item.name}, id: ${person.id}, cost: ${person.cost}"));
      });
      // widget.people.forEach((person) {
      //   person.cost = person.cost +
      //       selectedPeople.firstWhere((p) => p.id == person.id).cost;

      //   print(person.cost);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...items,
        // ElevatedButton(
        //     onPressed: calculateTotalCosts, child: Text('calculate costs')),
        // ElevatedButton(
        //     onPressed: () => widget.people.forEach(
        //         (p) => print("id" + p.id + "cost : " + p.cost.toString())),
        //     child: Text('print costs'))
      ],
    );
  }
}
