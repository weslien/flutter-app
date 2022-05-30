import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

import 'company.dart';
import 'firebase_options.dart';

final functions = FirebaseFunctions.instanceFor(region: "europe-west1");

abstract class ReadWriteCompanies {

  static Future<bool> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );
    return true;
  }

  static Future<void> createCompanies() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    final HttpsCallable callable = functions.httpsCallable('createCompanies');
    try {
      await callable();

    } catch (e) {
      print('Error creating companies: ');
      print(e);
    }
  }

  static Future<List<Company>> loadCompanies() async {
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

  static Future<Company> loadCompany(id) async {
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
