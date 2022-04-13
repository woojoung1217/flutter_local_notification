import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image_page'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final _picker = ImagePicker();
              // Pick an image
              final image =
                  await _picker.pickImage(source: ImageSource.gallery);

              if (image != null) {
                setState(() {
                  _image = File(image.path);
                });
              }
              print('image $image');
            },
            child: const Text('갤러리에서 가져오기'),
          ),
          _image == null ? const Text('image is empty') : Image.file(_image!),
          ElevatedButton(
            onPressed: () async {
              final _picker = ImagePicker();
              // Pick an image
              final image = await _picker.pickImage(source: ImageSource.camera);

              if (image != null) {
                setState(() {
                  _image = File(image.path);
                });
              }
            },
            child: const Text('카메라에서 가져오기'),
          ),
          _image == null ? const Text('image is empty') : Image.file(_image!),
        ],
      ),
    );
  }
}
