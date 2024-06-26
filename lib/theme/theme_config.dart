/*
 *
 * Copyright (C) 2024 taboosun
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * /
 *
 *
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trinity_wizard/theme/app_colors.dart';

class ThemeConfig {
  ThemeConfig._();

  static final ThemeData _light = _createLightTheme();

  static ThemeData get light {
    if (kDebugMode) {
      return _createLightTheme();
    }
    return _light;
  }

  static ThemeData _createLightTheme() => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColors.primary,
        appBarTheme: _appBarTheme.copyWith(
          foregroundColor: Colors.black,
          titleTextStyle: _appBarTheme.titleTextStyle!.copyWith(
            color: Colors.black,
          ),
        ),
      );

  static final ThemeData _dark = _createDarkTheme();

  static ThemeData get dark {
    if (kDebugMode) {
      return _createDarkTheme();
    }
    return _dark;
  }

  static ThemeData _createDarkTheme() => ThemeData.dark().copyWith(
        primaryColor: AppColors.primary,
        appBarTheme: _appBarTheme.copyWith(
          iconTheme: const IconThemeData(
            color: AppColors.white,
          ),
        ),
      );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18,
    ),
  );
}
