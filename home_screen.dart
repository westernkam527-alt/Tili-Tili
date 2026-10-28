import 'package:flutter/material.dart';

void main() {
  runApp(const TiliTiliApp());
}

class TiliTiliApp extends StatelessWidget {
  const TiliTiliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tili Tili',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'Welcome to Tili Tili!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
