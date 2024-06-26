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

import 'dart:io';

import 'package:common/common.dart';
import 'package:mason/mason.dart';

import 'constant.dart';

void run(HookContext context) {
  final Directory currentDirectory = Directory.current;
  context.vars['importRoot'] =
      ImportPathResolver.getImportPath(currentDirectory: currentDirectory);

  context.replacePlaceholderNameWithDirectoryNameIfNeeded(
    currentDirectory: currentDirectory,
  );

  const String implementationKey = DiConstant.implementationsKey;
  context.vars[implementationKey] = _parseStringToMapEntries(
    variable: context.vars[implementationKey],
    key: implementationKey,
  ).toList();
  _removeVariableIfEmptyArray(context: context, key: implementationKey);
  _injectVariableExistenceBoolean(context: context, key: implementationKey);

  context.dumpVariables();
}

void _injectVariableExistenceBoolean({
  required HookContext context,
  required String key,
}) {
  final String existenceKey = 'has${key.pascalCase}';
  context.vars[existenceKey] = context.vars[key] != null;
}

/// Remove the variable of the given [key] if it is an empty array.
///
/// *** Arguments: ***
/// - context: The [HookContext] to be used.
/// - key: The key of the variable to be removed.
void _removeVariableIfEmptyArray({
  required HookContext context,
  required String key,
}) {
  final dynamic variable = context.vars[key];
  if (variable is! List) {
    throw Exception('Variable $key is not an array/list.');
  }

  context.logger.info('Variable $key is an array/list. Value: ${variable}');
  if (variable.isNotEmpty) {
    return;
  }

  context.vars.remove(key);
}

/// Parse string to list.
///
/// We support parsing both comma-separated and space-separated string where
/// comma-separated takes precedence if coexists.
///
/// *** Example: ***
/// - "a, b, c" => ["a", "b", "c"]
/// - "a b c" => ["a", "b", "c"]
///
/// *** Arguments: ***
/// - variable: The variable to be parsed to a list.
Iterable<Map<String, String>> _parseStringToMapEntries({
  required String key,
  required String variable,
}) sync* {
  if (variable.contains(',')) {
    yield* variable.splitVariableAndMap(
      separator: ',',
      key: key,
    );
    return;
  }

  if (variable.contains(' ')) {
    yield* variable.splitVariableAndMap(
      separator: ' ',
      key: key,
    );
    return;
  }

  if (variable.isEmpty) {
    return;
  }

  yield <String>[variable]
      .toMasonVariableMap(
        key: key,
      )
      .single;
}

extension _VariableSplittingExtension on String {
  Iterable<Map<String, String>> splitVariableAndMap({
    required String separator,
    required String key,
  }) {
    return split(separator).toMasonVariableMap(
      key: key,
    );
  }
}

extension _ToMasonVariableMapExtension on Iterable<String> {
  Iterable<Map<String, String>> toMasonVariableMap({
    required String key,
  }) {
    return map((e) => <String, String>{
          '${key}_key': e.trim(),
        });
  }
}

/// Normalize empty array argument.
///
/// We need this because Mason doesn't allow empty array variable, hence we use
/// ["?"] to represent empty array in `brick.yaml`. This function removes the
/// variable that contains such pattern.
///
/// *** Arguments: ***
/// - context: The context of the hook.
/// - key: The key of the variable to be normalized.
/*
void _normalizeEmptyArrayVariable({
  required HookContext context,
  required String key,
}) {
  final dynamic variable = context.vars[key];
  if (variable is! List) {
    throw Exception('Variable $key is not an array/list.');
  }

  // This is not a placeholder for empty array.
  if (!variable.contains('?')) {
    return;
  }

  if (variable.length >= 1) {
    context.logger.warn(
        'Trying to specify an array variable with more than one placeholder: `?`. This brick will still run as if this array variable value is an empty array.');
  }

  context.vars.remove(key);
}
*/
