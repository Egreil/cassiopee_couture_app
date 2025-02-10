import 'package:cassiopee_couture_app/database/tables.dart';
import 'package:cassiopee_couture_app/src/menu/gestion/rendez_vous_form_view.dart';
import 'package:drift/drift.dart' show ComparableExpr, OrderingTerm, innerJoin;
import 'package:flutter/material.dart';
import '../../../database/database.dart';
import '../../theme/app_theme.dart';

class GestionTasksView extends StatefulWidget {
  final AppDatabase database;

  const GestionTasksView({super.key, required this.database});

  @override
  State<GestionTasksView> createState() => _GestionTasksViewState();
}

class _GestionTasksViewState extends State<GestionTasksView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scrollController = ScrollController();
  final List<String> _tabs = [
    'Rendez-vous',
    'Cautions à rendre',
    'Cautions à recevoir',
    'Retours',
    'Départs',
    'Acomptes',
    'Paiements',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final tabIndex = (currentScroll / (maxScroll / (_tabs.length - 1))).round();
    _tabController.animateTo(tabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        title: const Text('Tâches du jour'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
          onTap: (index) {
            final position =
                (index * _scrollController.position.maxScrollExtent) /
                    (_tabs.length - 1);
            _scrollController.animateTo(
              position,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: _tabs.map((tab) => _buildSection(tab)).toList(),
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
      child: StreamBuilder<List<dynamic>>(
        stream: _getDataForSection(title),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('Erreur dans $title: ${snapshot.error}');
            return Text('Erreur: ${snapshot.error}');
          }

          final items = snapshot.data ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              if (items.isEmpty)
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 24,
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${items.length} tâches à traiter'),
                    const SizedBox(height: 8),
                    if (title == 'Rendez-vous')
                      _buildRendezVousSection(
                          items.cast<RendezVousWithClient>())
                    else if (title == 'Cautions à rendre' ||
                        title == 'Cautions à recevoir')
                      _buildCautionsSection(
                          items.cast<CautionWithClientAndReservation>())
                    else if (title == 'Retours' || title == 'Départs')
                      _buildRetoursSection(
                          items.cast<RetourWithClientAndVetement>())
                    else if (title == 'Acomptes' || title == 'Paiements')
                      _buildAcomptesSection(
                          items.cast<AcompteWithClientAndVetement>()),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  Stream<List<dynamic>> _getDataForSection(String title) {
    print('Getting data for section: $title');
    switch (title) {
      case 'Rendez-vous':
        return _getRendezVousDuJour().map((data) {
          print('Rendez-vous data: ${data.length} items');
          return data;
        });
      case 'Cautions à rendre':
        return _getCautionsARendre();
      case 'Cautions à recevoir':
        return _getCautionsARecevoir();
      case 'Retours':
        return _getRetoursAujourdhui();
      case 'Départs':
        return _getDepartsAujourdhui();
      case 'Acomptes':
        return _getAcomptesAttendus();
      case 'Paiements':
        return _getPaiementsAttendus();
      default:
        return Stream.value([]);
    }
  }

  Stream<List<RendezVousWithClient>> _getRendezVousDuJour() {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return (widget.database.select(widget.database.rendezVous)
          ..where((r) => r.date.isBetweenValues(startOfDay, endOfDay))
          ..orderBy([(r) => OrderingTerm(expression: r.heure)]))
        .join([
          innerJoin(
            widget.database.clients,
            widget.database.clients.id
                .equalsExp(widget.database.rendezVous.idClient),
          ),
        ])
        .watch()
        .map((rows) => rows.map((row) {
              final rdv = row.readTable(widget.database.rendezVous);
              final client = row.readTable(widget.database.clients);
              return RendezVousWithClient(
                id: rdv.id,
                date: rdv.date,
                heure: rdv.heure,
                duree: rdv.duree,
                motif: rdv.motif,
                client: client,
              );
            }).toList());
  }

  Stream<List<CautionWithClientAndReservation>> _getCautionsARendre() {
    return (widget.database.select(widget.database.cautions)
          ..where((c) => c.statut.equals(CautionStatus.AR.toString())))
        .join([
          innerJoin(
            widget.database.reservations,
            widget.database.reservations.id
                .equalsExp(widget.database.cautions.idReservation),
          ),
          innerJoin(
            widget.database.clients,
            widget.database.clients.id
                .equalsExp(widget.database.reservations.idClient),
          ),
        ])
        .watch()
        .map((rows) => rows.map((row) {
              final caution = row.readTable(widget.database.cautions);
              final client = row.readTable(widget.database.clients);
              return CautionWithClientAndReservation(
                id: caution.id,
                montant: caution.montant,
                dateReception: caution.dateReception,
                client: client,
                idReservation: caution.idReservation,
              );
            }).toList());
  }

  Stream<List<CautionWithClientAndReservation>> _getCautionsARecevoir() {
    return (widget.database.select(widget.database.cautions)
          ..where((c) => c.statut.equals(CautionStatus.EA.toString())))
        .join([
          innerJoin(
            widget.database.reservations,
            widget.database.reservations.id
                .equalsExp(widget.database.cautions.idReservation),
          ),
          innerJoin(
            widget.database.clients,
            widget.database.clients.id
                .equalsExp(widget.database.reservations.idClient),
          ),
        ])
        .watch()
        .map((rows) => rows.map((row) {
              final caution = row.readTable(widget.database.cautions);
              final client = row.readTable(widget.database.clients);
              return CautionWithClientAndReservation(
                id: caution.id,
                montant: caution.montant,
                dateReception: caution.dateReception,
                client: client,
                idReservation: caution.idReservation,
              );
            }).toList());
  }

  Stream<List<RetourWithClientAndVetement>> _getRetoursAujourdhui() {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (widget.database.select(widget.database.reservations)
          ..where((r) => r.dateRetour.isBetweenValues(startOfDay, endOfDay)))
        .join([
          innerJoin(
            widget.database.clients,
            widget.database.clients.id
                .equalsExp(widget.database.reservations.idClient),
          ),
          innerJoin(
            widget.database.vetements,
            widget.database.vetements.id
                .equalsExp(widget.database.reservations.idVetement),
          ),
        ])
        .watch()
        .map((rows) => rows.map((row) {
              final reservation = row.readTable(widget.database.reservations);
              final client = row.readTable(widget.database.clients);
              final vetement = row.readTable(widget.database.vetements);
              return RetourWithClientAndVetement(
                id: reservation.id,
                dateRetour: reservation.dateRetour!,
                client: client,
                vetement: vetement,
              );
            }).toList());
  }

  Stream<List<RetourWithClientAndVetement>> _getDepartsAujourdhui() {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (widget.database.select(widget.database.reservations)
          ..where((r) => r.dateSortie.isBetweenValues(startOfDay, endOfDay)))
        .join([
          innerJoin(
            widget.database.clients,
            widget.database.clients.id
                .equalsExp(widget.database.reservations.idClient),
          ),
          innerJoin(
            widget.database.vetements,
            widget.database.vetements.id
                .equalsExp(widget.database.reservations.idVetement),
          ),
        ])
        .watch()
        .map((rows) => rows.map((row) {
              final reservation = row.readTable(widget.database.reservations);
              final client = row.readTable(widget.database.clients);
              final vetement = row.readTable(widget.database.vetements);
              return RetourWithClientAndVetement(
                id: reservation.id,
                dateRetour: reservation.dateSortie,
                client: client,
                vetement: vetement,
              );
            }).toList());
  }

  Stream<List<AcompteWithClientAndVetement>> _getAcomptesAttendus() {
    return (widget.database.select(widget.database.acomptes)
          ..where((a) => a.paye.equals(0)))
        .join([
          innerJoin(
            widget.database.reservations,
            widget.database.reservations.id
                .equalsExp(widget.database.acomptes.idReservation),
          ),
          innerJoin(
            widget.database.clients,
            widget.database.clients.id
                .equalsExp(widget.database.reservations.idClient),
          ),
          innerJoin(
            widget.database.vetements,
            widget.database.vetements.id
                .equalsExp(widget.database.reservations.idVetement),
          ),
        ])
        .watch()
        .map((rows) => rows.map((row) {
              final acompte = row.readTable(widget.database.acomptes);
              final client = row.readTable(widget.database.clients);
              final vetement = row.readTable(widget.database.vetements);
              return AcompteWithClientAndVetement(
                id: acompte.id,
                montant: acompte.montant,
                datePaiement: acompte.datePaiement,
                client: client,
                vetement: vetement,
                paye: acompte.paye,
              );
            }).toList());
  }

  Stream<List<AcompteWithClientAndVetement>> _getPaiementsAttendus() {
    return (widget.database.select(widget.database.acomptes)
          ..where((a) => a.paye.equals(0)))
        .join([
          innerJoin(
            widget.database.reservations,
            widget.database.reservations.id
                .equalsExp(widget.database.acomptes.idReservation),
          ),
          innerJoin(
            widget.database.clients,
            widget.database.clients.id
                .equalsExp(widget.database.reservations.idClient),
          ),
          innerJoin(
            widget.database.vetements,
            widget.database.vetements.id
                .equalsExp(widget.database.reservations.idVetement),
          ),
        ])
        .watch()
        .map((rows) => rows
            .map((row) {
              final acompte = row.readTable(widget.database.acomptes);
              final client = row.readTable(widget.database.clients);
              final vetement = row.readTable(widget.database.vetements);
              if (acompte.montant == vetement.prix) {
                return AcompteWithClientAndVetement(
                  id: acompte.id,
                  montant: acompte.montant,
                  datePaiement: acompte.datePaiement,
                  client: client,
                  vetement: vetement,
                  paye: acompte.paye,
                );
              }
            })
            .whereType<AcompteWithClientAndVetement>()
            .toList());
  }

  Widget _buildRendezVousSection(List<RendezVousWithClient> rendezVous) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rendezVous.map((rdv) {
        String motifLabel;
        switch (rdv.motif) {
          case MotifRendezVous.motif:
            motifLabel = 'Motif';
            break;
          case MotifRendezVous.essayage:
            motifLabel = 'Essayage';
            break;
          case MotifRendezVous.consultation:
            motifLabel = 'Consultation';
            break;
          case MotifRendezVous.retour:
            motifLabel = 'Retour';
            break;
        }

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text('${rdv.client.prenom} ${rdv.client.nom}'),
            subtitle: Text('$motifLabel à ${rdv.heure}'),
            trailing: Text('${rdv.duree.inMinutes} min'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RendezVousFormView(
                    database: widget.database,
                    rendezVous: RendezVousData(
                      id: rdv.id,
                      date: rdv.date,
                      heure: rdv.heure,
                      duree: rdv.duree,
                      motif: rdv.motif,
                      idClient: rdv.client.id,
                    ),
                    readOnly: true,
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCautionsSection(List<CautionWithClientAndReservation> cautions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cautions.map((caution) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text('${caution.client.prenom} ${caution.client.nom}'),
            subtitle: Text('Tél: ${caution.client.numero}'),
            trailing: Text('${caution.montant.toStringAsFixed(2)} €'),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRetoursSection(List<RetourWithClientAndVetement> retours) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: retours.map((retour) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(retour.vetement.nom),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Client: ${retour.client.prenom} ${retour.client.nom}'),
                Text('Tél: ${retour.client.numero}'),
              ],
            ),
            isThreeLine: true,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAcomptesSection(List<AcompteWithClientAndVetement> acomptes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: acomptes.map((acompte) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(acompte.vetement.nom),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Client: ${acompte.client.prenom} ${acompte.client.nom}'),
                Text('Tél: ${acompte.client.numero}'),
              ],
            ),
            trailing: Text('${acompte.montant.toStringAsFixed(2)} €'),
            isThreeLine: true,
          ),
        );
      }).toList(),
    );
  }
}

class RendezVousWithClient {
  final int id;
  final DateTime date;
  final String heure;
  final Duration duree;
  final MotifRendezVous motif;
  final Client client;

  RendezVousWithClient({
    required this.id,
    required this.date,
    required this.heure,
    required this.duree,
    required this.motif,
    required this.client,
  });
}

class CautionWithClientAndReservation {
  final int id;
  final double montant;
  final DateTime dateReception;
  final Client client;
  final int idReservation;

  CautionWithClientAndReservation({
    required this.id,
    required this.montant,
    required this.dateReception,
    required this.client,
    required this.idReservation,
  });
}

class RetourWithClientAndVetement {
  final int id;
  final DateTime dateRetour;
  final Client client;
  final Vetement vetement;

  RetourWithClientAndVetement({
    required this.id,
    required this.dateRetour,
    required this.client,
    required this.vetement,
  });
}

class AcompteWithClientAndVetement {
  final int id;
  final double montant;
  final DateTime datePaiement;
  final Client client;
  final Vetement vetement;
  final int paye;

  AcompteWithClientAndVetement({
    required this.id,
    required this.montant,
    required this.datePaiement,
    required this.client,
    required this.vetement,
    required this.paye,
  });
}
