import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pszczoly_v3/models/note.dart';
import 'package:pszczoly_v3/screens/checklist_screen.dart';
import 'package:pszczoly_v3/screens/checklists_list_screen.dart';
import 'package:pszczoly_v3/widgets/image_input.dart';
import '../providers/hive_list_provider.dart';

// //ignore: must_be_immutable - this comment make flutter ignore this warning
class HiveScreen extends ConsumerStatefulWidget {
  HiveScreen(
      {super.key,
      this.selectedImage,
      required this.hiveName,
      required this.hiveId});

  File? selectedImage;
  String hiveName;
  String hiveId;

  @override
  ConsumerState<HiveScreen> createState() => _HiveScreenState();
}

class _HiveScreenState extends ConsumerState<HiveScreen> {
  updateHiveData(BuildContext context, File newImage) {
    ref
        .read(hiveDataProvider.notifier)
        .updateHivePhoto(widget.hiveName, newImage);
    ref.read(databaseProvider).updateHivePhoto(widget.hiveId, newImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ULala',
          style: TextStyle(
            fontFamily: GoogleFonts.zeyada().fontFamily,
            fontSize: 31,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Ul ${widget.hiveName}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.selectedImage != null &&
                      widget.selectedImage!.path.isNotEmpty &&
                      File(widget.selectedImage!.path).existsSync()
                  ? ClipRRect(
                     borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        widget.selectedImage!,
                        fit: BoxFit.cover,
                        height: 250,
                        width: double.infinity,
                      ),
                    )
                  : ImageInput(onPickImage: (image) {
                      updateHiveData(context, image);
                    }),
            ),
            widget.selectedImage == null
                ? TextButton(
                    onPressed: () {
                      ref.read(hiveDataProvider.notifier).updateHivePhoto(
                          widget.hiveName, widget.selectedImage);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Dodaj zdjęcie'),
                  )
                : const SizedBox(
                    height: 10,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => ChecklistScreen(
                                hiveId: widget.hiveId,
                                hiveName: widget.hiveName,
                              )),
                    );
                  },
                  child: const Text('Nowa checklista'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => ChecklistListScreen(
                                hiveId: widget.hiveId,
                                hiveName: widget.hiveName,
                              )),
                    );
                  },
                  child: const Text('Zobacz checklisty'),
                ),
              ],
            ),
            NoteEditor(
              hiveId: widget.hiveId,
            ),
            // const NoteEditor(),
          ],
        ),
      ),
    );
  }
}
