import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../SelectorScreen/selector_screen.dart';
import '../SelectorScreen/components/indicator_circle.dart';

class TotalCost extends StatelessWidget {
  final Person person;

  const TotalCost(this.person, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            IndicatorCircle(
              person.color,
              person.id,
              () {},
              true,
              isInFinalScreen: true,
            ),
            Text("Cost: " + person.cost.toString()),
          ],
        ),
      ),
    );
  }
}
