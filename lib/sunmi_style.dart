import 'enums.dart';

class SunmiStyle {
  double? fontSize;
  SunmiPrintAlign? align;
  bool? bold;
  bool? isUnderLine;

  SunmiStyle({this.fontSize = 24, this.align = SunmiPrintAlign.LEFT, this.bold = false, this.isUnderLine = false});
}
