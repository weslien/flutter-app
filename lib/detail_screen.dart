import 'package:flutter/material.dart';

import 'business_card.dart';
import 'firebase/companies_rw.dart';
import 'firebase/company.dart';

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Company.
  const DetailScreen({super.key, required this.companyId});

  // Declare a field that holds the Company.
  final String companyId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Company>(
      future: ReadWriteCompanies.loadCompany(companyId),
      // function where you call your api
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
                body: BusinessCard(company: snapshot.data as Company));
          }
        }
      },
    );
  }
}
