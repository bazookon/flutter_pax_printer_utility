import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter_pax_printer_utility/flutter_pax_printer_utility.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'scanner_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? initSuccess = await FlutterPaxPrinterUtility.init;
  if (initSuccess == true) {
    // Now ready to print
    runApp(const MyApp());
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _platformVersion = 'Unknown';
  String statusPrinter = '0';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getPrinterStatus();

    // Scanner
    FlutterPaxPrinterUtility.scan().then((value) {
      if (value == null) return;
      // Toast message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value),
        backgroundColor: Colors.green,
      ));
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await FlutterPaxPrinterUtility.platformVersion ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  getPrinterStatus() async {
    await FlutterPaxPrinterUtility.init;
    PrinterStatus status = await FlutterPaxPrinterUtility.getStatus;
    print(status);
    setState(() {
      if (status == PrinterStatus.SUCCESS) {
        statusPrinter = "1";
      } else {
        statusPrinter = "0";
      }
    });
  }

  printQrCode() async {
    await FlutterPaxPrinterUtility.init;
    await FlutterPaxPrinterUtility.fontSet(
        EFontTypeAscii.FONT_24_24, EFontTypeExtCode.FONT_24_24);
    await FlutterPaxPrinterUtility.spaceSet(0, 10);
    await FlutterPaxPrinterUtility.setGray(1);
    await FlutterPaxPrinterUtility.printStr('SILAHKAN SCAN QRCODE', null);
    await FlutterPaxPrinterUtility.printStr('\n\n', null);
    await FlutterPaxPrinterUtility.printStr('ID1782363', null);
    await FlutterPaxPrinterUtility.printStr('\n', null);
    await FlutterPaxPrinterUtility.printStr('001', null);
    await FlutterPaxPrinterUtility.printQRCode(
        '190237901273akshfaksdh', 512, 512);
    await FlutterPaxPrinterUtility.printStr('BAKSO', null);
    await FlutterPaxPrinterUtility.step(150);
    var status = await FlutterPaxPrinterUtility.start();
    return status;
  }

  Future<void> _manualPrintWithBitmap() async {
    setState(() => isLoading = true);
    // Init printer, makesure printer is ready to print
    await FlutterPaxPrinterUtility.init;

    // Set Gray level
    await FlutterPaxPrinterUtility.setGray(3);

    // Set fontset
    await FlutterPaxPrinterUtility.fontSet(
        EFontTypeAscii.FONT_16_24, EFontTypeExtCode.FONT_16_32);

    await FlutterPaxPrinterUtility.leftIndents(10);
    await FlutterPaxPrinterUtility.printStr(
        "          Example Git Test     \n", null);
    await FlutterPaxPrinterUtility.printStr(
        "           Jl. Test     \n", null);
    await FlutterPaxPrinterUtility.printStr(
        "            Testing      \n", null);
    await FlutterPaxPrinterUtility.printStr("\n", null);
    await FlutterPaxPrinterUtility.printStr(
        "TID    : 123456           \n", null);
    await FlutterPaxPrinterUtility.printStr(
        "Peymen : CASH             \n", null);
    await FlutterPaxPrinterUtility.printStr(
        "Date   : ${DateTime.now().toLocal()}\n", null);
    await FlutterPaxPrinterUtility.printStr("\n", null);
    await FlutterPaxPrinterUtility.setDoubleWidth(true, true);
    await FlutterPaxPrinterUtility.setDoubleHeight(true, true);
    await FlutterPaxPrinterUtility.printStr(
        "           BANK TEST     \n", null);
    await FlutterPaxPrinterUtility.setDoubleWidth(false, false);
    await FlutterPaxPrinterUtility.setDoubleHeight(false, false);
    await FlutterPaxPrinterUtility.printStr("\n", null);
    await FlutterPaxPrinterUtility.printStr(
        "STAN   : 123456123        \n", null);
    await FlutterPaxPrinterUtility.printStr(
        "MID    : 0812393          \n", null);
    await FlutterPaxPrinterUtility.printStr(
        "REFF   : 1023701923701    \n", null);
    await FlutterPaxPrinterUtility.printStr("\n\n", null);
    await FlutterPaxPrinterUtility.printStr(
        "Amount :               100.000\n", null);
    await FlutterPaxPrinterUtility.printStr(
        "Tip    :                     0\n", null);
    await FlutterPaxPrinterUtility.printStr(
        "- - - - - - - - - - - - - - - \n", null);
    await FlutterPaxPrinterUtility.printStr(
        "Total  :               100.000\n", null);
    await FlutterPaxPrinterUtility.printStr("\n", null);
    await FlutterPaxPrinterUtility.printStr(
        "       NO SIGN REQUIRED   \n", null);
    await FlutterPaxPrinterUtility.printStr(
        "    ** Payment Success **  \n", null);
    await FlutterPaxPrinterUtility.printStr("\n", null);
    await FlutterPaxPrinterUtility.printStr(
        " FOR DEVELOPMENT PURPOSE ONLY\n", null);
    await FlutterPaxPrinterUtility.printStr("\n\n\n\n", null);
    await FlutterPaxPrinterUtility.step(10);
    await FlutterPaxPrinterUtility.start();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Pax Printer Utitlity - Git Example'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Text(
              'Running on: $_platformVersion\n',
              textAlign: TextAlign.center,
            ),
            FutureBuilder(
                future: FlutterPaxPrinterUtility.getSN(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text('SN: ${snapshot.data}',
                        textAlign: TextAlign.center);
                  } else {
                    return const Text('SN: Loading...',
                        textAlign: TextAlign.center);
                  }
                }),
            statusPrinter == '1'
                ? const Text(
                    'Status Printer: Connected',
                    textAlign: TextAlign.center,
                  )
                : const Text(
                    'Status Printer: Disconnected',
                    textAlign: TextAlign.center,
                  ),
            const Divider(),
            ElevatedButton(
              onPressed: () async {
                await FlutterPaxPrinterUtility.printReceipt(
                    "TEST PRINT\n\nOK SUCCESS PRINTING\n\n");
              },
              child: const Text("TEST PRINT RECEIPT"),
            ),
            ElevatedButton(
              onPressed: () => printQrCode(),
              child: const Text("TEST PRINT WITH QRCODE"),
            ),
            ElevatedButton(
              onPressed: _manualPrintWithBitmap,
              child: const Text("TEST PRINT RECEIPT FROM SCRATCH"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScannerView())),
              child: const Text("TEST SCANNER"),
            ),
          ],
        ),
      ),
    );
  }
}