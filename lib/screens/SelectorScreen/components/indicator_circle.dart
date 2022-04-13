import 'package:flutter/material.dart';

class IndicatorCircle extends StatefulWidget {
  final Color circleColor;
  final String id;
  final Function selectCircle;

  const IndicatorCircle(this.circleColor, this.id, this.selectCircle,
      {Key? key})
      : super(key: key);

  @override
  State<IndicatorCircle> createState() => _IndicatorCircleState();
}

class _IndicatorCircleState extends State<IndicatorCircle> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSelected = !isSelected;
        widget.selectCircle(widget.id);
      },
      child: Container(
        height: 30,
        width: 30,
        margin: const EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
            color: widget.circleColor,
            border: isSelected
                ? Border.all(color: Colors.blueAccent, width: 4)
                : null,
            borderRadius: BorderRadiusDirectional.circular(15)),
      ),
    );
  }
}
