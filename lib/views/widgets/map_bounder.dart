import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double x0, x1, y0, y1;
    for (final LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) {
          x1 = latLng.latitude;
        }
        if (latLng.latitude < x0) {
          x0 = latLng.latitude;
        }
        if (latLng.longitude > y1) {
          y1 = latLng.longitude;
        }
        if (latLng.longitude < y0) {
          y0 = latLng.longitude;
        }
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec = await ui
        .instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  ///returns the path for icons to match various screen sizes
  static String getDPISpecificDirectoryFromPath(
      {String prefix, String fileName, double pixelRatio}) {
    String directory = '/xhdpi/';
    if (!Platform.isIOS) {
      if (pixelRatio >= 2.5) {
        directory = '/xxxhdpi/';
      } else if (pixelRatio >= 1.5) {
        directory = '/xxhdpi/';
      } else if (pixelRatio >= 0.5) {
        directory = '/xhdpi/';
      }
    }
    return '$prefix$directory$fileName';
  }

  static Future<BitmapDescriptor> getMarkerIcon(String iconName,
      {@required double pixelRatio}) async {
    var icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: pixelRatio),
      getDPISpecificDirectoryFromPath(
          fileName: iconName, prefix: "images/markers", pixelRatio: pixelRatio),
    );
    return icon;
  }
}
