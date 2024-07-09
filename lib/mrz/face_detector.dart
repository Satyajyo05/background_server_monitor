// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'input_image.dart';
//
// class FaceDetector {
//   final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector() as FaceDetector;
//
//   Future<List<Face>> processImage(InputImage inputImage) async {
//     final inputImageGoogle = GoogleMlKit.vision.inputImageFromBytes(
//       bytes: inputImage.bytes!,
//       inputImageData: InputImageData(
//           size: inputImage.metadata!.size,
//           imageRotation: InputImageRotationValue.fromRawValue(inputImage.metadata!.rotation.rawValue)!,
//           inputImageFormat: InputImageFormatValue.fromRawValue(inputImage.metadata!.format.rawValue)!,
//           planeData: [InputImagePlaneMetadata(bytesPerRow: inputImage.metadata!.bytesPerRow)]
//       ),
//     );
//     return await _faceDetector.processImage(inputImageGoogle);
//   }
// }
