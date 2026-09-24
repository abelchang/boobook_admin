import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTheme {
  /// for getting light theme
  ThemeData get lightTheme {
    return ThemeData();
  }

  /// for getting dark theme
  ThemeData get darkTheme {
    return ThemeData();
  }
}

/// for providing app theme [AppTheme]
final appThemeProvider = Provider<AppTheme>((_) => AppTheme());
