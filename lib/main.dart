import 'package:flutter/material.dart';
import 'screens/user_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter REST API',
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity
            .adaptivePlatformDensity, // Menyesuaikan kepadatan visual
      ),
      home: UserListScreen(),
    );
  }
}
