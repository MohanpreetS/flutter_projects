import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sh_colors.dart';

abstract class SHTheme {
  static ThemeData dark = ThemeData(
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.gruppo(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: SHColors.textColor,
        ),
        bodyMedium: GoogleFonts.gruppo(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: SHColors.textColor,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: SHColors.textColor,
        ),
        displayLarge: GoogleFonts.buda(
          fontSize: 70,
          color: SHColors.textColor,
        ),
        displayMedium: GoogleFonts.buda(
          fontSize: 50,
          color: SHColors.textColor,
        ),
        displaySmall: GoogleFonts.buda(
          fontSize: 40,
          color: SHColors.textColor,
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(color: SHColors.textColor),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ));
}
