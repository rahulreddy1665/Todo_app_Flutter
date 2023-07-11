import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagepicker extends StatefulWidget {
  const Imagepicker({Key? key}) : super(key: key);

  @override
  State<Imagepicker> createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker> {
  late ImagePicker _imagePicker;
  String? _pickedImagePath;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _pickedImagePath = pickedImage?.path;
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );

    setState(() {
      _pickedImagePath = pickedImage?.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_pickedImagePath != null)
              Image.file(
                File(_pickedImagePath!),
                height: 200,
              ),
            if (_pickedImagePath == null)
            const FlutterLogo(
              size: 150,
            ),
            const SizedBox(height: 20),
            Text(
              'Pick an Image',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _pickImageFromGallery,
              icon: Icon(Icons.photo_library),
              label: Text('Pick from Gallery'),
            ),
            ElevatedButton.icon(
              onPressed: _pickImageFromCamera,
              icon: Icon(Icons.camera_alt),
              label: Text('Pick from Camera'),

            ),
            const SizedBox(height: 20),

          ],
        ),
      )
    );
  }
}
