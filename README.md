# flutter_pax_printer_utility

This Flutter plugin is based on the PAX NeptuneLite API SDK and provides a simple interface to print on PAX terminal devices. Currently supports Android only.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_pax_printer_utility:
  git:
    url: git@github.com:bazookon/flutter_pax_printer_utility.git
    ref: main/
```

Or run:

```bash
flutter pub add flutter_pax_printer_utility
```

### Android setup

In your `android/app/build.gradle`, ensure `minifyEnabled` and `shrinkResources` are disabled for release builds:

```groovy
buildTypes {
    release {
        ...
        minifyEnabled false
        shrinkResources false
    }
}
```

**Important:** In your `android/app/src/main/AndroidManifest.xml`, ensure that `android:taskAffinity=""` is **not** present in the `<activity>` tag. This attribute interferes with the PAX DAL initialization and will cause the plugin to fail with null pointer exceptions.

```xml
<!-- ❌ This will cause DAL initialization to fail -->
<activity
    android:name=".MainActivity"
    android:taskAffinity=""
    ... />

<!-- ✅ Correct configuration -->
<activity
    android:name=".MainActivity"
    ... />
```

## Getting started in your app

Import the plugin:

```dart
import 'package:flutter_pax_printer_utility/flutter_pax_printer_utility.dart';
```

Initialize the printer before use:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? initSuccess = await FlutterPaxPrinterUtility.init;
  if (initSuccess == true) {
    // Now ready to print
  }
  runApp(MyApp());
}
```

## Usage

All methods return a `Future` and should be awaited. A complete list of available methods:

- `FlutterPaxPrinterUtility.platformVersion`: get Android OS version.
- `FlutterPaxPrinterUtility.init`: initialize printer (returns `bool?`).
- `FlutterPaxPrinterUtility.getStatus`: get printer status (`PrinterStatus` enum).
- `FlutterPaxPrinterUtility.printReceipt(String text)`: print a text receipt.
- `FlutterPaxPrinterUtility.printReceiptWithQr(String text, String qrString)`: print receipt with a QR code.
- `FlutterPaxPrinterUtility.printQRReceipt(String text1, String text2, String text3, String text4, String qrString)`: print template receipt with multiple lines and a QR code.
- `FlutterPaxPrinterUtility.fontSet(EFontTypeAscii asciiFontType, EFontTypeExtCode cFontType)`: set ASCII and extended font types.
- `FlutterPaxPrinterUtility.spaceSet(int wordSpace, int lineSpace)`: set word and line spacing.
- `FlutterPaxPrinterUtility.printStr(String text, String? charset)`: print a string with optional charset.
- `FlutterPaxPrinterUtility.step(int step)`: advance printer by steps.
- `FlutterPaxPrinterUtility.printBitmap(Uint8List bitmap)`: print a bitmap image.
- `FlutterPaxPrinterUtility.printImageUrl(String url)`: download and print image from URL.
- `FlutterPaxPrinterUtility.printImageAsset(String assetPath)`: load and print image from Flutter assets.
- `FlutterPaxPrinterUtility.printQRCode(String text, int width, int height)`: print a QR code.
- `FlutterPaxPrinterUtility.leftIndents(int indent)`: set left indentation.
- `FlutterPaxPrinterUtility.start()`: start printing buffered data (returns status `String`).
- `FlutterPaxPrinterUtility.getDotLine()`: get number of printable lines per page (`int?`).
- `FlutterPaxPrinterUtility.setGray(int level)`: set gray level.
- `FlutterPaxPrinterUtility.setDoubleWidth(bool isAscDouble, bool isLocalDouble)`: enable/disable double width.
- `FlutterPaxPrinterUtility.setDoubleHeight(bool isAscDouble, bool isLocalDouble)`: enable/disable double height.
- `FlutterPaxPrinterUtility.setInvert(bool isInvert)`: enable/disable invert mode.
- `FlutterPaxPrinterUtility.cutPaper(int mode)`: cut paper (0 full cut, 1 partial cut).
- `FlutterPaxPrinterUtility.getSN()`: get printer serial number.
- `FlutterPaxPrinterUtility.scan()`: start scanner once (returns `String?`).
- `FlutterPaxPrinterUtility.scanStream`: receive continuous scan results as a `Stream<String>`.

### Example: Print a simple receipt

```dart
await FlutterPaxPrinterUtility.init;
String? status = await FlutterPaxPrinterUtility.printReceipt("Hello Pax Printer!");
print("Printer responded: \$status");
```

### Example: Scan with built-in scanner

```dart
// Listen for scanned data
final subscription = FlutterPaxPrinterUtility.scanStream.listen((code) {
  print("Scanned: \$code");
});
// Start scanner
await FlutterPaxPrinterUtility.scan();
// Later, cancel subscription
await subscription.cancel();
```

## Tested devices

- PAX A920
- PAX A910S

## Contributing

See [CHANGELOG.md](CHANGELOG.md) for release notes and updates.

## License

[MIT](LICENSE)
