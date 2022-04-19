import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import './color_pick.dart';

class NewPersonCard extends StatelessWidget {
  const NewPersonCard({
    Key? key,
    required this.colors,
    colorPickers = [],
  }) : super(key: key);

  final List<Color> colors;
  List<ColorPick> colorPickers;

  void selectColor(List<ColorPick> list, String id) {
    List<ColorPick> copyList = [...list];
    for (ColorPick colorPick in copyList) {
      if (colorPick.id == id) {
        colorPick.isSelected = true;
      } else {
        colorPick.isSelected = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    colorPickers = colors
        .map((color) => ColorPick(color, (String id) {
              selectColor(colorPickers, id);
            }, color.toString()))
        .toList();

    return Stack(children: [
      Neumorphic(
        style: const NeumorphicStyle(depth: 4),
        margin: const EdgeInsets.only(bottom: 10),
        child: const SizedBox(
          width: 220,
          height: 200,
        ),
      ),
      Neumorphic(
        margin: const EdgeInsets.only(left: 20, top: 70),
        style: NeumorphicStyle(
            depth: -4,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))),
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
          bottom: 7,
        ),
        child: Container(
          alignment: Alignment.center,
          width: 35,
          // height: 60,
          child: const TextField(
            maxLength: 2,
            textCapitalization: TextCapitalization.characters,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: NeumorphicColors.darkVariant,
            ),
            cursorColor: NeumorphicColors.darkVariant,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 25),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: ,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 120),
              child: Column(children: colorPickers.sublist(0, 4)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                  children: colorPickers.sublist(4, colorPickers.length)),
            ),
          ],
        ),
      ),
    ]);
  }
}
