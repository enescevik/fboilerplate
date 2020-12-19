import 'package:flutter/material.dart';

class EnvironmentModel {
  static List<Environment> environments = [
    Environment(1, 'prod', 'https://10.0.2.2:5001/api'),
    Environment(2, 'test', 'https://10.0.2.2:5001/api')
  ];
}

@immutable
class Environment {
  final int id;
  final String name;
  final String url;

  Environment(this.id, this.name, this.url);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Environment && other.id == id;
}
