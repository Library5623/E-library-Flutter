import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constant/handler.dart';
import '../constant/url_constants.dart';
import '../providers/transaction_provider.dart';

class DashboardServices {
  Future<Map<String, dynamic>> fetchData(context) async {
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/dashboard'), headers: <String, String>{
        'api_key': "123456",
        'token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhcnZlc2hAZ21haWwuY29tIiwiaWF0IjoxNjg2MzE2Mzc3LCJleHAiOjE2OTQ5NTYzNzd9.kwwdtXh03r8oXj8lPz1kP2fhtUgcmZZ_Hc6Nm52_9RY',
        'authorization': 'bearer sarvesh@gmail.com'
      });
      httpErrorHandle(response: res, context: context, onSuccess: () {});
      return Map<String, dynamic>.from(jsonDecode(res.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return {};
    }
  }
}