// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter_ocr_sdk/mrz_result.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:widget_code/animated_drawer.dart';
// import 'app_theme.dart';
// import 'selected_value.dart';
// import 'data_constraints.dart';
// import 'mrz/camera_page.dart';
// import 'strings.dart';
// import 'package:widget_code/animated_drawer.dart';
// class DigitalOnboarding extends StatefulWidget {
//   const DigitalOnboarding({super.key});
//   static const String routeName = "/digitalonboarding";
//
//   @override
//   State<DigitalOnboarding> createState() => _DigitalOnboardingState();
// }
//
// class _DigitalOnboardingState extends State<DigitalOnboarding> {
//   var result;
//   var resultPhoto;
//   final List<String> residentialType = [
//     Strings.citizen,
//     Strings.resident,
//   ];
//   late List<String> documentType = [
//     Strings.nationalID,
//     Strings.passport,
//     Strings.ePassport,
//   ];
//   String selectedResidentialType = '';
//   String selectedDocumentType = '';
//   String previousSelectedResidentialType = '';
//   String previousSelectedDocumentType = '';
//   String scan = Strings.scanDocuments;
//   Color bgScan = LightColor.lightGrey.withAlpha(100);
//
//   Widget _heading() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Row(
//               children: [
//                 Icon(
//                   Icons.arrow_circle_left_outlined,
//                   color: Colors.black,
//                   size: 40,
//                 )
//               ],
//             ),
//           ),
//           const Expanded(
//             child: Text(
//               Strings.digitalOnboardingTitle,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 24,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget documentTypeDropDown(
//       String title, String defaultText, List<String> items) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 7.5, right: 7.5),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700)),
//           const SizedBox(height: 12.5),
//           Container(
//             decoration: BoxDecoration(
//               color: LightColor.lightGrey.withAlpha(100),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: DropdownButtonFormField2<String>(
//               isExpanded: true,
//               decoration: InputDecoration(
//                 // Add Horizontal padding using menuItemStyleData.padding so it matches
//                 // the menu padding when button's width is not specified.
//                   contentPadding: const EdgeInsets.symmetric(vertical: 16),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   )
//                 // Add more decoration..
//               ),
//               hint: Text(
//                 defaultText,
//                 style: const TextStyle(fontSize: 14, color: Colors.black),
//               ),
//               items: items
//                   .map((item) => DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item,
//                   style: const TextStyle(
//                       fontSize: 14, color: Colors.black),
//                 ),
//               ))
//                   .toList(),
//               validator: (value) {
//                 if (value == null) {
//                   return '';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 setState(() {
//                   if (title == Strings.residentialType) {
//                     if (value == residentialType[0]) {
//                       documentType = [
//                         Strings.nationalID,
//                         Strings.passport,
//                         Strings.ePassport,
//                       ];
//                     } else if (value == residentialType[1]) {
//                       documentType = [
//                         Strings.passport,
//                         Strings.ePassport,
//                       ];
//                     }
//                     selectedResidentialType = value.toString();
//                     SelectedValueHolder.RESIDENT_TYPE = value.toString();
//                     if (previousSelectedResidentialType !=
//                         selectedResidentialType) {
//                       bgScan = LightColor.lightGrey.withAlpha(100);
//                       result = null;
//                     }
//                   } else if (title == Strings.documentType) {
//                     selectedDocumentType = value.toString();
//                     SelectedValueHolder.DOCUMENT_TYPE = value.toString();
//                     if (previousSelectedDocumentType != selectedDocumentType) {
//                       bgScan = LightColor.lightGrey.withAlpha(100);
//                       result = null;
//                     }
//                     if (selectedDocumentType == Strings.nationalID) {
//                       scan = "Scan your $selectedDocumentType" + " card front ";
//                     } else {
//                       scan = "Scan your $selectedDocumentType";
//                     }
//                   }
//                 });
//               },
//               onSaved: (value) {},
//               buttonStyleData: const ButtonStyleData(
//                 padding: EdgeInsets.only(right: 8),
//               ),
//               iconStyleData: const IconStyleData(
//                 icon: Icon(
//                   Icons.arrow_drop_down,
//                   color: LightColor.primaryColor,
//                 ),
//                 iconSize: 24,
//               ),
//               dropdownStyleData: DropdownStyleData(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               menuItemStyleData: const MenuItemStyleData(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget scanType(String title, String subtitle, String image, Color bgScan) {
//     return InkWell(
//       onTap: () {
//         print("Selected Resident Type: $selectedResidentialType");
//         print("Selected Document Type: $selectedDocumentType");
//         _checkAndProceed();
//       },
//       child: SingleChildScrollView(
//         child: Expanded(
//           child: DottedBorder(
//             borderType: BorderType.RRect,
//             radius: const Radius.circular(20),
//             padding: const EdgeInsets.all(0),
//             color: Colors.cyan,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.all(Radius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(7.5),
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   // alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: bgScan,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 1,
//                         offset:
//                         const Offset(0, 1), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         const SizedBox(height: 7.5),
//                         Image.asset(
//                           image,
//                           // width: 60.0,
//                           height: 50.0,
//                           fit: BoxFit.cover,
//                         ),
//                         const SizedBox(height: 7.5),
//                         Text(
//                           title,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w700,
//                               color: Colors.black,
//                               fontSize: 18),
//                         ),
//                         Text(
//                           subtitle,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                               fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     return SafeArea(
//       bottom: false,
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Expanded(
//             child: Container(
//               color: Colors.white,
//               height: screenHeight,
//               child: Column(
//                 children: [
//                   // Heading at the top
//                   _heading(),
//
//                   // Spacer to push content to the middle
//                   const Spacer(),
//
//                   SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     dragStartBehavior: DragStartBehavior.down,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20, right: 20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           documentTypeDropDown(Strings.residentialType,
//                               Strings.selectResidentialType, residentialType),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           documentTypeDropDown(Strings.documentType,
//                               Strings.selectDocumentType, documentType),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           scanType(scan, Strings.scanDocumentsDescription,
//                               'images/assets/national_ID.png', bgScan),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           scanType(
//                               Strings.takeSelfie,
//                               Strings.takeSelfieDescription,
//                               'images/assets/selfie.png',
//                               LightColor.lightGrey.withAlpha(100)),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                   ),
//
//                   const Spacer(),
//
//                   Padding(
//                     padding:
//                     const EdgeInsets.only(left: 30, right: 30, bottom: 40),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.black),
//                             ),
//                             onPressed: () {
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(builder: (context) =>DrawerScreen()),
//                               // );
//                             },
//                             child: const Text(
//                               Strings.btnContinue,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'MontserratMedium'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _checkAndProceed() async {
//     if (!selectedResidentialType.isEmpty) {
//       if (!selectedDocumentType.isEmpty) {
//         if (result == null) {
//           previousSelectedResidentialType = selectedResidentialType;
//           previousSelectedDocumentType = selectedDocumentType;
//           if (SelectedValueHolder.DOCUMENT_TYPE == Strings.nationalID) {
//             if (resultPhoto != null) {
//               result = await Navigator.of(context).push(createCustomRoute(
//                 CameraPage("scanMRZ"),
//               ));
//             } else {
//               resultPhoto = await Navigator.of(context).push(createCustomRoute(
//                 CameraPage(""),
//               ));
//             }
//           } else if (SelectedValueHolder.DOCUMENT_TYPE == Strings.passport) {
//             result = await Navigator.of(context).push(createCustomRoute(
//               CameraPage(""),
//             ));
//           }
//         }
//
//         if (resultPhoto != null) {
//           setState(() {
//             scan = "Scan your $selectedDocumentType" + " card back";
//           });
//         }
//         if (result != null) {
//           final MrzResult mrzResult = result;
//           print(mrzResult);
//           setState(() {
//             bgScan = LightColor.primaryColor;
//           });
//         }
//       } else {
//         showToast(Strings.selectDocumentType);
//       }
//     } else {
//       showToast(Strings.selectDocumentType);
//     }
//   }
//
//   void showToast(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength:
//       Toast.LENGTH_SHORT, // Duration for which the toast is displayed
//       gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
//       timeInSecForIosWeb: 1, // Duration for iOS and web platforms
//       backgroundColor: Colors.black45, // Background color of the toast
//       textColor: Colors.white, // Text color of the toast message
//       fontSize: 16.0, // Font size of the toast message
//     );
//   }
// }
