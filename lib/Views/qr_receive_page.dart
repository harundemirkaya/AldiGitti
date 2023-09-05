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
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250, // QR kodun okunacağı alanın boyutunu ayarlar
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Burada QR kodun içeriğini alabilirsiniz.
      // Örneğin, bir şeyler yapmak için:
      print('QR Code Scanned: ${scanData.code}');

      // QR kodu okunduktan sonra kamera işlevini durdurmak için:
      controller.pauseCamera();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
