import 'package:flutter/material.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:flutter_project_template/pages/language.dart';

class Me extends StatelessWidget {
  const Me({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).me),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(S.of(context).settingsLanguage),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const LanguagePage()));
            },
          ),
          ListTile(
            title: Text(S.of(context).privacyPolicy),
            onTap: () {},
          ),
          ListTile(
            title: Text(S.of(context).termsOfService),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
