import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:socialhub/user_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;

 Future<void> login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        if (email.isEmpty) _emailError = "Email cannot be empty";
        if (password.isEmpty) _passwordError = "Password cannot be empty";
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://jasiridb.onrender.com/auth/signin'), // Replace with your backend URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login successful!"),
            backgroundColor: Color(0xFF0026DC), // Success color
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => UserScreen(),
          ),
        );
      } else {
        final error = json.decode(response.body);
        String errorMessage = error['error'] ?? 'An unknown error occurred';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red, // Error color
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
          backgroundColor: Colors.red, // Error color red
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF0F4FF),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/images/security.svg',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              // Email Field with Error Display
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 187, 186, 186),
                        ),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 187, 186, 186),
                      ),
                      prefixIcon: Icon(Icons.email,
                          color: Color.fromARGB(255, 187, 186, 186)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 187, 186, 186),
                        ),
                      ),
                    ),
                  ),
                  if (_emailError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _emailError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              // Password Field with Error Display
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 187, 186, 186),
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 187, 186, 186),
                      ),
                      prefixIcon: Icon(Icons.lock,
                          color: Color.fromARGB(255, 187, 186, 186)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 187, 186, 186),
                        ),
                      ),
                    ),
                  ),
                  if (_passwordError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _passwordError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Forgot Password logic
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0xFF0026DC)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ElevatedButton(
                onPressed: _isLoading ? null : login,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Color(0xFF0026DC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
