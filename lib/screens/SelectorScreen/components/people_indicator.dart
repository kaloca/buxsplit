import 'package:flutter/material.dart';

import '../selector_screen.dart';
import './indicator_circle.dart';

class PeopleIndicator extends StatefulWidget {
  final Function selectCircle;
  final List<Person> people;

  const PeopleIndicator(
      {Key? key, required this.selectCircle, required this.people})
      : super(key: key);

  @override
  State<PeopleIndicator> createState() => _PeopleIndicatorState();
}

class _PeopleIndicatorState extends State<PeopleIndicator> {
  List<IndicatorCircle> indicatorCircles = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 80,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadiusDirectional.circular(10)),
            child: SizedBox(
              height: 30,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: widget.people
                      .map((person) => IndicatorCircle(
                          person.color, person.id, widget.selectCircle))
                      .toList()),
            ),
          ),
        ),
      ],
    );
  }
}

/*
GestureDetector(
            onTap: () {
              setState(() {
                indicatorCircles = [
                  ...indicatorCircles,
                  (IndicatorCircle(
                      Colors.primaries[
                          Random().nextInt(Colors.primaries.length)],
                      indicatorCircles.length,
                      widget.selectCircle))
                ];
              });
              print(indicatorCircles);
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadiusDirectional.circular(2)),
            ),
              )


  IndicatorCircle(
                          person.color, person.id, widget.selectCircle))
 */