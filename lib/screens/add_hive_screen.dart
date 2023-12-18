import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pszczoly_v3/widgets/image_input.dart';

class AddHiveScreen extends StatefulWidget {
  const AddHiveScreen({super.key});

  @override
  State<AddHiveScreen> createState() => _AddHiveScreenState();
}

class _AddHiveScreenState extends State<AddHiveScreen> {
  late File _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dodaj nowy ul')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Numer ula'),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ElevatedButton(
              onPressed: null,
              child: Text('Dodaj ul'),
            ),
          ],
        ),
      ),
    );
  }
}
