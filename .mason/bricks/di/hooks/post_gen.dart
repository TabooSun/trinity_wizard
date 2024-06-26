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

import 'constant.dart';

void run(HookContext context) {
  context.dumpVariables();

  final String serviceName =
      '${(context.vars[DiConstant.nameKey] as String).pascalCase}${(context.vars[DiConstant.suffixKey] as String).pascalCase}';
  final List<String> implementations =
      (context.vars[DiConstant.implementationsKey] as List<dynamic>?)
              ?.cast<Map<String, dynamic>>()
              .map(
            (Map<String, dynamic> entry) =>
                entry[DiConstant.implementationsKeyKey] as String,
          )
              .toList() ??
          <String>[];

  final StringBuffer sb = StringBuffer();
  sb.writeln('You may copy the following code to your binding file:');

  void writeBindingCode() {
    if (implementations.isEmpty) {
      sb.writeln();
      _writeImplementation(
        sb: sb,
        implementation: null,
        serviceName: serviceName,
      );
    }
    for (final String implementation in implementations) {
      _writeImplementation(
        sb: sb,
        implementation: implementation,
        serviceName: serviceName,
      );
    }
  }

  writeBindingCode();
  context.logger.info(sb.toString());
}

void _writeImplementation({
  required StringBuffer sb,
  required String? implementation,
  required String serviceName,
}) {
  /* Example:
  Get.lazyPut<AppointmentRepositoryService>(
    () => MockAppointmentRepositoryService(),
  );
  */
  if (implementation != null) {
    sb.writeln('/// ${implementation} implementation:');
  }
  sb.writeln(
    'Get.lazyPut<${serviceName}>(',
  );
  sb.writeln(
    '\t() => ${implementation?.pascalCase ?? ''}${serviceName}(),',
  );
  sb.writeln(');');
  sb.writeln();
}
