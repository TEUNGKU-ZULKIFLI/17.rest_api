import 'package:flutter/material.dart';
import '../models/users.dart';
import '../services/api_service.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = ApiService().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    void _refreshUserList() {
      setState(() {
        futureUsers = ApiService().fetchUsers();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshUserList,
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            List<User> users = snapshot.data!;
            return ListView.separated(
              itemCount: users.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 2, color: Colors.grey),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    users[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(users[index].email),
                  onTap: () async {
                    final updatedUser = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserDetailScreen(user: users[index]),
                      ),
                    );

                    if (updatedUser != null) {
                      _refreshUserList(); // Memperbarui daftar jika ada perubahan
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
