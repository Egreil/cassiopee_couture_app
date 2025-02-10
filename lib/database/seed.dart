import 'dart:math';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'database.dart';
import 'tables.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class DatabaseSeeder {
  final AppDatabase db;
  final random = Random();

  DatabaseSeeder(this.db);

  Future<void> clearDatabase() async {
    // Supprimer les données dans l'ordre inverse des dépendances
    await db.delete(db.rendezVous).go();
    await db.delete(db.acomptes).go();
    await db.delete(db.cautions).go();
    await db.delete(db.reservations).go();
    await db.delete(db.photos).go();
    await db.delete(db.vetements).go();
    await db.delete(db.clients).go();
  }

  Future<void> seedDatabase() async {
    // Clients
    final clients = [
      ClientsCompanion.insert(
        nom: 'Dubois',
        prenom: 'Emma',
        adresse: '12 rue des Lilas, 75020 Paris',
        numero: '0612345678',
        mail: const Value('emma.dubois@email.com'),
      ),
      ClientsCompanion.insert(
        nom: 'Bernard',
        prenom: 'Sophie',
        adresse: '45 avenue Foch, 75016 Paris',
        numero: '0623456789',
        mail: const Value('sophie.bernard@email.com'),
      ),
      ClientsCompanion.insert(
        nom: 'Petit',
        prenom: 'Marie',
        adresse: '8 rue du Commerce, 75015 Paris',
        numero: '0634567890',
        mail: const Value('marie.petit@email.com'),
      ),
    ];

    for (final client in clients) {
      await db.into(db.clients).insert(client);
    }

    // Vêtements
    final vetements = [
      VetementsCompanion.insert(
        nom: 'Robe de Soirée Noire',
        couleurs: 'Noir',
        category: 'robe',
        longueurTotale: 150,
        prix: 250.0,
        tourTaille: const Value(70),
        tourPoitrine: const Value(90),
        commentaire: const Value('Robe longue en satin'),
      ),
      VetementsCompanion.insert(
        nom: 'Jupe Plissée',
        couleurs: 'Bleu marine',
        category: 'jupe',
        longueurTotale: 65,
        prix: 120.0,
        tourTaille: const Value(65),
        tourPoitrine: const Value(null),
        commentaire: const Value('Jupe mi-longue plissée'),
      ),
      VetementsCompanion.insert(
        nom: 'Top Dentelle',
        couleurs: 'Blanc',
        category: 'haut',
        longueurTotale: 45,
        prix: 85.0,
        tourTaille: const Value(null),
        tourPoitrine: const Value(88),
        commentaire: const Value('Top en dentelle fine'),
      ),
    ];

    for (final vetement in vetements) {
      await db.into(db.vetements).insert(vetement);
    }

    // Photos (à implémenter plus tard avec de vraies photos)
    await db.into(db.photos).insert(
          PhotosCompanion.insert(
            idVetement: 1,
            url: 'assets/images/robe_noire.jpg',
          ),
        );
  }

  Future<void> seedTodayTasks() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Récupérer les IDs des clients existants
    final clientIds = await (db.select(db.clients)..limit(21))
        .map((client) => client.id)
        .get();

    if (clientIds.isEmpty) {
      print('Aucun client trouvé en base de données');
      return;
    }

    // 3 Rendez-vous aujourd'hui
    await db.into(db.rendezVous).insert(RendezVousCompanion.insert(
          idClient: clientIds[0],
          date: today.add(const Duration(hours: 9)),
          heure: '09:00',
          duree: const Duration(minutes: 30),
          motif: MotifRendezVous.consultation,
        ));

    await db.into(db.rendezVous).insert(RendezVousCompanion.insert(
          idClient: clientIds[1],
          date: today.add(const Duration(hours: 14)),
          heure: '14:00',
          duree: const Duration(minutes: 45),
          motif: MotifRendezVous.essayage,
        ));

    await db.into(db.rendezVous).insert(RendezVousCompanion.insert(
          idClient: clientIds[2],
          date: today.add(const Duration(hours: 16)),
          heure: '16:00',
          duree: const Duration(minutes: 30),
          motif: MotifRendezVous.retour,
        ));

    // 3 Cautions à rendre
    await db.into(db.cautions).insert(CautionsCompanion.insert(
          idReservation: 1,
          statut: CautionStatus.AR,
          montant: 200.0,
          dateReception: today.subtract(const Duration(days: 30)),
          dateRendu: Value(today),
        ));

    await db.into(db.cautions).insert(CautionsCompanion.insert(
          idReservation: 2,
          statut: CautionStatus.AR,
          montant: 150.0,
          dateReception: today.subtract(const Duration(days: 20)),
          dateRendu: Value(today),
        ));

    await db.into(db.cautions).insert(CautionsCompanion.insert(
          idReservation: 3,
          statut: CautionStatus.AR,
          montant: 300.0,
          dateReception: today.subtract(const Duration(days: 15)),
          dateRendu: Value(today),
        ));

    // 3 Cautions à recevoir
    await db.into(db.cautions).insert(CautionsCompanion.insert(
          idReservation: 4,
          statut: CautionStatus.EA,
          montant: 250.0,
          dateReception: today,
          dateRendu: const Value(null),
        ));

    await db.into(db.cautions).insert(CautionsCompanion.insert(
          idReservation: 5,
          statut: CautionStatus.EA,
          montant: 180.0,
          dateReception: today,
          dateRendu: const Value(null),
        ));

    await db.into(db.cautions).insert(CautionsCompanion.insert(
          idReservation: 6,
          statut: CautionStatus.EA,
          montant: 220.0,
          dateReception: today,
          dateRendu: const Value(null),
        ));

    // 3 Retours prévus
    await db.into(db.reservations).insert(ReservationsCompanion.insert(
          idVetement: 1,
          idClient: clientIds[6],
          dateEntree: today.subtract(const Duration(days: 10)),
          dateReservation: today.subtract(const Duration(days: 5)),
          dateSortie: today.subtract(const Duration(days: 2)),
          dateRetour: Value(today),
        ));

    await db.into(db.reservations).insert(ReservationsCompanion.insert(
          idVetement: 2,
          idClient: clientIds[7],
          dateEntree: today.subtract(const Duration(days: 8)),
          dateReservation: today.subtract(const Duration(days: 4)),
          dateSortie: today.subtract(const Duration(days: 1)),
          dateRetour: Value(today),
        ));

    await db.into(db.reservations).insert(ReservationsCompanion.insert(
          idVetement: 3,
          idClient: clientIds[8],
          dateEntree: today.subtract(const Duration(days: 7)),
          dateReservation: today.subtract(const Duration(days: 3)),
          dateSortie: today.subtract(const Duration(days: 1)),
          dateRetour: Value(today),
        ));

    // 3 Départs prévus
    await db.into(db.reservations).insert(ReservationsCompanion.insert(
          idVetement: 4,
          idClient: clientIds[9],
          dateEntree: today.subtract(const Duration(days: 5)),
          dateReservation: today,
          dateSortie: today,
          dateRetour: Value(today.add(const Duration(days: 5))),
        ));

    await db.into(db.reservations).insert(ReservationsCompanion.insert(
          idVetement: 5,
          idClient: clientIds[10],
          dateEntree: today.subtract(const Duration(days: 3)),
          dateReservation: today,
          dateSortie: today,
          dateRetour: Value(today.add(const Duration(days: 7))),
        ));

    await db.into(db.reservations).insert(ReservationsCompanion.insert(
          idVetement: 6,
          idClient: clientIds[11],
          dateEntree: today.subtract(const Duration(days: 2)),
          dateReservation: today,
          dateSortie: today,
          dateRetour: Value(today.add(const Duration(days: 6))),
        ));

    // 3 Acomptes à recevoir
    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: 7,
          montant: 50.0,
          paye: 0,
          datePaiement: today,
        ));

    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: 8,
          montant: 75.0,
          paye: 0,
          datePaiement: today,
        ));

    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: 9,
          montant: 60.0,
          paye: 0,
          datePaiement: today,
        ));

    // 3 Paiements à recevoir
    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: 10,
          montant: 250.0, // Prix complet du vêtement
          paye: 0,
          datePaiement: today,
        ));

    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: 11,
          montant: 120.0, // Prix complet du vêtement
          paye: 0,
          datePaiement: today,
        ));

    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: 12,
          montant: 85.0, // Prix complet du vêtement
          paye: 0,
          datePaiement: today,
        ));
  }

  Future<void> deleteDatabase() async {
    try {
      // D'abord fermer la connexion
      await db.close();

      // Ensuite supprimer le fichier
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'location_vetements.db'));
      if (await file.exists()) {
        await file.delete();
        print('Base de données supprimée avec succès');
      }

      // Supprimer aussi le fichier -shm si il existe
      final shmFile = File('${file.path}-shm');
      if (await shmFile.exists()) {
        await shmFile.delete();
      }

      // Supprimer aussi le fichier -wal si il existe
      final walFile = File('${file.path}-wal');
      if (await walFile.exists()) {
        await walFile.delete();
      }
    } catch (e) {
      print('Erreur lors de la suppression de la base de données: $e');
    }
  }
}
