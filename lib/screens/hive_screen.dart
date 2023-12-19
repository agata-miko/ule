import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/note.dart';
import 'package:pszczoly_v3/screens/checklist_screen.dart';
import 'package:pszczoly_v3/screens/hives_list_screen.dart';
import 'package:pszczoly_v3/widgets/image_input.dart';

import '../providers/hive_list_provider.dart';

class HiveScreen extends ConsumerStatefulWidget {
  HiveScreen({super.key, this.selectedImage, required this.hiveName, required this.hiveId});

  File? selectedImage;
  String hiveName;
  String hiveId;

  @override
  ConsumerState<HiveScreen> createState() => _HiveScreenState();
}

class _HiveScreenState extends ConsumerState<HiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.hiveName)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.selectedImage != null
                  ? SizedBox(height: 250, width: double.infinity,
                    child: Image.file(
                        widget.selectedImage!,
                        fit: BoxFit.cover,
                      ),
                  )
                  : ImageInput(
                      onPickImage: (image) {
                        widget.selectedImage = image;
                      },
                    ),
            ),
            widget.selectedImage == null
                ? TextButton(onPressed: () {
                ref.read(hiveDataProvider.notifier).updateHivePhoto(widget.hiveName, widget.selectedImage);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => HivesListScreen(hives: ref.watch(hiveDataProvider))));
            }, child: const Text('Dodaj zdjęcie'),) :
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => ChecklistScreen(hiveId: widget.hiveId,
                            hiveName: widget.hiveName,)),
                    );
                  },
                  child: const Text('Nowa checklista'),
                ),
                const ElevatedButton(
                  onPressed: null,
                  child: Text('Poprzednie checklisty'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // const NoteEditor(),
          ],
        ),
      ),
    );
  }
}
