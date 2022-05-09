import 'package:flutter/material.dart';

import './item.dart';
import '../types.dart';

final List<GlobalObjectKey<ItemState>> itemKeyList =
    List.generate(13, (index) => GlobalObjectKey<ItemState>(index));

class ItemList extends StatefulWidget {
  static final GlobalKey<_ItemListState> globalKey = GlobalKey();

  final List<Person> people;
  final List<String> selectedPeopleId;
  final int index;
  var items;

  ItemList({
    Key? key,
    required this.people,
    required this.selectedPeopleId,
    required this.items,
    required this.index,
  }) : super(key: globalKey);

  @override
  _ItemListState createState() => _ItemListState();
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
          calculateTotalCosts,
          key: itemKeyList[0]),
      Item('POKE TROPICAL', 54, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          quantity: 2, key: itemKeyList[1]),
      Item(
        'AÇAI FRUTARIA',
        30,
        widget.people,
        widget.selectedPeopleId,
        calculateTotalCosts,
      ),
      Item('COMPL FRUTAS DIVERSA', 7, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          quantity: 2, key: itemKeyList[2]),
      Item('SUCO AÇAI', 28, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          key: itemKeyList[3]),
      Item('COMPL CASTANHA CAJU', 7, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          key: itemKeyList[4]),
      Item('TAPIOCA PERU', 31, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          key: itemKeyList[5]),
      Item('COMPL OVOS MEXIDOS', 14, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          key: itemKeyList[6]),
    ];

    items2 = [
      Item('PORC A ROSSINI', 80, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          quantity: 2, key: itemKeyList[7]),
      Item('CAFE', 6.75, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          key: itemKeyList[8]),
      Item('AGUA S/ GAS', 7, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          key: itemKeyList[9]),
      Item('COUVERT LE JAZ', 11.5, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          key: itemKeyList[10]),
      Item('CHOPP COYOTERO', 15, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          key: itemKeyList[11]),
      Item('MEXILHAO GRAND', 66.5, widget.people, widget.selectedPeopleId,
          calculateTotalCosts,
          key: itemKeyList[12]),
    ];

    itemsList = [items, items2];
  }

  void removeCircleFromItems(String id) {
    print(id);
    for (int i = 0; i < itemsList[widget.index].length; i++) {
      print(itemKeyList[i]);
      var item = itemsList[widget.index][i];
      for (var circle in item.indicatorCircles) {
        if (circle.id == id) {
          itemKeyList[i].currentState?.removeCircle(id);
          // item.indicatorCircles.remove(circle);
        }
      }
    }
  }

  bool checkIfEmpty(String id) {
    for (var item in itemsList[widget.index]) {
      if (item.indicatorCircles.where((i) => i.id == id).isNotEmpty) {
        return false;
      }
    }
    return true;
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
