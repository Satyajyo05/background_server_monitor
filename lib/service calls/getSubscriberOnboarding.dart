import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_code/main_home_page.dart';
import 'package:widget_code/models/user.dart';
import 'package:widget_code/user_provider.dart';
import 'api_utils.dart';
import 'package:widget_code/animated_drawer.dart';
Future<Map<String, dynamic>?> postSubscriberData(BuildContext context) async {
  final Map<String, dynamic>? responseData = await postData(
    serviceMethod: "getSubscriberOnboarding",
    requestBody: {
      "serviceMethod": "getSubscriberOnboarding",
      "requestBody": {
        "suid": "fcf82b17-216e-49f3-be81-f1c139c1738a",
        "selfieRequired": true,
      },
    },
    context: context,
  );

  if (responseData != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(responseData));
    if(responseData["success"] == true) {
      print('Data saved to SharedPreferences');
    }
    Map<String, dynamic> result = responseData['result'];
    String subscriberUgPassEmail = result['subscriberUgPassEmail'] ?? '';
    String subscriberMobileNumber = result['subscriberMobileNumber'] ?? '';
    Map<String, dynamic> subscriberData = result['subscriberData'];
    User user = User.fromJson(
        subscriberData, subscriberUgPassEmail, subscriberMobileNumber);

    Provider.of<UserProvider>(context, listen: false).setUser(user);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DrawerScreen()),
    );
  } else {
    print('Failed to fetch subscriber data.');

  }
}
