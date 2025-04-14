import 'package:cassiopee_couture_app/src/newVersionCheck/newVersionCheck.dart'
    show executeSteps;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'database/database.dart';
import 'database/seed.dart';
// import 'dart:io';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Nécessaire pour utiliser les plugins natifs avant runApp
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  executeSteps();
  try {
    // Créer une nouvelle instance de la base de données
    final database = AppDatabase();
    final seeder = DatabaseSeeder(database);

    // Supprimer complètement la base de données
    await seeder.deleteDatabase();

    // Recréer et initialiser la base de données
    await seeder.seedDatabase();
    await seeder.seedTodayTasks();
    print('Base de données créée avec succès');

    // Afficher le chemin
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dbFolder.path, 'location_vetements.db');
    print('Chemin de la base de données: $dbPath');

    runApp(MyApp(
      settingsController: settingsController,
      database: database,
    ));
  } catch (e) {
    print('Erreur lors de l\'initialisation de la base de données: $e');
  }
}
