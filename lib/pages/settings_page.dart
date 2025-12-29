import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_template/i18n/i18n.dart';
import 'package:flutter_project_template/store.dart';
import 'package:flutter_project_template/utils/toast_util.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const String _feedbackEmail = 'and2long@icloud.com';
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
                    leading: const Icon(LucideIcons.palette),
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
                  const Divider(),
                  ListTile(
                    leading: const Icon(LucideIcons.languages),
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
            Card(
              child: ListTile(
                leading: const Icon(LucideIcons.mail),
                title: Text(
                  S.of(context).settingsFeedbackTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  S.of(context).settingsFeedbackSubtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                onTap: _sendFeedbackEmail,
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

  String _localeLabel(Locale locale) {
    return S.localeSets[locale.languageCode] ?? locale.languageCode;
  }

  Future<void> _showLanguageSelector() async {
    final strings = S.of(context);
    final options = [
      ...S.supportedLocales.map(
        (locale) => MapEntry<String, String>(
          locale.languageCode,
          S.localeSets[locale.languageCode] ?? locale.languageCode,
        ),
      ),
    ];

    // 返回所选的 Locale，如果直接关闭则返回 null
    final selectedLocale = await showModalBottomSheet<Locale>(
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
              RadioGroup<String>(
                groupValue: currentLocale.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    final locale = S.supportedLocales.firstWhere(
                      (l) => l.languageCode == value,
                      orElse: () => S.supportedLocales.first,
                    );
                    Navigator.of(context).pop(locale);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options
                      .map(
                        (option) => RadioListTile<String>(
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
    if (selectedLocale != null && mounted) {
      context.read<ConfigStore>().setLocale(selectedLocale);
    }
  }

  String _buildFeedbackBody(S strings, String version, String systemInfo) {
    return [
      strings.settingsFeedbackBodyIntro,
      '',
      '${strings.settingsFeedbackAppVersion}: $version',
      '${strings.settingsFeedbackSystemInfo}: $systemInfo',
    ].join('\n');
  }

  String _getSystemInfo() {
    final osName = Platform.operatingSystem;
    final osVersion = Platform.operatingSystemVersion;
    return '$osName $osVersion';
  }

  Future<String> _getVersionForFeedback() async {
    if (_version.isNotEmpty) return _version;
    final info = await PackageInfo.fromPlatform();
    final version = '${info.version}+${info.buildNumber}';
    if (mounted) {
      setState(() {
        _version = version;
      });
    }
    return version;
  }

  Future<void> _sendFeedbackEmail() async {
    final strings = S.of(context);
    final version = await _getVersionForFeedback();
    final systemInfo = _getSystemInfo();
    final body = _buildFeedbackBody(strings, version, systemInfo);
    final subject = Uri.encodeComponent("Flutter Project Template Feedback");
    final normalizedBody = body.replaceAll('\n', '\r\n');
    final encodedBody = Uri.encodeComponent(normalizedBody);
    final mailtoUrl =
        'mailto:$_feedbackEmail?subject=$subject&body=$encodedBody';

    try {
      final launched = await launchUrlString(
        mailtoUrl,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        ToastUtil.show(strings.settingsFeedbackLaunchFailure);
      }
    } catch (_) {
      if (mounted) {
        ToastUtil.show(strings.settingsFeedbackLaunchFailure);
      }
    }
  }
}
