import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  Future<void> createUser() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.https('reqres.in', '/api/users'),
        body: {
          'name': nameController.text,
          'email': emailController.text,
          'age': ageController.text,
          'country': countryController.text,
        },
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User created successfully')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to create user')));
      }
    }
  }

  String? validateEmail(String? value) {
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: validateEmail,
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: countryController,
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a country';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: createUser,
                child: Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
