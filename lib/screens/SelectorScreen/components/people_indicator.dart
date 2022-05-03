import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../types.dart';
import './indicator_circle.dart';

class PeopleIndicator extends StatefulWidget {
  final Function selectCircle;
  final List<Person> people;
  final Function createPerson;

  const PeopleIndicator(
      {Key? key,
      required this.selectCircle,
      required this.people,
      required this.createPerson})
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
          child: Neumorphic(
            margin: const EdgeInsets.only(bottom: 20),
            style: const NeumorphicStyle(
              intensity: 0,
              lightSource: LightSource.top,
            ),
            child: Container(
              height: 60,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border.all(color: Colors.blueAccent),
              //     borderRadius: BorderRadiusDirectional.circular(10)),
              child: SizedBox(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                        //alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 8, top: 5),
                        child: widget.people.isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  widget.createPerson();
                                  setState(() {});
                                },
                                child: const Text(
                                  'Adicionar pessoas',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: NeumorphicColors.darkVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : null),
                    ...widget.people
                        .map((person) => IndicatorCircle(person.color,
                            person.id, widget.selectCircle, false))
                        .toList(),
                    InkWell(
                      onTap: () {
                        widget.createPerson();
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: NeumorphicIcon(
                          Icons.add,
                          style: const NeumorphicStyle(
                            depth: 1,
                            color: NeumorphicColors.darkVariant,
                          ),
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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