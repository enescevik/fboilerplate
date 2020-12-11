import 'package:fboilerplate/app/locator.dart';
import 'package:fboilerplate/app/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeView extends StatelessWidget {
  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Boilerplate'),
      ),
      body: Center(
        child: Text('...'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: () => _navigationService.navigateTo(Routes.settingsView),
      ),
    );
  }
}
