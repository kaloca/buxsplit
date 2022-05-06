import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../types.dart';
import './indicator_circle.dart';

class PeopleIndicator extends StatefulWidget {
  final Function selectCircle;
  final List<Person> people;
  final Function createPerson;
  final Function removePerson;

  const PeopleIndicator(
      {Key? key,
      required this.selectCircle,
      required this.people,
      required this.createPerson,
      required this.removePerson})
      : super(key: key);

  @override
  State<PeopleIndicator> createState() => _PeopleIndicatorState();
}

class _PeopleIndicatorState extends State<PeopleIndicator> {
  List<IndicatorCircle> indicatorCircles = [];
  int _groupValue = 10;

  void selectCircle(int value) {
    setState(() => _groupValue = value);
    widget.selectCircle(value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Neumorphic(
            //margin: const EdgeInsets.only(bottom: 20),
            style: const NeumorphicStyle(
              intensity: 0,
              lightSource: LightSource.top,
            ),
            child: Container(
              height: 68,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border.all(color: Colors.blueAccent),
              //     borderRadius: BorderRadiusDirectional.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    //width: 100,
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
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
                            .map((person) => IndicatorCircle(
                                person.color, person.id, selectCircle, false,
                                value: int.parse(person.id),
                                groupValue: _groupValue))
                            .toList(),
                      ],
                    ),
                  ),
                  addRemoveCircle(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container addRemoveCircle() {
    return Container(
      margin: EdgeInsets.only(
          top: widget.people.isNotEmpty && widget.people.length < 8 ? 8 : 0),
      height: 60,
      // color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: widget.people.length < 8 ? 28 : 0,
            child: widget.people.length < 8
                ? InkWell(
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
                  )
                : null,
          ),
          SizedBox(
            child: widget.people.isNotEmpty
                ? InkWell(
                    onTap: () {
                      widget.removePerson();
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: NeumorphicIcon(
                        Icons.remove,
                        style: const NeumorphicStyle(
                          depth: 1,
                          color: NeumorphicColors.darkVariant,
                        ),
                        size: 32,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
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