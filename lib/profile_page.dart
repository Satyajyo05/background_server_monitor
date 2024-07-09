
// passport details profile page

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:widget_code/user_provider.dart';
import 'models/user.dart';

String formatDateString(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

void showProfilePage(BuildContext context, Uint8List bytes) {
  UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
  User? user = userProvider.user;

  List<Map<dynamic, dynamic>> passportDetails = [
    {'icons': Icons.edit_document, "fieldName": "Passport", 'fieldInfo': user?.documentNumber},
    {'icons': Icons.edit_document, "fieldName": "Nationality", 'fieldInfo': user?.nationality},
    // {'icons': Icons.edit_document, "fieldName": "Date of Birth", 'fieldInfo': formatDateString(user!.dateOfBirth )},
    // {'icons': Icons.edit_document, "fieldName": "Document valid upto", 'fieldInfo':  formatDateString(user!.dateOfExpiry) },
    {'icons': Icons.edit_document, "fieldName": "Email ID", 'fieldInfo': user?.subscriberUgPassEmail},
    {'icons': Icons.edit_document, "fieldName": "Mobile Number", 'fieldInfo': user?.subscriberMobileNumber},
    {'icons': Icons.edit_document, "fieldName": "Gender", 'fieldInfo': user?.gender},
  ];

  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    context: context,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.0,
        maxChildSize: 0.7,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              ListTile(
                leading:ClipOval(
                    child : Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                      height: 80,
                      width: 60,
                    )
                ),
                title: Center(
                    child: Text(
                      user!.primaryIdentifier,
                      textAlign: TextAlign.center,
                    )),
                subtitle:
                Center(child: Text("MyTrust status: Active")),),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: passportDetails.length,
                    itemBuilder: (context, index) {
                      final item = passportDetails[index];
                      return Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['fieldName'],
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                color: Colors.cyan[600],
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // border: Border.all(color: Colors.white),
                                color: Colors.grey[200],
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                leading: Icon(item['icons']),
                                title: Text(item['fieldInfo']),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

_buildListTilesForProfile(List<Map<String,dynamic>>passportDetails){
  return ListView.builder(
      itemCount: passportDetails.length,
      itemBuilder: (context, index){
        final items = passportDetails[index];
        return ListTile(
          leading: items['icons'],
          title: Text(items['fieldInfo']),
        );
      });

}


