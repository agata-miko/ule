import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pszczoly_v3/providers/image_provider.dart';

class MockFile extends Mock implements File {
  @override
  final String path;

  MockFile({String? path}) : path = path ?? 'default_path';
}

void main () {
  test('SelectedImageNotifier should update the state with the selectedImage', () {
    final container = ProviderContainer();
    final selectedImage = container.read(selectedImageProvider.notifier);
    final testImage = MockFile();

    selectedImage.setSelectedImage(testImage);
    expect(container.read(selectedImageProvider), equals(testImage));
  });

  test('SelectedImageNotifier should update the state with the selectedImage multiple times', () {
    final container = ProviderContainer();
    final selectedImage = container.read(selectedImageProvider.notifier);

    List<MockFile> testImageList = [
      MockFile(path: 'a'),
      MockFile(path: 'b'),
      MockFile(path: 'c'),
      MockFile(path: 'd'),
      MockFile(path: 'e'),
    ];

    for(final testImage in testImageList) {
      selectedImage.setSelectedImage(testImage);
      final readResult = container.read(selectedImageProvider);
      expect(readResult, equals(testImage));
    }
    expect(container.read(selectedImageProvider), equals(testImageList.last));
  });

  test('SelectedImageNotifier default state should be null', () {
    final container = ProviderContainer();
    expect(container.read(selectedImageProvider), isNull);
  });

  test('SelectedImageNotifier should handle null selectedImage', () {
    final container = ProviderContainer();
    final selectedImage = container.read(selectedImageProvider.notifier);

    selectedImage.setSelectedImage(null);
    expect(container.read(selectedImageProvider), isNull);
  });

}