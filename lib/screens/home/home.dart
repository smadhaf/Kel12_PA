import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:patest1/widgets/kamera.dart';
import 'package:patest1/widgets/navbar.dart';
import 'package:patest1/widgets/drawer.dart';
import 'package:patest1/models/user.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  String? _result;

  bool _isLoading = false;

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = null; // Reset hasil klasifikasi
      });
    }
  }

  Future<void> _classifyImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image first.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse('http://192.168.3.242:5000/classify'); // Ganti sesuai alamat backend
      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('image', _image!.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final data = json.decode(responseData.body);

        setState(() {
          _result = data['hair_type'];
        });
      } else {
        setState(() {
          _result = "Failed to classify image.";
        });
      }
    } catch (e) {
      setState(() {
        _result = "Error: Unable to connect to server.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hair Type Detection'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: _currentIndex == 0
          ? LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Welcome!",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Analyze your hair type instantly",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        CameraButton(
                          onTap: _pickImageFromCamera,
                        ),
                        const SizedBox(height: 15),
                        _image != null
                            ? Image.file(
                                _image!,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              )
                            : const Text("No image selected."),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _classifyImage,
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Classify Hair Type"),
                        ),
                        const SizedBox(height: 20),
                        _result != null
                            ? Text(
                                "Result: $_result",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
              },
            )
          : const UserScreen(), // Tampilkan halaman UserScreen jika index 1
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
