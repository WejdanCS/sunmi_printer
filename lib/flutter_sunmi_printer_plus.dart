import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'column_maker.dart';
import 'enums.dart';
import 'sunmi_style.dart';

class SunmiPrinter {
  static bool isConnected = false;

  static const MethodChannel _channel = MethodChannel('flutter_sunmi_printer_plus');

  static Future<bool?> initPrinter() async {
    bool? res;
    try {
      res = await _channel.invokeMethod('initPrinter');
      if (res != null && res == true) {
        isConnected = res;
        return isConnected;
      } else {
        res = await _channel.invokeMethod('initPrinter');
        isConnected = res ?? false;
        return isConnected;
      }
    } on PlatformException {
      throw ("Platform Error: this plugin is unSupported");
    } catch (err) {
      throw ("Printer is not Connected");
    }
  }

  static Future<String> getVersion() async {
    if (!SunmiPrinter.isConnected) throw ("Printer is not connect");
    String version = await _channel.invokeMethod('getVersion');
    return version;
  }

  static Future<void> setBold(bool? isBold) async {
    if (!SunmiPrinter.isConnected) throw ("Printer is not connect");
    await _channel.invokeMethod('setBold', {"isBold": isBold});
  }

  static Future<void> setUnderline(bool? isUnderline) async {
    if (!SunmiPrinter.isConnected) throw ("Printer is not connect");
    await _channel.invokeMethod('setUnderline', {"isUnderline": isUnderline});
  }

  static Future<void> setFontSize(int? fontSize) async {
    if (!SunmiPrinter.isConnected) throw ("Printer is not connect");
    await _channel.invokeMethod('setFontSize', {"size": fontSize});
  }

  static Future<String> getDeviceModel() async {
    if (!SunmiPrinter.isConnected) throw ("Printer is not connect");
    String model = await _channel.invokeMethod('getDeviceModel');
    return model;
  }

  static Future<void> printText({required String content, required SunmiStyle style}) async {
    try {
      if (SunmiPrinter.isConnected) {
        await _channel.invokeMethod('printText',
            {"content": content, "size": style.fontSize, "isBold": style.bold, "isUnderLine": style.isUnderLine, "align": style.align?.index});
      } else {
        throw ("Printer is not connect");
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> printImage({required Uint8List image, required SunmiPrintAlign align}) async {
    try {
      if (SunmiPrinter.isConnected) {
        await _channel.invokeMethod('printImage', {"image": image, "align": align.index});
      } else {
        throw ("Printer is not connect");
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> printQr(
      {required String data,
      int size = 5,
      SunmiQrcodeLevel errLevel = SunmiQrcodeLevel.LEVEL_H,
      SunmiPrintAlign align = SunmiPrintAlign.CENTER}) async {
    try {
      if (SunmiPrinter.isConnected) {
        await _channel.invokeMethod('printQr', {"data": data, "size": size, "errorLevel": errLevel.index, "align": align.index});
      } else {
        throw ("Printer is not connect");
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> printBarCode(
      {required String data,
      SunmiBarcodeType barcodeType = SunmiBarcodeType.CODE128,
      height = 50,
      width = 2,
      SunmiBarcodeTextPos textPosition = SunmiBarcodeTextPos.TEXT_UNDER,
      SunmiPrintAlign align = SunmiPrintAlign.CENTER}) async {
    try {
      if (SunmiPrinter.isConnected) {
        await _channel.invokeMethod('printBarCode', {
          "data": data,
          "symbology": barcodeType.index,
          "height": height,
          "width": width,
          "textPosition": textPosition.index,
          "align": align.index
        });
      } else {
        throw ("Printer is not connect");
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> printTable({required List<ColumnMaker> cols}) async {
    try {
      if (SunmiPrinter.isConnected) {
        final List<Map<String, String>> _jsonCols = List<Map<String, String>>.from(cols.map<Map<String, String>>((ColumnMaker col) => col.toJson()));
        await _channel.invokeMethod('printTable', {"cols": json.encode(_jsonCols)});
      } else {
        throw ("Printer is not connect");
      }
    } catch (err) {
      rethrow;
    }
  }

  // skip lines
  static Future<void> lineWrap(int lines) async {
    try {
      if (SunmiPrinter.isConnected) {
        await _channel.invokeMethod('lineWrap', {"lineNumber": lines});
      } else {
        throw ("Printer is not connect");
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> setAlignment({required SunmiPrintAlign align}) async {
    try {
      if (SunmiPrinter.isConnected) {
        await _channel.invokeMethod('setAlignment', {"align": 0});
      } else {
        throw ("Printer is not connect");
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> feedPaper() async {
    try {
      await _channel.invokeMethod('feedPaper');
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> cutPaper() async {
    try {
      await _channel.invokeMethod('cutPaper');
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> disconnect() async {
    try {
      await _channel.invokeMethod('disconnect');
    } catch (err) {
      rethrow;
    }
  }

  static Future<String> getPrinterSerialNo() async {
    try {
      String serialNo = await _channel.invokeMethod('getPrinterSerialNo');
      return serialNo;
    } catch (err) {
      rethrow;
    }
  }

  static Future<String> getPrinterPaper() async {
    try {
      String paper = await _channel.invokeMethod('getPrinterPaper');
      return paper;
    } catch (err) {
      rethrow;
    }
  }

  static Future<bool> isBlackLabelMode() async {
    try {
      bool isBlack = await _channel.invokeMethod('isBlackLabelMode');
      return isBlack;
    } catch (err) {
      rethrow;
    }
  }

  static Future<bool> isLabelMode() async {
    try {
      bool isLabelMode = await _channel.invokeMethod('isLabelMode');
      return isLabelMode;
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> openCashBox() async {
    try {
      await _channel.invokeMethod('openCashBox');
    } catch (err) {
      rethrow;
    }
  }
}
