// // // Flutter Packages
import 'package:flutter/material.dart';

// // // My Packages
// // import 'package:list_picker/list_picker.dart';



// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'NHM',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const MyHomePage(title: 'List Picker Example'),
// //     );
// //   }
// // }

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({super.key, required this.title});

// //   final String title;

// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   final TextEditingController chcController = TextEditingController();
// //   final TextEditingController fieldCont = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: Column(
// //           // mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             // Using the ListPickerField widget
// //             ListPickerField(
// //               label: 'CHC',
// //               isRequired: true,
// //               items: const ["CHERUVADI", "CHERUVANNUR", "KODENCHERY", "KODUVALLI", "KOORACHUNDU", "KUNNUMMAL", "MELADY", "MUKKAM", "NARIKUNI", "OLAVANNA", "ORKATERY", "THALAKULATHUR", "THIRUVALLUR", "THIRUVANGOOR", "ULLIYERI", "VALAYAM"],
// //               controller: fieldCont,
            
              
// //             ),
// //             const SizedBox(height: 16),


// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// List<String> _questions = [
//   "Question 1",
//   "Question 2",
//   // Add more questions as needed
// ];

// List<bool> _questionStates = List.generate(11, (_) => false); // Initialize all states as false

// List<Widget> _buildFormFields() {
//   List<Widget> formFields = [];

//   for (int i = 0; i < 11; i++) {
//     formFields.add(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 27),
//           QuestionText(text: _questions[i]), // Assuming QuestionText is a custom widget for displaying questions
//           FormBuilderTextField(
//             autovalidateMode: AutovalidateMode.always,
//             name: "Q$i",
//             decoration: InputDecoration(
//               suffixIcon: _questionStates[i]
//                   ? const Icon(Icons.error, color: Colors.red)
//                   : const Icon(Icons.check, color: Colors.green),
//             ),
//             onChanged: (val) {
//               setState(() {
//                 _questionStates[i] =
//                     !(_formKey.currentState?.fields['Q$i']?.validate() ?? false);
//               });
//             },
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(),
//               FormBuilderValidators.numeric(),
//               FormBuilderValidators.max(10000),
//             ]),
//             keyboardType: TextInputType.number,
//             textInputAction: TextInputAction.next,
//           ),
//         ],
//       ),
//     );
//   }
//   return formFields;
// }


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_upward),
            onPressed: scrollToTop,
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 50, // Replace with your actual list length
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item ${index + 1}'),
          );
        },
      ),
    );
  }

  void scrollToTop() {
    setState(() {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    });
  }
}
