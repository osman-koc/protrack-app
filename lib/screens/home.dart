import 'package:flutter/material.dart';
import 'package:protrack/util/firebase_user.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ana sayfa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appbar')),
      body: Center(
        child: Column(
          children: [
            Text('Test sayfa'),
            Text(getFirebaseUser().email ?? 'yok')
          ],
        ),
      ),
    );
  }
}