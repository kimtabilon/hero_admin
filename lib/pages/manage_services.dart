import 'package:flutter/material.dart';
import 'package:hero_admin/pages/service_form.dart';
import 'package:hero_admin/pages/service_option.dart';
import 'package:hero_admin/pages/services.dart';

import 'categories.dart';

void main() {
  runApp(ManageServices());
}

class ManageServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Services",),
                Tab(text: "Option",),
                Tab(text: "Form",),
                Tab(text: "Category",),
              ],
            ),
            title: Text('Manage Services'),
          ),
          body: TabBarView(
            children: [
              Services(),
              ServiceOption(),
              ServiceForm(),
              //Icon(Icons.directions_car),
              Categories(),

            ],
          ),
        ),
      ),
    );
  }
}