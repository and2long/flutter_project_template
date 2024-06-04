import 'package:flutter/material.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:flutter_project_template/store.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LanguagePageState();
  }
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    LocaleStore localeModel = context.watch<LocaleStore>();
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settingsLanguage)),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: List<Widget>.of(
            S.localeSets.keys.map(
              (key) => ListTile(
                title: Text(
                  S.localeSets[key]!,
                  // 对APP当前语言进行高亮显示
                  style: TextStyle(
                      color: localeModel.languageCode == key ? color : null),
                ),
                trailing: localeModel.languageCode == key
                    ? Icon(Icons.done, color: color)
                    : null,
                onTap: () {
                  localeModel.setLanguageCode(key);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }
}
