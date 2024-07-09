// import 'dart:typed_data';
// import 'dart:io';
// import 'package:flutter/material.dart';
//
// class InputImage {
//   final String? filePath;
//   final Uint8List? bytes;
//   final InputImageType type;
//   final InputImageMetadata? metadata;
//
//   InputImage._({this.filePath, this.bytes, required this.type, this.metadata});
//
//   factory InputImage.fromFilePath(String path) {
//     return InputImage._(filePath: path, type: InputImageType.file);
//   }
//
//   factory InputImage.fromFile(File file) {
//     return InputImage._(filePath: file.path, type: InputImageType.file);
//   }
//
//   factory InputImage.fromBytes(
//       {required Uint8List bytes, required InputImageMetadata metadata}) {
//     return InputImage._(
//         bytes: bytes, type: InputImageType.bytes, metadata: metadata);
//   }
//
//   Map<String, dynamic> toJson() => {
//     'bytes': bytes,
//     'type': type.name,
//     'path': filePath,
//     'metadata': metadata?.toJson()
//   };
// }
//
// enum InputImageType {
//   file,
//   bytes,
// }
//
// class InputImageMetadata {
//   final Size size;
//   final InputImageRotation rotation;
//   final InputImageFormat format;
//   final int bytesPerRow;
//
//   InputImageMetadata({
//     required this.size,
//     required this.rotation,
//     required this.format,
//     required this.bytesPerRow,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'width': size.width,
//     'height': size.height,
//     'rotation': rotation.rawValue,
//     'image_format': format.rawValue,
//     'bytes_per_row': bytesPerRow,
//   };
// }
//
// enum InputImageRotation {
//   rotation0deg,
//   rotation90deg,
//   rotation180deg,
//   rotation270deg
// }
//
// extension InputImageRotationValue on InputImageRotation {
//   int get rawValue {
//     switch (this) {
//       case InputImageRotation.rotation0deg:
//         return 0;
//       case InputImageRotation.rotation90deg:
//         return 90;
//       case InputImageRotation.rotation180deg:
//         return 180;
//       case InputImageRotation.rotation270deg:
//         return 270;
//     }
//   }
//
//   static InputImageRotation? fromRawValue(int rawValue) {
//     try {
//       return InputImageRotation.values
//           .firstWhere((element) => element.rawValue == rawValue);
//     } catch (_) {
//       return null;
//     }
//   }
// }
//
// enum InputImageFormat {
//   nv21,
//   yv12,
//   yuv_420_888,
//   yuv420,
//   bgra8888,
// }
//
// extension InputImageFormatValue on InputImageFormat {
//   int get rawValue {
//     switch (this) {
//       case InputImageFormat.nv21:
//         return 17;
//       case InputImageFormat.yv12:
//         return 842094169;
//       case InputImageFormat.yuv_420_888:
//         return 35;
//       case InputImageFormat.yuv420:
//         return 875704438;
//       case InputImageFormat.bgra8888:
//         return 1111970369;
//     }
//   }
//
//   static InputImageFormat? fromRawValue(int rawValue) {
//     try {
//       return InputImageFormat.values
//           .firstWhere((element) => element.rawValue == rawValue);
//     } catch (_) {
//       return null;
//     }
//   }
// }
