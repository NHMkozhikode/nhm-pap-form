import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class questionStyle{
  static const TextStyle question =  TextStyle(
                            fontSize: 15,
                            // backgroundColor: Colors.black26,
                            // fontWeight: FontWeight.bold,
                            
                          );
}

// class ConstantText extends StatelessWidget {
//   final String text;

//   ConstantText({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: questionStyle.question, // If no style is provided, use default TextStyle
//       textAlign: TextAlign.left,
//     );
//   }
// }

// class QuestionText extends StatelessWidget {
//   final String text;
//   final int questionNumber;
  
//   const QuestionText({super.key, required this.text, required this.questionNumber});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text("$questionNumber "),
//         Expanded(
//           child: Text(
//             text,
//             style: questionStyle.question, // If no style is provided, use default TextStyle
//             textAlign: TextAlign.left,
//             // overflow: TextOverflow.visible,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class QuestionText extends StatelessWidget {
//   final String text;
//   final int questionNumber;

//   const QuestionText({super.key, required this.text, required this.questionNumber});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start, // Align the Row's contents at the top
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start, // Align the Column's contents at the start
//           children: [
//             Text(
//               "$questionNumber",
//               style: TextStyle(height: 1), // Adjust height if necessary
//             ),
//           ],
//         ),
//         SizedBox(width: 5), // Add some spacing between the number and the text
//         Expanded(
//           child: Text(
//             text,
//             style: questionStyle.question,
//             textAlign: TextAlign.left,
//             overflow: TextOverflow.visible,
//           ),
//         ),
//       ],
//     );
//   }
// }

class QuestionText extends StatelessWidget {
  final String text;
  final int questionNumber;

  const QuestionText({super.key, required this.text, required this.questionNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align the Row's contents at the top
      children: [
        Baseline(
          baseline: 16, // Adjust this value as needed to align with the text
          baselineType: TextBaseline.alphabetic,
          child: Text(
            "$questionNumber. ",
            style: TextStyle(
              fontSize: 15,
              height: 1.2, // Adjust height if necessary
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: questionStyle.question,
            textAlign: TextAlign.left,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}