import 'package:flutter/material.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({super.key});

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Work in Progress"),
      ),
      body: const Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text("We are brewing someting amazing !")
        ],
      ),
    );
  }
}