// ignore_for_file: unrelated_type_equality_checks


import 'dart:io';
import 'package:cobranzas/repository/authentication.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildQrView(context),
              Positioned(bottom: 10, child: buildResult()),
            ],
          ),
        ),
      );
  // Size size = MediaQuery.of(context).size;

  /*Stack(
        children: [
          Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.blueColor.withOpacity(.15),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Constants.blueColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.blueColor.withOpacity(.15),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Constants.blueColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
            top: 100,
            right: 20,
            left: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                          print("Presionaste el escaner");
                          
                       
                      },
                      child: Image.asset(
                        'assets/images/code-scan.png',
                        height: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Abrir escaner',
                      style: TextStyle(
                        color: Constants.blueColor.withOpacity(.80),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),*/

  Widget _buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).colorScheme.secondary,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        result = barcode;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget buildResult() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white24,
        ),
        child: GestureDetector(
          onTap: () {
            try {
              authenticationRepository.validaciones('Texto :${result!.code}');
            } catch (e) {
              e.hashCode.toString();
            }
          },
          child: Text(
            style: const TextStyle(fontSize: 17),
            result != null ? 'Texto :${result!.code}' : 'escanea el código',
            maxLines: 3,
          ),
        ),
      );
}
