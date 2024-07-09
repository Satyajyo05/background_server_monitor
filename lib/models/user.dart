//data retrieved from backend after posting to getSubscriberOnboarding service call

import 'dart:convert';

class User {
  final String primaryIdentifier;
  final String gender;
  final String dateOfExpiry;
  final String dateOfBirth;
  final String nationality;
  final String documentNumber;
  final String subscriberUgPassEmail;
  final String subscriberMobileNumber;
  final String subscriberSelfie;

  User({
    required this.primaryIdentifier,
    required this.gender,
    required this.dateOfExpiry,
    required this.dateOfBirth,
    required this.nationality,
    required this.documentNumber,
    required this.subscriberUgPassEmail,
    required this.subscriberMobileNumber,
    required this.subscriberSelfie,
  });

  factory User.fromJson(Map<String, dynamic> json, String subscriberUgPassEmail, String subscriberMobileNumber) {
    return User(
      primaryIdentifier: json['primaryIdentifier'] ?? '',
      gender: json['gender'] ?? '',
      dateOfExpiry: json['dateOfExpiry'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      nationality: json['nationality'] ?? '',
      documentNumber: json['documentNumber'] ?? '',
      subscriberUgPassEmail: subscriberUgPassEmail,
      subscriberMobileNumber: subscriberMobileNumber,
      subscriberSelfie: json['subscriberSelfie'] ?? '',
    );
  }
}
