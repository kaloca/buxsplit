import 'package:flutter/material.dart';

class PeopleIndicator extends StatefulWidget {
  const PeopleIndicator({Key? key}) : super(key: key);

  @override
  State<PeopleIndicator> createState() => _PeopleIndicatorState();
}

class _PeopleIndicatorState extends State<PeopleIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadiusDirectional.circular(10)),
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadiusDirectional.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
