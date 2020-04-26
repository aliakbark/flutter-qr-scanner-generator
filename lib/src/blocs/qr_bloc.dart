import 'package:gismachinetest/src/blocs/base_bloc.dart';
import 'package:gismachinetest/src/utilities/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QRBloc extends Object with Validators implements BaseBloc {
  final _phone = BehaviorSubject<String>();
  final _scannedCode = PublishSubject<String>();

  // Add data to stream, validate inputs
  Stream<String> get phone => _phone.stream.transform(validatePhone);

  Stream<String> get scannedCode => _scannedCode.stream;

  // get value
  String get getPhone => _phone.value;

// change data
  Function(String) get changePhone => _phone.sink.add;

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      _scannedCode.sink.add(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        _scannedCode.sink
            .addError('The user did not grant the camera permission!');
      } else {
        _scannedCode.sink.addError('Unknown error: $e');
      }
    } on FormatException {
      _scannedCode.sink.addError(
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      _scannedCode.sink.addError('Unknown error: $e');
    }
  }

  @override
  void dispose() async {
    await _phone.drain();
    _phone.close();
    await _scannedCode.drain();
    _scannedCode.close();
  }
}
