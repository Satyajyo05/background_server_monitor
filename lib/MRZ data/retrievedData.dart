// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:widget_code/main_home_page.dart';
//
// class UserDetailsScreen extends StatefulWidget {
//   const UserDetailsScreen({Key? key}) : super(key: key);
//
//   @override
//   _UserDetailsScreenState createState() => _UserDetailsScreenState();
// }
//
// class _UserDetailsScreenState extends State<UserDetailsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateToHomePage();
//   }
//
//   Future<void> _navigateToHomePage() async {
//     User? user = await getUserData();
//     if (user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => MainHomePage(user: user)),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("User details")),
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
//
// Future<User?> getUserData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? userData = prefs.getString('userData');
//   if (userData != null) {
//     Map<String, dynamic> responseData = jsonDecode(userData);
//     if (responseData.containsKey('result')) {
//       Map<String, dynamic> result = responseData['result'];
//       String subscriberUgPassEmail = result['subscriberUgPassEmail'] ?? '';
//       String subscriberMobileNumber = result['subscriberMobileNumber'] ?? '';
//       if (result.containsKey('subscriberData')) {
//         Map<String, dynamic> subscriberData = result['subscriberData'];
//         return User.fromJson(subscriberData, subscriberUgPassEmail, subscriberMobileNumber);
//       } else {
//         print('No "subscriberData" object found in result');
//       }
//     } else {
//       print('No "result" object found in user data');
//     }
//   }
//   return null;
// }
//
// class User {
//   final String primaryIdentifier;
//   final String gender;
//   final String dateOfExpiry;
//   final String dateOfBirth;
//   final String nationality;
//   final String documentNumber;
//   final String subscriberUgPassEmail;
//   final String subscriberMobileNumber;
//   final String subscriberSelfie;
//
//   User({
//     required this.primaryIdentifier,
//     required this.gender,
//     required this.dateOfExpiry,
//     required this.documentNumber,
//     required this.nationality,
//     required this.dateOfBirth,
//     required this.subscriberUgPassEmail,
//     required this.subscriberMobileNumber,
//     required this.subscriberSelfie,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json, String subscriberUgPassEmail, String subscriberMobileNumber) {
//     return User(
//       primaryIdentifier: json['primaryIdentifier'] ?? '',
//       gender: json['gender'] ?? '',
//       dateOfExpiry: json['dateOfExpiry'] ?? '',
//       dateOfBirth: json['dateOfBirth'] ?? '',
//       documentNumber: json['documentNumber'] ?? '',
//       nationality: json['nationality'] ?? '',
//       subscriberSelfie : json['subscriberSelfie'] ?? '',
//       subscriberUgPassEmail: subscriberUgPassEmail,
//       subscriberMobileNumber: subscriberMobileNumber,
//     );
//   }
// }
