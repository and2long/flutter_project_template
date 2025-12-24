import 'package:flutter/material.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:flutter_project_template/store.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${info.version}+${info.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settingsTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      S.of(context).settingsTheme,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      _themeModeLabel(context.watch<ConfigStore>().themeMode),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    onTap: _showThemeSelector,
                  ),
                  const Divider(height: 1, indent: 0, endIndent: 0),
                  ListTile(
                    title: Text(
                      S.of(context).settingsLanguage,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      _localeLabel(context.watch<ConfigStore>().locale),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    onTap: _showLanguageSelector,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                '${S.of(context).settingsVersion} $_version',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _themeModeLabel(ThemeMode mode) {
    final strings = S.of(context);
    switch (mode) {
      case ThemeMode.light:
        return strings.settingsThemeLight;
      case ThemeMode.dark:
        return strings.settingsThemeDark;
      case ThemeMode.system:
        return strings.settingsThemeSystem;
    }
  }

  Future<void> _showThemeSelector() async {
    final strings = S.of(context);
    final options = [
      MapEntry(ThemeMode.light, strings.settingsThemeLight),
      MapEntry(ThemeMode.dark, strings.settingsThemeDark),
      MapEntry(ThemeMode.system, strings.settingsThemeSystem),
    ];

    final selectedMode = await showModalBottomSheet<ThemeMode>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        final currentMode = context.read<ConfigStore>().themeMode;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    strings.settingsTheme,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              RadioGroup<ThemeMode>(
                groupValue: currentMode,
                onChanged: (mode) {
                  if (mode != null) {
                    Navigator.of(context).pop(mode);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options
                      .map(
                        (option) => RadioListTile<ThemeMode>(
                          value: option.key,
                          title: Text(option.value),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );

    if (selectedMode != null && mounted) {
      context.read<ConfigStore>().setThemeMode(selectedMode);
    }
  }

  String _localeLabel(Locale? locale) {
    if (locale == null) {
      return S.of(context).settingsLanguageSystem;
    }
    return S.localeSets[locale.languageCode] ?? locale.languageCode;
  }

  Future<void> _showLanguageSelector() async {
    final strings = S.of(context);
    final options = [
      MapEntry<Locale?, String>(null, strings.settingsLanguageSystem),
      ...S.supportedLocales.map(
        (locale) => MapEntry<Locale?, String>(
          locale,
          S.localeSets[locale.languageCode] ?? locale.languageCode,
        ),
      ),
    ];

    // 使用包装类来区分"选择了系统默认(null)"和"未选择直接关闭"
    final selection = await showModalBottomSheet<_LocaleSelection>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        final currentLocale = context.read<ConfigStore>().locale;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    strings.settingsLanguage,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              RadioGroup<Locale?>(
                groupValue: currentLocale,
                onChanged: (value) {
                  Navigator.of(context).pop(_LocaleSelection(value));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options
                      .map(
                        (option) => RadioListTile<Locale?>(
                          value: option.key,
                          title: Text(option.value),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );

    // 只有用户明确选择了选项才更新
    if (selection != null && mounted) {
      context.read<ConfigStore>().setLocale(selection.locale);
    }
  }
}

/// 用于区分"选择了系统默认(null)"和"未选择直接关闭弹窗"
class _LocaleSelection {
  final Locale? locale;
  const _LocaleSelection(this.locale);
}
