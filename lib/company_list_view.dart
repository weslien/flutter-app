import 'package:flutter/material.dart';

import 'detail_screen.dart';
import 'firebase/companies_rw.dart';
import 'firebase/company.dart';

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
  }





  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Company>>(
        future: ReadWriteCompanies.loadCompanies(),
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
            }
          }
        });
  }
}