import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pap_care_management/app_secrets/confidential.dart';
import 'package:pap_care_management/styles/question_style.dart';

import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class HospitalForm extends StatefulWidget {

  const HospitalForm({Key? key}) : super(key: key);
  @override
  State<HospitalForm> createState() => _HospitalFormState();
}

class _HospitalFormState extends State<HospitalForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final db = FirebaseFirestore.instance;

  
  bool autoValidate = true;
  bool readOnly = false;
  String queryString = '';
  String? eachQuestion = '';
  String firstFormElem ='';
  final List<FocusNode> _focusNodes = List.generate(_questions.length, (_) => FocusNode());
  final List<bool> _questionStates = List.generate(_questions.length, (_) => true); // Initialize all states as false
 //                                                 ^ chnage the no of qns

  // late Future<List> instituteAndLocationGlobal;
  late Future<List<dynamic>> instituteAndLocationGlobal ;

@override
  void initState() {
    super.initState();
    instituteAndLocationGlobal = _instituteLocationSharedPrefReciver();

    // Print the data once it is retrieved
    instituteAndLocationGlobal.then((data) {
      String? institute = data[0] as String?;
      String? location = data[1] as String?;
      debugPrint('Institute: $institute');
      debugPrint('Location: $location');
    });
  }

  Future<List> _instituteLocationSharedPrefReciver()async{
    String? _institute;
    SharedPreferences prefs = await _prefs;
    String? _location;
    setState(() {
        _institute = (prefs.getString('Institute') ?? "No data received");
        _location = (prefs.getString('Location') ?? "No data received");
        // debugPrint(_institute.toString());
        // debugPrint(_location.toString());
    });

    return [_institute,_location];
  }

  Future <int> _addingDataToFirebase( List<dynamic> instituteLocationListMain, Map <String,dynamic> quesionsListWithInstituteAndLocation)async {
    try{
      db.collection(instituteLocationListMain[0]) // institution
      .doc(instituteLocationListMain[1]) //location
      .set(quesionsListWithInstituteAndLocation);
      return 1;
    } catch(e){
      debugPrint("Error writing document: $e");
      return 0; // failure
    }     
    // .onError((e, _) => debugPrint("Error writing document: $e"));
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
            debugPrint(_formKey.currentState!.value.toString());
          },
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround ,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   child: Text(widget.message),
              // ),
              // const SizedBox(height: 20),
              // Generated FormBuilderTextField widgets for questions Q1 to Q11
              ..._buildFormFields(),
              const SizedBox(height: 24,),
              EasyButton(
              idleStateWidget: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              loadingStateWidget: const CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
              useWidthAnimation: true,
              useEqualLoadingStateWidgetDimension: true,
              width: 150.0,
              height: 40.0,
              borderRadius: 4.0,
              contentGap: 6.0,
              buttonColor: Colors.blueAccent,
              onPressed: ()async{
                  await Future.delayed(const Duration(milliseconds: 3000), () => 42);
                  _formKey.currentState!.saveAndValidate();
                  debugPrint(_formKey.currentState?.instantValue.toString() ?? '');
                  Map<String, dynamic>? formData = _formKey.currentState?.instantValue;
                  List instituteLocationList = await _instituteLocationSharedPrefReciver();

                  final quesionsListWithInstituteAndLocation = {
                  "Institute": instituteLocationList[0],
                  "Location": instituteLocationList[1],
                  "Status": true,
                  "timestamp": FieldValue.serverTimestamp()
                  };

                  for(int i=0; i< _questions.length; i++){
                    eachQuestion = formData?["Q$i"];
                    if(eachQuestion != null){
                      quesionsListWithInstituteAndLocation['Q$i'] = eachQuestion! ;
                    }else{
                      quesionsListWithInstituteAndLocation['Q$i'] = "";
                    }
                  }

                  debugPrint(quesionsListWithInstituteAndLocation.toString());
                  _addingDataToFirebase(instituteLocationList, quesionsListWithInstituteAndLocation);
                  sendRequest('function2');
                },
            ),
            ],
          ),
        ),
      );

  }

  List<Widget> _buildFormFields() {
    List<Widget> formFields = [];
    // debugPrint("Number of questions");
    // debugPrint(_questions.length.toString());
    for (int i = 0; i < _questions.length; i++) {
      formFields.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 27),
            QuestionText(text: _questions[i], questionNumber: i + 1,),
            FutureBuilder<List>(
              future: instituteAndLocationGlobal,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(); // or a placeholder widget
                }
                String? institute = snapshot.data![0] as String?;
                String? location = snapshot.data![1] as String?;
                // debugPrint('Institute: $institute');
                // debugPrint('Location: $location');
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection(institute!).doc(location!).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(); // or a placeholder widget
                    }
                    final data = snapshot.data?.data() as Map<String, dynamic>?;
                    return FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.disabled,
                      initialValue: data?['Q$i']?.toString() ?? '',
                      focusNode: _focusNodes[i],
                      name: "Q$i",
                      decoration: InputDecoration(
                        suffixIcon: _questionStates[i]
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _questionStates[i] =
                              !(_formKey.currentState?.fields['Q$i']?.validate() ?? false);
                        });
                      },
                      validator: FormBuilderValidators.compose([
                        // FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(10000),
                      ]),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        if (i + 1 < _questions.length) {
                          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                        } else {
                          FocusScope.of(context).unfocus();
                        }
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    }
    return formFields;
  }


  Future<int> sendRequest(String action) async {
    String url = AppScriptString().theAppScriptUrl;

    final response = await http.get(Uri.parse('$url?action=$action'));

    if (response.statusCode == 200) {
      // var responseBody = json.decode(response.body);
      // var responseBody = jsonDecode(response.body);
      // debugPrint('Response: $responseBody');
      debugPrint("Work AAAyi mwonnee");
      return 1;
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
      return 0;
    }
  }


}
const _questions = [
"Number of units with trained (BCCPM / 10 days) charge medical officer",
"Number of units with trained (BCCPN / 10 days) charges Nursing Officer",
"New Patients of Follow up in the month",
"No of patients on Follow up at the End of the month",
"Total no of Home care days",
"Total No. of Patients Visited by Staff Nurse",
"Total No. of Patients Visited by Doctor",
"Number of Ascetic tapping at Home",
"Special OP attendance",
"No. of institutions having morphine license",
"Total number of Patients given morphine",
"Total No of patients given IP care",
"Catheterization",
"No of patients given Colostomy materials",
"No of Health Professionals completed 3 days training in this month",
"No. of Nursing Students Completed 3 Days Training in this Month",
"Mouth Care",
"Parenteral Fluid / Medicine",
"Wound Care",
"PRE Enema",
"Riles tube",
"Colostomy Care",
"Tracheotomy Care",
"Lymph edema",
"No. of Care Homes in the Secondary Area",
"No. of Care Homes Visit",
"Other Innovative Programs"
];

 // Initialize all states as false





