import 'package:cloud_functions/cloud_functions.dart';
import 'package:company_app/company.dart';
import 'package:company_app/firebase_options.dart';
import 'package:company_app/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Tester());
}

class Tester extends StatelessWidget {
  Tester({Key? key}) : super(key: key) {
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

    await _createCompanies();

    final HttpsCallable callable = functions.httpsCallable('getCompanies');
    try {
      final HttpsCallableResult results =
          await callable({'number': 20, 'offset': 0});
      List<dynamic> list = results.data;
      Map<String, dynamic> map = list.reduce((a, b) {
        a.addAll(b);
        return a;
      });

      List<Company> data = await Company.fromJsonList(map);
      print(data);
    } catch (e) {
      print('Error loading companies: ');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp();
  }
}
