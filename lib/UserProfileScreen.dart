import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Profile with background
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.greenAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/pcc.png'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),

            // Basic Info
            Text(
              "Marie Sando",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "ingabiremariesandrine@gmail.com",
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Add edit profile logic
                  },
                  icon: Icon(Icons.edit),
                  label: Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // Add logout logic
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: BorderSide(color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Additional Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profileItem("Phone", "+250 780528972"),
                      Divider(),
                      profileItem("Gender", "Female"),
                      Divider(),
                      profileItem("Date of Birth", "01 october 1995"),
                      Divider(),
                      profileItem("Address", "Kigali, Rwanda"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget profileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.teal),
          SizedBox(width: 10),
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
