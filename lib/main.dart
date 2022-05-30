import 'package:flutter/material.dart';
import 'company_list_view.dart';
import 'package:company_app/firebase/companies_rw.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ReadWriteCompanies.init();
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

        primarySwatch: Colors.blue,
      ),
      home: const CompanyListView(title: 'Flutter company app'),
    );
  }
}







