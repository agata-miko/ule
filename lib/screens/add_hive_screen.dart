import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/screens/hives_list_screen.dart';
import 'package:pszczoly_v3/widgets/image_input.dart';

class AddHiveScreen extends ConsumerStatefulWidget {
  const AddHiveScreen({super.key});

  @override
  ConsumerState<AddHiveScreen> createState() => _AddHiveScreenState();
}

class _AddHiveScreenState extends ConsumerState<AddHiveScreen> {
late File? photo;

  @override
  Widget build(BuildContext context) {
    final hivesList = ref.watch(hiveDataProvider);
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
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Numer ula'),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(hiveDataProvider.notifier).addHive(photo: photo);
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => HivesListScreen(hives: hivesList)));
              },
              child: Text('Dodaj ul'),
            ),
          ],
        ),
      ),
    );
  }
}
