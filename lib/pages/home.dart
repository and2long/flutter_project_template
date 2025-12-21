import 'package:flutter/material.dart';
import 'package:flutter_project_template/pages/settings_page.dart';
import 'package:flutter_ytnavigator/flutter_ytnavigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              NavigatorUtil.push(context, SettingsPage());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Edit lib/pages/home.dart to start your project.'),
      ),
    );
  }
}
