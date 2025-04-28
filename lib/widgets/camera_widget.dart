import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatefulWidget {
  final Function(String) onImageCaptured;

  const CameraWidget({super.key, required this.onImageCaptured});

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  final _picker = ImagePicker();

  Future<void> _captureImage() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      widget.onImageCaptured(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center the column content
      children: [
        IconButton(
          icon: const Icon(Icons.camera_alt, size: 72), // Use const for the icon
          onPressed: _captureImage,
        ),
        const SizedBox(height: 8), // Added a small gap
        const Text('Capture Leaf Image', style: TextStyle(fontSize: 18)), // Use const for the Text widget
      ],
    );
  }
}
