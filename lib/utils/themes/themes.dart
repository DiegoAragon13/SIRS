import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApp {
  ThemeApp._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    splashColor: Colors.transparent,
    brightness: Brightness.light,
    primaryColor: const Color(0xFF660B05), // Guinda principal
    shadowColor: const Color.fromARGB(30, 0, 0, 0),
    scaffoldBackgroundColor: const Color(0xFFFFF0C4), // Beige
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF660B05),
      secondary: Color(0xFFF0C4), // Beige suave
      tertiary: Color(0xFF8C1007), // Guinda claro
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14,
        color: Color(0xFF3E0703), // Guinda oscuro para textos
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: Color(0xFF660B05), // Guinda principal
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    splashColor: Colors.transparent,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF660B05),
    scaffoldBackgroundColor: const Color(0xFF3E0703), // Guinda oscuro
    shadowColor: const Color.fromARGB(39, 0, 0, 0),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF660B05),
      secondary: Color(0xFF8C1007), // Guinda claro
      tertiary: Color(0xFFFFF0C4), // Beige
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14,
        color: Color(0xFFFFF0C4), // Beige para texto en oscuro
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: Color(0xFFFFF0C4),
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
