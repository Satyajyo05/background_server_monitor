import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQR extends StatelessWidget {
  // URL or path to the image to be shown when the QR code is scanned
  final String qrData = 'images/assets/expired.png'; // This should be the path or URL you want to encode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Display'),
      ),
      body: Center(
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 200.0,
          embeddedImage: AssetImage('images/assets/expired.png'),
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: Size(40, 40),
          ),
        ),
      ),
    );
  }
}
