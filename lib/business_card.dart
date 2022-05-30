import 'package:flutter/material.dart';

import 'firebase/company.dart';

class BusinessCard extends StatelessWidget {
  final Company company;

  const BusinessCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey[300],
        elevation: 8.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          height: 200,
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 50, //we give the image a radius of 50
                    backgroundImage: NetworkImage(
                        'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/7a3ec529632909.55fc107b84b8c.png'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
//CrossAxisAlignment.end ensures the components are aligned from the right to left.
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 150,
                        color: Colors.black54,
                        height: 2,
                      ),
                      const SizedBox(height: 4),
                      Text(company.name),
                      Text(company.city ?? "Default city"),
                      Text(company.industry ?? "Default buzzwords"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gustav Weslien',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(company.name),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Technologist delux',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(company.name),
                    ],
                  )
                ],
              ),
            ],
          ),


        ));

  }
}
