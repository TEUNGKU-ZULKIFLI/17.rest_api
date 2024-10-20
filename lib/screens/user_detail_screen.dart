import 'package:flutter/material.dart';
import '../models/users.dart';
import 'edit_user_screen.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    void _deleteUser() async {
      try {
        // Menghapus user dengan mengomentari ini, karena tidak ada metode delete
        // await ApiService().deleteUser(user.id);
        Navigator.pop(context, true); // Kembali dengan hasil true
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete user: $e')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User Details',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text('ID: ${user.id}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Name: ${user.name}',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                Text('Email: ${user.email}',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditUserScreen(user: user),
                          ),
                        );
                      },
                      child: Text('Edit User'),
                    ),
                    ElevatedButton(
                      onPressed: _deleteUser,
                      child: Text('Delete User'),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
