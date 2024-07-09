// getCertificateDetails.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_code/models/user.dart';
import 'package:widget_code/user_provider.dart';
import 'api_utils.dart';

Future<void> postCertificateData(BuildContext context) async {
  final Map<String, dynamic>? responseData = await postData(
    serviceMethod: "getCertificateDetailsBySubscriberUniqueId",
    requestBody: {
      "serviceMethod": "getCertificateDetailsBySubscriberUniqueId",
      "requestBody": {
        "subscriberUniqueId": "2e937529-e11d-40e0-83c1-423ecbbe3bd2",
      },
    },
    context: context,
  );

  if (responseData != null && responseData['success'] == true) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        context: context,
        //   isScrollControlled: true,
        builder: (BuildContext context) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.cyan.shade800,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Center(
                    child: ClipOval(
                      child: Image.asset(
                        'images/assets/profile.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  subtitle: Center(
                      child: Text(
                    '${responseData["result"]["certificateDetails"]["certStatus"]}',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'images/assets/profile.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        'certificate issue date',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        '${responseData["result"]["certificateDetails"]["issueDate"]}',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'images/assets/profile.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        'certificate Expiry date',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                      '${responseData["result"]["certificateDetails"]["expiryDate"]}',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  } else {
    print('Failed to fetch certificate details.');
    Fluttertoast.showToast(
      msg: "Failed to fetch certificate details",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
