import 'package:flutter/material.dart';

import 'components/people_indicator.dart';

class SelectorScreen extends StatefulWidget {
  const SelectorScreen({Key? key}) : super(key: key);

  @override
  State<SelectorScreen> createState() => _SelectorScreenState();
}

class _SelectorScreenState extends State<SelectorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        //color: Colors.white,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            PeopleIndicator(),
          ],
        ),
      ),
    );
  }
}
