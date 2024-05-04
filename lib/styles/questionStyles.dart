import "package:flutter/material.dart";

class questionStyle{
  static const TextStyle question =  TextStyle(
                            fontSize: 17,
                            // fontWeight: FontWeight.bold,
                            
                          );
}

class ConstantText extends StatelessWidget {
  final String text;

  ConstantText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: questionStyle.question, // If no style is provided, use default TextStyle
      textAlign: TextAlign.left,
    );
  }
}
