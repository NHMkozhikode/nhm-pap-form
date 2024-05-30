import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pap_care_management/codepage.dart';
import 'package:pap_care_management/pages/formOne.dart';
import 'package:pap_care_management/pages/lsgdForm.dart';
import 'package:pap_care_management/pages/mHospForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RelatedFields extends StatefulWidget {
  const RelatedFields({super.key});

  @override
  State<RelatedFields> createState() => _RelatedFieldsState();
}

class _RelatedFieldsState extends State<RelatedFields> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String selectedInstitution = 'CHC'; // Default selection for institution
  String selectedLocation = ''; // Default selection for location

  static const String preInstitute = "";
  static const String preLocation = "";

  // List of institutions and their corresponding locations
  static const Map<String, List<String>> institutionToLocations = {
    'CHC': ["CHERUVADI", "CHERUVANNUR", "KODENCHERY", "KODUVALLI", "KOORACHUNDU", "KUNNUMMAL", "MELADY", "MUKKAM", "NARIKUNI", "OLAVANNA", "ORKATERY", "THALAKULATHUR", "THIRUVALLUR", "THIRUVANGOOR", "ULLIYERI", "VALAYAM"],
    'Hospital': ["GGH KOZHIKODE", "TH KOYILANDY", "TH NADAPURAM", "TH KUTTYADI", "TH PERAMBRA", "TH BALUSSERI", "TH THAMARASSERI"],
    'LSGD' : [
    "Arikkulam", "Atholi", "Ayancheri", "Azhiyur", "Balusseri", "Changaroth", "Chathamangalam", "Chekkittapara", "Chekkiyad", "Chelannur", "Chemancheri", "Chengottukave", "Cheruvannur", "Chorode", "Corporation Unit 1", "Corporation Unit 2", "Corporation Unit 3", "Edacheri", "Eramala", "Feroke",
    "Kadalundi", "Kakkodi", "Kakkur", "Karasseri", "Kattippara", "Kavilumpara", "Kayakkodi", "Kayanna", "Keezhariyur", "Kizhakkoth", "Kodancheri", "Kodiyathur", "Koduvalli", "Koodaranhi", "Koorachundu", "Koothali", "Kottur", "Koyilandy Unit 1", "Koyilandy Unit 2", "Kunnamangalam",
    "Kunnummal", "Kuruvattur", "Kuttyadi", "Madavoor", "Maniyur", "Maruthonkara", "Mavoor", "Meppayoor", "Moodadi", "Mukkam", "Nadapuram", "Naduvanur", "Nanminda", "Narikkuni", "Narippatta", "Nochad", "Olavanna Unit 1", "Olavanna Unit 2", "Omassery", "Onchiyam",
    "Panangad Unit 1", "Panangad Unit 2", "Payyoli Unit 1", "Payyoli Unit 2", "Perambra", "Perumanna", "Peruvayal", "Puramery", "Puthuppadi", "Ramanattukara", "Thalakulathur", "Thamarasseri", "Thikkodi", "Thiruvallur", "Thiruvambadi", "Thuneri", "Thurayur", "Ulliyeri", "Unnikulam", "Vadakara Unit 1",
    "Vadakara Unit 2", "Valayam", "Vanimel", "Velom", "Villyapalli"
    ],

  };

  Future<bool> _instituteLocationSharedPrefSender(String currentInst, String currentLocation)async{
    SharedPreferences prefs = await _prefs;
    prefs.setString("Institute", currentInst);
    prefs.setString("Location", currentLocation);
    return true;
  }

  @override
  void initState() {
    super.initState();
    selectedLocation = institutionToLocations[selectedInstitution]?.first ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          FormBuilderDropdown<String>(
            name: 'institution',
            decoration: const InputDecoration(label: Text("Institution")),
            initialValue: selectedInstitution,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedInstitution = value;
                  selectedLocation = institutionToLocations[value]?.first ?? '';
                });
              }
            },
            items: institutionToLocations.keys.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                )).toList(),
          ),
          const SizedBox(height: 10),
          FormBuilderDropdown<String>(
            name: 'location',
            decoration: const InputDecoration(label: Text('Location')),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            initialValue: selectedLocation,
            onChanged: (value) => setState(() => selectedLocation = value ?? ''),
            items: (institutionToLocations[selectedInstitution] ?? []).map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                )).toList(),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            color: Theme.of(context).colorScheme.secondary,
            child: const Text("Submit", style: TextStyle(color: Colors.white)),
            onPressed: () {
              if(selectedInstitution == "CHC"){
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                debugPrint(_formKey.currentState?.instantValue.toString() ?? '');
                _instituteLocationSharedPrefSender(selectedInstitution,selectedLocation);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CodePage(title: 'CHC level', child: FormOne(selectedInstitution: "selectedInstitution" ,selectedLocation: "selectedLocation",)))
                  // MaterialPageRoute(builder: (context) => const CodePage(title: 'Fields', child: FormOne(selectedInstitution: "selectedInstitution",selectedLocation: "selectedLocation",)))
                );
              }
              } else if(selectedInstitution == "Hospital"){
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                debugPrint(_formKey.currentState?.instantValue.toString() ?? '');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CodePage(title: 'Hospital level', child: MajorHospitalForm(selectedInstitution: preInstitute ,selectedLocation: preLocation,)))
                  // MaterialPageRoute(builder: (context) => const CodePage(title: 'Fields', child: FormOne(selectedInstitution: "selectedInstitution",selectedLocation: "selectedLocation",)))
                );
              }
              } else if(selectedInstitution == "LSGD"){
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                debugPrint(_formKey.currentState?.instantValue.toString() ?? '');
                Navigator.push(
                  context,
                  //TODO(Rishi-ks): message
                  
                  MaterialPageRoute(builder: (context) => const CodePage(title: 'LSGD', child: LsgdForm(selectedInstitution: "selectedInstitution" ,selectedLocation: "selectedLocation",)))
                  // MaterialPageRoute(builder: (context) => const CodePage(title: 'Fields', child: FormOne(selectedInstitution: "selectedInstitution",selectedLocation: "selectedLocation",)))
                );
              }
              }
              
            },
          ),
        ],
      ),
    );
  }
}
