import 'package:credits/credits.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credits Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Credits(
        children: [
          _creditText("CAST", 40),
          _creditText("Actor 1", 20),
          _creditText("Actor 2", 22),
          _creditText("Actor 3", 24),
          _creditText("Actor 4", 26),
        ],
        onFinished: () {
          // Do something when the credits finish
          debugPrint("Credits finished");
        },
      ),
    );
  }

  Widget _creditText(String text, double size) => Padding(
    padding: const EdgeInsets.only(bottom: 32),
    child: Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
  );
}
