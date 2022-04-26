import 'dart:collection';

import 'package:flutter/material.dart';

import './item.dart';
import '../types.dart';

class ItemList extends StatefulWidget {
  final List<Person> people;
  final List<String> selectedPeopleId;
  var items;

  ItemList(
      {Key? key,
      required this.people,
      required this.selectedPeopleId,
      required this.items})
      : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final doubleRegex = RegExp(r'\s+(\d+\.\d+)\s+', multiLine: false);

  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    print(widget.items);

    items = widget.items["amounts"].map<Item>(
      (amount) {
        String name = amount["text"];
        return Item(
          name,
          5,
          widget.people,
          widget.selectedPeopleId,
          calculateTotalCosts,
          quantity: 3,
        );
      },
    ).toList();
    // items = [
    //   Item('Temaki de Salmão', 27, widget.people, widget.selectedPeopleId,
    //       calculateTotalCosts,
    //       quantity: 3),
    //   Item('Uramaki', 45, widget.people, widget.selectedPeopleId,
    //       calculateTotalCosts),
    //   Item('Combinado para uma pessoa', 123, widget.people,
    //       widget.selectedPeopleId, calculateTotalCosts)
    // ];
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
    return ListView(shrinkWrap: true, children: [...items]);
  }
}
