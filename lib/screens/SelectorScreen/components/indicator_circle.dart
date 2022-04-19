import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IndicatorCircle extends StatefulWidget {
  final Color circleColor;
  final String id;
  final Function selectCircle;
  final bool isPartOfItem;
  final double price;
  final bool isInFinalScreen;

  const IndicatorCircle(
      this.circleColor, this.id, this.selectCircle, this.isPartOfItem,
      {Key? key, this.price = 0, this.isInFinalScreen = false})
      : super(key: key);

  @override
  State<IndicatorCircle> createState() => _IndicatorCircleState();
}

class _IndicatorCircleState extends State<IndicatorCircle> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: !widget.isInFinalScreen
            ? () {
                if (widget.isPartOfItem) {
                  widget.selectCircle(widget.id);
                } else {
                  isSelected = !isSelected;
                  widget.selectCircle(widget.id);
                }
              }
            : null,
        child: Stack(
          children: [
            Neumorphic(
              style: NeumorphicStyle(
                color: !isSelected
                    ? widget.circleColor
                    : widget.circleColor.withOpacity(0.5),
                boxShape: const NeumorphicBoxShape.circle(),
                depth: isSelected ? -3.5 : 3,
                intensity: 1,
                // border: NeumorphicBorder(
                //   color: Color.fromARGB(255, 16, 0, 118),
                //   isEnabled: isSelected,
                //   width: 0.3,
                // ),
              ),
              margin: const EdgeInsets.only(right: 10),
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                // child: isSelected
                //     ? const Icon(
                //         Icons.done,
                //         size: 20,
                //         color: NeumorphicColors.background,
                //       )
                //     : null,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 18, bottom: 20),
              child: widget.isPartOfItem && !widget.isInFinalScreen
                  ? Neumorphic(
                      style: const NeumorphicStyle(depth: 1),
                      child: Icon(
                        Icons.clear_rounded,
                        size: 16,
                        color: Colors.red[400],
                      ),
                    )
                  : null,
              // child: Text(widget.price.toString()),
            ),
          ],
        ));
  }
}
