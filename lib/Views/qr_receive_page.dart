// ignore_for_file: prefer_const_constructors

import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRReceivePage extends StatefulWidget {
  const QRReceivePage({Key? key}) : super(key: key);

  @override
  State<QRReceivePage> createState() => _QRReceivePageState();
}

class _QRReceivePageState extends State<QRReceivePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Theme.of(context).primaryColor,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 250,
            ),
          ),
          PrimaryNavigationBar(
            backButton: true,
            bgColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        print('QR Code Scanned: ${scanData.code}');

        controller.pauseCamera();
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
