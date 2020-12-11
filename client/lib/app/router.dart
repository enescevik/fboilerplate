import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:fboilerplate/views/home/home_view.dart';
import 'package:fboilerplate/views/login/login_view.dart';
import 'package:fboilerplate/views/settings/settings_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: LoginView, initial: true),
  CustomRoute(
    page: SettingsView,
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  ),
  MaterialRoute(page: HomeView),
])
class $Router {}
