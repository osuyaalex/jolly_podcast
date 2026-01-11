import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/utility/sizes.dart';
import 'iacolors.dart';

class IATheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: IAColors.primary),
      useMaterial3: true,
      primaryColor: IAColors.primary,
      primaryColorLight: IAColors.primary_20,
      primaryColorDark: IAColors.primary_dark,
      scaffoldBackgroundColor: IAColors.veryLightGrey,
      textTheme: TextTheme(
        titleLarge: GoogleFonts.nunitoSans(
          color: IAColors.black,
          fontSize: 8.pW,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.nunitoSans(
          color: IAColors.black,
          fontSize: 6.pW,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: GoogleFonts.nunitoSans(
          color: IAColors.black,
          fontSize: 4.5.pW,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.nunitoSans(
          color: IAColors.black,
          fontSize: 3.5.pW,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.nunitoSans(
          color: IAColors.black,
          fontSize: 4.5.pW,
          fontWeight: FontWeight.bold,
        ),

        displayLarge: GoogleFonts.nunitoSans(
          color: IAColors.black,
          fontSize: 6.pW,
          fontWeight: FontWeight.bold,
        ),

        bodyLarge: GoogleFonts.nunitoSans(
          color: IAColors.black,
          fontSize: 8.pW,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: GoogleFonts.nunitoSans(
          color: IAColors.black,
          fontSize: 6.pW,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: GoogleFonts.nunitoSans(
          color: IAColors.black,
          fontSize: (4.5).pW,
          fontWeight: FontWeight.normal,
        ),
      ),
      //no chip border
      chipTheme: ChipThemeData(
        backgroundColor: IAColors.primary_20,
        labelStyle: GoogleFonts.nunitoSans(
          color: IAColors.darkGrey,
          fontSize: 4.5.pW,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      buttonTheme: ButtonThemeData(
        buttonColor: IAColors.primary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(IAColors.black),
          backgroundColor: WidgetStateProperty.all(IAColors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(IAColors.black),
            backgroundColor: WidgetStateProperty.all(IAColors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: IAColors.black,
        contentTextStyle: GoogleFonts.nunitoSans(
          color: IAColors.white,
          fontSize: 4.5.pW,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(IAColors.white),
          backgroundColor: WidgetStateProperty.all(IAColors.primary),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: IAColors.darkGrey,
        size: 8.pW,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: IAColors.primary,
        selectionColor: IAColors.primary_20,
        selectionHandleColor: IAColors.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:Colors.grey.shade400),
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400), // transparent
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400), // transparent
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        fillColor: IAColors.grey,
        hintStyle: GoogleFonts.nunitoSans(
          color: IAColors.darkGrey,
          fontSize: 4.5.pW,
          fontWeight: FontWeight.normal,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 5.pW,
          vertical: 2.pH,
        ),

        labelStyle: GoogleFonts.nunitoSans(

          color: IAColors.white,
          fontSize: 3.5.pW,
          fontWeight: FontWeight.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(

        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.all(2)),

          foregroundColor: WidgetStateProperty.all(IAColors.black),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),


      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: IAColors.black,
          fontSize: 5.8.pW,
          fontWeight: FontWeight.w400,

        ),
      ),

    );
  }
}
final TextStyle inputText = GoogleFonts.nunitoSans(
  fontSize: 4.5.pW,
);
