import 'package:flutter/material.dart';
import 'package:kel2/screens/user_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // You'll likely want to add a home property to specify the initial route
      home: UserListScreen(), // Assuming this is the screen you want to display
    );
  }
}
