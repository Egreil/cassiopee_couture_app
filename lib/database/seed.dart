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
    final today = DateTime.now();
    // Clients
    final clientsIds = await Future.wait([
      db.into(db.clients).insertReturning(
            ClientsCompanion.insert(
              nom: 'Dubois',
              prenom: 'Emma',
              adresse: '12 rue des Lilas, 75020 Paris',
              numero: '0612345678',
              mail: const Value('emma.dubois@email.com'),
            ),
          ),
      db.into(db.clients).insertReturning(
            ClientsCompanion.insert(
              nom: 'Bernard',
              prenom: 'Sophie',
              adresse: '45 avenue Foch, 75016 Paris',
              numero: '0623456789',
              mail: const Value('sophie.bernard@email.com'),
            ),
          ),
      db.into(db.clients).insertReturning(
            ClientsCompanion.insert(
              nom: 'Petit',
              prenom: 'Marie',
              adresse: '8 rue du Commerce, 75015 Paris',
              numero: '0634567890',
              mail: const Value('marie.petit@email.com'),
            ),
          ),
    ]);

    // Vêtements
    final vetements = [
      VetementsCompanion.insert(
        nom: 'Robe de Soirée Noire',
        couleurs: 'Noir',
        category: Category.robe,
        evenement: TypeEvenement.soiree,
        longueurTotale: 150,
        prix: 250.0,
        tourTaille: const Value(70),
        tourPoitrine: const Value(90),
        commentaire: const Value('Robe longue en satin'),
      ),
      VetementsCompanion.insert(
        nom: 'Jupe Plissée',
        couleurs: 'Bleu marine',
        category: Category.jupe,
        evenement: TypeEvenement.soiree,
        longueurTotale: 65,
        prix: 120.0,
        tourTaille: const Value(65),
        tourPoitrine: const Value(100),
        commentaire: const Value('Jupe mi-longue plissée'),
      ),
      VetementsCompanion.insert(
        nom: 'Top Dentelle',
        couleurs: 'Blanc',
        category: Category.haut,
        evenement: TypeEvenement.soiree,
        longueurTotale: 45,
        prix: 85.0,
        tourTaille: const Value(100),
        tourPoitrine: const Value(88),
        commentaire: const Value('Top en dentelle fine'),
      ),
      VetementsCompanion.insert(
        nom: 'Robe Cocktail',
        couleurs: 'Rouge',
        category: Category.robe,
        evenement: TypeEvenement.soiree,
        longueurTotale: 120,
        prix: 250.0,
        tourTaille: const Value(75),
        tourPoitrine: const Value(92),
        commentaire: const Value('Robe cocktail élégante'),
      ),
      VetementsCompanion.insert(
        nom: 'Tailleur Pantalon',
        couleurs: 'Gris',
        category: Category.ensemble,
        evenement: TypeEvenement.mariage,
        longueurTotale: 140,
        prix: 120.0,
        tourTaille: const Value(68),
        tourPoitrine: const Value(88),
        commentaire: const Value('Tailleur professionnel'),
      ),
      VetementsCompanion.insert(
        nom: 'Robe Longue Fleurie',
        couleurs: 'Multicolore',
        category: Category.robe,
        evenement: TypeEvenement.mariage,
        longueurTotale: 160,
        prix: 85.0,
        tourTaille: const Value(72),
        tourPoitrine: const Value(86),
        commentaire: const Value('Robe d\'été longue'),
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

    // Réservations avec différents statuts
    await db.batch((batch) {
      // 1. Réservation expirée
      batch.insert(
        db.reservations,
        ReservationsCompanion.insert(
          idClient: 1,
          idVetement: 1,
          type: TypeReservation.location,
          montantTotal: 150.0,
          statut: 'R', // Rendu
          dateReservation: DateTime(
              today.year, today.month, today.day - 30), // Créée il y a 30 jours
          dateSortie: DateTime(today.year, today.month, today.day - 25),
          dateRetour: Value(DateTime(today.year, today.month, today.day - 20)),
        ),
      );

      // 2. Réservation en cours
      batch.insert(
        db.reservations,
        ReservationsCompanion.insert(
          idClient: 2,
          idVetement: 2,
          type: TypeReservation.location,
          montantTotal: 200.0,
          statut: 'EC', // En cours
          dateReservation: DateTime(
              today.year, today.month, today.day - 5), // Créée il y a 5 jours
          dateSortie: DateTime(today.year, today.month, today.day - 2),
          dateRetour: Value(DateTime(today.year, today.month, today.day + 3)),
        ),
      );

      // 3. Réservation future avec caution et acompte
      batch.insert(
        db.reservations,
        ReservationsCompanion.insert(
          idClient: 3,
          idVetement: 3,
          type: TypeReservation.location,
          montantTotal: 250.0,
          statut: 'EC',
          dateReservation: today, // Créée aujourd'hui
          dateSortie: DateTime(today.year, today.month, today.day + 2),
          dateRetour: Value(DateTime(today.year, today.month, today.day + 7)),
        ),
      );
    });

    // Ajouter caution et acompte pour la réservation future
    await db.batch((batch) {
      batch.insert(
        db.cautions,
        CautionsCompanion.insert(
          idReservation: 3,
          montant: 500.0,
          dateReception: DateTime(today.year, today.month, today.day),
          statut: CautionStatus.EA,
        ),
      );

      batch.insert(
        db.acomptes,
        AcomptesCompanion.insert(
          idReservation: 3,
          montant: 75.0, // 30% du montant total
          paye: 1,
          datePaiement: DateTime(today.year, today.month, today.day),
        ),
      );
    });

    // 3 Rendez-vous aujourd'hui
    await db.into(db.rendezVous).insert(RendezVousCompanion.insert(
          idClient: clientsIds[0].id,
          date: DateTime(today.year, today.month, today.day),
          heure: '09:00',
          duree: const Duration(minutes: 30),
          motif: MotifRendezVous.consultation,
        ));

    await db.into(db.rendezVous).insert(RendezVousCompanion.insert(
          idClient: clientsIds[1].id,
          date: today.add(const Duration(hours: 14)),
          heure: '14:00',
          duree: const Duration(minutes: 45),
          motif: MotifRendezVous.essayage,
        ));

    await db.into(db.rendezVous).insert(RendezVousCompanion.insert(
          idClient: clientsIds[2].id,
          date: today.add(const Duration(hours: 16)),
          heure: '16:00',
          duree: const Duration(minutes: 30),
          motif: MotifRendezVous.retour,
        ));

    // 3 Départs prévus
    final depart1 = await db.into(db.reservations).insertReturning(
          ReservationsCompanion.insert(
            idVetement: 4,
            idClient: clientsIds[0].id,
            type: TypeReservation.location,
            montantTotal: 250.0,
            statut: 'EC',
            dateReservation: today
                .subtract(const Duration(days: 2)), // Réservé il y a 2 jours
            dateSortie: today,
            dateRetour: Value(today.add(const Duration(days: 5))),
          ),
        );

    final depart2 = await db.into(db.reservations).insertReturning(
          ReservationsCompanion.insert(
            idVetement: 5,
            idClient: clientsIds[1].id,
            type: TypeReservation.location,
            montantTotal: 120.0,
            statut: 'EC',
            dateReservation: today
                .subtract(const Duration(days: 3)), // Réservé il y a 3 jours
            dateSortie: today,
            dateRetour: Value(today.add(const Duration(days: 7))),
          ),
        );

    final depart3 = await db.into(db.reservations).insertReturning(
          ReservationsCompanion.insert(
            idVetement: 6,
            idClient: clientsIds[2].id,
            type: TypeReservation.location,
            montantTotal: 85.0,
            statut: 'EC',
            dateReservation:
                today.subtract(const Duration(days: 1)), // Réservé hier
            dateSortie: today,
            dateRetour: Value(today.add(const Duration(days: 6))),
          ),
        );

    // 3 Paiements à recevoir (utilisant les IDs des réservations de départ)
    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: depart1.id,
          montant: 250.0, // Prix complet du vêtement
          paye: 0,
          datePaiement: today,
        ));

    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: depart2.id,
          montant: 120.0, // Prix complet du vêtement
          paye: 0,
          datePaiement: today,
        ));

    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: depart3.id,
          montant: 85.0, // Prix complet du vêtement
          paye: 0,
          datePaiement: today,
        ));
  }

  Future<void> seedTodayTasks() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);

    // Récupérer les 3 clients existants
    final clients = await (db.select(db.clients)).get();
    if (clients.length < 3) {
      print('Erreur: Il faut au moins 3 clients en base de données');
      return;
    }

    // Créer d'abord les réservations
    final reservation1 = await db.into(db.reservations).insertReturning(
          ReservationsCompanion.insert(
            idVetement: 1,
            idClient: clients[0].id,
            type: TypeReservation.location,
            montantTotal: 250.0,
            statut: 'EC',
            dateReservation:
                DateTime(startOfDay.year, startOfDay.month, startOfDay.day - 5),
            dateSortie:
                DateTime(startOfDay.year, startOfDay.month, startOfDay.day - 2),
            dateRetour: Value(DateTime(
                startOfDay.year, startOfDay.month, startOfDay.day - 1)),
          ),
        );

    final reservation2 = await db.into(db.reservations).insertReturning(
          ReservationsCompanion.insert(
            idVetement: 2,
            idClient: clients[1].id,
            type: TypeReservation.location,
            montantTotal: 120.0,
            statut: 'EC',
            dateReservation:
                DateTime(startOfDay.year, startOfDay.month, startOfDay.day - 4),
            dateSortie:
                DateTime(startOfDay.year, startOfDay.month, startOfDay.day - 1),
            dateRetour: Value(DateTime(
                startOfDay.year, startOfDay.month, startOfDay.day - 1)),
          ),
        );

    final reservation3 = await db.into(db.reservations).insertReturning(
          ReservationsCompanion.insert(
            idVetement: 3,
            idClient: clients[2].id,
            type: TypeReservation.location,
            montantTotal: 85.0,
            statut: 'EC',
            dateReservation:
                DateTime(startOfDay.year, startOfDay.month, startOfDay.day - 3),
            dateSortie:
                DateTime(startOfDay.year, startOfDay.month, startOfDay.day - 1),
            dateRetour: Value(DateTime(
                startOfDay.year, startOfDay.month, startOfDay.day - 1)),
          ),
        );

    // Créer les cautions avec les IDs des réservations
    await db.into(db.cautions).insert(CautionsCompanion.insert(
          idReservation: reservation1.id,
          statut: CautionStatus.AR,
          montant: 200.0,
          dateReception: today.subtract(const Duration(days: 30)),
          dateRendu: Value(today),
        ));

    await db.into(db.cautions).insert(CautionsCompanion.insert(
          idReservation: reservation2.id,
          statut: CautionStatus.AR,
          montant: 150.0,
          dateReception: today.subtract(const Duration(days: 20)),
          dateRendu: Value(today),
        ));

    await db.into(db.cautions).insert(CautionsCompanion.insert(
          idReservation: reservation3.id,
          statut: CautionStatus.AR,
          montant: 300.0,
          dateReception: today.subtract(const Duration(days: 15)),
          dateRendu: Value(today),
        ));

    // Créer les acomptes avec les IDs des réservations
    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: reservation1.id,
          montant: 50.0,
          paye: 0,
          datePaiement: today,
        ));

    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: reservation2.id,
          montant: 75.0,
          paye: 0,
          datePaiement: today,
        ));

    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: reservation3.id,
          montant: 60.0,
          paye: 0,
          datePaiement: today,
        ));

    // 3 Rendez-vous aujourd'hui
    await db.into(db.rendezVous).insert(RendezVousCompanion.insert(
          idClient: clients[0].id,
          date: DateTime(today.year, today.month, today.day),
          heure: '09:00',
          duree: const Duration(minutes: 30),
          motif: MotifRendezVous.consultation,
        ));

    await db.into(db.rendezVous).insert(RendezVousCompanion.insert(
          idClient: clients[1].id,
          date: today.add(const Duration(hours: 14)),
          heure: '14:00',
          duree: const Duration(minutes: 45),
          motif: MotifRendezVous.essayage,
        ));

    await db.into(db.rendezVous).insert(RendezVousCompanion.insert(
          idClient: clients[2].id,
          date: today.add(const Duration(hours: 16)),
          heure: '16:00',
          duree: const Duration(minutes: 30),
          motif: MotifRendezVous.retour,
        ));

    // 3 Départs prévus
    final depart1 = await db.into(db.reservations).insertReturning(
          ReservationsCompanion.insert(
            idVetement: 4,
            idClient: clients[0].id,
            type: TypeReservation.location,
            montantTotal: 250.0,
            statut: 'EC',
            dateReservation: today
                .subtract(const Duration(days: 2)), // Réservé il y a 2 jours
            dateSortie: today,
            dateRetour: Value(today.add(const Duration(days: 5))),
          ),
        );

    final depart2 = await db.into(db.reservations).insertReturning(
          ReservationsCompanion.insert(
            idVetement: 5,
            idClient: clients[1].id,
            type: TypeReservation.location,
            montantTotal: 120.0,
            statut: 'EC',
            dateReservation: today
                .subtract(const Duration(days: 3)), // Réservé il y a 3 jours
            dateSortie: today,
            dateRetour: Value(today.add(const Duration(days: 7))),
          ),
        );

    final depart3 = await db.into(db.reservations).insertReturning(
          ReservationsCompanion.insert(
            idVetement: 6,
            idClient: clients[2].id,
            type: TypeReservation.location,
            montantTotal: 85.0,
            statut: 'EC',
            dateReservation:
                today.subtract(const Duration(days: 1)), // Réservé hier
            dateSortie: today,
            dateRetour: Value(today.add(const Duration(days: 6))),
          ),
        );

    // 3 Paiements à recevoir (utilisant les IDs des réservations de départ)
    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: depart1.id,
          montant: 250.0, // Prix complet du vêtement
          paye: 0,
          datePaiement: today,
        ));

    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: depart2.id,
          montant: 120.0, // Prix complet du vêtement
          paye: 0,
          datePaiement: today,
        ));

    await db.into(db.acomptes).insert(AcomptesCompanion.insert(
          idReservation: depart3.id,
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
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
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
