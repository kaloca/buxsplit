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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Item('Temaki de Salmão', 27, widget.people, widget.selectedPeopleId),
        Item('Uramaki', 45, widget.people, widget.selectedPeopleId),
        Item('Combinado para uma pessoa', 123, widget.people,
            widget.selectedPeopleId)
      ],
    );
  }
}
