import 'package:intl/intl.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../SelectorScreen/types.dart';
import '../SelectorScreen/components/indicator_circle.dart';

final toReais = NumberFormat.simpleCurrency(locale: 'pt_BR');

class TotalCost extends StatefulWidget {
  final Person person;
  final double tip;

  const TotalCost(this.person, this.tip, {Key? key}) : super(key: key);

  @override
  State<TotalCost> createState() => _TotalCostState();
}

class _TotalCostState extends State<TotalCost> {
  double iconDepth = 3;
  bool showItems = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Neumorphic(
          margin: const EdgeInsets.only(bottom: 22),
          child: GestureDetector(
            onTap: () =>
                widget.person.items.forEach((item) => print(item.name)),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IndicatorCircle(
                    widget.person.color,
                    widget.person.id,
                    () {},
                    true,
                    isInFinalScreen: true,
                  ),
                  Text(
                    toReais.format(widget.person.cost * (1 + widget.tip / 100)),
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        iconDepth = !showItems ? 0.7 : 3.5;
                        showItems = !showItems;
                      });
                    },
                    child: NeumorphicIcon(
                      Icons.info,
                      style: NeumorphicStyle(depth: iconDepth),
                      size: 35,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: widget.person.items.isNotEmpty && showItems
              ? Container(
                  margin: const EdgeInsets.only(left: 5, bottom: 15),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ...widget.person.items
                          .map((item) => ListItem(item))
                          .toList(),
                      SizedBox(
                          child: widget.tip > 0
                              ? ListItem(SelectedItem("Gorjeta",
                                  widget.person.cost * (widget.tip / 100), 1))
                              : null)
                    ],
                  ),
                )
              : null,
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final SelectedItem item;

  const ListItem(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              child: Text(
                  "${((item.quantity * 100).round() / 100.0).toString()}x")),
          SizedBox(
            // alignment: Alignment.centerLeft,
            width: 100,
            child: NeumorphicText(
              toReais.format(item.price),
              style: const NeumorphicStyle(
                color: Colors.black87,
                depth: 1,
              ),
              textStyle: NeumorphicTextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            item.name,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
