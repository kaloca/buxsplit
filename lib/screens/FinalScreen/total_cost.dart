import 'package:intl/intl.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../SelectorScreen/types.dart';
import '../SelectorScreen/components/indicator_circle.dart';

final toReais = NumberFormat.simpleCurrency(locale: 'pt_BR');

class TotalCost extends StatefulWidget {
  final Person person;

  const TotalCost(this.person, {Key? key}) : super(key: key);

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
                    toReais.format(widget.person.cost),
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
                    children: widget.person.items
                        .map((item) => SizedBox(
                              height: 25,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      child:
                                          Text("${item.quantity.toString()}x")),
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
                            ))
                        .toList(),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
