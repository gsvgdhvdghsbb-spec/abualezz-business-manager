import 'package:flutter/material';

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
        fontFamily: 'Cairo',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('نظام إدارة أبو العز (Abu Al-Ezz Manager)'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'مرحباً بك في نظام إدارة أبو العز V1.0\nجاهزون للربط والتطوير 🚀',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
