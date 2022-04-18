import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  int numberOfPeople = 0;
  TextEditingController numberOfPeopleController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        alignment: AlignmentDirectional.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: numberOfPeopleController,
              decoration: const InputDecoration(labelText: "Enter your number"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: NeumorphicButton(
                onPressed: () {
                  setState(() {
                    numberOfPeople = int.parse(numberOfPeopleController.text);
                  });
                  Navigator.pushNamed(context, '/selector');
                },
                child: const Text('TEST'),
              ),
            ),
            Text(numberOfPeople.toString()),
          ],
        ),
      ),
    );
  }
}
