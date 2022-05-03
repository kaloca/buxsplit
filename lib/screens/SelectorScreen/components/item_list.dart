import 'dart:collection';

import 'package:flutter/material.dart';

import './item.dart';
import '../types.dart';

class ItemList extends StatefulWidget {
  final List<Person> people;
  final List<String> selectedPeopleId;
  final int index;
  var items;

  ItemList(
      {Key? key,
      required this.people,
      required this.selectedPeopleId,
      required this.items,
      required this.index})
      : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final doubleRegex = RegExp(r'\s+(\d+\.\d+)\s+', multiLine: false);

  List<Item> items = [];
  List<Item> items2 = [];
  List<List<Item>> itemsList = [];

  @override
  void initState() {
    super.initState();
    print(widget.items);

    // items = widget.items["amounts"].map<Item>(
    //   (amount) {
    //     String name = amount["text"];
    //     return Item(
    //       name,
    //       5,
    //       widget.people,
    //       widget.selectedPeopleId,
    //       calculateTotalCosts,
    //       quantity: 3,
    //     );
    //   },
    // ).toList();
    items = [
      Item('COMPL BANANA FATIADA', 6, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
      Item(
        'POKE TROPICAL',
        54,
        widget.people,
        widget.selectedPeopleId,
        calculateTotalCosts,
        quantity: 2,
      ),
      Item('AÇAI FRUTARIA', 30, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
      Item(
        'COMPL FRUTAS DIVERSA',
        7,
        widget.people,
        widget.selectedPeopleId,
        calculateTotalCosts,
        quantity: 2,
      ),
      Item('SUCO AÇAI', 28, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
      Item('COMPL CASTANHA CAJU', 7, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
      Item('TAPIOCA PERU', 31, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
      Item('COMPL OVOS MEXIDOS', 14, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
    ];

    items2 = [
      Item(
        'PORC A ROSSINI',
        80,
        widget.people,
        widget.selectedPeopleId,
        calculateTotalCosts,
        quantity: 2,
      ),
      Item(
        'CAFE',
        6.75,
        widget.people,
        widget.selectedPeopleId,
        calculateTotalCosts,
      ),
      Item('AGUA S/ GAS', 7, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
      Item(
        'COUVERT LE JAZ',
        11.5,
        widget.people,
        widget.selectedPeopleId,
        calculateTotalCosts,
      ),
      Item('CHOPP COYOTERO', 15, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
      Item('MEXILHAO GRAND', 66.5, widget.people, widget.selectedPeopleId,
          calculateTotalCosts),
    ];

    itemsList = [items, items2];
  }

  void calculateTotalCosts() {
    for (var person in widget.people) {
      person.cost = 0;
      person.items = [];
    }

    for (var item in itemsList[widget.index]) {
      var selectedPeople = item.indicatorCircles;
      for (var person in selectedPeople) {
        var currentPerson = widget.people.firstWhere((p) => p.id == person.id);
        currentPerson.cost += person.cost;
        currentPerson.items.add(SelectedItem(
            item.name,
            item.price * item.quantity / selectedPeople.length,
            item.quantity / selectedPeople.length));

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
    return ListView(shrinkWrap: true, children: [...itemsList[widget.index]]);
  }
}
