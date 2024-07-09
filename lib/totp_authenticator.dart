// import 'package:flutter/material.dart';
// import 'package:otp/otp.dart';
// class TOTPAuthenticatorPage extends StatefulWidget {
//   @override
//   _TOTPAuthenticatorPageState createState() => _TOTPAuthenticatorPageState();
// }
//
// class _TOTPAuthenticatorPageState extends State<TOTPAuthenticatorPage> {
//   late String secret;
//   late String code;
//
//   @override
//   void initState() {
//     super.initState();
//     // Generate a random secret (usually obtained from the server)
//     //secret = OTP.generateTOTPSecretString();
//     // Generate the initial TOTP code
//     code = OTP.generateTOTPCodeString("JBSWY3DPEHPK3PXP", 1362302550000);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TOTP Authenticator'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Secret: $secret',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'TOTP Code: $code',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   // Generate a new TOTP code
//                   code = OTP.generateTOTPCodeString();
//                 });
//               },
//               child: Text('Refresh Code'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
