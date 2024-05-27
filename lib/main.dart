import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pap_care_management/codepage.dart';
import 'package:pap_care_management/pages/chooseInstitute.dart';
// import 'package:pap_care_management/pages/formOne.dart';
// import 'package:pap_care_management/test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import "package:firebase_core/firebase_core.dart";
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const CodePage(title: 'NHM Kozhikode',child: RelatedFields());
  }
}