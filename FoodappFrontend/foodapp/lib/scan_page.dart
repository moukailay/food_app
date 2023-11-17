import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String barcode = "";

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barcode = result.rawContent;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan de Produit'),
        backgroundColor: const Color(0xff1E2E3D),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Résultat du Scan : $barcode'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanBarcode,
              child: const Text('Scanner un Produit'),
            ),
          ],
        ),
      ),
    );
  }
}
