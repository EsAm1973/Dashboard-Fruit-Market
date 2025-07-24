import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageFeild extends StatefulWidget {
  const ImageFeild({super.key});

  @override
  State<ImageFeild> createState() => _ImageFeildState();
}

class _ImageFeildState extends State<ImageFeild> {
  bool isLoading = false;
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
          } on Exception catch (e) {
            // TODO
          }
          setState(() {
            isLoading = false;
          });
        },
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.image_outlined, size: 180),
        ),
      ),
    );
  }
}
