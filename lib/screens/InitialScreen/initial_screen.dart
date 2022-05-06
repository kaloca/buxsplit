import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: Stack(
        children: [
          Opacity(
              opacity: 0.9,
              child: Container(
                margin: const EdgeInsets.only(left: 200, top: 60),
                child: Image.asset(
                  'assets/images/demo.png',
                  width: 200,
                ),
              )),
          Opacity(
            opacity: 0.3,
            child: Container(
              margin: const EdgeInsets.only(top: 470),
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/bux-logo.png',
                width: 1,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image.network(
                //   'https://buxbank.com.br/wp-content/uploads/2022/03/bux-logo-main.webp',
                //   height: 90,
                // ),
                Container(
                  margin: const EdgeInsets.only(top: 280, bottom: 50),
                  child: NeumorphicText(
                    "BuxSplit",
                    textStyle: NeumorphicTextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                    style: const NeumorphicStyle(
                      depth: 3,
                      intensity: 0.8,
                      color: Color.fromARGB(255, 94, 93, 213),
                    ),
                  ),
                ),
                NeumorphicButton(
                  style: const NeumorphicStyle(
                    depth: 3,
                    intensity: 0.8,
                    color: NeumorphicColors.background,
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/scan'),
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 80,
                    child: const Text('Começar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
