import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:buxsplit/screens/SelectorScreen/components/indicator_circle.dart';

import '../types.dart';

class Item extends StatefulWidget {
  final String name;
  final double price;
  final List<Person> people;
  final List<String> selectedPeopleId;
  final Function executeWhenTapped;
  final double quantity;

  List<Person> indicatorCircles = [];

  List<Person> returnSelectedPeople() {
    return (indicatorCircles);
  }

  Item(this.name, this.price, this.people, this.selectedPeopleId,
      this.executeWhenTapped,
      {Key? key, this.quantity = 1})
      : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  void updatePricesPerItem() {
    for (var circle in widget.indicatorCircles) {
      double currentCost =
          widget.price * widget.quantity / widget.indicatorCircles.length;

      circle.cost = currentCost;
      // widget.people.firstWhere((p) => p.id == circle.id).cost +=
      //     currentCost;
    }
  }

  void removeCircle(String id) {
    setState(() {
      widget.indicatorCircles.removeWhere((circle) => circle.id == id);
      updatePricesPerItem();
      widget.executeWhenTapped();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // customBorder: ShapeBorder.,
      onTap: () {
        var peopleCopy = widget.people.map(
            (person) => Person(id: person.id, color: person.color, cost: 0));

        List<Person> _selectedPeople = List.from(peopleCopy
            .where((person) => person.id == widget.selectedPeopleId.last)
            .toList());
        print(_selectedPeople);

        List<Person> peopleToAdd = [];

        for (var person in _selectedPeople) {
          if (!widget.indicatorCircles.map((p) => p.id).contains(person.id)) {
            peopleToAdd.add(person);
          }
        }
        widget.indicatorCircles =
            List.from([...widget.indicatorCircles, ...peopleToAdd]);
        setState(() {
          widget.indicatorCircles.sort((a, b) => a.id.compareTo(b.id));
          updatePricesPerItem();
          widget.executeWhenTapped();
        });
      },
      child: Neumorphic(
        style: const NeumorphicStyle(
          lightSource: LightSource.top,
          depth: 3,
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.blueAccent),
          //   borderRadius: BorderRadiusDirectional.circular(10),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    margin: const EdgeInsets.only(right: 10),
                    child: NeumorphicText(
                      (widget.price * widget.quantity).toString(),
                      style: const NeumorphicStyle(
                        color: Colors.black54,
                        depth: 0.5,
                      ),
                      textStyle: NeumorphicTextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 153,
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 31, 31, 31),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 6, left: 8),
                    width: 18,
                    child: Text(
                      "${widget.quantity.toInt().toString()}x",
                    ),
                  ),
                ],
              ),
              Container(
                height: 38,
                alignment: Alignment.center,
                constraints: const BoxConstraints(minWidth: 40, maxWidth: 90),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: widget.indicatorCircles
                      .map((person) => IndicatorCircle(
                            person.color,
                            person.id,
                            removeCircle,
                            true,
                            price: person.cost,
                            value: 1,
                            groupValue: 4,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
