import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ImageInput extends ConsumerStatefulWidget {
 const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  ConsumerState<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends ConsumerState<ImageInput> {

  File? _selectedImage;

  void _takePicture(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: source, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
      // ref.read(selectedImageProvider.notifier).setSelectedImage(selectedImage!);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Card(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _takePicture(ImageSource.camera);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.camera_alt_outlined, size: 25,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                Text(AppLocalizations.of(context)!.takePhoto),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: () {
              _takePicture(ImageSource.gallery);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.photo_library, size: 25,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                Text(AppLocalizations.of(context)!.chooseFromGallery),
              ],
            ),
          ),
        ],
      ),
    );

    // TextButton.icon(
    //   icon: const Icon(Icons.camera_alt_outlined,),
    //   label: Text('Zrób zdjęcie', style: Theme.of(context).textTheme.bodyMedium,),
    //   onPressed: _takePicture,
    // );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: () {
          _takePicture(ImageSource.camera);
        },
        child: ClipRRect(borderRadius: BorderRadius.circular(20),
          child: Image.file(
            _selectedImage!,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
      );
    }

    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     width: 1,
      //     color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      //   ),
      // ),
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        content,
      ],
    ),
    );
  }
}
