import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:ui';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../SelectorScreen/selector_screen.dart';

List<String> imagePaths = [
  'assets/images/notinha1.jpeg',
  'assets/images/notinha2.jpeg',
];

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var _image;
  bool loading = false;
  bool showSelector = false;

  int numberOfPeople = 0;
  TextEditingController numberOfPeopleController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    var response, decodedResponse;

    void onChoosePhoto(int path) {
      setState(() {
        _image = path;
        showSelector = false;
      });
    }

    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text('Selecionar Nota'),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GestureDetector(
            onTap: (() => setState(() => showSelector = false)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: AlignmentDirectional.topCenter,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 80),
                    child: loading
                        ? const NeumorphicProgressIndeterminate(
                            height: 10,
                            style: ProgressStyle(
                                accent: Color.fromARGB(255, 112, 63, 152),
                                variant: Color.fromARGB(255, 81, 156, 213)),
                          )
                        : null,
                  ),
                  GestureDetector(
                    onTap: () => {setState(() => showSelector = true)},
                    child: Neumorphic(
                      style: const NeumorphicStyle(
                        depth: 7,
                      ),
                      child: _image != null
                          ? Image.asset(
                              imagePaths[_image],
                              height: 300,
                            )
                          : const SizedBox(
                              width: 300,
                              height: 300,
                              child: Icon(
                                Icons.image,
                                size: 70,
                                color: Color.fromARGB(255, 94, 93, 213),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: _image != null
                        ? NeumorphicButton(
                            margin: const EdgeInsets.only(top: 10, bottom: 30),
                            style: const NeumorphicStyle(
                              color: Color.fromARGB(255, 94, 93, 213),
                            ),
                            onPressed: () async {
                              setState(() => loading = true);
                              Future.delayed(const Duration(milliseconds: 3600),
                                  () {
                                Navigator.pushNamed(
                                  context,
                                  '/selector',
                                  arguments:
                                      SelectorScreenArguments(items: _image),
                                );
                                setState(() => loading = false);
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 80,
                              child: const Text(
                                'Continuar',
                                style: TextStyle(
                                    color: Colors.white,
                                    //color: NeumorphicColors.background,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: showSelector
                ? Container(
                    width: double.infinity,
                    height: 400,
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(
                      top: 50,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                      border: Border.all(
                        width: 4,
                        color: const Color.fromARGB(74, 240, 240, 240),
                      ),
                    ),
                    child: OverflowBox(
                      child: Column(children: [
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (() =>
                                    setState(() => showSelector = false)),
                                child: const Text('Cancelar'),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 342,
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Photo(0, onChoosePhoto),
                              Photo(1, onChoosePhoto),
                            ],
                          ),
                        )
                      ]),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class Photo extends StatelessWidget {
  final int path;
  final Function onTap;

  const Photo(
    this.path,
    this.onTap, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(path),
      child: SizedBox(
        width: 100,
        height: 100,
        child: FittedBox(
            child: Image.asset(
              imagePaths[path],
            ),
            fit: BoxFit.fill),
      ),
    );
  }
}
