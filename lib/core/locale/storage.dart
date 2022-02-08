import 'dart:async';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LocalStorage {
  LocalStorage._();
  static final LocalStorage _instance = LocalStorage._();
  static LocalStorage get i => _instance;

  static StreamController<ParseObject> streamController = StreamController<ParseObject>.broadcast();
  static Stream<ParseObject> get parseStream => streamController.stream;
}
