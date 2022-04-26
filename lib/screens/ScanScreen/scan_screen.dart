import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';

import '../SelectorScreen/selector_screen.dart';
import './upload_image.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _image;
  bool loading = false;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() => _image = imageTemporary);
    } on PlatformException catch (e) {
      print('fail $e');
    }
  }

  int numberOfPeople = 0;
  TextEditingController numberOfPeopleController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    var response, decodedResponse;
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text('Selecionar Nota'),
      ),
      body: Container(
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
              onTap: () => pickImage(),
              child: Neumorphic(
                style: const NeumorphicStyle(
                  depth: 7,
                ),
                child: _image != null
                    ? Image.file(
                        _image!,
                        height: 300,
                      )
                    : const SizedBox(
                        width: 300,
                        height: 300,
                        child: Icon(
                          Icons.image,
                          size: 70,
                          color: Colors.grey,
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
                        response = await getReceiptFromApi(_image!);
                        decodedResponse = json.decode(response);
                        setState(() => loading = false);
                        Navigator.pushNamed(
                          context,
                          '/selector',
                          arguments:
                              SelectorScreenArguments(items: decodedResponse),
                        );
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
    );
  }
}
