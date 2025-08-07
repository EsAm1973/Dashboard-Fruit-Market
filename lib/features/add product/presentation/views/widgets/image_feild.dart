import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageFeild extends StatefulWidget {
  const ImageFeild({super.key, required this.onFileChanged});
  final ValueChanged<File?> onFileChanged;
  @override
  State<ImageFeild> createState() => _ImageFeildState();
}

class _ImageFeildState extends State<ImageFeild> {
  bool isLoading = false;
  File? fileImage;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          try {
            final ImagePicker picker = ImagePicker();
            // Pick an image.
            final XFile? image = await picker.pickImage(
              source: ImageSource.gallery,
            );
            fileImage = File(image!.path);
            widget.onFileChanged(fileImage!);
          } on Exception {}
          setState(() {
            isLoading = false;
          });
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child:
                  fileImage != null
                      ? Image.file(fileImage!)
                      : const Icon(Icons.image_outlined, size: 180),
            ),
            Visibility(
              visible: fileImage != null,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    fileImage = null;
                    widget.onFileChanged(null);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
