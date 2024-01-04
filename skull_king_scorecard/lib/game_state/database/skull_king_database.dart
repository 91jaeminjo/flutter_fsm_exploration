import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:time_machine/time_machine.dart';

import '/extensions.dart';

import 'type_converters.dart' show InstantConverter;

part 'skull_king_database.g.dart';

typedef MigrationFunction = Future<void> Function(Migrator);

Future<File> skullKingDatabaseFile() async {
  return (await skullKingDatabaseFiles(mainOnly: true)).first;
}

Future<List<File>> skullKingDatabaseFiles({bool mainOnly = false}) async {
  final appDocs = await getApplicationDocumentsDirectory();
  final dbFolder = await Directory(p.join(appDocs.path, '.db')).create();
  final filenames = ['skull-king-db.sqlite'];
  if (!mainOnly) {
    filenames.addAll(['skull-king-db.sqlite-shm', 'skull-king-db.sqlite-wal']);
  }
  return [for (String name in filenames) File(p.join(dbFolder.path, name))];
}

@DriftDatabase(include: {'tables.drift'})
class SkullKingDatabase extends _$SkullKingDatabase {
  static const _dbName = 'skull-king-db';
  static const _ancillaryDbFileNames = [
    '$_dbName.sqlite-shm',
    '$_dbName.sqlite-wal'
  ];
  static const _primaryDbFileName = '$_dbName.sqlite';
  static const _allDbFileNames = [_primaryDbFileName, ..._ancillaryDbFileNames];

  SkullKingDatabase() : super(_connect());

  @override
  int get schemaVersion => 1;

  List<int> _versionsToMigrateTo(int from, int to) {
    return [for (var i = from; i < to; ++i) i + 1];
  }

  MigrationFunction _migrationToVersion(int version) {
    switch (version) {
      default:
        throw Exception('Migration missing for migrating to $version');
    }
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        // _log.fine('creating new skull king database.');
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // _log.info('upgrading skull king db from $from to $to');
        final versionsToMigrateTo = _versionsToMigrateTo(from, to);
        for (final migrateTo in versionsToMigrateTo) {
          // _log.fine('migrating to version $migrateTo...');
          await _migrationToVersion(migrateTo)(m);
          // _log.fine('migrating to version $migrateTo complete.');
        }
        // _log.info('migration steps complete.');
      },
    );
  }

  static LazyDatabase _connect() => LazyDatabase(
        () => _getPrimaryDbFilePath().then((value) {
          // _log.fine('skull king db stored at $value');
          return value;
        }).then((primaryDbFile) => _initDb(primaryDbFile)),
      );

  static NativeDatabase _initDb(File file) =>
      NativeDatabase(file, logStatements: false, setup: (db) {
        db.execute('PRAGMA journal_mode = WAL');
        db.execute('PRAGMA busy_timeout = 500');
        db.execute('PRAGMA foreign_keys = ON');
        // _log.fine('executed PRAGMA statements');
      });

  static Future<File> _getPrimaryDbFilePath() => _getOrCreateDatabaseDirectory()
      .then((dbDir) => dbDir.entryWithName(_primaryDbFileName));

  static Stream<File> _getDbFilePaths() =>
      _getOrCreateDatabaseDirectory().asStream().combineLatest<String, File>(
          Stream.fromIterable(_allDbFileNames),
          (dir, name) => dir.entryWithName(name));

  static Future<Directory> _getOrCreateDatabaseDirectory() =>
      getApplicationDocumentsDirectory()
          .then((appDocs) => p.join(appDocs.path, '.db'))
          .then((dbDirPath) => Directory(dbDirPath).create());

  static Future<String> getSkullKingDatabasePath() =>
      _getPrimaryDbFilePath().then((file) => file.path);

  static Future<void> erase() => _getDbFilePaths()
      .asyncWhere((aDbFile) => aDbFile.exists())
      .asyncMap((aDbFile) => aDbFile.delete())
      .toList();
}
