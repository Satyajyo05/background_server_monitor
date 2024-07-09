// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/services.dart';
//
// import 'package:camera_windows/camera_windows.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// // import 'package:flutter_document_scan_sdk/document_result.dart';
// // import 'package:flutter_document_scan_sdk/normalized_image.dart';
// // import 'package:flutter_document_scan_sdk/template.dart';
// import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:flutter_ocr_sdk/flutter_ocr_sdk_platform_interface.dart';
// import 'package:flutter_ocr_sdk/mrz_line.dart';
//
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:google_ml_vision/google_ml_vision.dart';
// // import 'package:mrz/plugin.dart';
//
//
// import 'package:camera_platform_interface/camera_platform_interface.dart';
// import '/strings.dart';
// import '/selected_value.dart';
//
// import 'dart:typed_data';
// import 'package:path_provider/path_provider.dart';
// import 'package:image/image.dart' as img;
// import 'dart:ui' as ui;
// import 'package:path/path.dart';
//
// // import 'document_data.dart';
// import 'global.dart';
//
//
// class CameraManager {
//   static const platform_main = MethodChannel('MainChannel');
//   BuildContext context;
//   CameraController? controller;
//   late List<CameraDescription> _cameras;
//   Size? previewSize;
//   bool _isScanAvailable = true;
//   List<List<MrzLine>>? mrzLines;
//   bool isDriverLicense = true;
//   bool isFinished = false;
//   StreamSubscription<FrameAvailabledEvent>? _frameAvailableStreamSubscription;
//   bool _isMobileWeb = false;
//   Timer? _autocaptureTimer;
//
//   String? croppedImagePath;
//   String _CropImageFromNative = '';
//
//
//   ui.Image? image;
//   // List<DocumentResult>? detectionResults = [];
//   ui.Image? normalizedUiImage;
//   bool documentSaved = true;
//
//   // NormalizedImage? normalizedImage;
//
//   CameraManager(
//       {required this.context,
//         required this.cbRefreshUi,
//         required this.cbIsMounted,
//         required this.cbNavigation, required this.cbscanMRZ});
//
//   Function cbRefreshUi;
//   Function cbIsMounted;
//   Function cbNavigation;
//   final bool cbscanMRZ;
//
//   void initState() {
//     initCamera();
//   }
//
//   Future<void> stopVideo() async {
//     if (controller == null) return;
//     if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
//       try {
//         await controller!.stopImageStream();
//       } catch (e) {
//         print("Error stopping image stream: $e");
//       }
//
//     }
//
//     controller!.dispose();
//     controller = null;
//
//     _frameAvailableStreamSubscription?.cancel();
//     _frameAvailableStreamSubscription = null;
//   }
//
//   Future<void> webCamera() async {
//     if (controller == null || isFinished || cbIsMounted() == false) return;
//
//     XFile file = await controller!.takePicture();
//
//     var results = await mrzDetector.recognizeByFile(file.path);
//     if (results == null || !cbIsMounted()) return;
//
//     mrzLines = results;
//     cbRefreshUi();
//     // handleMrz(results);
//
//     if (!isFinished) {
//       webCamera();
//     }
//   }
//
//   //mrz is not called in prcocess id as opposed to originalcode
//   void handleMrz(List<List<MrzLine>> results, String capturedImagePath) {
//     if (results.isNotEmpty) {
//       // _scanDoc(capturedImagePath);
//       if (documentSaved) {
//         _detectFace(capturedImagePath);
//         _cropImageFromNative(results, capturedImagePath);
//       }
//
//     }
//   }
//
//   void processId(
//       Uint8List bytes, int width, int height, int stride, int format) {
//     cbRefreshUi();
//     mrzDetector
//         .recognizeByBuffer(bytes, width, height, stride, format)
//         .then((results) {
//       if (results == null || !cbIsMounted()) return;
//
//       if (MediaQuery.of(context).size.width <
//           MediaQuery.of(context).size.height) {
//         if (Platform.isAndroid) {
//           results = rotate90mrz(results, previewSize!.height.toInt());
//         }
//       }
//
//       mrzLines = results;
//       cbRefreshUi();
//       // handleMrz(results);
//
//       _isScanAvailable = true;
//     });
//   }
//
//   Future<void> mobileCamera() async {
//     await controller!.startImageStream((CameraImage availableImage) async {
//       assert(defaultTargetPlatform == TargetPlatform.android ||
//           defaultTargetPlatform == TargetPlatform.iOS);
//       if (cbIsMounted() == false || isFinished) return;
//       int format = ImagePixelFormat.IPF_NV21.index;
//
//       switch (availableImage.format.group) {
//         case ImageFormatGroup.yuv420:
//           format = ImagePixelFormat.IPF_NV21.index;
//           break;
//         case ImageFormatGroup.bgra8888:
//           format = ImagePixelFormat.IPF_ARGB_8888.index;
//           break;
//         default:
//           format = ImagePixelFormat.IPF_RGB_888.index;
//       }
//
//       if (!_isScanAvailable) {
//         return;
//       }
//
//       _isScanAvailable = false;
//
//       processId(availableImage.planes[0].bytes, availableImage.width,
//           availableImage.height, availableImage.planes[0].bytesPerRow, format);
//     });
//   }
//
//
//   Future<void> startVideo() async {
//     mrzLines = null;
//
//     isFinished = false;
//
//     cbRefreshUi();
//     startAutocaptureTimer();
//   }
//
//   void _onFrameAvailable(FrameAvailabledEvent event) {
//     if (cbIsMounted() == false || isFinished) return;
//
//     Map<String, dynamic> map = event.toJson();
//     final Uint8List? data = map['bytes'] as Uint8List?;
//     if (data != null) {
//       if (!_isScanAvailable) {
//         return;
//       }
//
//       _isScanAvailable = false;
//       int width = previewSize!.width.toInt();
//       int height = previewSize!.height.toInt();
//
//
//     }
//   }
//
//   Future<void> initCamera() async {
//     try {
//       WidgetsFlutterBinding.ensureInitialized();
//       _cameras = await availableCameras();
//       int index = 0;
//
//       for (; index < _cameras.length; index++) {
//         CameraDescription description = _cameras[index];
//         if (description.name.toLowerCase().contains('back')) {
//           _isMobileWeb = true;
//           break;
//         }
//       }
//       if (_cameras.isEmpty) return;
//
//       toggleCamera(0);
//     } on CameraException catch (e) {
//       print(e);
//     }
//   }
//
//   Widget getPreview() {
//     if (controller == null || !controller!.value.isInitialized || isFinished) {
//       return Container(
//         child: const Text('No camera available!'),
//       );
//     }
//
//
//     return CameraPreview(controller!);
//   }
//
//   Future<void> toggleCamera(int index) async {
//     if (controller != null) controller!.dispose();
//
//     controller = CameraController(_cameras[index], ResolutionPreset.veryHigh);
//
//     controller!.initialize().then((_) {
//       // Set flash mode to FlashMode.off to prevent the flash from turning on
//       controller!.setFlashMode(FlashMode.off);
//       if (!cbIsMounted()) {
//         return;
//       }
//
//       previewSize = controller!.value.previewSize;
//
//       startVideo();
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             break;
//           default:
//             break;
//         }
//       }
//     });
//   }
//
//   // Start autocapture timer
//   void startAutocaptureTimer() {
//     // Cancel any existing timer
//     _autocaptureTimer?.cancel();
//
//     // Set a timer for autocapture after a delay (e.g., 3 seconds)
//     _autocaptureTimer = Timer(const Duration(seconds: 3), () {
//       // Capture the image after the delay
//       captureImage();
//     });
//   }
//
//   // Capture the image
//   void captureImage() async {
//     if (controller != null && !isFinished) {
//       XFile file = await controller!.takePicture();
//       print("TAKEN");
//       print(cbscanMRZ);
//       File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(path: file.path);
//       var results = await mrzDetector.recognizeByFile(rotatedImage.path);
//       print(results);
//       print(rotatedImage.path);
//       print("ROTATED");
//
//       if(!cbscanMRZ && results!.isEmpty) {
//         print("Scan only for Face");
//         _detectFace(file.path);
//       } else if (!cbscanMRZ && results != null) {
//         print("scan face not mrz");
//         startAutocaptureTimer();
//       } else {
//         if (results != null && cbIsMounted()) {
//           mrzLines = results;
//           cbRefreshUi();
//           for (List<MrzLine> area in results) {
//             if (area.length == 2) {
//               if (SelectedValueHolder.DOCUMENT_TYPE == Strings.passport) {
//                 // handleMrz(results, file.path);
//                 _detectFace(file.path);
//                 sendResponse(results);
//                 // _cropImageFromNative(results, file.path);
//               } else if (SelectedValueHolder.DOCUMENT_TYPE == Strings.nationalID){
//                 print("You are scanning wrong document");
//                 startAutocaptureTimer();
//               }
//             } else if(area.length == 3) {
//               sendResponse(results);
//               if (SelectedValueHolder.DOCUMENT_TYPE == Strings.nationalID) {
//                 sendResponse(results);
//               } else if (SelectedValueHolder.DOCUMENT_TYPE == Strings.passport){
//                 print("You are scanning wrong document");
//                 startAutocaptureTimer();
//               }
//             }
//           }
//           startAutocaptureTimer();
//         }
//       }
//     }
//   }
//
//
//   Future<void> _cropImageFromNative(List<List<MrzLine>> results, String capturedImagePath) async {
//     print('_cropImageFromNative');
//     String responseResult;
//     try {
//       final String result = await platform_main.invokeMethod('CropImageFromNative', {"imagePath": capturedImagePath});
//       responseResult = '$result';
//       print('CropImage Response : $responseResult');
//       saveCapturedDocumentImage(XFile(capturedImagePath), 'captured_document.png');
//       sendResponse(results);
//     } on PlatformException catch (e) {
//       responseResult = "'${e.message}'.";
//       print('CropImage exception : $responseResult');
//
//       switch (e.code) {
//         case 'NO_FACES_AVAILABLE':
//           break;
//         case 'ERROR_CODE_2':
//         // Handle error code 2
//           break;
//       // Add more cases as needed
//         default:
//         // Handle other error codes
//           break;
//       }
//     }
//     _CropImageFromNative = responseResult;
//   }
//
//
//   void sendResponse(List<List<MrzLine>> results) {
//     List<MrzLine>? finalArea;
//     try {
//       for (List<MrzLine> area in results) {
//         if (area.length == 2) {
//           if (area[0].confidence >= 70 && area[1].confidence >= 70) {
//             int line1 = area[0].text.length;
//             int line2 = area[1].text.length;
//             if (line1 == 44 && line2 == 44 ){
//               finalArea = area;
//             } else {
//               startAutocaptureTimer();
//             }
//             break;
//           }
//         } else if (area.length == 3) {
//           if (area[0].confidence >= 70 &&
//               area[1].confidence >= 70 &&
//               area[2].confidence >= 70) {
//             int line1 = area[0].text.length;
//             int line2 = area[1].text.length;
//             int line3 = area[2].text.length;
//             if (line1 == 30 && line2 == 30 && line3 == 30){
//               finalArea = area;
//             } else {
//               startAutocaptureTimer();
//             }
//             // finalArea = area;
//             break;
//           }
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//
//     if (!isFinished && finalArea != null) {
//       isFinished = true;
//       cbNavigation(finalArea);
//     } else {
//       print("Face Not Detected");
//     }
//   }
//
//   Future<void> _detectFace(String imagePath) async {
//     print("_detectFace");
//     final GoogleVisionImage visionImage = GoogleVisionImage.fromFilePath(imagePath);
//     final FaceDetector faceDetector = GoogleVision.instance.faceDetector(
//       const FaceDetectorOptions(
//         mode: FaceDetectorMode.fast,
//         enableLandmarks: true,
//       ),
//     );
//     try {
//       List<Face> faces = await faceDetector.processImage(visionImage);
//       List<Map<String, int>> faceMaps = [];
//
//       if (faces.isNotEmpty) {
//         // Process the detected faces
//         for (Face face in faces) {
//           print("face detected");
//           // Access face information
//           print("Smiling probability: ${face.smilingProbability}");
//           print("Left eye open probability: ${face.leftEyeOpenProbability}");
//           print("Right eye open probability: ${face.rightEyeOpenProbability}");
//
//           // Access face landmarks if enabled in FaceDetectorOptions
//           if (face.getLandmark(FaceLandmarkType.leftEye) != null) {
//             print("Left eye position: ${face.getLandmark(FaceLandmarkType.leftEye)!.position}");
//           }
//
//           int x = face.boundingBox.left.toInt();
//           int y = face.boundingBox.top.toInt();
//           int w = face.boundingBox.width.toInt();
//           int h = face.boundingBox.height.toInt();
//           Map<String, int> thisMap = {'x': x, 'y': y, 'w': w, 'h':h};
//           faceMaps.add(thisMap);
//
//           print("faceMaps : $faceMaps.length");
//
//
//           // You can access other face features similarly
//
//           // Example: Draw bounding box around the face
//           Rect boundingBox = face.boundingBox;
//
//           double x_axis = face.boundingBox.left;
//           double y_axis = face.boundingBox.top;
//           double width = face.boundingBox.width + x_axis/4;
//           double height = face.boundingBox.height + y_axis/7;
//           print("x_axis: $x_axis");
//           print("y_axis: $y_axis");
//           print("width: $width");
//           print("height: $height");
//
//           File croppedFile = await FlutterNativeImage.cropImage( imagePath, x_axis.toInt(), y_axis.toInt(), width.toInt(), height.toInt());
//           // _saveCroppedImageFile(croppedFile);
//           saveCapturedDocumentImage(XFile(croppedFile.path), 'cropped.png');
//
//           if(!cbscanMRZ) {
//             if (!isFinished) {
//               isFinished = true;
//               cbNavigation();
//             }
//           }
//         }
//       } else {
//         // No face detected
//         print("No face detected");
//         startAutocaptureTimer();
//       }
//     } catch (e) {
//       print("Error during face detection: $e");
//     }
//   }
//
//
//   Future<void> _saveCroppedImageFile(File croppedFile) async {
//     // Save the cropped image to a new file
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String documentsPath = documentsDirectory.path;
//
//     // Create a unique filename for the cropped image
//     String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//     String filePath = '$documentsPath/finally_path_to_save_cropped_image_$timestamp.png';
//     print("FilePath : $filePath");
//     final File savedFile = File(filePath); // Change the path accordingly
//     await savedFile.writeAsBytes(await croppedFile.readAsBytes());
//     print("successfully saved");
//   }
//
//   Future<void> saveCapturedDocumentImage(XFile file, String fileName) async {
//     String? path;
//     Directory directory =
//     await getApplicationDocumentsDirectory();
//     path = join(directory.path, fileName);
//     await file.saveTo(path);
//     print("Captured document saved successfully");
//   }
// }
