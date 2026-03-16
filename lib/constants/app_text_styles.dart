import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ── Display ─────────────────────────────────────────────────────────────
  static final displayLarge = GoogleFonts.poppins(
    fontSize: 42,
    fontWeight: FontWeight.w800,
    color: AppColors.textColor,
    height: 1.15,
    letterSpacing: -0.5,
  );

  static final displayMedium = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
    height: 1.2,
  );

  // ── Headings ─────────────────────────────────────────────────────────────
  static final headingLarge = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
  );

  static final headingMedium = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static final headingSmall = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  // ── Body ─────────────────────────────────────────────────────────────────
  static final bodyLarge = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );

  static final bodyMedium = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );

  static final bodySmall = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // ── Label ────────────────────────────────────────────────────────────────
  static final labelLarge = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
    letterSpacing: 0.4,
  );

  static final labelMedium = GoogleFonts.nunito(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
    letterSpacing: 0.4,
  );

  static final labelSmall = GoogleFonts.nunito(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.6,
  );

  // ── Button ───────────────────────────────────────────────────────────────
  static final button = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  // ── Caption / Hint ───────────────────────────────────────────────────────
  static final caption = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final hint = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // ── Link ─────────────────────────────────────────────────────────────────
  static final link = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColor,
  );
}