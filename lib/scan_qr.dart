import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';


// QR Code Scanner
class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = '';

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan a QR code to start transfer'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code!;
      });
      controller.dispose();
      _startBluetoothTransfer(qrText);
    });
  }

  void _startBluetoothTransfer(String data) async {
    if (await Permission.bluetooth.isGranted && await Permission.bluetoothScan.isGranted && await Permission.bluetoothConnect.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BluetoothTransfer(data: data),
        ),
      );
    } else {

      await Permission.bluetooth.request();
      await Permission.bluetoothScan.request();
      await Permission.bluetoothConnect.request();
      if (await Permission.bluetooth.isGranted && await Permission.bluetoothScan.isGranted && await Permission.bluetoothConnect.isGranted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BluetoothTransfer(data: data),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bluetooth permissions are required to transfer data')),
        );
      }
    }
  }
}

// Bluetooth Transfer
class BluetoothTransfer extends StatefulWidget {
  final String data;

  BluetoothTransfer({required this.data});

  @override
  _BluetoothTransferState createState() => _BluetoothTransferState();
}

class _BluetoothTransferState extends State<BluetoothTransfer> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? writeCharacteristic;
  String transferredData = '';

  @override
  void initState() {
    super.initState();
    startScan();
  }

  void startScan() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    var subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        // Connect to the first device found
        flutterBlue.stopScan();
        connectToDevice(r.device);
        break;
      }
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      connectedDevice = device;
    });
    discoverServices();
  }

  void discoverServices() async {
    if (connectedDevice == null) return;
    var services = await connectedDevice!.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          setState(() {
            writeCharacteristic = characteristic;
          });
          break;
        }
      }
      if (writeCharacteristic != null) break;
    }
    transferData();
  }

  void transferData() async {
    if (writeCharacteristic != null) {
      await writeCharacteristic!.write(utf8.encode(widget.data));
      setState(() {
        transferredData = widget.data;
      });
    }
  }

  @override
  void dispose() {
    connectedDevice?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Transfer'),
      ),
      body: Center(
        child: connectedDevice == null
            ? CircularProgressIndicator()
            : Text('Transferred Data: $transferredData'),
      ),
    );
  }
}
