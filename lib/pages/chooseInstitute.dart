import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pap_care_management/codepage.dart';
import 'package:pap_care_management/pages/formOne.dart';

class RelatedFields extends StatefulWidget {
  const RelatedFields({super.key});

  @override
  State<RelatedFields> createState() => _RelatedFieldsState();
}

class _RelatedFieldsState extends State<RelatedFields> {
  final _formKey = GlobalKey<FormBuilderState>();

  String selectedInstitution = 'CHC'; // Default selection for institution
  String selectedLocation = ''; // Default selection for location

  // List of institutions and their corresponding locations
  static const Map<String, List<String>> institutionToLocations = {
    'CHC': ["CHERUVADI", "CHERUVANNUR", "KODENCHERY", "KODUVALLI", "KOORACHUNDU", "KUNNUMMAL", "MELADY", "MUKKAM", "NARIKUNI", "OLAVANNA", "ORKATERY", "THALAKULATHUR", "THIRUVALLUR", "THIRUVANGOOR", "ULLIYERI", "VALAYAM"],
    'Hospital': ["GGH KOZHIKODE", "TH KOYILANDY", "TH NADAPURAM", "TH KUTTYADI", "TH PERAMBRA", "TH BALUSSERI", "TH THAMARASSERI"],
  };

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
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                debugPrint(_formKey.currentState?.instantValue.toString() ?? '');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CodePage(title: 'CHC level', child: FormOne(selectedInstitution: "selectedInstitution" ,selectedLocation: "selectedLocation",)))
                  // MaterialPageRoute(builder: (context) => const CodePage(title: 'Fields', child: FormOne(selectedInstitution: "selectedInstitution",selectedLocation: "selectedLocation",)))
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
