import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pap_care_management/confidential.dart';
import 'package:pap_care_management/styles/headingStyle.dart';
import 'package:pap_care_management/styles/questionStyles.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class LsgdForm extends StatefulWidget {
  final String selectedInstitution;
  final String selectedLocation;

  // const LsgdForm({
  //   super.key,
  // });


  const LsgdForm({Key? key, required this.selectedInstitution, required this.selectedLocation}) : super(key: key);
  @override
  State<LsgdForm> createState() => _LsgdFormState();
}

class _LsgdFormState extends State<LsgdForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool autoValidate = true;
  bool readOnly = false;
  String queryString = '';
  String eachQuestion = '';
  String firstFormElem ='';
  int counterQuestions = 0;
  final List<bool> _questionStates = List.generate(_questions.length, (_) => true); // Initialize all states as false
 //                                                 ^ chnage the no of qns
 final List<bool> _questionStates1 = List.generate(_questions1.length, (_) => true); // Initialize all states as false
 //                                                 ^ chnage the no of qns
 final List<bool> _questionStates2 = List.generate(_questions2.length, (_) => true); // Initialize all states as false
 //                                                 ^ chnage the no of qns
 final List<bool> _questionStates3 = List.generate(_questions3.length, (_) => true); // Initialize all states as false
 //                                                 ^ chnage the no of qns
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Container(
              //   child: Text(widget.message),
              // ),
              // const SizedBox(height: 20),
              // Generated FormBuilderTextField widgets for questions Q1 to Q11
              const HeadingText(headingText: "Registration & Home Care details "),
              ..._buildFormFields(_questions.length, _questions, _questionStates),
              const SizedBox(height: 20,),
              const HeadingText(headingText:"Training and number of Participants in Home Care"),
              ..._buildFormFields(_questions1.length, _questions1, _questionStates1),
              const SizedBox(height: 20,),
              const HeadingText(headingText:"Services Provided in Home Care"),
              ..._buildFormFields(_questions2.length, _questions2, _questionStates2),
              const SizedBox(height: 20,),
              const HeadingText(headingText:"Classification of Patients"),
              ..._buildFormFields(_questions3.length, _questions3, _questionStates3),
              MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  _formKey.currentState!.saveAndValidate();
                  debugPrint(_formKey.currentState?.instantValue.toString() ?? '');
                  Map<String, dynamic>? formData = _formKey.currentState?.instantValue;
                  for(int i=1; i< 26;i++){
                    // debugPrint(formData?["Q$i"]);
                    eachQuestion = formData?["Q$i"];
                    queryString  += "&Q$i=$eachQuestion";
                  }
                  // eachQuestion = "?Q1=Rishi&Q2=M&Q3=22";

                  firstFormElem = formData?["Q0"];
                  String firstElem = "?Q0=$firstFormElem";

                  String scriptURL  = AppScriptString().theAppScriptUrl;
                  var finalURI   = Uri.parse(scriptURL + firstElem +queryString);
                  // var finalURI   = Uri.parse(scriptURL + eachQuestion);
                  var response    = await http.get(finalURI);

                  debugPrint(finalURI.toString());
                  debugPrint(widget.selectedInstitution);
                  debugPrint(widget.selectedLocation);

                  queryString = "";

                  if (response.statusCode == 200) {
                    var bodyR = convert.jsonDecode(response.body);
                    debugPrint(bodyR.toString());
                  }
                    //TODO(wdas): put this to appscrpt
                  // if(_formKey.currentState!.saveAndValidate() == true){}
                  // if (formData != null) {
                  //       String? q0Value = formData["Q0"];
                  //       String? q1Value = formData["Q1"];
                  //       debugPrint(q0Value );
                  //       // Access other field values in a similar way
                  //     }
                },
              ),
            ],
          ),
        ),
      );

  }

  List<Widget> _buildFormFields(int numberOfQuestions, List questionList, List<bool> questionState) {
    List<Widget> formFields = [];

    for (int i = 0; i < numberOfQuestions; i++) { // the i repersent the number of questions, chnaege in up too
      formFields.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 27),
            QuestionText(text: questionList[i]),
            FormBuilderTextField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              name: "Q$i",
              decoration: InputDecoration(
                suffixIcon: questionState[i]
                    ? const Icon(Icons.error, color: Colors.red)
                    : const Icon(Icons.check, color: Colors.green),
              ),
              onChanged: (val) {
                setState(() {
                  questionState[i] =
                      !(_formKey.currentState?.fields['Q$i']?.validate() ?? false);
                });
                
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.max(10000),
              ]),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
      );
    }

    return formFields;
  }

}

const _questions = [
    "Total Number of Bed Bound Patients (Bedbound & People Who Need Support to get up from Bed) in Last Month",
    "New Bed Bound Patients Registered this Month",
    "Expired or Transfer out Case",
    "Total number of Bed Bound Patients",
    "Total Number of Bedbound Patients 18 years and below",
    "Total Number of Bedbound Patients between 19 and 59 years of age",
    "Total Number of Bedbound Patients 60 years and above",
    "Number of Bed Bound Patients visited in this month",
    "New Home Bound and Chronic illness Patients with SHS (Serious Health Related Suffering) Reporting by JAK Team",
    "Total number of Home bound / chronic illness patients with SHS",
    "Total number of Home bound / chronic illness patients with SHS Patients 18 years and below",
    "Total number of Home bound / chronic illness patients with SHS Patients 19 and 59 years of age",
    "Total number of Home bound / chronic illness patients with SHS Patients 60 years and above",
    "Number of Home Bound & Chronic Illness with SHS given Priority Visit from JAK",
    "Total number of Home care days",
    "Number of Bed bound Patients Visit by Community Nurse",
    "Number of Patients Visited by the Doctor - MM",
    "Number of Patients Visited by the Physiotherapist",
    "Number of Patients Visited by the Doctor ISM",
    "Number of Patients Visited by the Doctor Homoeo"
]; // 20 qns

const _questions1 = [
    "Number of volunteers attended 3 Days training in this month",
    "Number of Volunteers Completed 3 Days Training So far within your LSGD",
    "How many Volunteers were linked to Patients",
    "Number of LSGDI’s Members Involved in Home care",
    "Number of Health Staff Involved in Home care",
    "Number of ASHA Workers Involved in Home care",
    "Number of Community Volunteers Involved in Home care"
]; //7qns

const _questions2 = [
    "Number of Catheterization done",
    "Number of Bath",
    "Number of Mouth Care",
    "Number of indwelling catheter",
    "Number of Bladder Wash",
    "Number of Wound Dressing",
    "Number of PRE Enema",
    "Number of Riles Tube Insert"
]; //8qns

const _questions3 = [
    "Number of total Cancer Patients",
    "Number of CKD Patients",
    "Number of Dialysis Patients",
    "Number of Paraplegia + Quadriplegia Patients",
    "Number of Hemi Plegia Patients",
    "Number of Colostomy Patients",
    "Number of Tracheotomy Patients",
    "Number of Lymph edema Patients",
    "Number of Patients Taking Morphine",
    "Other Innovative Programs"
]; //10 qns
 // Initialize all states as false


