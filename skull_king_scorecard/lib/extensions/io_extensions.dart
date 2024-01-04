import 'dart:io';

import 'package:path/path.dart' as p;

extension DirectoryExtras on Directory {
  File entryWithName(String name) => File(p.join(path, name));

  Future<Directory> createSubDir(String name) {
    final subDirPath = p.join(path, name);
    return Directory(subDirPath).create();
  }
}
