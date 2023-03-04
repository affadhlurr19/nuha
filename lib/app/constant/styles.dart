import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color backgroundColor1 = Color(0XFFFFFFFF);
const Color backgroundColor2 = Color(0XFFF8F8F8);
const Color titleColor = Color(0XFF1E3833);
const Color buttonColor1 = Color(0XFF53998B);
const Color buttonColor2 = Color(0XFFFFCB24);
const Color grey50 = Color(0XFFF1F1F1);
const Color grey100 = Color(0XFFE1E1E1);
const Color grey400 = Color(0XFF919191);
const Color grey500 = Color(0XFF717171);
const Color grey900 = Color(0XFF1F1F1F);

final myTextTheme = TextTheme(
    headline1: GoogleFonts.jost(
        fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: -1.5),
    headline2: GoogleFonts.jost(fontSize: 28, fontWeight: FontWeight.w600),
    headline3: GoogleFonts.jost(fontSize: 22, fontWeight: FontWeight.w600),
    headline4: GoogleFonts.jost(fontSize: 17, fontWeight: FontWeight.normal),
    subtitle1: GoogleFonts.jost(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.15), //titleLarge//
    bodyText1: GoogleFonts.jost(fontSize: 20, letterSpacing: 0.5),
    bodyText2: GoogleFonts.jost(fontSize: 15),
    button: GoogleFonts.jost(fontSize: 17, fontWeight: FontWeight.w600),
    caption: GoogleFonts.jost(fontSize: 12, letterSpacing: 0.4),
    overline: GoogleFonts.jost(fontSize: 10, letterSpacing: 1.5) //bodySmall//
    );
