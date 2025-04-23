import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PostScreen extends StatefulWidget {
  final String userId; // Accept userId as a parameter

  PostScreen({required this.userId});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  File? _image;

  // Picking image from gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Handling form submission (post creation)
  Future<void> _submitPost() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Use the userId passed into the widget
        String userId = widget.userId;

        // Update the URL to include the userId
        var request = http.MultipartRequest(
            'POST', Uri.parse('http://localhost:5000/api/posts/new/$userId'));

        // Add the text to the request
        request.fields['text'] = _textController.text;

        // Add the image to the request if exists
        if (_image != null) {
          var file = await http.MultipartFile.fromPath('photo', _image!.path);
          request.files.add(file);
        }

        // Send the request
        var response = await request.send();

        if (response.statusCode == 200) {
          // Handle success
          print("Post created successfully!");
        } else {
          // Handle error
          print("Failed to create post");
        }
      } catch (e) {
        print("Error uploading post: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        backgroundColor: Color(0xFF0026DC), // Applied your color code
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text input field for post content
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Write your post',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Button to pick an image
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text('Pick Image'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Color(0xFF0026DC), // Applied your color code
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              // Display picked image preview
              _image != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Image.file(
                        _image!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text('No image selected'),
                    ),

              SizedBox(height: 20),

              // Button to submit post
              ElevatedButton(
                onPressed: _submitPost,
                child: Text('Submit Post'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Color(0xFF0026DC), // Applied your color code
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}