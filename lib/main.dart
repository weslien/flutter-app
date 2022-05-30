import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'company.dart';

import 'firebase_options.dart';

final functions = FirebaseFunctions.instanceFor(region: "europe-west1");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Companies',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const CompanyListView(title: 'Flutter Demo Home Page'),
    );
  }
}

class CompanyListView extends StatefulWidget {
  const CompanyListView({super.key, required String title});

  @override
  State<StatefulWidget> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView> {
  List<Company> items = [];

  @override
  void initState() {
    super.initState();

    _loadCompanies();
  }

  Future<void> _createCompanies() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    print('*** Creating companies***');
    final HttpsCallable callable = functions.httpsCallable('createCompanies');
    try {
      await callable();
      print("Created companies");
    } catch (e) {
      print('Error creating companies: ');
      print(e);
    }
  }

  void _loadCompanies() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    //await _createCompanies(); //No more data for now

    final HttpsCallable callable = functions.httpsCallable('getCompanies');
    try {
      final HttpsCallableResult results =
          await callable({'number': 20, 'offset': 0});
      //For clearer state management
      List<Company> temp = [];
      for (Map<String, dynamic> line in results.data) {
        temp.add(Company.fromJson(line));
      }
      setState(() {
        items = temp;
      });
    } catch (e) {
      print('Error loading companies: ');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build stateful state");
    const title = "Big list of companies";
    return MaterialApp(
        title: 'List of companies',
        //theme: myTheme,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(title),
          ),
          body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(items[index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (context) =>
                              DetailScreen(company: items[index])),
                    );
                  });
            },
          ),
        ));
  }

  MaterialPageRoute _DetailsScreen(id){
    return MaterialPageRoute<void>(
        builder: (context) =>
            DetailScreen(company: id));
  }
}

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Company.
  const DetailScreen({super.key, required this.company});

  // Declare a field that holds the Company.
  final Company company;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('${company.industry} (${company.employees} employees)'),
      ),
    );
  }
}
