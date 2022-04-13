import 'package:buxsplit/screens/SelectorScreen/components/indicator_circle.dart';
import 'package:flutter/material.dart';

import '../selector_screen.dart';

class Item extends StatefulWidget {
  final String name;
  final double price;
  final List<Person> people;
  final List<String> selectedPeopleId;

  const Item(this.name, this.price, this.people, this.selectedPeopleId,
      {Key? key})
      : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  List<Person> indicatorCircles = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // customBorder: ShapeBorder.,
      onTap: () {
        List<Person> selectedPeople = widget.people
            .where((person) => widget.selectedPeopleId.contains(person.id))
            .toList();

        List<Person> peopleToAdd = [];

        selectedPeople.forEach((person) {
          !indicatorCircles.contains(person) ? peopleToAdd.add(person) : null;
        });

        setState(() {
          indicatorCircles = [...indicatorCircles, ...peopleToAdd];
        });
      },
      child: Container(
        // height: 60,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadiusDirectional.circular(10),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  margin: const EdgeInsets.only(right: 6),
                  child: Text(
                    widget.price.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: Text(
                    widget.name,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minWidth: 40, maxWidth: 100),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: indicatorCircles
                    .map((person) =>
                        IndicatorCircle(person.color, person.id, () {}))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
