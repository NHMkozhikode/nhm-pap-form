import 'package:flutter/material.dart';

class FormSuccessfullyFinished extends StatefulWidget {
  const FormSuccessfullyFinished({super.key});

  @override
  State<FormSuccessfullyFinished> createState() => _FormSuccessfullyFinishedState();
}

class _FormSuccessfullyFinishedState extends State<FormSuccessfullyFinished> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data"),),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Text("Data Succesfully added :)"),
          SizedBox(height: 20,),
          MaterialButton(
            color: Colors.black,
            child: const Text("GO Back", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context); 
              Navigator.pop(context); 
            },
          ),
        ],
      ),
    );
  }
}