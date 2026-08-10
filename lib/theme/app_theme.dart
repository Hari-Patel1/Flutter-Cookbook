import 'package:flutter/material.dart';

class AppTheme {
  // Brand
  static const Color primary = Color(0xFFD9653B);
  static const Color secondary = Color(0xFFFFB74D);

  // Surfaces
  static const Color lightBackground = Color(0xFFFBF8F3);
  static const Color darkBackground = Color(0xFF171513);

  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF24211E);

  // Text
  static const Color darkText = Color(0xFF292522);
  static const Color lightText = Color(0xFFF7F3EE);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: primary,
      secondary: secondary,
      surface: lightSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,

      scaffoldBackgroundColor: lightBackground,

      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: darkText,
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: lightSurface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurface,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: primary,
            width: 2,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        backgroundColor: Colors.transparent,
        elevation: 0,
        indicatorColor: const Color(0xFFF0E3D8),

        labelTextStyle: WidgetStateProperty.resolveWith(
              (states) {
            final selected = states.contains(WidgetState.selected);

            return TextStyle(
              fontSize: 12,
              fontWeight: selected
                  ? FontWeight.w600
                  : FontWeight.w500,
              color: selected
                  ? const Color(0xFF9B573C)
                  : const Color(0xFF77706A),
            );
          },
        ),

        iconTheme: WidgetStateProperty.resolveWith(
              (states) {
            final selected = states.contains(WidgetState.selected);

            return IconThemeData(
              color: selected
                  ? const Color(0xFF9B573C)
                  : const Color(0xFF77706A),
              size: 23,
            );
          },
        ),
      ),

    );
  }

  static ThemeData get dark {
    const darkPrimary = Color(0xFFD17A58);
    const darkSecondary = Color(0xFFE5A15C);

    const darkBackground = Color(0xFF171615);
    const darkSurface = Color(0xFF22201E);
    const darkSurfaceVariant = Color(0xFF2A2825);

    const darkText = Color(0xFFF4F0EB);
    const darkSecondaryText = Color(0xFFA8A19A);

    final scheme = ColorScheme.fromSeed(
      seedColor: darkPrimary,
      brightness: Brightness.dark,
    ).copyWith(
      primary: darkPrimary,
      secondary: darkSecondary,
      surface: darkSurface,
      surfaceContainer: darkSurface,
      surfaceContainerHighest: darkSurfaceVariant,
      onSurface: darkText,
      onSurfaceVariant: darkSecondaryText,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,

      scaffoldBackgroundColor: darkBackground,

      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: darkText,
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: darkSurface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: darkPrimary,
            width: 2,
          ),
        ),

        hintStyle: const TextStyle(
          color: darkSecondaryText,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          backgroundColor: darkPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        backgroundColor: Colors.transparent,
        elevation: 0,

        // Very subtle selected-state background
        indicatorColor: const Color(0xFF332B26),

        labelTextStyle: WidgetStateProperty.resolveWith(
              (states) {
            final selected =
            states.contains(WidgetState.selected);

            return TextStyle(
              fontSize: 12,
              fontWeight: selected
                  ? FontWeight.w600
                  : FontWeight.w500,
              color: selected
                  ? darkPrimary
                  : darkSecondaryText,
            );
          },
        ),

        iconTheme: WidgetStateProperty.resolveWith(
              (states) {
            final selected =
            states.contains(WidgetState.selected);

            return IconThemeData(
              color: selected
                  ? darkPrimary
                  : darkSecondaryText,
              size: 23,
            );
          },
        ),
      ),
    );
  }
}