import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';

import './upload_image.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _image;

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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        alignment: AlignmentDirectional.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: 200,
                        height: 200,
                      )
                    : null),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: NeumorphicButton(
                onPressed: () {
                  pickImage();
                  // Navigator.pushNamed(context, '/selector');
                },
                child: const Text('SELECT'),
              ),
            ),
            NeumorphicButton(
              onPressed: () async {
                if (_image != null) {
                  response = await getReceiptFromApi(_image!);
                }
                // Navigator.pushNamed(context, '/selector');
              },
              child: const Text('UPLOAD'),
            ),
            NeumorphicButton(
              onPressed: () {
                print(response);
                decodedResponse = json.decode(response);
                // Navigator.pushNamed(context, '/selector');
              },
              child: const Text('PRINT'),
            ),
            NeumorphicButton(
              onPressed: () {
                print(decodedResponse["totalAmount"]["data"]);
                print(decodedResponse["amounts"]
                    .forEach((amount) => print(amount["text"])));
                // Navigator.pushNamed(context, '/selector');
              },
              child: const Text('PRINT'),
            ),
          ],
        ),
      ),
    );
  }
}
