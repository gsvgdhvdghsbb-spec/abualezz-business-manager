import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const AbuAlEzzApp());
}

class AbuAlEzzApp extends StatelessWidget {
  const AbuAlEzzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام إدارة أبو العز',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

