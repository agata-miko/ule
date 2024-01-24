import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';


class ImageInput extends ConsumerStatefulWidget {
 const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  ConsumerState<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends ConsumerState<ImageInput> {

  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

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
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 0,
      child: GestureDetector(
        onTap: () {
          _takePicture();
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.camera_alt_outlined, size: 45,),
            Text('Zrób zdjęcie'),
          ],
        ),
      ),
    );

    // TextButton.icon(
    //   icon: const Icon(Icons.camera_alt_outlined,),
    //   label: Text('Zrób zdjęcie', style: Theme.of(context).textTheme.bodyMedium,),
    //   onPressed: _takePicture,
    // );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: ClipRRect(borderRadius: BorderRadius.circular(20),
          child: Image.file(
            _selectedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
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
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
