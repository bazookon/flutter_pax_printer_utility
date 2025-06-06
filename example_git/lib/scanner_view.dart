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

    FlutterPaxPrinterUtility.scan().then((value) {
      if (kDebugMode) {
        print("Scan Result $value");
      }
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