import 'package:flutter/material.dart';
import 'package:flutter_project/page/login.dart';
import 'package:flutter_project/page/main.dart';
import 'package:flutter_project/page/publish.dart';

final routes = <String, WidgetBuilder>{
  'login': (context) => LoginPage(),
  'main': (context) => MainPage(),
  'publish': (context) => PublishPage(),
};
