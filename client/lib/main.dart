import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:fboilerplate/app/app_theme.dart';
import 'package:fboilerplate/app/locator.dart';
import 'package:fboilerplate/app/setup_dialog_ui.dart';
import 'package:fboilerplate/services/shared_preferences_service.dart';
import 'package:fboilerplate/views/settings/models/language.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

import 'app/router.gr.dart' as auto_router;
 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  setupDialogUi();
  await SharedPreferencesService.init();

  runApp(EasyLocalization(
    child: FBoilerplateApp(),
    path: 'assets/languages',
    assetLoader: YamlAssetLoader(),
    supportedLocales: LanguageModel.languages.map((e) => e.locale).toList(),
  ));
}

class FBoilerplateThemeModeManager implements IThemeModeManager {
  final _preference = locator<SharedPreferencesService>();

  @override
  Future<String> loadThemeMode() async {
    return _preference.themeMode;
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    _preference.themeMode = value;
    return true;
  }
}

class FBoilerplateApp extends StatelessWidget {
  final _preference = locator<SharedPreferencesService>();

  @override
  Widget build(BuildContext context) {
    context.locale =
        _preference.language?.locale ?? LanguageModel.languages[0].locale;

    return ThemeModeHandler(
      manager: FBoilerplateThemeModeManager(),
      builder: (themeMode) => MaterialApp(
        title: 'title'.tr(),
        locale: context.locale,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        initialRoute: auto_router.Routes.loginView,
        navigatorKey: locator<DialogService>().navigatorKey,
        onGenerateRoute: auto_router.Router().onGenerateRoute,
      ),
    );
  }
}
