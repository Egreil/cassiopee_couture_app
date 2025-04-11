// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $VetementsTable extends Vetements
    with TableInfo<$VetementsTable, Vetement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VetementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
      'nom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _couleursMeta =
      const VerificationMeta('couleurs');
  @override
  late final GeneratedColumn<String> couleurs = GeneratedColumn<String>(
      'couleurs', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _tourTailleMeta =
      const VerificationMeta('tourTaille');
  @override
  late final GeneratedColumn<double> tourTaille = GeneratedColumn<double>(
      'tour_taille', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longueurTotaleMeta =
      const VerificationMeta('longueurTotale');
  @override
  late final GeneratedColumn<double> longueurTotale = GeneratedColumn<double>(
      'longueur_totale', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _tourPoitrineMeta =
      const VerificationMeta('tourPoitrine');
  @override
  late final GeneratedColumn<double> tourPoitrine = GeneratedColumn<double>(
      'tour_poitrine', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _prixMeta = const VerificationMeta('prix');
  @override
  late final GeneratedColumn<double> prix = GeneratedColumn<double>(
      'prix', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _commentaireMeta =
      const VerificationMeta('commentaire');
  @override
  late final GeneratedColumn<String> commentaire = GeneratedColumn<String>(
      'commentaire', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nom,
        couleurs,
        category,
        tourTaille,
        longueurTotale,
        tourPoitrine,
        prix,
        commentaire
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vetements';
  @override
  VerificationContext validateIntegrity(Insertable<Vetement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nom')) {
      context.handle(
          _nomMeta, nom.isAcceptableOrUnknown(data['nom']!, _nomMeta));
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('couleurs')) {
      context.handle(_couleursMeta,
          couleurs.isAcceptableOrUnknown(data['couleurs']!, _couleursMeta));
    } else if (isInserting) {
      context.missing(_couleursMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('tour_taille')) {
      context.handle(
          _tourTailleMeta,
          tourTaille.isAcceptableOrUnknown(
              data['tour_taille']!, _tourTailleMeta));
    }
    if (data.containsKey('longueur_totale')) {
      context.handle(
          _longueurTotaleMeta,
          longueurTotale.isAcceptableOrUnknown(
              data['longueur_totale']!, _longueurTotaleMeta));
    } else if (isInserting) {
      context.missing(_longueurTotaleMeta);
    }
    if (data.containsKey('tour_poitrine')) {
      context.handle(
          _tourPoitrineMeta,
          tourPoitrine.isAcceptableOrUnknown(
              data['tour_poitrine']!, _tourPoitrineMeta));
    }
    if (data.containsKey('prix')) {
      context.handle(
          _prixMeta, prix.isAcceptableOrUnknown(data['prix']!, _prixMeta));
    } else if (isInserting) {
      context.missing(_prixMeta);
    }
    if (data.containsKey('commentaire')) {
      context.handle(
          _commentaireMeta,
          commentaire.isAcceptableOrUnknown(
              data['commentaire']!, _commentaireMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vetement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vetement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nom'])!,
      couleurs: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}couleurs'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      tourTaille: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tour_taille']),
      longueurTotale: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}longueur_totale'])!,
      tourPoitrine: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tour_poitrine']),
      prix: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}prix'])!,
      commentaire: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}commentaire']),
    );
  }

  @override
  $VetementsTable createAlias(String alias) {
    return $VetementsTable(attachedDatabase, alias);
  }
}

class Vetement extends DataClass implements Insertable<Vetement> {
  final int id;
  final String nom;
  final String couleurs;
  final String category;
  final double? tourTaille;
  final double longueurTotale;
  final double? tourPoitrine;
  final double prix;
  final String? commentaire;
  const Vetement(
      {required this.id,
      required this.nom,
      required this.couleurs,
      required this.category,
      this.tourTaille,
      required this.longueurTotale,
      this.tourPoitrine,
      required this.prix,
      this.commentaire});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nom'] = Variable<String>(nom);
    map['couleurs'] = Variable<String>(couleurs);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || tourTaille != null) {
      map['tour_taille'] = Variable<double>(tourTaille);
    }
    map['longueur_totale'] = Variable<double>(longueurTotale);
    if (!nullToAbsent || tourPoitrine != null) {
      map['tour_poitrine'] = Variable<double>(tourPoitrine);
    }
    map['prix'] = Variable<double>(prix);
    if (!nullToAbsent || commentaire != null) {
      map['commentaire'] = Variable<String>(commentaire);
    }
    return map;
  }

  VetementsCompanion toCompanion(bool nullToAbsent) {
    return VetementsCompanion(
      id: Value(id),
      nom: Value(nom),
      couleurs: Value(couleurs),
      category: Value(category),
      tourTaille: tourTaille == null && nullToAbsent
          ? const Value.absent()
          : Value(tourTaille),
      longueurTotale: Value(longueurTotale),
      tourPoitrine: tourPoitrine == null && nullToAbsent
          ? const Value.absent()
          : Value(tourPoitrine),
      prix: Value(prix),
      commentaire: commentaire == null && nullToAbsent
          ? const Value.absent()
          : Value(commentaire),
    );
  }

  factory Vetement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vetement(
      id: serializer.fromJson<int>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      couleurs: serializer.fromJson<String>(json['couleurs']),
      category: serializer.fromJson<String>(json['category']),
      tourTaille: serializer.fromJson<double?>(json['tourTaille']),
      longueurTotale: serializer.fromJson<double>(json['longueurTotale']),
      tourPoitrine: serializer.fromJson<double?>(json['tourPoitrine']),
      prix: serializer.fromJson<double>(json['prix']),
      commentaire: serializer.fromJson<String?>(json['commentaire']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nom': serializer.toJson<String>(nom),
      'couleurs': serializer.toJson<String>(couleurs),
      'category': serializer.toJson<String>(category),
      'tourTaille': serializer.toJson<double?>(tourTaille),
      'longueurTotale': serializer.toJson<double>(longueurTotale),
      'tourPoitrine': serializer.toJson<double?>(tourPoitrine),
      'prix': serializer.toJson<double>(prix),
      'commentaire': serializer.toJson<String?>(commentaire),
    };
  }

  Vetement copyWith(
          {int? id,
          String? nom,
          String? couleurs,
          String? category,
          Value<double?> tourTaille = const Value.absent(),
          double? longueurTotale,
          Value<double?> tourPoitrine = const Value.absent(),
          double? prix,
          Value<String?> commentaire = const Value.absent()}) =>
      Vetement(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        couleurs: couleurs ?? this.couleurs,
        category: category ?? this.category,
        tourTaille: tourTaille.present ? tourTaille.value : this.tourTaille,
        longueurTotale: longueurTotale ?? this.longueurTotale,
        tourPoitrine:
            tourPoitrine.present ? tourPoitrine.value : this.tourPoitrine,
        prix: prix ?? this.prix,
        commentaire: commentaire.present ? commentaire.value : this.commentaire,
      );
  Vetement copyWithCompanion(VetementsCompanion data) {
    return Vetement(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      couleurs: data.couleurs.present ? data.couleurs.value : this.couleurs,
      category: data.category.present ? data.category.value : this.category,
      tourTaille:
          data.tourTaille.present ? data.tourTaille.value : this.tourTaille,
      longueurTotale: data.longueurTotale.present
          ? data.longueurTotale.value
          : this.longueurTotale,
      tourPoitrine: data.tourPoitrine.present
          ? data.tourPoitrine.value
          : this.tourPoitrine,
      prix: data.prix.present ? data.prix.value : this.prix,
      commentaire:
          data.commentaire.present ? data.commentaire.value : this.commentaire,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vetement(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('couleurs: $couleurs, ')
          ..write('category: $category, ')
          ..write('tourTaille: $tourTaille, ')
          ..write('longueurTotale: $longueurTotale, ')
          ..write('tourPoitrine: $tourPoitrine, ')
          ..write('prix: $prix, ')
          ..write('commentaire: $commentaire')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nom, couleurs, category, tourTaille,
      longueurTotale, tourPoitrine, prix, commentaire);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vetement &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.couleurs == this.couleurs &&
          other.category == this.category &&
          other.tourTaille == this.tourTaille &&
          other.longueurTotale == this.longueurTotale &&
          other.tourPoitrine == this.tourPoitrine &&
          other.prix == this.prix &&
          other.commentaire == this.commentaire);
}

