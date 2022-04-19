import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ColorPick extends StatefulWidget {
  final Color color;
  bool isSelected;
  bool hasBeenSelected;
  final Function onTap;
  final String id;

  ColorPick(this.color, this.onTap, this.id,
      {this.isSelected = false, this.hasBeenSelected = false, Key? key})
      : super(key: key);
  @override
  State<ColorPick> createState() => _ColorPickState();
}

class _ColorPickState extends State<ColorPick> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
        widget.onTap();
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: -4,
          boxShape: const NeumorphicBoxShape.circle(),
          color: widget.color,
          border: NeumorphicBorder(
            color: Colors.blue[500],
            width: 6,
            isEnabled: widget.isSelected,
          ),
        ),
        child: const SizedBox(height: 30, width: 30),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
      ),
    );
  }
}
