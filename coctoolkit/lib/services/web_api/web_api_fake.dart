import 'dart:convert';

import 'package:coctoolkit/business_logic/models/test_model.dart';
import 'package:coctoolkit/services/web_api/web_api.dart';

class WebApiFake implements WebApi {

  @override
  Future<dynamic> sampleGet() async {
    var jsonString = '''
    {
        "test": "test"
    }
    ''';
    return TestModel.fromJson(json.decode(jsonString));
  }

  @override
  Future<dynamic> samplePost(String requestBody) async {
    var jsonString = '''
    {
        "test": "test"
    }
    ''';
    return TestModel.fromJson(json.decode(jsonString));
  }
}