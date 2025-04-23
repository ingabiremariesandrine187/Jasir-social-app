import 'dart:convert'; // for json decoding
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http; // Use http or Dio for API requests
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userId = '';
  String _userName = '';
  String _userEmail = '';
  String _token = '';
  String _error = '';

  String get userId => _userId;
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get token => _token;
  String get error => _error;

  // API endpoint to sign in the user
  final String _signinUrl =
      'https://your-api-url.com/signin'; // Replace with your actual API URL

  // Method to sign in the user
  Future<void> signin(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_signinUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract token and user data
        _token = data['token'];
        _userId = data['user']['_id'];
        _userName = data['user']['name'];
        _userEmail = data['user']['email'];

        _error = ''; // Reset error on successful login
        notifyListeners();
      } else {
        final data = jsonDecode(response.body);
        _error = data['error'] ?? 'An unknown error occurred';
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to connect to the server. Please try again later.';
      notifyListeners();
      print('Error during sign in: $e');
    }
  }

  // Method to clear the user session (signout)
  void signout() {
    _userId = '';
    _userName = '';
    _userEmail = '';
    _token = '';
    _error = '';
    notifyListeners();
  }

  // Method to handle error messages in the UI
  String getErrorMessage() {
    return _error;
  }
}
