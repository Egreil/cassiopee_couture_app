import 'package:drift/drift.dart' show OrderingMode, OrderingTerm;
import 'package:flutter/material.dart';
import '../../../database/database.dart';
import '../../theme/app_theme.dart';

class DatabaseView extends StatefulWidget {
  final AppDatabase database;

  const DatabaseView({super.key, required this.database});

  @override
  State<DatabaseView> createState() => _DatabaseViewState();
}

class _DatabaseViewState extends State<DatabaseView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    print("DatabaseView - initState called");
    _tabController = TabController(
      length: 7,
      vsync: this,
    );

    _tabController.addListener(() {
      print("Changement d'onglet vers l'index: ${_tabController.index}");
      setState(() {});
    });

    // Modifier le listener des rendez-vous avec un tri explicite
    (widget.database.select(widget.database.rendezVous)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.date,
                  mode: OrderingMode.asc,
                ),
            (t) => OrderingTerm(
                  expression: t.heure,
                  mode: OrderingMode.asc,
                ),
          ]))
        .watch()
        .listen((rdvs) {
      print("Listener RDV déclenché: ${rdvs.length} rendez-vous");
      for (var rdv in rdvs) {
        print(
            '  -> RDV ${rdv.id}: Client=${rdv.idClient}, Date=${rdv.date}, Heure=${rdv.heure}');
      }
      if (mounted && _tabController.index == 0) {
        print("setState appelé pour RDV");
        setState(() {});
      } else {
        print(
            "setState non appelé: mounted=$mounted, index=${_tabController.index}");
      }
    });

    widget.database.select(widget.database.clients).watch().listen((_) {
      if (mounted && _tabController.index == 1) setState(() {});
    });

    widget.database.select(widget.database.vetements).watch().listen((_) {
      if (mounted && _tabController.index == 2) setState(() {});
    });

    widget.database.select(widget.database.reservations).watch().listen((_) {
      if (mounted && _tabController.index == 3) setState(() {});
    });

    widget.database.select(widget.database.cautions).watch().listen((_) {
      if (mounted && _tabController.index == 4) setState(() {});
    });

    widget.database.select(widget.database.acomptes).watch().listen((_) {
      if (mounted && _tabController.index == 5) setState(() {});
    });

    widget.database.select(widget.database.photos).watch().listen((_) {
      if (mounted && _tabController.index == 6) setState(() {});
    });
  }

  @override
  void dispose() {
    print("DatabaseView - dispose called");
    _tabController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    print("DatabaseView - deactivate called");
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Contenu de la base de données'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => _showDeleteConfirmation(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Rendez-vous'),
            Tab(text: 'Clients'),
            Tab(text: 'Vêtements'),
            Tab(text: 'Réservations'),
            Tab(text: 'Cautions'),
            Tab(text: 'Acomptes'),
            Tab(text: 'Photos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _RendezVousTab(database: widget.database, key: UniqueKey()),
          _buildClientsTab(key: UniqueKey()),
          _buildVetementsTab(key: UniqueKey()),
          _buildReservationsTab(key: UniqueKey()),
          _buildCautionsTab(key: UniqueKey()),
          _buildAcomptesTab(key: UniqueKey()),
          _buildPhotosTab(key: UniqueKey()),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Vider la base de données'),
        content: const Text(
          'Êtes-vous sûr de vouloir supprimer toutes les données ? Cette action est irréversible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await widget.database.clearDatabase();
        print('Toutes les tables ont été vidées, y compris les clients');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Base de données entièrement vidée avec succès'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Widget _buildClientsTab({Key? key}) {
    print("Construction du widget Clients");
    return StreamBuilder<List<Client>>(
      stream: (() {
        print("Création d'un nouveau stream pour Clients");
        return widget.database.select(widget.database.clients).watch();
      })(),
      builder: (context, snapshot) {
        print("État du StreamBuilder Clients: ${snapshot.connectionState}");
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final clients = snapshot.data!;
        print("Nombre de clients chargés: ${clients.length}");
        return ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            final client = clients[index];
            return Card(
              child: ListTile(
                title: Text('${client.prenom} ${client.nom}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${client.id}'),
                    Text('Tél: ${client.numero}'),
                    if (client.mail != null) Text('Email: ${client.mail}'),
                    Text('Adresse: ${client.adresse}'),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildVetementsTab({Key? key}) {
    return StreamBuilder<List<Vetement>>(
      key: key,
      stream: widget.database.select(widget.database.vetements).watch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final vetements = snapshot.data!;
        return ListView.builder(
          itemCount: vetements.length,
          itemBuilder: (context, index) {
            final vetement = vetements[index];
            return Card(
              child: ListTile(
                title: Text(vetement.nom),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${vetement.id}'),
                    Text('Catégorie: ${vetement.category}'),
                    Text('Prix: ${vetement.prix}€'),
                    Text('Couleurs: ${vetement.couleurs}'),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildReservationsTab({Key? key}) {
    return StreamBuilder<List<Reservation>>(
      key: key,
      stream: widget.database.select(widget.database.reservations).watch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final reservations = snapshot.data!;
        return ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final reservation = reservations[index];
            return Card(
              child: ListTile(
                title: Text('Réservation #${reservation.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Vêtement ID: ${reservation.idVetement}'),
                    Text('Client ID: ${reservation.idClient}'),
                    Text('Date sortie: ${reservation.dateSortie}'),
                    Text('Date retour: ${reservation.dateRetour}'),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCautionsTab({Key? key}) {
    return StreamBuilder<List<Caution>>(
      key: key,
      stream: widget.database.select(widget.database.cautions).watch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final cautions = snapshot.data!;
        return ListView.builder(
          itemCount: cautions.length,
          itemBuilder: (context, index) {
            final caution = cautions[index];
            return Card(
              child: ListTile(
                title: Text('Caution #${caution.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Réservation ID: ${caution.idReservation}'),
                    Text('Montant: ${caution.montant}€'),
                    Text('Statut: ${caution.statut}'),
                    Text('Date réception: ${caution.dateReception}'),
                    if (caution.dateRendu != null)
                      Text('Date rendu: ${caution.dateRendu}'),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAcomptesTab({Key? key}) {
    return StreamBuilder<List<Acompte>>(
      key: key,
      stream: widget.database.select(widget.database.acomptes).watch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final acomptes = snapshot.data!;
        return ListView.builder(
          itemCount: acomptes.length,
          itemBuilder: (context, index) {
            final acompte = acomptes[index];
            return Card(
              child: ListTile(
                title: Text('Acompte #${acompte.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Réservation ID: ${acompte.idReservation}'),
                    Text('Montant: ${acompte.montant}€'),
                    Text('Payé: ${acompte.paye == 1 ? "Oui" : "Non"}'),
                    Text('Date paiement: ${acompte.datePaiement}'),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPhotosTab({Key? key}) {
    return StreamBuilder<List<Photo>>(
      key: key,
      stream: widget.database.select(widget.database.photos).watch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final photos = snapshot.data!;
        return ListView.builder(
          itemCount: photos.length,
          itemBuilder: (context, index) {
            final photo = photos[index];
            return Card(
              child: ListTile(
                title: Text('Photo #${photo.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Vêtement ID: ${photo.idVetement}'),
                    Text('URL: ${photo.url}'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _RendezVousTab extends StatefulWidget {
  final AppDatabase database;

  const _RendezVousTab({required this.database, Key? key}) : super(key: key);

  @override
  State<_RendezVousTab> createState() => _RendezVousTabState();
}

class _RendezVousTabState extends State<_RendezVousTab>
    with AutomaticKeepAliveClientMixin {
  late Future<List<RendezVousData>> _rdvsFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _rdvsFuture = widget.database.select(widget.database.rendezVous).get();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder<List<RendezVousData>>(
        future: _rdvsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          final rdvs = snapshot.data!;
          print('Affichage de ${rdvs.length} rendez-vous:');
          for (var rdv in rdvs) {
            print(
                'RDV ${rdv.id}: Client=${rdv.idClient}, Date=${rdv.date}, Heure=${rdv.heure}');
          }

          return ListView.builder(
            itemCount: rdvs.length,
            itemBuilder: (context, index) {
              final rdv = rdvs[index];
              return ListTile(
                title: Text('RDV ${rdv.id}'),
                subtitle: Text(
                    'Client: ${rdv.idClient}, Date: ${rdv.date}, Heure: ${rdv.heure}'),
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
