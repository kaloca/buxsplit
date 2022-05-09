import 'package:flutter_neumorphic/flutter_neumorphic.dart';

List<String> alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];

class IndicatorCircle extends StatefulWidget {
  final Color circleColor;
  final String id;
  final Function selectCircle;
  final bool isPartOfItem;
  final double price;
  final bool isInFinalScreen;
  final int value;
  final int groupValue;

  const IndicatorCircle(
      this.circleColor, this.id, this.selectCircle, this.isPartOfItem,
      {Key? key,
      this.price = 0,
      this.isInFinalScreen = false,
      required this.value,
      required this.groupValue})
      : super(key: key);

  bool get isSelected => value == groupValue;

  @override
  State<IndicatorCircle> createState() => _IndicatorCircleState();
}

class _IndicatorCircleState extends State<IndicatorCircle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: !widget.isInFinalScreen
            ? () {
                if (widget.isPartOfItem) {
                  widget.selectCircle(widget.id);
                } else {
                  // isSelected = !isSelected;
                  if (widget.value == widget.groupValue) {
                    //unselect
                    // widget.selectCircle(100);
                  } else {
                    widget.selectCircle(widget.value);
                  }
                  widget.selectCircle(widget.value);
                }
              }
            : null,
        child: Stack(
          children: [
            Neumorphic(
              style: NeumorphicStyle(
                color: !widget.isSelected
                    ? widget.circleColor
                    : widget.circleColor.withOpacity(0.5),
                boxShape: const NeumorphicBoxShape.circle(),
                depth: widget.isSelected ? -3.5 : 3,
                intensity: 1,
                // border: NeumorphicBorder(
                //   color: Color.fromARGB(255, 16, 0, 118),
                //   isEnabled: isSelected,
                //   width: 0.3,
                // ),
              ),
              margin: EdgeInsets.only(
                  right: !widget.isInFinalScreen &&
                          !widget.isPartOfItem &&
                          widget.id == '7'
                      ? 0
                      : 10),
              child: Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Text(alphabet[int.parse(widget.id)],
                    style: const TextStyle(
                      color: NeumorphicColors.background,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
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
