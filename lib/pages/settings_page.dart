import 'package:flutter/material.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:flutter_project_template/utils/sp_util.dart';

class ThemeController {
  ThemeController._();

  static late final ValueNotifier<ThemeMode> themeNotifier;

  static void init(ThemeMode initialMode) {
    themeNotifier = ValueNotifier<ThemeMode>(initialMode);
  }

  static Future<void> updateThemeMode(ThemeMode mode) async {
    if (themeNotifier.value == mode) return;
    themeNotifier.value = mode;
    await SPUtil.setThemeMode(mode);
  }
}

class LanguageController {
  LanguageController._();

  static late final ValueNotifier<Locale?> localeNotifier;

  static void init(Locale? initialLocale) {
    localeNotifier = ValueNotifier<Locale?>(initialLocale);
  }

  static Future<void> updateLocale(Locale? locale) async {
    if (localeNotifier.value?.toLanguageTag() == locale?.toLanguageTag()) {
      return;
    }
    localeNotifier.value = locale;
    await SPUtil.setLocale(locale?.languageCode);
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeMode _themeMode;
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _themeMode = ThemeController.themeNotifier.value;
    _locale = LanguageController.localeNotifier.value;
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
                      _themeModeLabel(_themeMode),
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
                      _localeLabel(_locale),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    onTap: _showLanguageSelector,
                  ),
                ],
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
              ...options.map(
                (option) => RadioListTile<ThemeMode>(
                  value: option.key,
                  groupValue: _themeMode,
                  onChanged: (mode) {
                    Navigator.of(context).pop(mode);
                  },
                  title: Text(option.value),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );

    if (selectedMode != null && selectedMode != _themeMode) {
      setState(() {
        _themeMode = selectedMode;
      });
      await ThemeController.updateThemeMode(selectedMode);
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

    final selectedLocale = await showModalBottomSheet<Locale?>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
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
              ...options.map(
                (option) => RadioListTile<Locale?>(
                  value: option.key,
                  groupValue: _locale,
                  onChanged: (value) {
                    Navigator.of(context).pop(value);
                  },
                  title: Text(option.value),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );

    if (selectedLocale != null
        ? selectedLocale.languageCode != _locale?.languageCode
        : _locale != null) {
      setState(() {
        _locale = selectedLocale;
      });
      await LanguageController.updateLocale(selectedLocale);
    }
  }
}
