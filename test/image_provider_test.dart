import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pszczoly_v3/providers/image_provider.dart';

class MockFile extends Mock implements File {}

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
      MockFile(),
      MockFile(),
      MockFile(),
      MockFile(),
      MockFile(),
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

  test('SelectedImageNotifier should handle setting to null when already null', () {
    final container = ProviderContainer();
    final selectedImage = container.read(selectedImageProvider.notifier);

    selectedImage.setSelectedImage(null);
    expect(container.read(selectedImageProvider), isNull);

    selectedImage.setSelectedImage(null);
    expect(container.read(selectedImageProvider), isNull);
  });
}