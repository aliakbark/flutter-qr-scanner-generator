import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gismachinetest/src/app_localizations.dart';
import 'package:gismachinetest/src/blocs/qr_bloc.dart';
import 'package:gismachinetest/src/utilities/constants.dart';
import 'package:gismachinetest/src/utilities/ui_helper.dart';
import 'package:gismachinetest/src/utilities/widgets/qr_generator.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final TextEditingController _phoneController = TextEditingController();

  final QRBloc _bloc = QRBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('qr')),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder(
            stream: _bloc.phone,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    textAlign: TextAlign.start,
                    controller: _phoneController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .translate('phone_input_hint'),
                        errorText: snapshot.hasError
                            ? AppLocalizations.of(context)
                                .translate('phone_input_error')
                            : null,
                        helperText: AppLocalizations.of(context)
                            .translate('phone_input_helper_text')),
                    onChanged: _bloc.changePhone,
                    keyboardType: TextInputType.phone,
                    onSubmitted: (text) {},
                  ),
                  verticalSpaceLarge,
                  RaisedButton(
                      color: snapshot.hasData
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                      child: Text(
                        AppLocalizations.of(context).translate('generate_qr'),
                        style: Theme.of(context).textTheme.button.copyWith(
                            color: snapshot.hasData
                                ? Colors.white
                                : Colors.white24),
                      ),
                      onPressed: () => snapshot.hasData ? _generateQR() : null),
                  verticalSpaceMassive,
                  StreamBuilder<String>(
                      stream: _bloc.scannedCode,
                      initialData: AppLocalizations.of(context)
                          .translate('scanner_initial_msg'),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasError
                              ? snapshot.error
                              : snapshot.data ?? '',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.body2.copyWith(
                              color: snapshot.hasError
                                  ? Colors.red
                                  : Colors.black),
                        );
                      }),
                ],
              );
            }),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _bloc.scan(),
        label: Text(AppLocalizations.of(context).translate('scan')),
        icon: Icon(Icons.settings_overscan),
      ),
    );
  }

  _generateQR() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) => QRGeneratorScreen(
        data: _bloc.getPhone ?? '',
      ),
    );
  }
}
