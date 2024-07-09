import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<Map<String, dynamic>?> postData({
  required String serviceMethod,
  required Map<String, dynamic> requestBody,
  required BuildContext context,
}) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    Fluttertoast.showToast(
      msg: "Unable to connect to internet",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    print('No internet connection.');
    return null;
  }

  const url = 'http://164.52.198.75:8081/OnBoardingTransactionHandler/api/post/onboarding/dataframe';
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "deviceId": "420C8D75-9478-41CB-A875-4C35235E6458",
    'appVersion': "3.0.13",
    "osVersion": "17.5.1",
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    print('Headers: $headers');
    if (response.statusCode == 200 ) {
      print('Response body: ${response.body}');
      var responseData = jsonDecode(response.body);
        return responseData;
    } else {
      print('Failed to post data: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error sending POST request: $e');
    return null;
  }
}

