import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pszczoly_v3/widgets/note.dart';
import 'package:pszczoly_v3/screens/checklist_screen.dart';
import 'package:pszczoly_v3/screens/checklists_list_screen.dart';
import 'package:pszczoly_v3/widgets/image_input.dart';
import '../providers/hive_list_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    var imageDisplay = widget.selectedImage != null &&
            widget.selectedImage!.path.isNotEmpty &&
            File(widget.selectedImage!.path).existsSync()
        ? Image.file(
            widget.selectedImage!,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          )
        : ImageInput(onPickImage: (image) {
            updateHiveData(context, image);
          });

    bool isImageDisplayPhoto() {
      return imageDisplay is Image ? true : false;
    }

    bool _shouldExtendBody() {
      // Check if the keyboard is open and the screen is adjusting
      return !(MediaQuery.of(context).viewInsets.bottom > 0 &&
          MediaQuery.of(context).viewInsets.bottom !=
              MediaQuery.of(context).padding.bottom);
    }

    return Scaffold(
      extendBodyBehindAppBar: _shouldExtendBody(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: isImageDisplayPhoto == true ? Colors.white : Colors.black54),
        //TODO make the appbar's text and icon color dependent on the color palette of the photo taken by user
        title: Text(
          'ULala',
          style: TextStyle(
            fontFamily: GoogleFonts.zeyada().fontFamily,
            fontSize: 31,
            color: isImageDisplayPhoto == true ? Colors.white : Colors.black54,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            top: 0,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Stack(
                  children: [
                    isImageDisplayPhoto()
                        ? imageDisplay
                        : Center(child: imageDisplay),
                    if (isImageDisplayPhoto())
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Theme.of(context).colorScheme.primaryContainer
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: null,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6),
              child: Card(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(widget.hiveName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!.copyWith(fontSize: 25, fontWeight: FontWeight.w600)
                            ),
                          ),
                        ),
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
                          child: Text(AppLocalizations.of(context)!.newChecklist),
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
                          child: Text(AppLocalizations.of(context)!.seeOldChecklists),
                        ),
                        NoteEditor(
                          hiveId: widget.hiveId,
                        ),
                      ],
                    ),
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
