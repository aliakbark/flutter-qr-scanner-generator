import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gismachinetest/src/utilities/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// for generating Qr code
/// show the  Qr in a dialog box
class QRGeneratorScreen extends StatefulWidget {
  final String data;

  QRGeneratorScreen({@required this.data});

  @override
  State<StatefulWidget> createState() => QRGeneratorScreenState();
}

class QRGeneratorScreenState extends State<QRGeneratorScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.close,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                  QrImage(
                    data: widget.data,
                    version: QrVersions.auto,
                    size: 200.0,
                    gapless: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '${Constants.QR_GENERATOR_TEXT} for ${widget.data}',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.body2,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
