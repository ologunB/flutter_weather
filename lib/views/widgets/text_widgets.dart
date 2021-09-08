import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';

Widget regularText(
  String text, {
  Color color,
  double fontSize,
  double letterSpacing,
  TextAlign textAlign,
  int maxLines,
  TextOverflow overflow,
  TextDecoration decoration,
  FontWeight fontWeight,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: GoogleFonts.overpass(
        color: color,
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        shadows: [BoxShadow(color: AppColors.textGrey)],
        fontWeight: fontWeight,
        decoration: decoration),
  );
}
