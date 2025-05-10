import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(
      {super.key, required this.text, this.textAlignment, this.textColor});
  final String text;
  final TextAlign? textAlignment;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlignment ?? TextAlign.left,
      style: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.bodyMedium,
          color: textColor ?? AppColors.textColor),
    );
  }
}

class StyledTitle extends StatelessWidget {
  const StyledTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style:
          GoogleFonts.kanit(textStyle: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class StyledHeading extends StatelessWidget {
  const StyledHeading(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(),
        style: GoogleFonts.kanit(
          textStyle: Theme.of(context).textTheme.headlineMedium,
        ));
  }
}
