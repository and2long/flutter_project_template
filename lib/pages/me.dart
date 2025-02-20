import 'package:flutter/material.dart';
import 'package:flutter_project_template/components/yt_tile.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:flutter_project_template/pages/language.dart';
import 'package:flutter_ytnavigator/flutter_ytnavigator.dart';

class Me extends StatelessWidget {
  const Me({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).me),
      ),
      body: ListView(
        children: [
          YTTile(
            title: S.of(context).settingsLanguage,
            onTap: () {
              NavigatorUtil.push(context, const LanguagePage());
            },
          ),
          YTTile(
            title: S.of(context).privacyPolicy,
            onTap: () {},
          ),
          YTTile(
            title: S.of(context).termsOfService,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
