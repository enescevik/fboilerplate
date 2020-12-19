import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fboilerplate/apis/models/base_model.dart';
import 'package:fboilerplate/app/locator.dart';
import 'package:fboilerplate/services/shared_preferences_service.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class BaseApi {
  final _dialog = locator<DialogService>();
  final _preferences = locator<SharedPreferencesService>();

  var log = Logger(
    printer: PrettyPrinter(),
  );

  String _url(String url) {
    if (_preferences.environment?.url == null) {
      log.e('base_url_empty'.tr());
      throw Exception('base_url_empty'.tr());
    }
    final result = '${_preferences.environment?.url}/$url';
    log.d(result);
    return result;
  }

  Map<String, String> _headers() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_preferences.currentUser?.token}',
    };
  }

  dynamic _checkResult(Response response) {
    if (response.statusCode != 200) {
      log.e('Servis Hata Kodu: ${response.statusCode}');
      throw Exception('Servis Hata Kodu: ${response.statusCode}');
    }

    var result = json.decode(response.body);
    if (result['IsFailure'] as bool) {
      log.e(result['Error']);
      throw Exception(result['Error']);
    }

    log.d(result);
    return result;
  }

  final httpClient = new HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  Future _httpGet(String url) async {
    return new IOClient(httpClient)
        .get(_url(url), headers: _headers())
        .then((res) => _checkResult(res))
        .timeout(const Duration(seconds: 5));
  }

  Future<R> getData<R extends BaseModel>(String url, [R model]) async {
    try {
      return _httpGet(url).then((res) =>
          res['Value'] == null ? null : model?.fromJson(res['Value']) as R);
    } catch (e) {
      await _dialog.showDialog(
        title: 'widget.warning'.tr(),
        description: e.message,
        barrierDismissible: true,
      );
      return null;
    }
  }

  Future<List<R>> getList<R extends BaseModel>(String url, [R model]) async {
    try {
      return await _httpGet(url).then((res) =>
          List.from(res['Value']).map((e) => model.fromJson(e) as R).toList());
    } catch (e) {
      await _dialog.showDialog(
        title: 'widget.warning'.tr(),
        description: e.message,
        barrierDismissible: true,
      );
      return null;
    }
  }

  Future _httpPost<T>(String url, T body) async {
    final jsonBody = body is List
        ? List.from(body).map((e) => e.toJson()).toList()
        : (body as BaseModel).toJson();

    final data = jsonEncode(jsonBody);
    log.d(data);

    return new IOClient(httpClient)
        .post(_url(url), body: data, headers: _headers())
        .then((res) => _checkResult(res))
        .timeout(const Duration(seconds: 5));
  }

  Future<bool> postData<B>(String url, B body) async {
    try {
      return _httpPost(url, body).then((res) => true);
    } catch (e) {
      await _dialog.showDialog(
        title: 'widget.warning'.tr(),
        description: e.message,
        barrierDismissible: true,
      );
    }
    return false;
  }

  Future<List<R>> postList<B, R extends BaseModel>(
      String url, B body, R model) async {
    try {
      return _httpPost(url, body).then((res) =>
          List.from(res['Value']).map((e) => model.fromJson(e) as R).toList());
    } catch (e) {
      await _dialog.showDialog(
        title: 'widget.warning'.tr(),
        description: e.message,
        barrierDismissible: true,
      );
    }
    return null;
  }
}
