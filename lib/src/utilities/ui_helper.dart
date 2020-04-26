import 'package:flutter/widgets.dart';

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

const Widget verticalSpaceTiny = SizedBox(height: 6.0);
const Widget verticalSpaceSmall = SizedBox(height: 12.0);
const Widget verticalSpaceMedium = SizedBox(height: 24.0);
const Widget verticalSpaceLarge = SizedBox(height: 56.0);
const Widget verticalSpaceMassive = SizedBox(height: 128.0);
