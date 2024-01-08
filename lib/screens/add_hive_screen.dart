import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/widgets/image_input.dart';

class AddHiveScreen extends ConsumerStatefulWidget {
  const AddHiveScreen({super.key});

  @override
  ConsumerState<AddHiveScreen> createState() => _AddHiveScreenState();
}

class _AddHiveScreenState extends ConsumerState<AddHiveScreen> {
  final _titleController = TextEditingController();
  File? photo;

  void _saveHive() {
    final enteredText = _titleController.text;

    if (enteredText.isEmpty) {
      return;
    }
    ref.read(hiveDataProvider.notifier).addHive(photo: photo, hiveName: enteredText);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

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
                  photo = image;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Nazwa/numer ula'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _saveHive,
              child: const Text('Dodaj ul'),
            ),
          ],
        ),
      ),
    );
  }
}
