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
          calculateTotalCosts,
          quantity: 3),
      Item('Uramaki', 45, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
      Item('Combinado para uma pessoa', 123, widget.people,
          widget.selectedPeopleId, calculateTotalCosts)
    ];
  }

  void calculateTotalCosts() {
    for (var person in widget.people) {
      person.cost = 0;
      person.items = [];
    }

    for (var item in items) {
      var selectedPeople = item.indicatorCircles;
      for (var person in selectedPeople) {
        var currentPerson = widget.people.firstWhere((p) => p.id == person.id);
        currentPerson.cost += person.cost;
        currentPerson.items.add(SelectedItem(
            item.name, item.price / selectedPeople.length, item.quantity));

        //print("Item: ${item.name}, id: ${person.id}, cost: ${person.cost}"));
      }
      // widget.people.forEach((person) {
      //   person.cost = person.cost +
      //       selectedPeople.firstWhere((p) => p.id == person.id).cost;

      //   print(person.cost);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
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
