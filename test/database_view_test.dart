import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cassiopee_couture_app/database/database.dart';
import 'package:cassiopee_couture_app/database/tables.dart';
import 'package:cassiopee_couture_app/database/seed.dart';
import 'package:cassiopee_couture_app/src/menu/debug/database_view.dart';
import 'package:drift/native.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase database;
  late DatabaseSeeder seeder;

  setUp(() async {
    // Utiliser une base de données en mémoire pour les tests
    database = AppDatabase();
    seeder = DatabaseSeeder(database);
    await database.clearDatabase();
    await seeder.seedDatabase();
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('Vérification de la mise à jour des rendez-vous', (tester) async {
    print('Début du test');

    // Vérifier l'état initial de la base
    final initialDbRdv = await database.select(database.rendezVous).get();
    print('Nombre initial de RDV dans la base: ${initialDbRdv.length}');

    // Construire l'app
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DatabaseView(database: database),
      ),
    ));
    await tester.pumpAndSettle();
    print('App initialisée');

    // Aller sur l'onglet rendez-vous
    await tester.tap(find.text('Rendez-vous'));
    await tester.pumpAndSettle();
    print('Onglet rendez-vous sélectionné');

    // Attendre que les données soient chargées
    await tester.pump(const Duration(seconds: 1));

    // Compter le nombre initial de rendez-vous affichés
    final initialCards = find.byType(Card);
    final initialCount = initialCards.evaluate().length;
    print('Nombre initial de rendez-vous affichés: $initialCount');

    // Créer et insérer un nouveau rendez-vous
    final today = DateTime.now();
    final rdv = RendezVousCompanion.insert(
      idClient: 1,
      date: DateTime(today.year, today.month, today.day),
      heure: '14:00',
      duree: const Duration(minutes: 30),
      motif: MotifRendezVous.consultation,
    );

    await database.into(database.rendezVous).insert(rdv);
    print('Nouveau rendez-vous inséré dans la base');

    // Vérifier l'insertion dans la base
    final afterInsertDbRdv = await database.select(database.rendezVous).get();
    print(
        'Nombre de RDV dans la base après insertion: ${afterInsertDbRdv.length}');

    // Attendre la mise à jour de l'UI
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Recompter les rendez-vous affichés
    final finalCards = find.byType(Card);
    final finalCount = finalCards.evaluate().length;
    print('Nombre final de rendez-vous affichés: $finalCount');

    // Vérifier que le nombre a augmenté
    expect(finalCount, equals(initialCount + 1),
        reason:
            'Le nombre de rendez-vous affichés devrait avoir augmenté de 1');

    // Vérifier que le nombre dans la base correspond
    expect(afterInsertDbRdv.length, equals(initialDbRdv.length + 1),
        reason:
            'Le nombre de rendez-vous dans la base devrait avoir augmenté de 1');

    // Debug: afficher tous les rendez-vous
    print('\nTous les rendez-vous dans la base:');
    for (var r in afterInsertDbRdv) {
      print(
          'RDV #${r.id}: Client=${r.idClient}, Date=${r.date}, Heure=${r.heure}');
    }
  });
}
