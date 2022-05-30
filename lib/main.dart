import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'company.dart';
import 'business_card.dart';
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
  //List<Company> items = [];

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

  Future<List<Company>> _loadCompanies() async {
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
      return temp;
    } catch (e) {
      print('Error loading companies: ');
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Company>>(
        future: _loadCompanies(),
        builder: (BuildContext context, AsyncSnapshot<List<Company>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              title: 'Loading',
              //theme: myTheme,
              home: Scaffold(
                appBar: AppBar(
                  title: const Text("Loading companies"),
                ),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return MaterialApp(
                title: 'Error',
                //theme: myTheme,
                home: Scaffold(
                    appBar: AppBar(
                      title: const Text("Error loading companies"),
                    ),
                    body: Center(child: Text('Error: ${snapshot.error}'))),
              );
            } else {
              List<Company> myList = snapshot.data ?? [];

              return MaterialApp(
                  title: 'List of companies',
                  //theme: myTheme,
                  home: Scaffold(
                    appBar: AppBar(
                      title: const Text("The big company list"),
                    ),
                    body: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(snapshot.data?.elementAt(index).name ??
                                "Default name"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => DetailScreen(
                                        companyId: snapshot.data
                                                ?.elementAt(index)
                                                .id ??
                                            "")),
                              );
                            });
                      },
                    ),
                  ));
            } // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        });
  }
}

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Company.
  const DetailScreen({super.key, required this.companyId});

  // Declare a field that holds the Company.
  final String companyId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Company>(
      future: _loadCompany(companyId), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<Company> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
            title: const Text("Loading.."),
          ));
        } else {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("There was an error loading"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('${snapshot.error}'),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data?.name as String),
              ),
              body: BusinessCard(company: snapshot.data as Company)
            );
          }
          return Center(
              child: new Text(
                  '${snapshot.data}')); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }

  Future<Company> _loadCompany(id) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    //await _createCompanies(); //No more data for now

    final HttpsCallable callable = functions.httpsCallable('getCompany');
    try {
      final HttpsCallableResult results = await callable({'id': id});
      //For clearer state management
      return Company.fromJson(results.data);
    } catch (e) {
      print('Error loading company: ');
      print(e);
      throw FirebaseFunctionsException(
          message: "Could not load company: $e", code: "1234");
    }
  }
}
