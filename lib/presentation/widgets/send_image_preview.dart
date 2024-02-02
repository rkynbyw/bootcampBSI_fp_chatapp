import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.imageFile,
  });

  final File imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Image.file(imageFile, fit: BoxFit.cover),
    );
  }
}