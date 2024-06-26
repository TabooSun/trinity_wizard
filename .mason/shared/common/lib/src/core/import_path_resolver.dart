import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:pubspec_parse/pubspec_parse.dart';

class ImportPathResolver {
  static const String kPubspecYamlFileName = 'pubspec.yaml';

  static String _getProjectName({
    required Directory projectDirectory,
  }) {
    final Pubspec pubspecYaml = Pubspec.parse(
      File(path.joinAll([
        projectDirectory.path,
        kPubspecYamlFileName,
      ])).readAsStringSync(),
    );
    return pubspecYaml.name;
  }

  static String getImportPath({
    required Directory currentDirectory,
  }) {
    final Directory brickDirectory = currentDirectory;
    Directory parentDirectory = currentDirectory.parent;
    while (parentDirectory.path != currentDirectory.path) {
      if (currentDirectory.listSync(followLinks: false).any(
          (element) => path.basename(element.path) == kPubspecYamlFileName)) {
        final String projectName = _getProjectName(
          projectDirectory: currentDirectory,
        );
        return path.joinAll(<String>[
          projectName,
          ...path
              .split(path.relative(brickDirectory.path,
                  from: currentDirectory.path))
              .skip(1),
        ]);
      }
      currentDirectory = parentDirectory;
      parentDirectory = currentDirectory.parent;
    }

    throw Exception('Invalid Flutter project');
  }
}
