import 'package:flutter/material.dart';
import 'package:socialhub/login_screen.dart';
import 'package:socialhub/sign_up_screen.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF0F4FF), 
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(
                    height:
                        screenHeight * 0.25), // Adjust based on screen height

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Social hub',
                      style: TextStyle(
                        fontSize: screenWidth * 0.1, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'cursive',
                      ),
                    ),
                  ],
                ),

               

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, // Responsive padding
                    vertical: screenHeight * 0.05,
                  ),
                  child: Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0026DC),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical:
                                  screenHeight * 0.02, // Responsive padding
                            ),
                            textStyle: TextStyle(
                              fontSize:
                                  screenWidth * 0.045, // Responsive font size
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Login'),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02), // Responsive space
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0026DC),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: screenHeight * 0.02,
                            ),
                            textStyle: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.03,
                  ),
                  child: Text(
                    'Welcome to our Social hub ,where millions of thinkers ,artists & Creatives ,creators and changemakers connect ,learn ,discover hobbies ,shop ,create and more. Enjoy your journey Jasiri!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.04, // Responsive font size
                    ),
                    textAlign: TextAlign.center, // Moved here
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