class VetementsCompanion extends UpdateCompanion<Vetement> {
  final Value<int> id;
  final Value<String> nom;
  final Value<String> couleurs;
  final Value<String> category;
  final Value<double?> tourTaille;
  final Value<double> longueurTotale;
  final Value<double?> tourPoitrine;
  final Value<double> prix;
  final Value<String?> commentaire;
  const VetementsCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.couleurs = const Value.absent(),
    this.category = const Value.absent(),
    this.tourTaille = const Value.absent(),
    this.longueurTotale = const Value.absent(),
    this.tourPoitrine = const Value.absent(),
    this.prix = const Value.absent(),
    this.commentaire = const Value.absent(),
  });
  VetementsCompanion.insert({
    this.id = const Value.absent(),
    required String nom,
    required String couleurs,
    required String category,
    this.tourTaille = const Value.absent(),
    required double longueurTotale,
    this.tourPoitrine = const Value.absent(),
    required double prix,
    this.commentaire = const Value.absent(),
  })  : nom = Value(nom),
        couleurs = Value(couleurs),
        category = Value(category),
        longueurTotale = Value(longueurTotale),
        prix = Value(prix);
  static Insertable<Vetement> custom({
    Expression<int>? id,
    Expression<String>? nom,
    Expression<String>? couleurs,
    Expression<String>? category,
    Expression<double>? tourTaille,
    Expression<double>? longueurTotale,
    Expression<double>? tourPoitrine,
    Expression<double>? prix,
    Expression<String>? commentaire,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (couleurs != null) 'couleurs': couleurs,
      if (category != null) 'category': category,
      if (tourTaille != null) 'tour_taille': tourTaille,
      if (longueurTotale != null) 'longueur_totale': longueurTotale,
      if (tourPoitrine != null) 'tour_poitrine': tourPoitrine,
      if (prix != null) 'prix': prix,
      if (commentaire != null) 'commentaire': commentaire,
    });
  }

  VetementsCompanion copyWith(
      {Value<int>? id,
      Value<String>? nom,
      Value<String>? couleurs,
      Value<String>? category,
      Value<double?>? tourTaille,
      Value<double>? longueurTotale,
      Value<double?>? tourPoitrine,
      Value<double>? prix,
      Value<String?>? commentaire}) {
    return VetementsCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      couleurs: couleurs ?? this.couleurs,
      category: category ?? this.category,
      tourTaille: tourTaille ?? this.tourTaille,
      longueurTotale: longueurTotale ?? this.longueurTotale,
      tourPoitrine: tourPoitrine ?? this.tourPoitrine,
      prix: prix ?? this.prix,
      commentaire: commentaire ?? this.commentaire,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (couleurs.present) {
      map['couleurs'] = Variable<String>(couleurs.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (tourTaille.present) {
      map['tour_taille'] = Variable<double>(tourTaille.value);
    }
    if (longueurTotale.present) {
      map['longueur_totale'] = Variable<double>(longueurTotale.value);
    }
    if (tourPoitrine.present) {
      map['tour_poitrine'] = Variable<double>(tourPoitrine.value);
    }
    if (prix.present) {
      map['prix'] = Variable<double>(prix.value);
    }
    if (commentaire.present) {
      map['commentaire'] = Variable<String>(commentaire.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VetementsCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('couleurs: $couleurs, ')
          ..write('category: $category, ')
          ..write('tourTaille: $tourTaille, ')
          ..write('longueurTotale: $longueurTotale, ')
          ..write('tourPoitrine: $tourPoitrine, ')
          ..write('prix: $prix, ')
          ..write('commentaire: $commentaire')
          ..write(')'))
        .toString();
  }
}

class $PhotosTable extends Photos with TableInfo<$PhotosTable, Photo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idVetementMeta =
      const VerificationMeta('idVetement');
  @override
  late final GeneratedColumn<int> idVetement = GeneratedColumn<int>(
      'id_vetement', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES vetements (id)'));
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, idVetement, url];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photos';
  @override
  VerificationContext validateIntegrity(Insertable<Photo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_vetement')) {
      context.handle(
          _idVetementMeta,
          idVetement.isAcceptableOrUnknown(
              data['id_vetement']!, _idVetementMeta));
    } else if (isInserting) {
      context.missing(_idVetementMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Photo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Photo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idVetement: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_vetement'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
    );
  }

  @override
  $PhotosTable createAlias(String alias) {
    return $PhotosTable(attachedDatabase, alias);
  }
}

class Photo extends DataClass implements Insertable<Photo> {
  final int id;
  final int idVetement;
  final String url;
  const Photo({required this.id, required this.idVetement, required this.url});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_vetement'] = Variable<int>(idVetement);
    map['url'] = Variable<String>(url);
    return map;
  }

  PhotosCompanion toCompanion(bool nullToAbsent) {
    return PhotosCompanion(
      id: Value(id),
      idVetement: Value(idVetement),
      url: Value(url),
    );
  }

  factory Photo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Photo(
      id: serializer.fromJson<int>(json['id']),
      idVetement: serializer.fromJson<int>(json['idVetement']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idVetement': serializer.toJson<int>(idVetement),
      'url': serializer.toJson<String>(url),
    };
  }

  Photo copyWith({int? id, int? idVetement, String? url}) => Photo(
        id: id ?? this.id,
        idVetement: idVetement ?? this.idVetement,
        url: url ?? this.url,
      );
  Photo copyWithCompanion(PhotosCompanion data) {
    return Photo(
      id: data.id.present ? data.id.value : this.id,
      idVetement:
          data.idVetement.present ? data.idVetement.value : this.idVetement,
      url: data.url.present ? data.url.value : this.url,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Photo(')
          ..write('id: $id, ')
          ..write('idVetement: $idVetement, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idVetement, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Photo &&
          other.id == this.id &&
          other.idVetement == this.idVetement &&
          other.url == this.url);
}

class PhotosCompanion extends UpdateCompanion<Photo> {
  final Value<int> id;
  final Value<int> idVetement;
  final Value<String> url;
  const PhotosCompanion({
    this.id = const Value.absent(),
    this.idVetement = const Value.absent(),
    this.url = const Value.absent(),
  });
  PhotosCompanion.insert({
    this.id = const Value.absent(),
    required int idVetement,
    required String url,
  })  : idVetement = Value(idVetement),
        url = Value(url);
  static Insertable<Photo> custom({
    Expression<int>? id,
    Expression<int>? idVetement,
    Expression<String>? url,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idVetement != null) 'id_vetement': idVetement,
      if (url != null) 'url': url,
    });
  }

  PhotosCompanion copyWith(
      {Value<int>? id, Value<int>? idVetement, Value<String>? url}) {
    return PhotosCompanion(
      id: id ?? this.id,
      idVetement: idVetement ?? this.idVetement,
      url: url ?? this.url,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idVetement.present) {
      map['id_vetement'] = Variable<int>(idVetement.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotosCompanion(')
          ..write('id: $id, ')
          ..write('idVetement: $idVetement, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
      'nom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _prenomMeta = const VerificationMeta('prenom');
  @override
  late final GeneratedColumn<String> prenom = GeneratedColumn<String>(
      'prenom', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _adresseMeta =
      const VerificationMeta('adresse');
  @override
  late final GeneratedColumn<String> adresse = GeneratedColumn<String>(
      'adresse', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<String> numero = GeneratedColumn<String>(
      'numero', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mailMeta = const VerificationMeta('mail');
  @override
  late final GeneratedColumn<String> mail = GeneratedColumn<String>(
      'mail', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nom, prenom, adresse, numero, mail];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(Insertable<Client> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nom')) {
      context.handle(
          _nomMeta, nom.isAcceptableOrUnknown(data['nom']!, _nomMeta));
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('prenom')) {
      context.handle(_prenomMeta,
          prenom.isAcceptableOrUnknown(data['prenom']!, _prenomMeta));
    } else if (isInserting) {
      context.missing(_prenomMeta);
    }
    if (data.containsKey('adresse')) {
      context.handle(_adresseMeta,
          adresse.isAcceptableOrUnknown(data['adresse']!, _adresseMeta));
    } else if (isInserting) {
      context.missing(_adresseMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(_numeroMeta,
          numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('mail')) {
      context.handle(
          _mailMeta, mail.isAcceptableOrUnknown(data['mail']!, _mailMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nom'])!,
      prenom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prenom'])!,
      adresse: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}adresse'])!,
      numero: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero'])!,
      mail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mail']),
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String nom;
  final String prenom;
  final String adresse;
  final String numero;
  final String? mail;
  const Client(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.adresse,
      required this.numero,
      this.mail});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nom'] = Variable<String>(nom);
    map['prenom'] = Variable<String>(prenom);
    map['adresse'] = Variable<String>(adresse);
    map['numero'] = Variable<String>(numero);
    if (!nullToAbsent || mail != null) {
      map['mail'] = Variable<String>(mail);
    }
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      nom: Value(nom),
      prenom: Value(prenom),
      adresse: Value(adresse),
      numero: Value(numero),
      mail: mail == null && nullToAbsent ? const Value.absent() : Value(mail),
    );
  }

  factory Client.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      prenom: serializer.fromJson<String>(json['prenom']),
      adresse: serializer.fromJson<String>(json['adresse']),
      numero: serializer.fromJson<String>(json['numero']),
      mail: serializer.fromJson<String?>(json['mail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nom': serializer.toJson<String>(nom),
      'prenom': serializer.toJson<String>(prenom),
      'adresse': serializer.toJson<String>(adresse),
      'numero': serializer.toJson<String>(numero),
      'mail': serializer.toJson<String?>(mail),
    };
  }

  Client copyWith(
          {int? id,
          String? nom,
          String? prenom,
          String? adresse,
          String? numero,
          Value<String?> mail = const Value.absent()}) =>
      Client(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        prenom: prenom ?? this.prenom,
        adresse: adresse ?? this.adresse,
        numero: numero ?? this.numero,
        mail: mail.present ? mail.value : this.mail,
      );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      prenom: data.prenom.present ? data.prenom.value : this.prenom,
      adresse: data.adresse.present ? data.adresse.value : this.adresse,
      numero: data.numero.present ? data.numero.value : this.numero,
      mail: data.mail.present ? data.mail.value : this.mail,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('prenom: $prenom, ')
          ..write('adresse: $adresse, ')
          ..write('numero: $numero, ')
          ..write('mail: $mail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nom, prenom, adresse, numero, mail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.prenom == this.prenom &&
          other.adresse == this.adresse &&
          other.numero == this.numero &&
          other.mail == this.mail);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> nom;
  final Value<String> prenom;
  final Value<String> adresse;
  final Value<String> numero;
  final Value<String?> mail;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.prenom = const Value.absent(),
    this.adresse = const Value.absent(),
    this.numero = const Value.absent(),
    this.mail = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String nom,
    required String prenom,
    required String adresse,
    required String numero,
    this.mail = const Value.absent(),
  })  : nom = Value(nom),
        prenom = Value(prenom),
        adresse = Value(adresse),
        numero = Value(numero);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<String>? nom,
    Expression<String>? prenom,
    Expression<String>? adresse,
    Expression<String>? numero,
    Expression<String>? mail,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (prenom != null) 'prenom': prenom,
      if (adresse != null) 'adresse': adresse,
      if (numero != null) 'numero': numero,
      if (mail != null) 'mail': mail,
    });
  }

  ClientsCompanion copyWith(
      {Value<int>? id,
      Value<String>? nom,
      Value<String>? prenom,
      Value<String>? adresse,
      Value<String>? numero,
      Value<String?>? mail}) {
    return ClientsCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      adresse: adresse ?? this.adresse,
      numero: numero ?? this.numero,
      mail: mail ?? this.mail,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (prenom.present) {
      map['prenom'] = Variable<String>(prenom.value);
    }
    if (adresse.present) {
      map['adresse'] = Variable<String>(adresse.value);
    }
    if (numero.present) {
      map['numero'] = Variable<String>(numero.value);
    }
    if (mail.present) {
      map['mail'] = Variable<String>(mail.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('prenom: $prenom, ')
          ..write('adresse: $adresse, ')
          ..write('numero: $numero, ')
          ..write('mail: $mail')
          ..write(')'))
        .toString();
  }
}

class $ReservationsTable extends Reservations
    with TableInfo<$ReservationsTable, Reservation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReservationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idVetementMeta =
      const VerificationMeta('idVetement');
  @override
  late final GeneratedColumn<int> idVetement = GeneratedColumn<int>(
      'id_vetement', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES vetements (id)'));
  static const VerificationMeta _idClientMeta =
      const VerificationMeta('idClient');
  @override
  late final GeneratedColumn<int> idClient = GeneratedColumn<int>(
      'id_client', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
  static const VerificationMeta _dateReservationMeta =
      const VerificationMeta('dateReservation');
  @override
  late final GeneratedColumn<DateTime> dateReservation =
      GeneratedColumn<DateTime>('date_reservation', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dateSortieMeta =
      const VerificationMeta('dateSortie');
  @override
  late final GeneratedColumn<DateTime> dateSortie = GeneratedColumn<DateTime>(
      'date_sortie', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dateRetourMeta =
      const VerificationMeta('dateRetour');
  @override
  late final GeneratedColumn<DateTime> dateRetour = GeneratedColumn<DateTime>(
      'date_retour', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, idVetement, idClient, dateReservation, dateSortie, dateRetour];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reservations';
  @override
  VerificationContext validateIntegrity(Insertable<Reservation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_vetement')) {
      context.handle(
          _idVetementMeta,
          idVetement.isAcceptableOrUnknown(
              data['id_vetement']!, _idVetementMeta));
    } else if (isInserting) {
      context.missing(_idVetementMeta);
    }
    if (data.containsKey('id_client')) {
      context.handle(_idClientMeta,
          idClient.isAcceptableOrUnknown(data['id_client']!, _idClientMeta));
    } else if (isInserting) {
      context.missing(_idClientMeta);
    }
    if (data.containsKey('date_reservation')) {
      context.handle(
          _dateReservationMeta,
          dateReservation.isAcceptableOrUnknown(
              data['date_reservation']!, _dateReservationMeta));
    } else if (isInserting) {
      context.missing(_dateReservationMeta);
    }
    if (data.containsKey('date_sortie')) {
      context.handle(
          _dateSortieMeta,
          dateSortie.isAcceptableOrUnknown(
              data['date_sortie']!, _dateSortieMeta));
    } else if (isInserting) {
      context.missing(_dateSortieMeta);
    }
    if (data.containsKey('date_retour')) {
      context.handle(
          _dateRetourMeta,
          dateRetour.isAcceptableOrUnknown(
              data['date_retour']!, _dateRetourMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reservation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reservation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idVetement: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_vetement'])!,
      idClient: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_client'])!,
      dateReservation: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_reservation'])!,
      dateSortie: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_sortie'])!,
      dateRetour: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_retour']),
    );
  }

  @override
  $ReservationsTable createAlias(String alias) {
    return $ReservationsTable(attachedDatabase, alias);
  }
}

class Reservation extends DataClass implements Insertable<Reservation> {
  final int id;
  final int idVetement;
  final int idClient;
  final DateTime dateReservation;
  final DateTime dateSortie;
  final DateTime? dateRetour;
  const Reservation(
      {required this.id,
      required this.idVetement,
      required this.idClient,
      required this.dateReservation,
      required this.dateSortie,
      this.dateRetour});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_vetement'] = Variable<int>(idVetement);
    map['id_client'] = Variable<int>(idClient);
    map['date_reservation'] = Variable<DateTime>(dateReservation);
    map['date_sortie'] = Variable<DateTime>(dateSortie);
    if (!nullToAbsent || dateRetour != null) {
      map['date_retour'] = Variable<DateTime>(dateRetour);
    }
    return map;
  }

  ReservationsCompanion toCompanion(bool nullToAbsent) {
    return ReservationsCompanion(
      id: Value(id),
      idVetement: Value(idVetement),
      idClient: Value(idClient),
      dateReservation: Value(dateReservation),
      dateSortie: Value(dateSortie),
      dateRetour: dateRetour == null && nullToAbsent
          ? const Value.absent()
          : Value(dateRetour),
    );
  }

  factory Reservation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reservation(
      id: serializer.fromJson<int>(json['id']),
      idVetement: serializer.fromJson<int>(json['idVetement']),
      idClient: serializer.fromJson<int>(json['idClient']),
      dateReservation: serializer.fromJson<DateTime>(json['dateReservation']),
      dateSortie: serializer.fromJson<DateTime>(json['dateSortie']),
      dateRetour: serializer.fromJson<DateTime?>(json['dateRetour']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idVetement': serializer.toJson<int>(idVetement),
      'idClient': serializer.toJson<int>(idClient),
      'dateReservation': serializer.toJson<DateTime>(dateReservation),
      'dateSortie': serializer.toJson<DateTime>(dateSortie),
      'dateRetour': serializer.toJson<DateTime?>(dateRetour),
    };
  }

  Reservation copyWith(
          {int? id,
          int? idVetement,
          int? idClient,
          DateTime? dateReservation,
          DateTime? dateSortie,
          Value<DateTime?> dateRetour = const Value.absent()}) =>
      Reservation(
        id: id ?? this.id,
        idVetement: idVetement ?? this.idVetement,
        idClient: idClient ?? this.idClient,
        dateReservation: dateReservation ?? this.dateReservation,
        dateSortie: dateSortie ?? this.dateSortie,
        dateRetour: dateRetour.present ? dateRetour.value : this.dateRetour,
      );
  Reservation copyWithCompanion(ReservationsCompanion data) {
    return Reservation(
      id: data.id.present ? data.id.value : this.id,
      idVetement:
          data.idVetement.present ? data.idVetement.value : this.idVetement,
      idClient: data.idClient.present ? data.idClient.value : this.idClient,
      dateReservation: data.dateReservation.present
          ? data.dateReservation.value
          : this.dateReservation,
      dateSortie:
          data.dateSortie.present ? data.dateSortie.value : this.dateSortie,
      dateRetour:
          data.dateRetour.present ? data.dateRetour.value : this.dateRetour,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reservation(')
          ..write('id: $id, ')
          ..write('idVetement: $idVetement, ')
          ..write('idClient: $idClient, ')
          ..write('dateReservation: $dateReservation, ')
          ..write('dateSortie: $dateSortie, ')
          ..write('dateRetour: $dateRetour')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, idVetement, idClient, dateReservation, dateSortie, dateRetour);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reservation &&
          other.id == this.id &&
          other.idVetement == this.idVetement &&
          other.idClient == this.idClient &&
          other.dateReservation == this.dateReservation &&
          other.dateSortie == this.dateSortie &&
          other.dateRetour == this.dateRetour);
}

class ReservationsCompanion extends UpdateCompanion<Reservation> {
  final Value<int> id;
  final Value<int> idVetement;
  final Value<int> idClient;
  final Value<DateTime> dateReservation;
  final Value<DateTime> dateSortie;
  final Value<DateTime?> dateRetour;
  const ReservationsCompanion({
    this.id = const Value.absent(),
    this.idVetement = const Value.absent(),
    this.idClient = const Value.absent(),
    this.dateReservation = const Value.absent(),
    this.dateSortie = const Value.absent(),
    this.dateRetour = const Value.absent(),
  });
  ReservationsCompanion.insert({
    this.id = const Value.absent(),
    required int idVetement,
    required int idClient,
    required DateTime dateReservation,
    required DateTime dateSortie,
    this.dateRetour = const Value.absent(),
  })  : idVetement = Value(idVetement),
        idClient = Value(idClient),
        dateReservation = Value(dateReservation),
        dateSortie = Value(dateSortie);
  static Insertable<Reservation> custom({
    Expression<int>? id,
    Expression<int>? idVetement,
    Expression<int>? idClient,
    Expression<DateTime>? dateReservation,
    Expression<DateTime>? dateSortie,
    Expression<DateTime>? dateRetour,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idVetement != null) 'id_vetement': idVetement,
      if (idClient != null) 'id_client': idClient,
      if (dateReservation != null) 'date_reservation': dateReservation,
      if (dateSortie != null) 'date_sortie': dateSortie,
      if (dateRetour != null) 'date_retour': dateRetour,
    });
  }

  ReservationsCompanion copyWith(
      {Value<int>? id,
      Value<int>? idVetement,
      Value<int>? idClient,
      Value<DateTime>? dateReservation,
      Value<DateTime>? dateSortie,
      Value<DateTime?>? dateRetour}) {
    return ReservationsCompanion(
      id: id ?? this.id,
      idVetement: idVetement ?? this.idVetement,
      idClient: idClient ?? this.idClient,
      dateReservation: dateReservation ?? this.dateReservation,
      dateSortie: dateSortie ?? this.dateSortie,
      dateRetour: dateRetour ?? this.dateRetour,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idVetement.present) {
      map['id_vetement'] = Variable<int>(idVetement.value);
    }
    if (idClient.present) {
      map['id_client'] = Variable<int>(idClient.value);
    }
    if (dateReservation.present) {
      map['date_reservation'] = Variable<DateTime>(dateReservation.value);
    }
    if (dateSortie.present) {
      map['date_sortie'] = Variable<DateTime>(dateSortie.value);
    }
    if (dateRetour.present) {
      map['date_retour'] = Variable<DateTime>(dateRetour.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReservationsCompanion(')
          ..write('id: $id, ')
          ..write('idVetement: $idVetement, ')
          ..write('idClient: $idClient, ')
          ..write('dateReservation: $dateReservation, ')
          ..write('dateSortie: $dateSortie, ')
          ..write('dateRetour: $dateRetour')
          ..write(')'))
        .toString();
  }
}

class $CautionsTable extends Cautions with TableInfo<$CautionsTable, Caution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CautionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idReservationMeta =
      const VerificationMeta('idReservation');
  @override
  late final GeneratedColumn<int> idReservation = GeneratedColumn<int>(
      'id_reservation', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES reservations (id)'));
  static const VerificationMeta _statutMeta = const VerificationMeta('statut');
  @override
  late final GeneratedColumnWithTypeConverter<CautionStatus, String> statut =
      GeneratedColumn<String>('statut', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CautionStatus>($CautionsTable.$converterstatut);
  static const VerificationMeta _montantMeta =
      const VerificationMeta('montant');
  @override
  late final GeneratedColumn<double> montant = GeneratedColumn<double>(
      'montant', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateReceptionMeta =
      const VerificationMeta('dateReception');
  @override
  late final GeneratedColumn<DateTime> dateReception =
      GeneratedColumn<DateTime>('date_reception', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dateRenduMeta =
      const VerificationMeta('dateRendu');
  @override
  late final GeneratedColumn<DateTime> dateRendu = GeneratedColumn<DateTime>(
      'date_rendu', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, idReservation, statut, montant, dateReception, dateRendu];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cautions';
  @override
  VerificationContext validateIntegrity(Insertable<Caution> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_reservation')) {
      context.handle(
          _idReservationMeta,
          idReservation.isAcceptableOrUnknown(
              data['id_reservation']!, _idReservationMeta));
    } else if (isInserting) {
      context.missing(_idReservationMeta);
    }
    context.handle(_statutMeta, const VerificationResult.success());
    if (data.containsKey('montant')) {
      context.handle(_montantMeta,
          montant.isAcceptableOrUnknown(data['montant']!, _montantMeta));
    } else if (isInserting) {
      context.missing(_montantMeta);
    }
    if (data.containsKey('date_reception')) {
      context.handle(
          _dateReceptionMeta,
          dateReception.isAcceptableOrUnknown(
              data['date_reception']!, _dateReceptionMeta));
    } else if (isInserting) {
      context.missing(_dateReceptionMeta);
    }
    if (data.containsKey('date_rendu')) {
      context.handle(_dateRenduMeta,
          dateRendu.isAcceptableOrUnknown(data['date_rendu']!, _dateRenduMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Caution map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Caution(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idReservation: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_reservation'])!,
      statut: $CautionsTable.$converterstatut.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}statut'])!),
      montant: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}montant'])!,
      dateReception: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_reception'])!,
      dateRendu: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_rendu']),
    );
  }

  @override
  $CautionsTable createAlias(String alias) {
    return $CautionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CautionStatus, String, String> $converterstatut =
      const EnumNameConverter<CautionStatus>(CautionStatus.values);
}

class Caution extends DataClass implements Insertable<Caution> {
  final int id;
  final int idReservation;
  final CautionStatus statut;
  final double montant;
  final DateTime dateReception;
  final DateTime? dateRendu;
  const Caution(
      {required this.id,
      required this.idReservation,
      required this.statut,
      required this.montant,
      required this.dateReception,
      this.dateRendu});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_reservation'] = Variable<int>(idReservation);
    {
      map['statut'] =
          Variable<String>($CautionsTable.$converterstatut.toSql(statut));
    }
    map['montant'] = Variable<double>(montant);
    map['date_reception'] = Variable<DateTime>(dateReception);
    if (!nullToAbsent || dateRendu != null) {
      map['date_rendu'] = Variable<DateTime>(dateRendu);
    }
    return map;
  }

  CautionsCompanion toCompanion(bool nullToAbsent) {
    return CautionsCompanion(
      id: Value(id),
      idReservation: Value(idReservation),
      statut: Value(statut),
      montant: Value(montant),
      dateReception: Value(dateReception),
      dateRendu: dateRendu == null && nullToAbsent
          ? const Value.absent()
          : Value(dateRendu),
    );
  }

  factory Caution.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Caution(
      id: serializer.fromJson<int>(json['id']),
      idReservation: serializer.fromJson<int>(json['idReservation']),
      statut: $CautionsTable.$converterstatut
          .fromJson(serializer.fromJson<String>(json['statut'])),
      montant: serializer.fromJson<double>(json['montant']),
      dateReception: serializer.fromJson<DateTime>(json['dateReception']),
      dateRendu: serializer.fromJson<DateTime?>(json['dateRendu']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idReservation': serializer.toJson<int>(idReservation),
      'statut': serializer
          .toJson<String>($CautionsTable.$converterstatut.toJson(statut)),
      'montant': serializer.toJson<double>(montant),
      'dateReception': serializer.toJson<DateTime>(dateReception),
      'dateRendu': serializer.toJson<DateTime?>(dateRendu),
    };
  }

  Caution copyWith(
          {int? id,
          int? idReservation,
          CautionStatus? statut,
          double? montant,
          DateTime? dateReception,
          Value<DateTime?> dateRendu = const Value.absent()}) =>
      Caution(
        id: id ?? this.id,
        idReservation: idReservation ?? this.idReservation,
        statut: statut ?? this.statut,
        montant: montant ?? this.montant,
        dateReception: dateReception ?? this.dateReception,
        dateRendu: dateRendu.present ? dateRendu.value : this.dateRendu,
      );
  Caution copyWithCompanion(CautionsCompanion data) {
    return Caution(
      id: data.id.present ? data.id.value : this.id,
      idReservation: data.idReservation.present
          ? data.idReservation.value
          : this.idReservation,
      statut: data.statut.present ? data.statut.value : this.statut,
      montant: data.montant.present ? data.montant.value : this.montant,
      dateReception: data.dateReception.present
          ? data.dateReception.value
          : this.dateReception,
      dateRendu: data.dateRendu.present ? data.dateRendu.value : this.dateRendu,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Caution(')
          ..write('id: $id, ')
          ..write('idReservation: $idReservation, ')
          ..write('statut: $statut, ')
          ..write('montant: $montant, ')
          ..write('dateReception: $dateReception, ')
          ..write('dateRendu: $dateRendu')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, idReservation, statut, montant, dateReception, dateRendu);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Caution &&
          other.id == this.id &&
          other.idReservation == this.idReservation &&
          other.statut == this.statut &&
          other.montant == this.montant &&
          other.dateReception == this.dateReception &&
          other.dateRendu == this.dateRendu);
}

class CautionsCompanion extends UpdateCompanion<Caution> {
  final Value<int> id;
  final Value<int> idReservation;
  final Value<CautionStatus> statut;
  final Value<double> montant;
  final Value<DateTime> dateReception;
  final Value<DateTime?> dateRendu;
  const CautionsCompanion({
    this.id = const Value.absent(),
    this.idReservation = const Value.absent(),
    this.statut = const Value.absent(),
    this.montant = const Value.absent(),
    this.dateReception = const Value.absent(),
    this.dateRendu = const Value.absent(),
  });
  CautionsCompanion.insert({
    this.id = const Value.absent(),
    required int idReservation,
    required CautionStatus statut,
    required double montant,
    required DateTime dateReception,
    this.dateRendu = const Value.absent(),
  })  : idReservation = Value(idReservation),
        statut = Value(statut),
        montant = Value(montant),
        dateReception = Value(dateReception);
  static Insertable<Caution> custom({
    Expression<int>? id,
    Expression<int>? idReservation,
    Expression<String>? statut,
    Expression<double>? montant,
    Expression<DateTime>? dateReception,
    Expression<DateTime>? dateRendu,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idReservation != null) 'id_reservation': idReservation,
      if (statut != null) 'statut': statut,
      if (montant != null) 'montant': montant,
      if (dateReception != null) 'date_reception': dateReception,
      if (dateRendu != null) 'date_rendu': dateRendu,
    });
  }

  CautionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? idReservation,
      Value<CautionStatus>? statut,
      Value<double>? montant,
      Value<DateTime>? dateReception,
      Value<DateTime?>? dateRendu}) {
    return CautionsCompanion(
      id: id ?? this.id,
      idReservation: idReservation ?? this.idReservation,
      statut: statut ?? this.statut,
      montant: montant ?? this.montant,
      dateReception: dateReception ?? this.dateReception,
      dateRendu: dateRendu ?? this.dateRendu,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idReservation.present) {
      map['id_reservation'] = Variable<int>(idReservation.value);
    }
    if (statut.present) {
      map['statut'] =
          Variable<String>($CautionsTable.$converterstatut.toSql(statut.value));
    }
    if (montant.present) {
      map['montant'] = Variable<double>(montant.value);
    }
    if (dateReception.present) {
      map['date_reception'] = Variable<DateTime>(dateReception.value);
    }
    if (dateRendu.present) {
      map['date_rendu'] = Variable<DateTime>(dateRendu.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CautionsCompanion(')
          ..write('id: $id, ')
          ..write('idReservation: $idReservation, ')
          ..write('statut: $statut, ')
          ..write('montant: $montant, ')
          ..write('dateReception: $dateReception, ')
          ..write('dateRendu: $dateRendu')
          ..write(')'))
        .toString();
  }
}

class $AcomptesTable extends Acomptes with TableInfo<$AcomptesTable, Acompte> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AcomptesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idReservationMeta =
      const VerificationMeta('idReservation');
  @override
  late final GeneratedColumn<int> idReservation = GeneratedColumn<int>(
      'id_reservation', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES reservations (id)'));
  static const VerificationMeta _montantMeta =
      const VerificationMeta('montant');
  @override
  late final GeneratedColumn<double> montant = GeneratedColumn<double>(
      'montant', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _payeMeta = const VerificationMeta('paye');
  @override
  late final GeneratedColumn<int> paye = GeneratedColumn<int>(
      'paye', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _datePaiementMeta =
      const VerificationMeta('datePaiement');
  @override
  late final GeneratedColumn<DateTime> datePaiement = GeneratedColumn<DateTime>(
      'date_paiement', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, idReservation, montant, paye, datePaiement];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'acomptes';
  @override
  VerificationContext validateIntegrity(Insertable<Acompte> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_reservation')) {
      context.handle(
          _idReservationMeta,
          idReservation.isAcceptableOrUnknown(
              data['id_reservation']!, _idReservationMeta));
    } else if (isInserting) {
      context.missing(_idReservationMeta);
    }
    if (data.containsKey('montant')) {
      context.handle(_montantMeta,
          montant.isAcceptableOrUnknown(data['montant']!, _montantMeta));
    } else if (isInserting) {
      context.missing(_montantMeta);
    }
    if (data.containsKey('paye')) {
      context.handle(
          _payeMeta, paye.isAcceptableOrUnknown(data['paye']!, _payeMeta));
    } else if (isInserting) {
      context.missing(_payeMeta);
    }
    if (data.containsKey('date_paiement')) {
      context.handle(
          _datePaiementMeta,
          datePaiement.isAcceptableOrUnknown(
              data['date_paiement']!, _datePaiementMeta));
    } else if (isInserting) {
      context.missing(_datePaiementMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Acompte map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Acompte(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idReservation: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_reservation'])!,
      montant: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}montant'])!,
      paye: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paye'])!,
      datePaiement: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_paiement'])!,
    );
  }

  @override
  $AcomptesTable createAlias(String alias) {
    return $AcomptesTable(attachedDatabase, alias);
  }
}

class Acompte extends DataClass implements Insertable<Acompte> {
  final int id;
  final int idReservation;
  final double montant;
  final int paye;
  final DateTime datePaiement;
  const Acompte(
      {required this.id,
      required this.idReservation,
      required this.montant,
      required this.paye,
      required this.datePaiement});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_reservation'] = Variable<int>(idReservation);
    map['montant'] = Variable<double>(montant);
    map['paye'] = Variable<int>(paye);
    map['date_paiement'] = Variable<DateTime>(datePaiement);
    return map;
  }

  AcomptesCompanion toCompanion(bool nullToAbsent) {
    return AcomptesCompanion(
      id: Value(id),
      idReservation: Value(idReservation),
      montant: Value(montant),
      paye: Value(paye),
      datePaiement: Value(datePaiement),
    );
  }

  factory Acompte.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Acompte(
      id: serializer.fromJson<int>(json['id']),
      idReservation: serializer.fromJson<int>(json['idReservation']),
      montant: serializer.fromJson<double>(json['montant']),
      paye: serializer.fromJson<int>(json['paye']),
      datePaiement: serializer.fromJson<DateTime>(json['datePaiement']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idReservation': serializer.toJson<int>(idReservation),
      'montant': serializer.toJson<double>(montant),
      'paye': serializer.toJson<int>(paye),
      'datePaiement': serializer.toJson<DateTime>(datePaiement),
    };
  }

  Acompte copyWith(
          {int? id,
          int? idReservation,
          double? montant,
          int? paye,
          DateTime? datePaiement}) =>
      Acompte(
        id: id ?? this.id,
        idReservation: idReservation ?? this.idReservation,
        montant: montant ?? this.montant,
        paye: paye ?? this.paye,
        datePaiement: datePaiement ?? this.datePaiement,
      );
  Acompte copyWithCompanion(AcomptesCompanion data) {
    return Acompte(
      id: data.id.present ? data.id.value : this.id,
      idReservation: data.idReservation.present
          ? data.idReservation.value
          : this.idReservation,
      montant: data.montant.present ? data.montant.value : this.montant,
      paye: data.paye.present ? data.paye.value : this.paye,
      datePaiement: data.datePaiement.present
          ? data.datePaiement.value
          : this.datePaiement,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Acompte(')
          ..write('id: $id, ')
          ..write('idReservation: $idReservation, ')
          ..write('montant: $montant, ')
          ..write('paye: $paye, ')
          ..write('datePaiement: $datePaiement')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, idReservation, montant, paye, datePaiement);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Acompte &&
          other.id == this.id &&
          other.idReservation == this.idReservation &&
          other.montant == this.montant &&
          other.paye == this.paye &&
          other.datePaiement == this.datePaiement);
}

class AcomptesCompanion extends UpdateCompanion<Acompte> {
  final Value<int> id;
  final Value<int> idReservation;
  final Value<double> montant;
  final Value<int> paye;
  final Value<DateTime> datePaiement;
  const AcomptesCompanion({
    this.id = const Value.absent(),
    this.idReservation = const Value.absent(),
    this.montant = const Value.absent(),
    this.paye = const Value.absent(),
    this.datePaiement = const Value.absent(),
  });
  AcomptesCompanion.insert({
    this.id = const Value.absent(),
    required int idReservation,
    required double montant,
    required int paye,
    required DateTime datePaiement,
  })  : idReservation = Value(idReservation),
        montant = Value(montant),
        paye = Value(paye),
        datePaiement = Value(datePaiement);
  static Insertable<Acompte> custom({
    Expression<int>? id,
    Expression<int>? idReservation,
    Expression<double>? montant,
    Expression<int>? paye,
    Expression<DateTime>? datePaiement,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idReservation != null) 'id_reservation': idReservation,
      if (montant != null) 'montant': montant,
      if (paye != null) 'paye': paye,
      if (datePaiement != null) 'date_paiement': datePaiement,
    });
  }

  AcomptesCompanion copyWith(
      {Value<int>? id,
      Value<int>? idReservation,
      Value<double>? montant,
      Value<int>? paye,
      Value<DateTime>? datePaiement}) {
    return AcomptesCompanion(
      id: id ?? this.id,
      idReservation: idReservation ?? this.idReservation,
      montant: montant ?? this.montant,
      paye: paye ?? this.paye,
      datePaiement: datePaiement ?? this.datePaiement,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idReservation.present) {
      map['id_reservation'] = Variable<int>(idReservation.value);
    }
    if (montant.present) {
      map['montant'] = Variable<double>(montant.value);
    }
    if (paye.present) {
      map['paye'] = Variable<int>(paye.value);
    }
    if (datePaiement.present) {
      map['date_paiement'] = Variable<DateTime>(datePaiement.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AcomptesCompanion(')
          ..write('id: $id, ')
          ..write('idReservation: $idReservation, ')
          ..write('montant: $montant, ')
          ..write('paye: $paye, ')
          ..write('datePaiement: $datePaiement')
          ..write(')'))
        .toString();
  }
}

class $RendezVousTable extends RendezVous
    with TableInfo<$RendezVousTable, RendezVousData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RendezVousTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idClientMeta =
      const VerificationMeta('idClient');
  @override
  late final GeneratedColumn<int> idClient = GeneratedColumn<int>(
      'id_client', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _heureMeta = const VerificationMeta('heure');
  @override
  late final GeneratedColumn<String> heure = GeneratedColumn<String>(
      'heure', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dureeMeta = const VerificationMeta('duree');
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int> duree =
      GeneratedColumn<int>('duree', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Duration>($RendezVousTable.$converterduree);
  static const VerificationMeta _motifMeta = const VerificationMeta('motif');
  @override
  late final GeneratedColumnWithTypeConverter<MotifRendezVous, String> motif =
      GeneratedColumn<String>('motif', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MotifRendezVous>($RendezVousTable.$convertermotif);
  @override
  List<GeneratedColumn> get $columns =>
      [id, idClient, date, heure, duree, motif];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rendez_vous';
  @override
  VerificationContext validateIntegrity(Insertable<RendezVousData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_client')) {
      context.handle(_idClientMeta,
          idClient.isAcceptableOrUnknown(data['id_client']!, _idClientMeta));
    } else if (isInserting) {
      context.missing(_idClientMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('heure')) {
      context.handle(
          _heureMeta, heure.isAcceptableOrUnknown(data['heure']!, _heureMeta));
    } else if (isInserting) {
      context.missing(_heureMeta);
    }
    context.handle(_dureeMeta, const VerificationResult.success());
    context.handle(_motifMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RendezVousData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RendezVousData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idClient: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_client'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      heure: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}heure'])!,
      duree: $RendezVousTable.$converterduree.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duree'])!),
      motif: $RendezVousTable.$convertermotif.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}motif'])!),
    );
  }

  @override
  $RendezVousTable createAlias(String alias) {
    return $RendezVousTable(attachedDatabase, alias);
  }

  static TypeConverter<Duration, int> $converterduree =
      const DurationConverter();
  static JsonTypeConverter2<MotifRendezVous, String, String> $convertermotif =
      const EnumNameConverter<MotifRendezVous>(MotifRendezVous.values);
}

class RendezVousData extends DataClass implements Insertable<RendezVousData> {
  final int id;
  final int idClient;
  final DateTime date;
  final String heure;
  final Duration duree;
  final MotifRendezVous motif;
  const RendezVousData(
      {required this.id,
      required this.idClient,
      required this.date,
      required this.heure,
      required this.duree,
      required this.motif});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_client'] = Variable<int>(idClient);
    map['date'] = Variable<DateTime>(date);
    map['heure'] = Variable<String>(heure);
    {
      map['duree'] =
          Variable<int>($RendezVousTable.$converterduree.toSql(duree));
    }
    {
      map['motif'] =
          Variable<String>($RendezVousTable.$convertermotif.toSql(motif));
    }
    return map;
  }

  RendezVousCompanion toCompanion(bool nullToAbsent) {
    return RendezVousCompanion(
      id: Value(id),
      idClient: Value(idClient),
      date: Value(date),
      heure: Value(heure),
      duree: Value(duree),
      motif: Value(motif),
    );
  }

  factory RendezVousData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RendezVousData(
      id: serializer.fromJson<int>(json['id']),
      idClient: serializer.fromJson<int>(json['idClient']),
      date: serializer.fromJson<DateTime>(json['date']),
      heure: serializer.fromJson<String>(json['heure']),
      duree: serializer.fromJson<Duration>(json['duree']),
      motif: $RendezVousTable.$convertermotif
          .fromJson(serializer.fromJson<String>(json['motif'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idClient': serializer.toJson<int>(idClient),
      'date': serializer.toJson<DateTime>(date),
      'heure': serializer.toJson<String>(heure),
      'duree': serializer.toJson<Duration>(duree),
      'motif': serializer
          .toJson<String>($RendezVousTable.$convertermotif.toJson(motif)),
    };
  }

  RendezVousData copyWith(
          {int? id,
          int? idClient,
          DateTime? date,
          String? heure,
          Duration? duree,
          MotifRendezVous? motif}) =>
      RendezVousData(
        id: id ?? this.id,
        idClient: idClient ?? this.idClient,
        date: date ?? this.date,
        heure: heure ?? this.heure,
        duree: duree ?? this.duree,
        motif: motif ?? this.motif,
      );
  RendezVousData copyWithCompanion(RendezVousCompanion data) {
    return RendezVousData(
      id: data.id.present ? data.id.value : this.id,
      idClient: data.idClient.present ? data.idClient.value : this.idClient,
      date: data.date.present ? data.date.value : this.date,
      heure: data.heure.present ? data.heure.value : this.heure,
      duree: data.duree.present ? data.duree.value : this.duree,
      motif: data.motif.present ? data.motif.value : this.motif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RendezVousData(')
          ..write('id: $id, ')
          ..write('idClient: $idClient, ')
          ..write('date: $date, ')
          ..write('heure: $heure, ')
          ..write('duree: $duree, ')
          ..write('motif: $motif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idClient, date, heure, duree, motif);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RendezVousData &&
          other.id == this.id &&
          other.idClient == this.idClient &&
          other.date == this.date &&
          other.heure == this.heure &&
          other.duree == this.duree &&
          other.motif == this.motif);
}

class RendezVousCompanion extends UpdateCompanion<RendezVousData> {
  final Value<int> id;
  final Value<int> idClient;
  final Value<DateTime> date;
  final Value<String> heure;
  final Value<Duration> duree;
  final Value<MotifRendezVous> motif;
  const RendezVousCompanion({
    this.id = const Value.absent(),
    this.idClient = const Value.absent(),
    this.date = const Value.absent(),
    this.heure = const Value.absent(),
    this.duree = const Value.absent(),
    this.motif = const Value.absent(),
  });
  RendezVousCompanion.insert({
    this.id = const Value.absent(),
    required int idClient,
    required DateTime date,
    required String heure,
    required Duration duree,
    required MotifRendezVous motif,
  })  : idClient = Value(idClient),
        date = Value(date),
        heure = Value(heure),
        duree = Value(duree),
        motif = Value(motif);
  static Insertable<RendezVousData> custom({
    Expression<int>? id,
    Expression<int>? idClient,
    Expression<DateTime>? date,
    Expression<String>? heure,
    Expression<int>? duree,
    Expression<String>? motif,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idClient != null) 'id_client': idClient,
      if (date != null) 'date': date,
      if (heure != null) 'heure': heure,
      if (duree != null) 'duree': duree,
      if (motif != null) 'motif': motif,
    });
  }

  RendezVousCompanion copyWith(
      {Value<int>? id,
      Value<int>? idClient,
      Value<DateTime>? date,
      Value<String>? heure,
      Value<Duration>? duree,
      Value<MotifRendezVous>? motif}) {
    return RendezVousCompanion(
      id: id ?? this.id,
      idClient: idClient ?? this.idClient,
      date: date ?? this.date,
      heure: heure ?? this.heure,
      duree: duree ?? this.duree,
      motif: motif ?? this.motif,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idClient.present) {
      map['id_client'] = Variable<int>(idClient.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (heure.present) {
      map['heure'] = Variable<String>(heure.value);
    }
    if (duree.present) {
      map['duree'] =
          Variable<int>($RendezVousTable.$converterduree.toSql(duree.value));
    }
    if (motif.present) {
      map['motif'] =
          Variable<String>($RendezVousTable.$convertermotif.toSql(motif.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RendezVousCompanion(')
          ..write('id: $id, ')
          ..write('idClient: $idClient, ')
          ..write('date: $date, ')
          ..write('heure: $heure, ')
          ..write('duree: $duree, ')
          ..write('motif: $motif')
          ..write(')'))
        .toString();
  }
}

class $FavorisTable extends Favoris with TableInfo<$FavorisTable, Favori> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavorisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idClientMeta =
      const VerificationMeta('idClient');
  @override
  late final GeneratedColumn<int> idClient = GeneratedColumn<int>(
      'id_client', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
  static const VerificationMeta _idVetementMeta =
      const VerificationMeta('idVetement');
  @override
  late final GeneratedColumn<int> idVetement = GeneratedColumn<int>(
      'id_vetement', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES vetements (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, idClient, idVetement];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favoris';
  @override
  VerificationContext validateIntegrity(Insertable<Favori> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_client')) {
      context.handle(_idClientMeta,
          idClient.isAcceptableOrUnknown(data['id_client']!, _idClientMeta));
    } else if (isInserting) {
      context.missing(_idClientMeta);
    }
    if (data.containsKey('id_vetement')) {
      context.handle(
          _idVetementMeta,
          idVetement.isAcceptableOrUnknown(
              data['id_vetement']!, _idVetementMeta));
    } else if (isInserting) {
      context.missing(_idVetementMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Favori map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favori(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idClient: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_client'])!,
      idVetement: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_vetement'])!,
    );
  }

  @override
  $FavorisTable createAlias(String alias) {
    return $FavorisTable(attachedDatabase, alias);
  }
}

class Favori extends DataClass implements Insertable<Favori> {
  final int id;
  final int idClient;
  final int idVetement;
  const Favori(
      {required this.id, required this.idClient, required this.idVetement});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_client'] = Variable<int>(idClient);
    map['id_vetement'] = Variable<int>(idVetement);
    return map;
  }

  FavorisCompanion toCompanion(bool nullToAbsent) {
    return FavorisCompanion(
      id: Value(id),
      idClient: Value(idClient),
      idVetement: Value(idVetement),
    );
  }

  factory Favori.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favori(
      id: serializer.fromJson<int>(json['id']),
      idClient: serializer.fromJson<int>(json['idClient']),
      idVetement: serializer.fromJson<int>(json['idVetement']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idClient': serializer.toJson<int>(idClient),
      'idVetement': serializer.toJson<int>(idVetement),
    };
  }

  Favori copyWith({int? id, int? idClient, int? idVetement}) => Favori(
        id: id ?? this.id,
        idClient: idClient ?? this.idClient,
        idVetement: idVetement ?? this.idVetement,
      );
  Favori copyWithCompanion(FavorisCompanion data) {
    return Favori(
      id: data.id.present ? data.id.value : this.id,
      idClient: data.idClient.present ? data.idClient.value : this.idClient,
      idVetement:
          data.idVetement.present ? data.idVetement.value : this.idVetement,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favori(')
          ..write('id: $id, ')
          ..write('idClient: $idClient, ')
          ..write('idVetement: $idVetement')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idClient, idVetement);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favori &&
          other.id == this.id &&
          other.idClient == this.idClient &&
          other.idVetement == this.idVetement);
}

class FavorisCompanion extends UpdateCompanion<Favori> {
  final Value<int> id;
  final Value<int> idClient;
  final Value<int> idVetement;
  const FavorisCompanion({
    this.id = const Value.absent(),
    this.idClient = const Value.absent(),
    this.idVetement = const Value.absent(),
  });
  FavorisCompanion.insert({
    this.id = const Value.absent(),
    required int idClient,
    required int idVetement,
  })  : idClient = Value(idClient),
        idVetement = Value(idVetement);
  static Insertable<Favori> custom({
    Expression<int>? id,
    Expression<int>? idClient,
    Expression<int>? idVetement,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idClient != null) 'id_client': idClient,
      if (idVetement != null) 'id_vetement': idVetement,
    });
  }

  FavorisCompanion copyWith(
      {Value<int>? id, Value<int>? idClient, Value<int>? idVetement}) {
    return FavorisCompanion(
      id: id ?? this.id,
      idClient: idClient ?? this.idClient,
      idVetement: idVetement ?? this.idVetement,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idClient.present) {
      map['id_client'] = Variable<int>(idClient.value);
    }
    if (idVetement.present) {
      map['id_vetement'] = Variable<int>(idVetement.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavorisCompanion(')
          ..write('id: $id, ')
          ..write('idClient: $idClient, ')
          ..write('idVetement: $idVetement')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VetementsTable vetements = $VetementsTable(this);
  late final $PhotosTable photos = $PhotosTable(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $ReservationsTable reservations = $ReservationsTable(this);
  late final $CautionsTable cautions = $CautionsTable(this);
  late final $AcomptesTable acomptes = $AcomptesTable(this);
  late final $RendezVousTable rendezVous = $RendezVousTable(this);
  late final $FavorisTable favoris = $FavorisTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        vetements,
        photos,
        clients,
        reservations,
        cautions,
        acomptes,
        rendezVous,
        favoris
      ];
}

typedef $$VetementsTableCreateCompanionBuilder = VetementsCompanion Function({
  Value<int> id,
  required String nom,
  required String couleurs,
  required String category,
  Value<double?> tourTaille,
  required double longueurTotale,
  Value<double?> tourPoitrine,
  required double prix,
  Value<String?> commentaire,
});
typedef $$VetementsTableUpdateCompanionBuilder = VetementsCompanion Function({
  Value<int> id,
  Value<String> nom,
  Value<String> couleurs,
  Value<String> category,
  Value<double?> tourTaille,
  Value<double> longueurTotale,
  Value<double?> tourPoitrine,
  Value<double> prix,
  Value<String?> commentaire,
});

final class $$VetementsTableReferences
    extends BaseReferences<_$AppDatabase, $VetementsTable, Vetement> {
  $$VetementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PhotosTable, List<Photo>> _photosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.photos,
          aliasName:
              $_aliasNameGenerator(db.vetements.id, db.photos.idVetement));

  $$PhotosTableProcessedTableManager get photosRefs {
    final manager = $$PhotosTableTableManager($_db, $_db.photos)
        .filter((f) => f.idVetement.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_photosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ReservationsTable, List<Reservation>>
      _reservationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.reservations,
              aliasName: $_aliasNameGenerator(
                  db.vetements.id, db.reservations.idVetement));

  $$ReservationsTableProcessedTableManager get reservationsRefs {
    final manager = $$ReservationsTableTableManager($_db, $_db.reservations)
        .filter((f) => f.idVetement.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reservationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FavorisTable, List<Favori>> _favorisRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.favoris,
          aliasName:
              $_aliasNameGenerator(db.vetements.id, db.favoris.idVetement));

  $$FavorisTableProcessedTableManager get favorisRefs {
    final manager = $$FavorisTableTableManager($_db, $_db.favoris)
        .filter((f) => f.idVetement.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_favorisRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$VetementsTableFilterComposer
    extends Composer<_$AppDatabase, $VetementsTable> {
  $$VetementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nom => $composableBuilder(
      column: $table.nom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get couleurs => $composableBuilder(
      column: $table.couleurs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get tourTaille => $composableBuilder(
      column: $table.tourTaille, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longueurTotale => $composableBuilder(
      column: $table.longueurTotale,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get tourPoitrine => $composableBuilder(
      column: $table.tourPoitrine, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get prix => $composableBuilder(
      column: $table.prix, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get commentaire => $composableBuilder(
      column: $table.commentaire, builder: (column) => ColumnFilters(column));

  Expression<bool> photosRefs(
      Expression<bool> Function($$PhotosTableFilterComposer f) f) {
    final $$PhotosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.photos,
        getReferencedColumn: (t) => t.idVetement,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PhotosTableFilterComposer(
              $db: $db,
              $table: $db.photos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> reservationsRefs(
      Expression<bool> Function($$ReservationsTableFilterComposer f) f) {
    final $$ReservationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reservations,
        getReferencedColumn: (t) => t.idVetement,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReservationsTableFilterComposer(
              $db: $db,
              $table: $db.reservations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> favorisRefs(
      Expression<bool> Function($$FavorisTableFilterComposer f) f) {
    final $$FavorisTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favoris,
        getReferencedColumn: (t) => t.idVetement,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavorisTableFilterComposer(
              $db: $db,
              $table: $db.favoris,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VetementsTableOrderingComposer
    extends Composer<_$AppDatabase, $VetementsTable> {
  $$VetementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nom => $composableBuilder(
      column: $table.nom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get couleurs => $composableBuilder(
      column: $table.couleurs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get tourTaille => $composableBuilder(
      column: $table.tourTaille, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longueurTotale => $composableBuilder(
      column: $table.longueurTotale,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get tourPoitrine => $composableBuilder(
      column: $table.tourPoitrine,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get prix => $composableBuilder(
      column: $table.prix, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get commentaire => $composableBuilder(
      column: $table.commentaire, builder: (column) => ColumnOrderings(column));
}

class $$VetementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VetementsTable> {
  $$VetementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get couleurs =>
      $composableBuilder(column: $table.couleurs, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get tourTaille => $composableBuilder(
      column: $table.tourTaille, builder: (column) => column);

  GeneratedColumn<double> get longueurTotale => $composableBuilder(
      column: $table.longueurTotale, builder: (column) => column);

  GeneratedColumn<double> get tourPoitrine => $composableBuilder(
      column: $table.tourPoitrine, builder: (column) => column);

  GeneratedColumn<double> get prix =>
      $composableBuilder(column: $table.prix, builder: (column) => column);

  GeneratedColumn<String> get commentaire => $composableBuilder(
      column: $table.commentaire, builder: (column) => column);

  Expression<T> photosRefs<T extends Object>(
      Expression<T> Function($$PhotosTableAnnotationComposer a) f) {
    final $$PhotosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.photos,
        getReferencedColumn: (t) => t.idVetement,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PhotosTableAnnotationComposer(
              $db: $db,
              $table: $db.photos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> reservationsRefs<T extends Object>(
      Expression<T> Function($$ReservationsTableAnnotationComposer a) f) {
    final $$ReservationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reservations,
        getReferencedColumn: (t) => t.idVetement,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReservationsTableAnnotationComposer(
              $db: $db,
              $table: $db.reservations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> favorisRefs<T extends Object>(
      Expression<T> Function($$FavorisTableAnnotationComposer a) f) {
    final $$FavorisTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favoris,
        getReferencedColumn: (t) => t.idVetement,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavorisTableAnnotationComposer(
              $db: $db,
              $table: $db.favoris,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VetementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VetementsTable,
    Vetement,
    $$VetementsTableFilterComposer,
    $$VetementsTableOrderingComposer,
    $$VetementsTableAnnotationComposer,
    $$VetementsTableCreateCompanionBuilder,
    $$VetementsTableUpdateCompanionBuilder,
    (Vetement, $$VetementsTableReferences),
    Vetement,
    PrefetchHooks Function(
        {bool photosRefs, bool reservationsRefs, bool favorisRefs})> {
  $$VetementsTableTableManager(_$AppDatabase db, $VetementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VetementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VetementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VetementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nom = const Value.absent(),
            Value<String> couleurs = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<double?> tourTaille = const Value.absent(),
            Value<double> longueurTotale = const Value.absent(),
            Value<double?> tourPoitrine = const Value.absent(),
            Value<double> prix = const Value.absent(),
            Value<String?> commentaire = const Value.absent(),
          }) =>
              VetementsCompanion(
            id: id,
            nom: nom,
            couleurs: couleurs,
            category: category,
            tourTaille: tourTaille,
            longueurTotale: longueurTotale,
            tourPoitrine: tourPoitrine,
            prix: prix,
            commentaire: commentaire,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nom,
            required String couleurs,
            required String category,
            Value<double?> tourTaille = const Value.absent(),
            required double longueurTotale,
            Value<double?> tourPoitrine = const Value.absent(),
            required double prix,
            Value<String?> commentaire = const Value.absent(),
          }) =>
              VetementsCompanion.insert(
            id: id,
            nom: nom,
            couleurs: couleurs,
            category: category,
            tourTaille: tourTaille,
            longueurTotale: longueurTotale,
            tourPoitrine: tourPoitrine,
            prix: prix,
            commentaire: commentaire,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$VetementsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {photosRefs = false,
              reservationsRefs = false,
              favorisRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (photosRefs) db.photos,
                if (reservationsRefs) db.reservations,
                if (favorisRefs) db.favoris
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (photosRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$VetementsTableReferences._photosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VetementsTableReferences(db, table, p0)
                                .photosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idVetement == item.id),
                        typedResults: items),
                  if (reservationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$VetementsTableReferences
                            ._reservationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VetementsTableReferences(db, table, p0)
                                .reservationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idVetement == item.id),
                        typedResults: items),
                  if (favorisRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$VetementsTableReferences._favorisRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VetementsTableReferences(db, table, p0)
                                .favorisRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idVetement == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$VetementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VetementsTable,
    Vetement,
    $$VetementsTableFilterComposer,
    $$VetementsTableOrderingComposer,
    $$VetementsTableAnnotationComposer,
    $$VetementsTableCreateCompanionBuilder,
    $$VetementsTableUpdateCompanionBuilder,
    (Vetement, $$VetementsTableReferences),
    Vetement,
    PrefetchHooks Function(
        {bool photosRefs, bool reservationsRefs, bool favorisRefs})>;
typedef $$PhotosTableCreateCompanionBuilder = PhotosCompanion Function({
  Value<int> id,
  required int idVetement,
  required String url,
});
typedef $$PhotosTableUpdateCompanionBuilder = PhotosCompanion Function({
  Value<int> id,
  Value<int> idVetement,
  Value<String> url,
});

final class $$PhotosTableReferences
    extends BaseReferences<_$AppDatabase, $PhotosTable, Photo> {
  $$PhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VetementsTable _idVetementTable(_$AppDatabase db) => db.vetements
      .createAlias($_aliasNameGenerator(db.photos.idVetement, db.vetements.id));

  $$VetementsTableProcessedTableManager get idVetement {
    final $_column = $_itemColumn<int>('id_vetement')!;

    final manager = $$VetementsTableTableManager($_db, $_db.vetements)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idVetementTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PhotosTableFilterComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  $$VetementsTableFilterComposer get idVetement {
    final $$VetementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idVetement,
        referencedTable: $db.vetements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VetementsTableFilterComposer(
              $db: $db,
              $table: $db.vetements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  $$VetementsTableOrderingComposer get idVetement {
    final $$VetementsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idVetement,
        referencedTable: $db.vetements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VetementsTableOrderingComposer(
              $db: $db,
              $table: $db.vetements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  $$VetementsTableAnnotationComposer get idVetement {
    final $$VetementsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idVetement,
        referencedTable: $db.vetements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VetementsTableAnnotationComposer(
              $db: $db,
              $table: $db.vetements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PhotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhotosTable,
    Photo,
    $$PhotosTableFilterComposer,
    $$PhotosTableOrderingComposer,
    $$PhotosTableAnnotationComposer,
    $$PhotosTableCreateCompanionBuilder,
    $$PhotosTableUpdateCompanionBuilder,
    (Photo, $$PhotosTableReferences),
    Photo,
    PrefetchHooks Function({bool idVetement})> {
  $$PhotosTableTableManager(_$AppDatabase db, $PhotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> idVetement = const Value.absent(),
            Value<String> url = const Value.absent(),
          }) =>
              PhotosCompanion(
            id: id,
            idVetement: idVetement,
            url: url,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int idVetement,
            required String url,
          }) =>
              PhotosCompanion.insert(
            id: id,
            idVetement: idVetement,
            url: url,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PhotosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({idVetement = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idVetement) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idVetement,
                    referencedTable:
                        $$PhotosTableReferences._idVetementTable(db),
                    referencedColumn:
                        $$PhotosTableReferences._idVetementTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PhotosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PhotosTable,
    Photo,
    $$PhotosTableFilterComposer,
    $$PhotosTableOrderingComposer,
    $$PhotosTableAnnotationComposer,
    $$PhotosTableCreateCompanionBuilder,
    $$PhotosTableUpdateCompanionBuilder,
    (Photo, $$PhotosTableReferences),
    Photo,
    PrefetchHooks Function({bool idVetement})>;
typedef $$ClientsTableCreateCompanionBuilder = ClientsCompanion Function({
  Value<int> id,
  required String nom,
  required String prenom,
  required String adresse,
  required String numero,
  Value<String?> mail,
});
typedef $$ClientsTableUpdateCompanionBuilder = ClientsCompanion Function({
  Value<int> id,
  Value<String> nom,
  Value<String> prenom,
  Value<String> adresse,
  Value<String> numero,
  Value<String?> mail,
});

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ReservationsTable, List<Reservation>>
      _reservationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.reservations,
          aliasName:
              $_aliasNameGenerator(db.clients.id, db.reservations.idClient));

  $$ReservationsTableProcessedTableManager get reservationsRefs {
    final manager = $$ReservationsTableTableManager($_db, $_db.reservations)
        .filter((f) => f.idClient.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reservationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RendezVousTable, List<RendezVousData>>
      _rendezVousRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.rendezVous,
              aliasName:
                  $_aliasNameGenerator(db.clients.id, db.rendezVous.idClient));

  $$RendezVousTableProcessedTableManager get rendezVousRefs {
    final manager = $$RendezVousTableTableManager($_db, $_db.rendezVous)
        .filter((f) => f.idClient.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_rendezVousRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FavorisTable, List<Favori>> _favorisRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.favoris,
          aliasName: $_aliasNameGenerator(db.clients.id, db.favoris.idClient));

  $$FavorisTableProcessedTableManager get favorisRefs {
    final manager = $$FavorisTableTableManager($_db, $_db.favoris)
        .filter((f) => f.idClient.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_favorisRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nom => $composableBuilder(
      column: $table.nom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prenom => $composableBuilder(
      column: $table.prenom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get adresse => $composableBuilder(
      column: $table.adresse, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mail => $composableBuilder(
      column: $table.mail, builder: (column) => ColumnFilters(column));

  Expression<bool> reservationsRefs(
      Expression<bool> Function($$ReservationsTableFilterComposer f) f) {
    final $$ReservationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reservations,
        getReferencedColumn: (t) => t.idClient,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReservationsTableFilterComposer(
              $db: $db,
              $table: $db.reservations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> rendezVousRefs(
      Expression<bool> Function($$RendezVousTableFilterComposer f) f) {
    final $$RendezVousTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rendezVous,
        getReferencedColumn: (t) => t.idClient,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RendezVousTableFilterComposer(
              $db: $db,
              $table: $db.rendezVous,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> favorisRefs(
      Expression<bool> Function($$FavorisTableFilterComposer f) f) {
    final $$FavorisTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favoris,
        getReferencedColumn: (t) => t.idClient,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavorisTableFilterComposer(
              $db: $db,
              $table: $db.favoris,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nom => $composableBuilder(
      column: $table.nom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prenom => $composableBuilder(
      column: $table.prenom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get adresse => $composableBuilder(
      column: $table.adresse, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mail => $composableBuilder(
      column: $table.mail, builder: (column) => ColumnOrderings(column));
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get prenom =>
      $composableBuilder(column: $table.prenom, builder: (column) => column);

  GeneratedColumn<String> get adresse =>
      $composableBuilder(column: $table.adresse, builder: (column) => column);

  GeneratedColumn<String> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<String> get mail =>
      $composableBuilder(column: $table.mail, builder: (column) => column);

  Expression<T> reservationsRefs<T extends Object>(
      Expression<T> Function($$ReservationsTableAnnotationComposer a) f) {
    final $$ReservationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reservations,
        getReferencedColumn: (t) => t.idClient,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReservationsTableAnnotationComposer(
              $db: $db,
              $table: $db.reservations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> rendezVousRefs<T extends Object>(
      Expression<T> Function($$RendezVousTableAnnotationComposer a) f) {
    final $$RendezVousTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rendezVous,
        getReferencedColumn: (t) => t.idClient,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RendezVousTableAnnotationComposer(
              $db: $db,
              $table: $db.rendezVous,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> favorisRefs<T extends Object>(
      Expression<T> Function($$FavorisTableAnnotationComposer a) f) {
    final $$FavorisTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favoris,
        getReferencedColumn: (t) => t.idClient,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavorisTableAnnotationComposer(
              $db: $db,
              $table: $db.favoris,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientsTable,
    Client,
    $$ClientsTableFilterComposer,
    $$ClientsTableOrderingComposer,
    $$ClientsTableAnnotationComposer,
    $$ClientsTableCreateCompanionBuilder,
    $$ClientsTableUpdateCompanionBuilder,
    (Client, $$ClientsTableReferences),
    Client,
    PrefetchHooks Function(
        {bool reservationsRefs, bool rendezVousRefs, bool favorisRefs})> {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nom = const Value.absent(),
            Value<String> prenom = const Value.absent(),
            Value<String> adresse = const Value.absent(),
            Value<String> numero = const Value.absent(),
            Value<String?> mail = const Value.absent(),
          }) =>
              ClientsCompanion(
            id: id,
            nom: nom,
            prenom: prenom,
            adresse: adresse,
            numero: numero,
            mail: mail,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nom,
            required String prenom,
            required String adresse,
            required String numero,
            Value<String?> mail = const Value.absent(),
          }) =>
              ClientsCompanion.insert(
            id: id,
            nom: nom,
            prenom: prenom,
            adresse: adresse,
            numero: numero,
            mail: mail,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ClientsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {reservationsRefs = false,
              rendezVousRefs = false,
              favorisRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reservationsRefs) db.reservations,
                if (rendezVousRefs) db.rendezVous,
                if (favorisRefs) db.favoris
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reservationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ClientsTableReferences._reservationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientsTableReferences(db, table, p0)
                                .reservationsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.idClient == item.id),
                        typedResults: items),
                  if (rendezVousRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ClientsTableReferences._rendezVousRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientsTableReferences(db, table, p0)
                                .rendezVousRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.idClient == item.id),
                        typedResults: items),
                  if (favorisRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ClientsTableReferences._favorisRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientsTableReferences(db, table, p0).favorisRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.idClient == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ClientsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientsTable,
    Client,
    $$ClientsTableFilterComposer,
    $$ClientsTableOrderingComposer,
    $$ClientsTableAnnotationComposer,
    $$ClientsTableCreateCompanionBuilder,
    $$ClientsTableUpdateCompanionBuilder,
    (Client, $$ClientsTableReferences),
    Client,
    PrefetchHooks Function(
        {bool reservationsRefs, bool rendezVousRefs, bool favorisRefs})>;
typedef $$ReservationsTableCreateCompanionBuilder = ReservationsCompanion
    Function({
  Value<int> id,
  required int idVetement,
  required int idClient,
  required DateTime dateReservation,
  required DateTime dateSortie,
  Value<DateTime?> dateRetour,
});
typedef $$ReservationsTableUpdateCompanionBuilder = ReservationsCompanion
    Function({
  Value<int> id,
  Value<int> idVetement,
  Value<int> idClient,
  Value<DateTime> dateReservation,
  Value<DateTime> dateSortie,
  Value<DateTime?> dateRetour,
});

final class $$ReservationsTableReferences
    extends BaseReferences<_$AppDatabase, $ReservationsTable, Reservation> {
  $$ReservationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VetementsTable _idVetementTable(_$AppDatabase db) =>
      db.vetements.createAlias(
          $_aliasNameGenerator(db.reservations.idVetement, db.vetements.id));

  $$VetementsTableProcessedTableManager get idVetement {
    final $_column = $_itemColumn<int>('id_vetement')!;

    final manager = $$VetementsTableTableManager($_db, $_db.vetements)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idVetementTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ClientsTable _idClientTable(_$AppDatabase db) =>
      db.clients.createAlias(
          $_aliasNameGenerator(db.reservations.idClient, db.clients.id));

  $$ClientsTableProcessedTableManager get idClient {
    final $_column = $_itemColumn<int>('id_client')!;

    final manager = $$ClientsTableTableManager($_db, $_db.clients)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idClientTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$CautionsTable, List<Caution>> _cautionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.cautions,
          aliasName: $_aliasNameGenerator(
              db.reservations.id, db.cautions.idReservation));

  $$CautionsTableProcessedTableManager get cautionsRefs {
    final manager = $$CautionsTableTableManager($_db, $_db.cautions)
        .filter((f) => f.idReservation.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cautionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AcomptesTable, List<Acompte>> _acomptesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.acomptes,
          aliasName: $_aliasNameGenerator(
              db.reservations.id, db.acomptes.idReservation));

  $$AcomptesTableProcessedTableManager get acomptesRefs {
    final manager = $$AcomptesTableTableManager($_db, $_db.acomptes)
        .filter((f) => f.idReservation.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_acomptesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ReservationsTableFilterComposer
    extends Composer<_$AppDatabase, $ReservationsTable> {
  $$ReservationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateReservation => $composableBuilder(
      column: $table.dateReservation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateSortie => $composableBuilder(
      column: $table.dateSortie, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateRetour => $composableBuilder(
      column: $table.dateRetour, builder: (column) => ColumnFilters(column));

  $$VetementsTableFilterComposer get idVetement {
    final $$VetementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idVetement,
        referencedTable: $db.vetements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VetementsTableFilterComposer(
              $db: $db,
              $table: $db.vetements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClientsTableFilterComposer get idClient {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idClient,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableFilterComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> cautionsRefs(
      Expression<bool> Function($$CautionsTableFilterComposer f) f) {
    final $$CautionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cautions,
        getReferencedColumn: (t) => t.idReservation,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CautionsTableFilterComposer(
              $db: $db,
              $table: $db.cautions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> acomptesRefs(
      Expression<bool> Function($$AcomptesTableFilterComposer f) f) {
    final $$AcomptesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.acomptes,
        getReferencedColumn: (t) => t.idReservation,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AcomptesTableFilterComposer(
              $db: $db,
              $table: $db.acomptes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ReservationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReservationsTable> {
  $$ReservationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateReservation => $composableBuilder(
      column: $table.dateReservation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateSortie => $composableBuilder(
      column: $table.dateSortie, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateRetour => $composableBuilder(
      column: $table.dateRetour, builder: (column) => ColumnOrderings(column));

  $$VetementsTableOrderingComposer get idVetement {
    final $$VetementsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idVetement,
        referencedTable: $db.vetements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VetementsTableOrderingComposer(
              $db: $db,
              $table: $db.vetements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClientsTableOrderingComposer get idClient {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idClient,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableOrderingComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReservationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReservationsTable> {
  $$ReservationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dateReservation => $composableBuilder(
      column: $table.dateReservation, builder: (column) => column);

  GeneratedColumn<DateTime> get dateSortie => $composableBuilder(
      column: $table.dateSortie, builder: (column) => column);

  GeneratedColumn<DateTime> get dateRetour => $composableBuilder(
      column: $table.dateRetour, builder: (column) => column);

  $$VetementsTableAnnotationComposer get idVetement {
    final $$VetementsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idVetement,
        referencedTable: $db.vetements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VetementsTableAnnotationComposer(
              $db: $db,
              $table: $db.vetements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClientsTableAnnotationComposer get idClient {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idClient,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableAnnotationComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> cautionsRefs<T extends Object>(
      Expression<T> Function($$CautionsTableAnnotationComposer a) f) {
    final $$CautionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cautions,
        getReferencedColumn: (t) => t.idReservation,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CautionsTableAnnotationComposer(
              $db: $db,
              $table: $db.cautions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> acomptesRefs<T extends Object>(
      Expression<T> Function($$AcomptesTableAnnotationComposer a) f) {
    final $$AcomptesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.acomptes,
        getReferencedColumn: (t) => t.idReservation,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AcomptesTableAnnotationComposer(
              $db: $db,
              $table: $db.acomptes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ReservationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReservationsTable,
    Reservation,
    $$ReservationsTableFilterComposer,
    $$ReservationsTableOrderingComposer,
    $$ReservationsTableAnnotationComposer,
    $$ReservationsTableCreateCompanionBuilder,
    $$ReservationsTableUpdateCompanionBuilder,
    (Reservation, $$ReservationsTableReferences),
    Reservation,
    PrefetchHooks Function(
        {bool idVetement,
        bool idClient,
        bool cautionsRefs,
        bool acomptesRefs})> {
  $$ReservationsTableTableManager(_$AppDatabase db, $ReservationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReservationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReservationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReservationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> idVetement = const Value.absent(),
            Value<int> idClient = const Value.absent(),
            Value<DateTime> dateReservation = const Value.absent(),
            Value<DateTime> dateSortie = const Value.absent(),
            Value<DateTime?> dateRetour = const Value.absent(),
          }) =>
              ReservationsCompanion(
            id: id,
            idVetement: idVetement,
            idClient: idClient,
            dateReservation: dateReservation,
            dateSortie: dateSortie,
            dateRetour: dateRetour,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int idVetement,
            required int idClient,
            required DateTime dateReservation,
            required DateTime dateSortie,
            Value<DateTime?> dateRetour = const Value.absent(),
          }) =>
              ReservationsCompanion.insert(
            id: id,
            idVetement: idVetement,
            idClient: idClient,
            dateReservation: dateReservation,
            dateSortie: dateSortie,
            dateRetour: dateRetour,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ReservationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {idVetement = false,
              idClient = false,
              cautionsRefs = false,
              acomptesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cautionsRefs) db.cautions,
                if (acomptesRefs) db.acomptes
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idVetement) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idVetement,
                    referencedTable:
                        $$ReservationsTableReferences._idVetementTable(db),
                    referencedColumn:
                        $$ReservationsTableReferences._idVetementTable(db).id,
                  ) as T;
                }
                if (idClient) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idClient,
                    referencedTable:
                        $$ReservationsTableReferences._idClientTable(db),
                    referencedColumn:
                        $$ReservationsTableReferences._idClientTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cautionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ReservationsTableReferences
                            ._cautionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ReservationsTableReferences(db, table, p0)
                                .cautionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idReservation == item.id),
                        typedResults: items),
                  if (acomptesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ReservationsTableReferences
                            ._acomptesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ReservationsTableReferences(db, table, p0)
                                .acomptesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idReservation == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ReservationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReservationsTable,
    Reservation,
    $$ReservationsTableFilterComposer,
    $$ReservationsTableOrderingComposer,
    $$ReservationsTableAnnotationComposer,
    $$ReservationsTableCreateCompanionBuilder,
    $$ReservationsTableUpdateCompanionBuilder,
    (Reservation, $$ReservationsTableReferences),
    Reservation,
    PrefetchHooks Function(
        {bool idVetement,
        bool idClient,
        bool cautionsRefs,
        bool acomptesRefs})>;
typedef $$CautionsTableCreateCompanionBuilder = CautionsCompanion Function({
  Value<int> id,
  required int idReservation,
  required CautionStatus statut,
  required double montant,
  required DateTime dateReception,
  Value<DateTime?> dateRendu,
});
typedef $$CautionsTableUpdateCompanionBuilder = CautionsCompanion Function({
  Value<int> id,
  Value<int> idReservation,
  Value<CautionStatus> statut,
  Value<double> montant,
  Value<DateTime> dateReception,
  Value<DateTime?> dateRendu,
});

final class $$CautionsTableReferences
    extends BaseReferences<_$AppDatabase, $CautionsTable, Caution> {
  $$CautionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReservationsTable _idReservationTable(_$AppDatabase db) =>
      db.reservations.createAlias(
          $_aliasNameGenerator(db.cautions.idReservation, db.reservations.id));

  $$ReservationsTableProcessedTableManager get idReservation {
    final $_column = $_itemColumn<int>('id_reservation')!;

    final manager = $$ReservationsTableTableManager($_db, $_db.reservations)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idReservationTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CautionsTableFilterComposer
    extends Composer<_$AppDatabase, $CautionsTable> {
  $$CautionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CautionStatus, CautionStatus, String>
      get statut => $composableBuilder(
          column: $table.statut,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get montant => $composableBuilder(
      column: $table.montant, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateReception => $composableBuilder(
      column: $table.dateReception, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateRendu => $composableBuilder(
      column: $table.dateRendu, builder: (column) => ColumnFilters(column));

  $$ReservationsTableFilterComposer get idReservation {
    final $$ReservationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idReservation,
        referencedTable: $db.reservations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReservationsTableFilterComposer(
              $db: $db,
              $table: $db.reservations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CautionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CautionsTable> {
  $$CautionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get statut => $composableBuilder(
      column: $table.statut, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get montant => $composableBuilder(
      column: $table.montant, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateReception => $composableBuilder(
      column: $table.dateReception,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateRendu => $composableBuilder(
      column: $table.dateRendu, builder: (column) => ColumnOrderings(column));

  $$ReservationsTableOrderingComposer get idReservation {
    final $$ReservationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idReservation,
        referencedTable: $db.reservations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReservationsTableOrderingComposer(
              $db: $db,
              $table: $db.reservations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CautionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CautionsTable> {
  $$CautionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CautionStatus, String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  GeneratedColumn<double> get montant =>
      $composableBuilder(column: $table.montant, builder: (column) => column);

  GeneratedColumn<DateTime> get dateReception => $composableBuilder(
      column: $table.dateReception, builder: (column) => column);

  GeneratedColumn<DateTime> get dateRendu =>
      $composableBuilder(column: $table.dateRendu, builder: (column) => column);

  $$ReservationsTableAnnotationComposer get idReservation {
    final $$ReservationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idReservation,
        referencedTable: $db.reservations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReservationsTableAnnotationComposer(
              $db: $db,
              $table: $db.reservations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CautionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CautionsTable,
    Caution,
    $$CautionsTableFilterComposer,
    $$CautionsTableOrderingComposer,
    $$CautionsTableAnnotationComposer,
    $$CautionsTableCreateCompanionBuilder,
    $$CautionsTableUpdateCompanionBuilder,
    (Caution, $$CautionsTableReferences),
    Caution,
    PrefetchHooks Function({bool idReservation})> {
  $$CautionsTableTableManager(_$AppDatabase db, $CautionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CautionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CautionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CautionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> idReservation = const Value.absent(),
            Value<CautionStatus> statut = const Value.absent(),
            Value<double> montant = const Value.absent(),
            Value<DateTime> dateReception = const Value.absent(),
            Value<DateTime?> dateRendu = const Value.absent(),
          }) =>
              CautionsCompanion(
            id: id,
            idReservation: idReservation,
            statut: statut,
            montant: montant,
            dateReception: dateReception,
            dateRendu: dateRendu,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int idReservation,
            required CautionStatus statut,
            required double montant,
            required DateTime dateReception,
            Value<DateTime?> dateRendu = const Value.absent(),
          }) =>
              CautionsCompanion.insert(
            id: id,
            idReservation: idReservation,
            statut: statut,
            montant: montant,
            dateReception: dateReception,
            dateRendu: dateRendu,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CautionsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({idReservation = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idReservation) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idReservation,
                    referencedTable:
                        $$CautionsTableReferences._idReservationTable(db),
                    referencedColumn:
                        $$CautionsTableReferences._idReservationTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CautionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CautionsTable,
    Caution,
    $$CautionsTableFilterComposer,
    $$CautionsTableOrderingComposer,
    $$CautionsTableAnnotationComposer,
    $$CautionsTableCreateCompanionBuilder,
    $$CautionsTableUpdateCompanionBuilder,
    (Caution, $$CautionsTableReferences),
    Caution,
    PrefetchHooks Function({bool idReservation})>;
typedef $$AcomptesTableCreateCompanionBuilder = AcomptesCompanion Function({
  Value<int> id,
  required int idReservation,
  required double montant,
  required int paye,
  required DateTime datePaiement,
});
typedef $$AcomptesTableUpdateCompanionBuilder = AcomptesCompanion Function({
  Value<int> id,
  Value<int> idReservation,
  Value<double> montant,
  Value<int> paye,
  Value<DateTime> datePaiement,
});

final class $$AcomptesTableReferences
    extends BaseReferences<_$AppDatabase, $AcomptesTable, Acompte> {
  $$AcomptesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReservationsTable _idReservationTable(_$AppDatabase db) =>
      db.reservations.createAlias(
          $_aliasNameGenerator(db.acomptes.idReservation, db.reservations.id));

  $$ReservationsTableProcessedTableManager get idReservation {
    final $_column = $_itemColumn<int>('id_reservation')!;

    final manager = $$ReservationsTableTableManager($_db, $_db.reservations)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idReservationTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AcomptesTableFilterComposer
    extends Composer<_$AppDatabase, $AcomptesTable> {
  $$AcomptesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get montant => $composableBuilder(
      column: $table.montant, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paye => $composableBuilder(
      column: $table.paye, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get datePaiement => $composableBuilder(
      column: $table.datePaiement, builder: (column) => ColumnFilters(column));

  $$ReservationsTableFilterComposer get idReservation {
    final $$ReservationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idReservation,
        referencedTable: $db.reservations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReservationsTableFilterComposer(
              $db: $db,
              $table: $db.reservations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AcomptesTableOrderingComposer
    extends Composer<_$AppDatabase, $AcomptesTable> {
  $$AcomptesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get montant => $composableBuilder(
      column: $table.montant, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paye => $composableBuilder(
      column: $table.paye, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get datePaiement => $composableBuilder(
      column: $table.datePaiement,
      builder: (column) => ColumnOrderings(column));

  $$ReservationsTableOrderingComposer get idReservation {
    final $$ReservationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idReservation,
        referencedTable: $db.reservations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReservationsTableOrderingComposer(
              $db: $db,
              $table: $db.reservations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AcomptesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AcomptesTable> {
  $$AcomptesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get montant =>
      $composableBuilder(column: $table.montant, builder: (column) => column);

  GeneratedColumn<int> get paye =>
      $composableBuilder(column: $table.paye, builder: (column) => column);

  GeneratedColumn<DateTime> get datePaiement => $composableBuilder(
      column: $table.datePaiement, builder: (column) => column);

  $$ReservationsTableAnnotationComposer get idReservation {
    final $$ReservationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idReservation,
        referencedTable: $db.reservations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReservationsTableAnnotationComposer(
              $db: $db,
              $table: $db.reservations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AcomptesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AcomptesTable,
    Acompte,
    $$AcomptesTableFilterComposer,
    $$AcomptesTableOrderingComposer,
    $$AcomptesTableAnnotationComposer,
    $$AcomptesTableCreateCompanionBuilder,
    $$AcomptesTableUpdateCompanionBuilder,
    (Acompte, $$AcomptesTableReferences),
    Acompte,
    PrefetchHooks Function({bool idReservation})> {
  $$AcomptesTableTableManager(_$AppDatabase db, $AcomptesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AcomptesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AcomptesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AcomptesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> idReservation = const Value.absent(),
            Value<double> montant = const Value.absent(),
            Value<int> paye = const Value.absent(),
            Value<DateTime> datePaiement = const Value.absent(),
          }) =>
              AcomptesCompanion(
            id: id,
            idReservation: idReservation,
            montant: montant,
            paye: paye,
            datePaiement: datePaiement,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int idReservation,
            required double montant,
            required int paye,
            required DateTime datePaiement,
          }) =>
              AcomptesCompanion.insert(
            id: id,
            idReservation: idReservation,
            montant: montant,
            paye: paye,
            datePaiement: datePaiement,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AcomptesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({idReservation = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idReservation) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idReservation,
                    referencedTable:
                        $$AcomptesTableReferences._idReservationTable(db),
                    referencedColumn:
                        $$AcomptesTableReferences._idReservationTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AcomptesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AcomptesTable,
    Acompte,
    $$AcomptesTableFilterComposer,
    $$AcomptesTableOrderingComposer,
    $$AcomptesTableAnnotationComposer,
    $$AcomptesTableCreateCompanionBuilder,
    $$AcomptesTableUpdateCompanionBuilder,
    (Acompte, $$AcomptesTableReferences),
    Acompte,
    PrefetchHooks Function({bool idReservation})>;
typedef $$RendezVousTableCreateCompanionBuilder = RendezVousCompanion Function({
  Value<int> id,
  required int idClient,
  required DateTime date,
  required String heure,
  required Duration duree,
  required MotifRendezVous motif,
});
typedef $$RendezVousTableUpdateCompanionBuilder = RendezVousCompanion Function({
  Value<int> id,
  Value<int> idClient,
  Value<DateTime> date,
  Value<String> heure,
  Value<Duration> duree,
  Value<MotifRendezVous> motif,
});

final class $$RendezVousTableReferences
    extends BaseReferences<_$AppDatabase, $RendezVousTable, RendezVousData> {
  $$RendezVousTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _idClientTable(_$AppDatabase db) => db.clients
      .createAlias($_aliasNameGenerator(db.rendezVous.idClient, db.clients.id));

  $$ClientsTableProcessedTableManager get idClient {
    final $_column = $_itemColumn<int>('id_client')!;

    final manager = $$ClientsTableTableManager($_db, $_db.clients)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idClientTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RendezVousTableFilterComposer
    extends Composer<_$AppDatabase, $RendezVousTable> {
  $$RendezVousTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get heure => $composableBuilder(
      column: $table.heure, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Duration, Duration, int> get duree =>
      $composableBuilder(
          column: $table.duree,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<MotifRendezVous, MotifRendezVous, String>
      get motif => $composableBuilder(
          column: $table.motif,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$ClientsTableFilterComposer get idClient {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idClient,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableFilterComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RendezVousTableOrderingComposer
    extends Composer<_$AppDatabase, $RendezVousTable> {
  $$RendezVousTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get heure => $composableBuilder(
      column: $table.heure, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duree => $composableBuilder(
      column: $table.duree, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get motif => $composableBuilder(
      column: $table.motif, builder: (column) => ColumnOrderings(column));

  $$ClientsTableOrderingComposer get idClient {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idClient,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableOrderingComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RendezVousTableAnnotationComposer
    extends Composer<_$AppDatabase, $RendezVousTable> {
  $$RendezVousTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get heure =>
      $composableBuilder(column: $table.heure, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Duration, int> get duree =>
      $composableBuilder(column: $table.duree, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MotifRendezVous, String> get motif =>
      $composableBuilder(column: $table.motif, builder: (column) => column);

  $$ClientsTableAnnotationComposer get idClient {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idClient,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableAnnotationComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RendezVousTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RendezVousTable,
    RendezVousData,
    $$RendezVousTableFilterComposer,
    $$RendezVousTableOrderingComposer,
    $$RendezVousTableAnnotationComposer,
    $$RendezVousTableCreateCompanionBuilder,
    $$RendezVousTableUpdateCompanionBuilder,
    (RendezVousData, $$RendezVousTableReferences),
    RendezVousData,
    PrefetchHooks Function({bool idClient})> {
  $$RendezVousTableTableManager(_$AppDatabase db, $RendezVousTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RendezVousTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RendezVousTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RendezVousTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> idClient = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> heure = const Value.absent(),
            Value<Duration> duree = const Value.absent(),
            Value<MotifRendezVous> motif = const Value.absent(),
          }) =>
              RendezVousCompanion(
            id: id,
            idClient: idClient,
            date: date,
            heure: heure,
            duree: duree,
            motif: motif,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int idClient,
            required DateTime date,
            required String heure,
            required Duration duree,
            required MotifRendezVous motif,
          }) =>
              RendezVousCompanion.insert(
            id: id,
            idClient: idClient,
            date: date,
            heure: heure,
            duree: duree,
            motif: motif,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RendezVousTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({idClient = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idClient) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idClient,
                    referencedTable:
                        $$RendezVousTableReferences._idClientTable(db),
                    referencedColumn:
                        $$RendezVousTableReferences._idClientTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RendezVousTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RendezVousTable,
    RendezVousData,
    $$RendezVousTableFilterComposer,
    $$RendezVousTableOrderingComposer,
    $$RendezVousTableAnnotationComposer,
    $$RendezVousTableCreateCompanionBuilder,
    $$RendezVousTableUpdateCompanionBuilder,
    (RendezVousData, $$RendezVousTableReferences),
    RendezVousData,
    PrefetchHooks Function({bool idClient})>;
typedef $$FavorisTableCreateCompanionBuilder = FavorisCompanion Function({
  Value<int> id,
  required int idClient,
  required int idVetement,
});
typedef $$FavorisTableUpdateCompanionBuilder = FavorisCompanion Function({
  Value<int> id,
  Value<int> idClient,
  Value<int> idVetement,
});

final class $$FavorisTableReferences
    extends BaseReferences<_$AppDatabase, $FavorisTable, Favori> {
  $$FavorisTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _idClientTable(_$AppDatabase db) => db.clients
      .createAlias($_aliasNameGenerator(db.favoris.idClient, db.clients.id));

  $$ClientsTableProcessedTableManager get idClient {
    final $_column = $_itemColumn<int>('id_client')!;

    final manager = $$ClientsTableTableManager($_db, $_db.clients)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idClientTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $VetementsTable _idVetementTable(_$AppDatabase db) =>
      db.vetements.createAlias(
          $_aliasNameGenerator(db.favoris.idVetement, db.vetements.id));

  $$VetementsTableProcessedTableManager get idVetement {
    final $_column = $_itemColumn<int>('id_vetement')!;

    final manager = $$VetementsTableTableManager($_db, $_db.vetements)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idVetementTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FavorisTableFilterComposer
    extends Composer<_$AppDatabase, $FavorisTable> {
  $$FavorisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$ClientsTableFilterComposer get idClient {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idClient,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableFilterComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$VetementsTableFilterComposer get idVetement {
    final $$VetementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idVetement,
        referencedTable: $db.vetements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VetementsTableFilterComposer(
              $db: $db,
              $table: $db.vetements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavorisTableOrderingComposer
    extends Composer<_$AppDatabase, $FavorisTable> {
  $$FavorisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$ClientsTableOrderingComposer get idClient {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idClient,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableOrderingComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$VetementsTableOrderingComposer get idVetement {
    final $$VetementsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idVetement,
        referencedTable: $db.vetements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VetementsTableOrderingComposer(
              $db: $db,
              $table: $db.vetements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavorisTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavorisTable> {
  $$FavorisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$ClientsTableAnnotationComposer get idClient {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idClient,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableAnnotationComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$VetementsTableAnnotationComposer get idVetement {
    final $$VetementsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idVetement,
        referencedTable: $db.vetements,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VetementsTableAnnotationComposer(
              $db: $db,
              $table: $db.vetements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavorisTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FavorisTable,
    Favori,
    $$FavorisTableFilterComposer,
    $$FavorisTableOrderingComposer,
    $$FavorisTableAnnotationComposer,
    $$FavorisTableCreateCompanionBuilder,
    $$FavorisTableUpdateCompanionBuilder,
    (Favori, $$FavorisTableReferences),
    Favori,
    PrefetchHooks Function({bool idClient, bool idVetement})> {
  $$FavorisTableTableManager(_$AppDatabase db, $FavorisTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavorisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavorisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavorisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> idClient = const Value.absent(),
            Value<int> idVetement = const Value.absent(),
          }) =>
              FavorisCompanion(
            id: id,
            idClient: idClient,
            idVetement: idVetement,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int idClient,
            required int idVetement,
          }) =>
              FavorisCompanion.insert(
            id: id,
            idClient: idClient,
            idVetement: idVetement,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$FavorisTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({idClient = false, idVetement = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idClient) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idClient,
                    referencedTable:
                        $$FavorisTableReferences._idClientTable(db),
                    referencedColumn:
                        $$FavorisTableReferences._idClientTable(db).id,
                  ) as T;
                }
                if (idVetement) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idVetement,
                    referencedTable:
                        $$FavorisTableReferences._idVetementTable(db),
                    referencedColumn:
                        $$FavorisTableReferences._idVetementTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FavorisTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FavorisTable,
    Favori,
    $$FavorisTableFilterComposer,
    $$FavorisTableOrderingComposer,
    $$FavorisTableAnnotationComposer,
    $$FavorisTableCreateCompanionBuilder,
    $$FavorisTableUpdateCompanionBuilder,
    (Favori, $$FavorisTableReferences),
    Favori,
    PrefetchHooks Function({bool idClient, bool idVetement})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VetementsTableTableManager get vetements =>
      $$VetementsTableTableManager(_db, _db.vetements);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db, _db.photos);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$ReservationsTableTableManager get reservations =>
      $$ReservationsTableTableManager(_db, _db.reservations);
  $$CautionsTableTableManager get cautions =>
      $$CautionsTableTableManager(_db, _db.cautions);
  $$AcomptesTableTableManager get acomptes =>
      $$AcomptesTableTableManager(_db, _db.acomptes);
  $$RendezVousTableTableManager get rendezVous =>
      $$RendezVousTableTableManager(_db, _db.rendezVous);
  $$FavorisTableTableManager get favoris =>
      $$FavorisTableTableManager(_db, _db.favoris);
}
