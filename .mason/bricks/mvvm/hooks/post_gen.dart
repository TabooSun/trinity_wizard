/*
 *
 * Copyright (C) 2023 taboosun
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

import 'package:common/common.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  context.dumpVariables();

  final String viewName = (context.vars[Constant.nameKey] as String).pascalCase;

  final StringBuffer sb = StringBuffer();
  _printRouteName(
    sb: sb,
    viewName: viewName,
  );
  _printRouteRegistrationCode(
    sb: sb,
    viewName: viewName,
  );
  context.logger.info(sb.toString());
}

void _printRouteRegistrationCode({
  required StringBuffer sb,
  required String viewName,
}) {
  /* Example:
  GetPage<dynamic>(
    name: RouteName.home,
    page: () => const HomeView(),
    binding: BindingsBuilder<HomeViewModel>(() {
      Get.lazyPut<HomeViewModel>(() => HomeViewModel(),);
    }),
  ),
  */
  sb.writeln();

  sb.writeln(_wrapAnsiGreenColor(
    message: 'Here is your route registration code:',
  ));
  sb.writeln();

  final String pascalCaseViewName = viewName.pascalCase;
  sb.writeln("GetPage<dynamic>(");
  sb.writeln("  name: RouteName.${viewName.camelCase},");
  sb.writeln("  page: () => const ${pascalCaseViewName}View(),");
  sb.writeln("  binding: BindingsBuilder<${pascalCaseViewName}ViewModel>(() {");
  sb.writeln(
      "    Get.lazyPut<${pascalCaseViewName}ViewModel>(() => ${pascalCaseViewName}ViewModel(),);");
  sb.writeln("  }),");
  sb.writeln("),");
}

void _printRouteName({
  required StringBuffer sb,
  required String viewName,
}) {
  sb.writeln();

  sb.writeln(_wrapAnsiGreenColor(
    message: 'Here is your route name:',
  ));
  sb.writeln();
  // Example: static const String home = '/home';
  final String camelCaseViewName = viewName.camelCase;
  sb.writeln(
      "static const String ${camelCaseViewName} = '/${camelCaseViewName}';");
}

String _wrapAnsiGreenColor({
  required String message,
}) {
  return '\x1B[32m$message\x1B[0m';
}
