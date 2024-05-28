import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserDetailsScreen extends StatelessWidget {
  final int userId;

  UserDetailsScreen({required this.userId});

  Future<User> fetchUserDetails() async {
    final response =
        await http.get(Uri.https('reqres.in', '/api/users/$userId'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<User>(
        future: fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${user.email}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  // Placeholder data
                  Text(
                    'Age: 20',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Country: Indonesia',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
