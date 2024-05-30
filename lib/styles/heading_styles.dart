import 'package:flutter/material.dart';

class headingStyle{
  static const TextStyle question = TextStyle(fontSize: 19,fontWeight: FontWeight.bold);
}


class HeadingText extends StatelessWidget {
  final String headingText;
  const HeadingText({super.key, required this.headingText});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueAccent,
      // width: BorderSide.strokeAlignCenter,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        headingText,
        style: headingStyle.question,
        // textAlign: TextAlign.center,
      ),
    );
  }
}