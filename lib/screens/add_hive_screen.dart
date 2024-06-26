import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/providers/database_provider.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/widgets/image_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final newHive = Hive(photo: photo, hiveName: enteredText);
    ref.read(databaseProvider).insertHive(newHive.toJson());
    ref
        .read(hiveDataProvider.notifier)
        .addHive(photo: photo, hiveName: enteredText);
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
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.addHive.toUpperCase())),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: ImageInput(
                onPickImage: (image) {
                  photo = image;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: TextField(
                controller: _titleController,
                maxLength: 30,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.hiveName,
                    hintStyle: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
            FloatingActionButton.extended(
              shape: const CircleBorder(),
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: _saveHive,
              label: const Icon(Icons.add),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
