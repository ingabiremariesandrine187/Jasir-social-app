import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'model/post.dart'; // ✅ Your model

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  Uint8List? _imageData;
  final TextEditingController _captionController = TextEditingController();

  Post? _postedContent; // ✅ For storing created post

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageData = bytes;
      });
    }
  }

  void _handlePost() {
    if (_imageData != null && _captionController.text.isNotEmpty) {
      final newPost = Post(
        imageData: _imageData!,
        caption: _captionController.text,
      );
      setState(() {
        _postedContent = newPost;
        _imageData = null;
        _captionController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _imageData != null
                ? Image.memory(_imageData!)
                : ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(Icons.photo),
                    label: Text("Choose Photo"),
                  ),
            SizedBox(height: 20),
            TextField(
              controller: _captionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Write a caption...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handlePost,
              child: Text("Post"),
            ),
            SizedBox(height: 30),
            if (_postedContent != null) ...[
              Divider(),
              Text("Your Posted Content:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(_postedContent!.caption),
              SizedBox(height: 10),
              Image.memory(_postedContent!.imageData),
            ]
          ],
        ),
      ),
    );
  }
}
