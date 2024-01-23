import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pszczoly_v3/models/note.dart';
import 'package:pszczoly_v3/screens/checklist_screen.dart';
import 'package:pszczoly_v3/screens/checklists_list_screen.dart';
import 'package:pszczoly_v3/widgets/image_input.dart';
import '../providers/hive_list_provider.dart';

class HiveScreen extends ConsumerStatefulWidget {
  HiveScreen({
    super.key,
    this.selectedImage,
    required this.hiveName,
    required this.hiveId,
  });

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //TODO make the appbar's text and icon color dependent on the color palette of the photo taken by user
        title: Text(
          'ULala',
          style: TextStyle(
            fontFamily: GoogleFonts.zeyada().fontFamily,
            fontSize: 31,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          // Background Image
          Positioned.fill(
            bottom: 100.0,
            child: widget.selectedImage != null &&
                    widget.selectedImage!.path.isNotEmpty &&
                    File(widget.selectedImage!.path).existsSync()
                ? Image.file(
                    widget.selectedImage!,
                    fit: BoxFit.cover,
                  )
                : ImageInput(onPickImage: (image) {
                    updateHiveData(context, image);
                  }),
          ),

          // Overlay Card
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            top: 350,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)), color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20,),
                      Text(widget.hiveName, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 25), textAlign: TextAlign.center),
                      const SizedBox(height: 20,),
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
                                  ),
                                ),
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
                                  ),
                                ),
                              );
                            },
                            child: const Text('Zobacz checklisty'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      NoteEditor(hiveId: widget.hiveId),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
