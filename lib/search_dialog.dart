import 'package:flutter/material.dart';

void showSearchDialog(BuildContext context) {
  String searchText = '';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text("Search"),
        content: TextField(
          onChanged: (value) {
            searchText = value;
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              print("Search value: $searchText");
            },
            child: Text("Search"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
          ),
        ],
      );
    },
  );
}
