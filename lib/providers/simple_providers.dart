import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedImageProvider =
    StateNotifierProvider<SelectedImageNotifier, File?>(
        (ref) => SelectedImageNotifier());

class SelectedImageNotifier extends StateNotifier<File?> {
  SelectedImageNotifier() : super(null);

  void setSelectedImage(File image) {
    state = image;
  }
}



