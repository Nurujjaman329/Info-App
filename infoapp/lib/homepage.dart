import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text("Rest Api Call"),
        ),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user['email'];
            final picture = user['picture']['thumbnail'];
            final name = user['name']['first'];
            return ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(picture)),
              title: Text(email),
              subtitle: Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.upload_file_rounded), onPressed: fetchUsers),
    );
  }

  void fetchUsers() async {
    print('Fetch Users Called');
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print('Fetch Completed');
  }
}
