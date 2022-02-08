import 'package:flutterlivequery/core/constants/parse_constants.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseProvider {
  ParseProvider._();
  static final ParseProvider _instance = ParseProvider._();
  static ParseProvider get i => _instance;

  Parse parse = Parse();

  Future<void> initParse() async {
    await parse
        .initialize(
      ParseConstants.appId,
      ParseConstants.serverUrl,
      liveQueryUrl: ParseConstants.liveQueryUrl,
    )
        .onError((error, stackTrace) {
      error ??= error;
      print('Parse Error: $error');
      return Future.error(false);
    });
  }
}
