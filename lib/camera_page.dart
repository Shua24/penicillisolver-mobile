import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'database_helper.dart';

class CameraPage extends StatefulWidget {
  final Function(File) onImageCaptured;

  const CameraPage({super.key, required this.onImageCaptured});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras.first, ResolutionPreset.high);
    await _cameraController!.initialize();
    if (mounted) {
      setState(() {}); // Pastikan widget masih ada sebelum memanggil setState
    }
  }

  void _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final XFile file = await _cameraController!.takePicture();
        File? croppedFile = await _cropImage(File(file.path));

        if (croppedFile != null) {
          widget.onImageCaptured(croppedFile);

          // Simpan path hasil crop ke SQLite
          final dbHelper = DatabaseHelper();
          await dbHelper.saveProfilePicture(croppedFile.path);

          if (mounted) {
            Navigator.pop(context); // Periksa `mounted` sebelum menggunakan `context`
          }
        }
      } catch (e) {
        debugPrint("Error capturing image: $e");
      }
    }
  }

Future<File?> _cropImage(File imageFile) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Crop Image',
        minimumAspectRatio: 1.0,
      ),
    ],
  );

  if (croppedFile != null) {
    return File(croppedFile.path);
  }
  return null;
}

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kamera'),
        backgroundColor: Colors.blue,
      ),
      body: _cameraController != null && _cameraController!.value.isInitialized
          ? Stack(
              children: [
                CameraPreview(_cameraController!),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: _captureImage,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
