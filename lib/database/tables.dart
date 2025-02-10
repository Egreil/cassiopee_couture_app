import 'package:drift/drift.dart';

class DurationConverter extends TypeConverter<Duration, int> {
  const DurationConverter();
  @override
  Duration fromSql(int fromDb) => Duration(minutes: fromDb);
  @override
  int toSql(Duration value) => value.inMinutes;
}

class Vetements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nom => text()();
  TextColumn get couleurs => text()();
  TextColumn get category =>
      text().withLength(min: 1, max: 20)(); // 'robe', 'jupe', 'haut'
  RealColumn get tourTaille => real().nullable()(); // pour robe et jupe
  RealColumn get longueurTotale => real()();
  RealColumn get tourPoitrine => real().nullable()(); // pour robe et hauts
  RealColumn get prix => real()();
  TextColumn get commentaire => text().nullable()();
}

class Photos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idVetement => integer().references(Vetements, #id)();
  TextColumn get url => text()();
}

class Reservations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idVetement => integer().references(Vetements, #id)();
  IntColumn get idClient => integer().references(Clients, #id)();
  DateTimeColumn get dateEntree => dateTime()();
  DateTimeColumn get dateReservation => dateTime()();
  DateTimeColumn get dateSortie => dateTime()();
  DateTimeColumn get dateRetour => dateTime().nullable()();
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
