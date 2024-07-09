// import 'package:flutter/material.dart';
// import 'package:flutter_ocr_sdk/mrz_line.dart';
// import 'package:flutter_ocr_sdk/mrz_parser.dart';
// import 'package:widget_code/digital_onboarding_page.dart';
// import 'package:widget_code/selected_value.dart';
//
// import 'package:widget_code/data_constraints.dart';
// import 'package:widget_code/strings.dart';
// import 'camera_manager.dart';
// import 'global.dart';
//
//
// class CameraPage extends StatefulWidget {
//   String scanMRZ = "";
//   CameraPage(this.scanMRZ, {super.key});
//   @override
//   State<CameraPage> createState() => _CameraPageState(scanMRZ);
// }
//
// class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
//   late CameraManager _mobileCamera;
//
//   String scanMRZ = "";
//   String statusMessage = "Hello";
//   _CameraPageState(this.scanMRZ);
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//
//     if (SelectedValueHolder.DOCUMENT_TYPE == Strings.nationalID) {
//       if (scanMRZ == 'scanMRZ') {
//         _mobileCamera = CameraManager(
//           context: context,
//           cbRefreshUi: refreshUI,
//           cbIsMounted: isMounted,
//           cbNavigation: navigation,
//           cbscanMRZ : true,
//         );
//       } else {
//         _mobileCamera = CameraManager(
//           context: context,
//           cbRefreshUi: refreshUI,
//           cbIsMounted: isMounted,
//           cbNavigation: navigationImage,
//           cbscanMRZ : false,
//         );
//       }
//     } else if (SelectedValueHolder.DOCUMENT_TYPE == Strings.passport) {
//       _mobileCamera = CameraManager(
//         context: context,
//         cbRefreshUi: refreshUI,
//         cbIsMounted: isMounted,
//         cbNavigation: navigation,
//         cbscanMRZ : true,
//       );
//     }
//     _mobileCamera.initState();
//   }
//
//   void navigationImage() {
//     // Constants.prefs!.setBool(UserData.cropped.name, true);
//     Navigator.pop(context, "Photo cropped successfully");
//   }
//
//   void navigation(dynamic order) {
//
//     List<MrzLine> area = order;
//     var information;
//     if (area.length == 2) {
//       information = MRZ.parseTwoLines(area[0].text, area[1].text);
//       information.lines = '${area[0].text}\n${area[1].text}';
//     } else if (area.length == 3) {
//       information =
//           MRZ.parseThreeLines(area[0].text, area[1].text, area[2].text);
//       information.lines = '${area[0].text}\n${area[1].text}\n${area[2].text}';
//     }
//     Navigator.pop(context, information);
//   }
//
//   void refreshUI() {
//     setState(() {
//       statusMessage = "Your status message here";
//       print("Status Message: $statusMessage");
//     });
//   }
//
//   bool isMounted() {
//     return mounted;
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _mobileCamera.stopVideo();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (_mobileCamera.controller == null ||
//         !_mobileCamera.controller!.value.isInitialized) {
//       return;
//     }
//
//     if (state == AppLifecycleState.inactive) {
//       _mobileCamera.controller!.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       _mobileCamera.toggleCamera(0);
//     }
//   }
//
//   List<Widget> createCameraPreview() {
//     if (_mobileCamera.controller != null && _mobileCamera.previewSize != null) {
//       final hint = const Text(
//           'P<CANAMAN<<RITA<TANIA<<<<<<<<<<<<<<<<<<<<<<<\nERE82721<9CAN8412070M2405252<<<<<<<<<<<<<<08',
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.white,
//           ));
//       return [
//         SizedBox(
//             width: MediaQuery.of(context).size.width <
//                 MediaQuery.of(context).size.height
//                 ? _mobileCamera.previewSize!.height
//                 : _mobileCamera.previewSize!.width,
//             height: MediaQuery.of(context).size.width <
//                 MediaQuery.of(context).size.height
//                 ? _mobileCamera.previewSize!.width
//                 : _mobileCamera.previewSize!.height,
//             child: _mobileCamera.getPreview()),
//         Positioned(
//           child: createOverlay(
//             _mobileCamera.mrzLines,
//           ),
//         ),
//         Positioned(
//           top: 400,
//           left: 20,
//           right: 20,
//           bottom: 400,
//           child: Center(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.red,
//                   width: 3.0,
//                 ),
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: Colors.transparent,
//               ),
//             ),
//           ),
//         ),
//         /* Positioned(
//           left: !kIsWeb && (Platform.isAndroid) ? 0 : 150,
//           child: !kIsWeb && (Platform.isAndroid)
//               ? Transform.rotate(
//                   angle: pi / 2, // 90 degrees in radians
//                   child: hint,
//                 )
//               : hint,
//         ),*/
//       ];
//     } else {
//       return [const CircularProgressIndicator()];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     /*dynamic data = ModalRoute.of(context)!.settings.arguments;
//
//     if (data != null) {
//       print('Received data: $data');
//       setState(() {
//         scanMRZ = data['scanMRZ'];
//       });
//       print(scanMRZ);
//     }*/
//     return WillPopScope(
//         onWillPop: () async {
//           return true;
//         },
//         child: Scaffold(
//           body: Stack(
//             children: <Widget>[
//               if (_mobileCamera.controller != null &&
//                   _mobileCamera.previewSize != null)
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   left: 0,
//                   bottom: 0,
//                   child: FittedBox(
//                     fit: BoxFit.cover,
//                     child: Stack(
//                       children: createCameraPreview(),
//                     ),
//                   ),
//                 ),
//               if (statusMessage != null)
//                 Positioned(
//                   top: 16,
//                   left: 16,
//                   child: Text(
//                     statusMessage!,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ));
//   }
// }
