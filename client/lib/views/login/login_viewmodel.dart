import 'package:easy_localization/easy_localization.dart';
import 'package:fboilerplate/apis/authenticate_api.dart';
import 'package:fboilerplate/app/locator.dart';
import 'package:fboilerplate/app/router.gr.dart';
import 'package:fboilerplate/app/setup_dialog_ui.dart';
import 'package:fboilerplate/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _dialog = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _preferences = locator<SharedPreferencesService>();

  final _authenticateApi = locator<AuthenticateApi>();

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool showPassword = false;
  void togglePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  String get version => _preferences.version;

  Future<void> login() async {
    if (usernameTextController.value.text.isEmpty) {
      await _dialog.showDialog(
        title: 'widget.warning'.tr(),
        description: 'login.username_empty'.tr(),
        barrierDismissible: true,
      );
    } else if (passwordTextController.value.text.isEmpty) {
      await _dialog.showDialog(
        title: 'widget.warning'.tr(),
        description: 'login.password_empty'.tr(),
        barrierDismissible: true,
      );
    } else {
      _dialog.showCustomDialog(
        variant: DialogType.loading,
        description: 'login.logging'.tr(),
      );

      try {
        _preferences.currentUser = await _authenticateApi.login(
          username: usernameTextController.text,
          password: passwordTextController.text,
        );
        _navigationService.back();

        _navigationService.navigateTo(Routes.homeView);
      } catch (e) {
        await _dialog.showDialog(
          title: 'widget.warning'.tr(),
          description: e.message,
          barrierDismissible: true,
        );
        _navigationService.back();
      }
    }
  }
}
