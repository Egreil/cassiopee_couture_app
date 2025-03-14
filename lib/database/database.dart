import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' if (dart.library.html) 'dart:html';
import 'connection/connection.dart'
    if (dart.library.html) 'connection/web.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Vetements,
  Photos,
  Reservations,
  Cautions,
  Acomptes,
  Clients,
  RendezVous,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.deleteTable('rendez_vous');
            await m.createTable(rendezVous);
          }
        },
        beforeOpen: (details) async {
          if (details.wasCreated) {
            print('Base de données créée avec succès');
          }
          if (details.hadUpgrade) {
            print('Base de données mise à jour avec succès');
          }
        },
      );

  Future<void> clearDatabase() async {
    await transaction(() async {
      // Supprimer dans l'ordre inverse des dépendances
      await delete(rendezVous).go();
      await delete(acomptes).go();
      await delete(cautions).go();
      await delete(reservations).go();
      await delete(photos).go();
      await delete(vetements).go();
      await delete(clients).go();
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
