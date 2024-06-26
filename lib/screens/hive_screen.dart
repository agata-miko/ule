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
import 'package:pszczoly_v3/providers/database_provider.dart';

class HiveScreen extends ConsumerStatefulWidget {
  const HiveScreen({
    super.key,
    this.selectedImage,
    required this.hiveName,
    required this.hiveId,
  });

  final File? selectedImage;
  final String hiveName;
  final int hiveId;

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

    bool shouldExtendBody() {
      // Check if the keyboard is open and the screen is adjusting
      return !(MediaQuery.of(context).viewInsets.bottom > 0 &&
          MediaQuery.of(context).viewInsets.bottom !=
              MediaQuery.of(context).padding.bottom);
    }

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: shouldExtendBody(),
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white.withOpacity(0.4),
          iconTheme: const IconThemeData(),
          title: Text(
            'ULE', style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
            fontFamily: GoogleFonts.plaster().fontFamily,
          ),
            ),
          ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_1.png'),
                  fit: BoxFit.cover)),
          height: MediaQuery.of(context).size.height,
          child: Stack(
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
                            child: Center(
                              child: Text(widget.hiveName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!.copyWith(fontSize: 25, fontWeight: FontWeight.w600)
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                            child: ElevatedButton(
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
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.016,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                            child: ElevatedButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
