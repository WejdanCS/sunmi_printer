import 'enums.dart';

class ColumnMaker {
  String text;
  double? width;
  SunmiPrintAlign? align;

  ColumnMaker({required this.text, this.width = 5, this.align = SunmiPrintAlign.LEFT});

  //Convert to json
  Map<String, String> toJson() {
    int value = 0;
    switch (align) {
      case SunmiPrintAlign.LEFT:
        value = 0;
        break;
      case SunmiPrintAlign.CENTER:
        value = 1;
        break;
      case SunmiPrintAlign.RIGHT:
        value = 2;
        break;
      default:
        value = 0;
    }
    return {
      "text": text,
      "width": width.toString(),
      "align": value.toString(),
    };
  }
}
