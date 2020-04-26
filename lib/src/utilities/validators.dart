import 'dart:async';

import 'constants.dart';

///validators  for stream
///if the validation satisfy then data will be added in stream else add error in stream
class Validators {
  final validatePhone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (RegExp(r"^(?:[+0]+)?[0-9]{10,13}$").hasMatch(phone)) {
      sink.add(phone);
    } else {
      sink.addError(Constants.INVALID_MOBILE_NUM);
    }
  });
}
