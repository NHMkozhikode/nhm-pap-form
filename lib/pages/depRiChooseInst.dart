// import 'package:flutter/material.dart';
// // import 'package:flutter_form_builder/flutter_form_builder.dart';
// // import 'package:form_builder_validators/form_builder_validators.dart';
// // import 'package:pap_care_management/codepage.dart';
// // import 'package:pap_care_management/pages/formOne.dart';

// class RelatedFields extends StatefulWidget {
//   const RelatedFields({
//     super.key,
//     });

//   @override
//   State<RelatedFields> createState() => _RelatedFieldsState();
// }

// class _RelatedFieldsState extends State<RelatedFields> {
//   final _formKey = GlobalKey<FormBuilderState>();
  
//   bool autoValidate = true;
//   bool readOnly = false;
//   bool _ageHasError = true;
//   String country = '';
//   String city = '';
  
//   String institutionType = "";
//   String chc = ""; 
  
//   List<String> chcList =[];

//   List<String> cities = [];

//   @override
//   void initState() {
//     country = _insitiutionType.first;
//     city = _allChcList.first;
//     cities = _allChcList;

//     // chc = 
//     super.initState();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return FormBuilder(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           const SizedBox(height: 20),
//           FormBuilderDropdown<String>(
            
//             name: 'institution',
//             decoration: const InputDecoration(
//               label: Text("Institution"),
//             ),
//             initialValue: country,
//             onChanged: (value) {
//               setState(() {
//                 country = value ?? '';
//                 city = '';
//                 changeCities();
//               });
//             },
//             items: _insitiutionType
//                 .map((e) => DropdownMenuItem(
//                       value: e,
//                       child: Text(e),
//                     ))
//                 .toList(),
//           ),
//           const SizedBox(height: 10),
//           FormBuilderDropdown<String>(
            
//             name: 'location',
//             decoration: const InputDecoration(
//               label: Text('Location'),
//             ),
//             validator: FormBuilderValidators.compose([
//                     FormBuilderValidators.required(),]),
//             onChanged: (val) {
//                     setState(() {
//                       _ageHasError =
//                           !(_formKey.currentState?.fields['location']?.validate() ??
//                               false);
//                     });
//                   },
//             initialValue: city,
//             items: cities
//                 .map((e) => DropdownMenuItem(
//                       value: e,
//                       child: Text(e),
//                     ))
//                 .toList(),
//           ),
//           const SizedBox(height: 10),

//           // FormBuilderTextField(
//           //         autovalidateMode: AutovalidateMode.always,
//           //         name: "age",
//           //         decoration: InputDecoration(
//           //           labelText: 'Age',
//           //           suffixIcon: _ageHasError
//           //               ? const Icon(Icons.error, color: Colors.red)
//           //               : const Icon(Icons.check, color: Colors.green),
//           //         ),
//           //         onChanged: (val) {
//           //           setState(() {
//           //             _ageHasError =
//           //                 !(_formKey.currentState?.fields['age']?.validate() ??
//           //                     false);
//           //           });
//           //         },
//           //         // valueTransformer: (text) => num.tryParse(text),
//           //         validator: FormBuilderValidators.compose([
//           //           FormBuilderValidators.required(),
//           //           FormBuilderValidators.numeric(),
//           //           FormBuilderValidators.max(10000),
//           //         ]),
//           //         // initialValue: '12',
//           //         keyboardType: TextInputType.number,
//           //         textInputAction: TextInputAction.next,
//           //  ),

//           MaterialButton(
//             color: Theme.of(context).colorScheme.secondary,
//             child: const Text(
//               "Submit",
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: () {
//               // final String locationStr ='hgf';
//               _formKey.currentState!.saveAndValidate();
//               debugPrint(_formKey.currentState?.instantValue.toString() ?? ''); 
//               // Map<String, dynamic>? placeData = _formKey.currentState?.instantValue;
//               // locationStr = placeData?["location"];
//               if(_formKey.currentState?.fields['location']?.validate() == true){
//                 Navigator.push(context,MaterialPageRoute(builder: (context) =>const CodePage(title: 'Fields',child: FormOne(selectedInstitution: "suii",selectedLocation: "tft",))));

//               }
//               // Navigator.push(context,MaterialPageRoute(builder: (context) =>const CodePage(title: 'Fields',child: SimpleTextFields())));
//             },
//           ),

          
           
          
//         ],
//       ),
//     );
//   }

//   void changeCities() {
//     switch (country) {
//       case 'Hospital':
//         cities = _allHospitalList;
//         break;
//       case 'CHC':
//         cities = _allChcList;
//         break;
//       default:
//         cities = [];
//     }
//   }
// }

// const _insitiutionType = [
//   'CHC',
//   'Hospital',
// ];

// const _allChcList = [
//   "CHERUVADI", "CHERUVANNUR", "KODENCHERY", "KODUVALLI", "KOORACHUNDU", "KUNNUMMAL", "MELADY", "MUKKAM", "NARIKUNI", "OLAVANNA", "ORKATERY", "THALAKULATHUR", "THIRUVALLUR", "THIRUVANGOOR", "ULLIYERI", "VALAYAM"
// ];

// const _allHospitalList = [
//   "GGH KOZHIKODE", "TH KOYILANDY", "TH NADAPURAM", "TH KUTTYADI", "TH PERAMBRA", "TH BALUSSERI", "TH THAMARASSERI"
// ];


// // const _insitiutionType = [
// //   'CHC',
// //   'Hospital'
// //   ];

// // const _


