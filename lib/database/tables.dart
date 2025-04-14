import 'package:cassiopee_couture_app/database/database.dart';
import 'package:drift/drift.dart';

class DurationConverter extends TypeConverter<Duration, int> {
  const DurationConverter();
  @override
  Duration fromSql(int fromDb) => Duration(minutes: fromDb);
  @override
  int toSql(Duration value) => value.inMinutes;
}

enum Category {
  robe,
  jupe,
  haut,
  ensemble,
}

enum TypeEvenement {
  soiree,
  mariage,
}

class Vetements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nom => text()();
  TextColumn get couleurs => text()();
  TextColumn get category => textEnum<Category>()();
  TextColumn get evenement => textEnum<TypeEvenement>()();
  RealColumn get prix => real()();
  RealColumn get tourTaille => real().nullable()();
  RealColumn get tourPoitrine => real().nullable()();
  RealColumn get longueurTotale => real()();
  TextColumn get commentaire => text().nullable()();
}

class Photos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idVetement => integer().references(Vetements, #id)();
  TextColumn get url => text()();
}

enum TypeReservation {
  achat,
  location,
}

class Reservations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idClient => integer().references(Clients, #id)();
  IntColumn get idVetement => integer().references(Vetements, #id)();
  TextColumn get type => textEnum<TypeReservation>()();
  RealColumn get montantTotal => real()();
  TextColumn get statut => text()(); // 'EC' (en cours), 'R' (rendu)
  DateTimeColumn get dateReservation => dateTime()(); // date de création
  DateTimeColumn get dateSortie => dateTime()(); // date de sortie prévue
  DateTimeColumn get dateRetour =>
      dateTime().nullable()(); // date de retour prévue
}

class Cautions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idReservation => integer().references(Reservations, #id)();
  TextColumn get statut => textEnum<CautionStatus>()();
  RealColumn get montant => real()();
  DateTimeColumn get dateReception => dateTime()();
  DateTimeColumn get dateRendu => dateTime().nullable()();
}

class Acomptes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idReservation => integer().references(Reservations, #id)();
  RealColumn get montant => real()();
  IntColumn get paye => integer()(); // 0 ou 1

  DateTimeColumn get datePaiement => dateTime()();
}

class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nom => text()();
  TextColumn get prenom => text()();
  TextColumn get adresse => text()();
  TextColumn get numero => text()();
  TextColumn get mail => text().nullable()();
}

class RendezVous extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idClient => integer().references(Clients, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get heure => text()();
  IntColumn get duree => integer().map(const DurationConverter())();
  TextColumn get motif => textEnum<MotifRendezVous>()();
}

class Favoris extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idClient => integer().references(Clients, #id)();
  IntColumn get idVetement => integer().references(Vetements, #id)();

  @override
  List<String> get customConstraints => [
        'UNIQUE (id_client, id_vetement)',
      ];
}

// Enum pour le statut des cautions
enum CautionStatus {
  EA, // En attente
  EP, // En possession
  AR, // A rendre
  RE // Rendue
}

enum MotifRendezVous {
  motif,
  essayage,
  consultation,
  retour,
}
