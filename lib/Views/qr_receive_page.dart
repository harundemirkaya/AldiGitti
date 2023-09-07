// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:aldigitti/ViewModels/QRReceiveViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/success_reservation_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRReceivePage extends StatefulWidget {
  final String journeyID;
  final String reservationUserID;
  final String confirmReservationKey;
  const QRReceivePage({
    Key? key,
    required this.confirmReservationKey,
    required this.journeyID,
    required this.reservationUserID,
  }) : super(key: key);

  @override
  State<QRReceivePage> createState() => _QRReceivePageState();
}

class _QRReceivePageState extends State<QRReceivePage> {
  QRReceiveViewModel viewModel = QRReceiveViewModel();
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
      (scanData) async {
        if (scanData.code == widget.confirmReservationKey) {
          controller.pauseCamera();
          await viewModel.updateReservationStatus(
              widget.journeyID, widget.reservationUserID);
          bool? shouldPop = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessReservationPage(
                isSuccessQR: true,
                title: "Kargo Teslim Alındı",
                description:
                    "Tüm rezervasyonlarınızın kargo teslimini gerçekleştirmenizin ardından yola çıkabilirsiniz!",
                buttonText: "",
              ),
            ),
          );
          if (shouldPop == true) {
            Navigator.pop(context);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
