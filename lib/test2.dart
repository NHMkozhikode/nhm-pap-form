// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;


// void main() async{
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Send Data To Google Sheets',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//       ),
//       home: const HomePage(title: 'Send Data To Google Sheets'),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key, required this.title}) : super(key: key);
//   // always marked "final".

//   final String title;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final _formKey        = GlobalKey<FormState>();

//   /// Controllers
//   TextEditingController nameController    = TextEditingController();
//   TextEditingController sexController     = TextEditingController();
//   TextEditingController ageController     = TextEditingController();


//   void _submitForm() async{
//     if(_formKey.currentState!.validate()){
      
//       const String scriptURL  = 'https://script.google.com/macros/s/AKfycbxP1j46urBRkNRjeycLZfKHLpMPE2Xi6NMgP89mOzILjcjLOQUCkcPkL6plQcCUT9k4/exec';

//       String tempName     = nameController.text;
//       String tempSex      = sexController.text;
//       String tempAge      = ageController.text;

//       String queryString  = "?name=$tempName&sex=$tempSex&age=$tempAge";

//       var finalURI   = Uri.parse(scriptURL + queryString);
//       var response    = await http.get(finalURI);
//       //print(finalURI);
      
//       if (response.statusCode == 200) {
//         var bodyR = convert.jsonDecode(response.body);
//         print(bodyR);
//       }

//     }
//   }


//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//         child: Form(
//           key: _formKey,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 TextFormField(
//                   validator: (value){
//                     if(value ==""){
//                       return "Enter a valid value for name";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Enter Name',
//                   ),
//                   controller: nameController,
//                 ),
//                 TextFormField(
//                   validator: (value){
//                     if(value == ""){
//                       return "Enter a valid Sex";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Sex',
//                   ),
//                   controller: sexController,
//                 ),
//                 TextFormField(
//                   validator: (value){
//                     if(value == ""){
//                       return "Enter a valid Action";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Age',
//                   ),
//                   controller: ageController,
//                 ),
//                 SizedBox(height: 10,),
//                 RaisedButton(onPressed: (){ 
//                   _submitForm();
//                 },
//                   child: Text('Save Details'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// class TestPageMain extends StatefulWidget {
//   const TestPageMain({super.key});
//   @override
//   State<TestPageMain> createState() => _TestPageMainState();
// }

// class _TestPageMainState extends State<TestPageMain> {

//   final String title;
//   final _formKey        = GlobalKey<FormState>();
  
//   TextEditingController nameController    = TextEditingController();
//   TextEditingController sexController     = TextEditingController();
//   TextEditingController ageController     = TextEditingController();


//   void _submitForm() async{
//     if(_formKey.currentState!.validate()){
      
//       const String scriptURL  = 'https://script.google.com/macros/s/AKfycbxP1j46urBRkNRjeycLZfKHLpMPE2Xi6NMgP89mOzILjcjLOQUCkcPkL6plQcCUT9k4/exec';

//       String tempName     = nameController.text;
//       String tempSex      = sexController.text;
//       String tempAge      = ageController.text;

//       String queryString  = "?name=$tempName&sex=$tempSex&age=$tempAge";

//       var finalURI   = Uri.parse(scriptURL + queryString);
//       var response    = await http.get(finalURI);
//       //print(finalURI);
      
//       if (response.statusCode == 200) {
//         var bodyR = convert.jsonDecode(response.body);
//         print(bodyR);
//       }

//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//         child: Form(
//           key: _formKey,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 TextFormField(
//                   validator: (value){
//                     if(value ==""){
//                       return "Enter a valid value for name";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Enter Name',
//                   ),
//                   controller: nameController,
//                 ),
//                 TextFormField(
//                   validator: (value){
//                     if(value == ""){
//                       return "Enter a valid Sex";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Sex',
//                   ),
//                   controller: sexController,
//                 ),
//                 TextFormField(
//                   validator: (value){
//                     if(value == ""){
//                       return "Enter a valid Action";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Age',
//                   ),
//                   controller: ageController,
//                 ),
//                 SizedBox(height: 10,),
//                 RaisedButton(onPressed: (){ 
//                   _submitForm();
//                 },
//                   child: Text('Save Details'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }