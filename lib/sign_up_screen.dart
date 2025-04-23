import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUpUser() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://jasiridb.onrender.com/api/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Success: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up successful!'),
            backgroundColor: Color(0xFF0026DC), // Set background color here
          ),
        );

        // Navigate to login screen
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        final errorData = json.decode(response.body);

        // Check for errors in the response
        if (errorData['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorData['error']),
              backgroundColor: Colors.red, // Red background for error
            ),
          );
        } else if (errorData['message'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${errorData['message']}'),
              backgroundColor: Colors.red, // Red background for error
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An unknown error occurred'),
              backgroundColor: Colors.red, // Red background for error
            ),
          );
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
      print('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF0F4FF),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.05,
            horizontal: screenWidth * 0.05,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight * 0.05),
                Text(
                  "Welcome to  Social Hub",
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.05),

                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.03),

                // Sign Up Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUpUser,
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    backgroundColor: Color(0xFF0026DC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Sign Up', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Already have an account? Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("If you already have an account "),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFF0026DC),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
