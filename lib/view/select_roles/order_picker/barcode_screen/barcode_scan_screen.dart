import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({Key? key}) : super(key: key);

  @override
  _BarcodeScanScreenState createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  String? scanResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Barcode'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: scanBarcode, child: Text('Start Scan'))),
          Text(
            scanResult == null ? 'Scan a code!' : 'Scan result : $scanResult',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Future scanBarcode() async {
    String ScanResult;
    try {
      ScanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ffB7003D', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      ScanResult = 'Failed to get platform version';
    }
    if (!mounted) return;
    setState(() {
      this.scanResult = ScanResult;
    });
  }
}
