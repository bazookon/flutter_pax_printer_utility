import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pax_printer_utility/flutter_pax_printer_utility.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({Key? key}) : super(key: key);

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  String result = "";

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = FlutterPaxPrinterUtility.scanStream.listen((event) {
      setState(() {
        result = event;
      });
    });
    // Scanner
    FlutterPaxPrinterUtility.scanStream.listen((event) {
      print("Scanned Data: $event");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Scanned Data: $event"),
        backgroundColor: Colors.green,
      ));
    }, onError: (error) {
      print("Scanner Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Scanner Error: $error"),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanner View"),
      ),
      body: Center(
        child: Text("Scanner Result $result"),
      ),
    );
  }
}
