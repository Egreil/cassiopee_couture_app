import 'package:drift/drift.dart'
    show OrderingMode, OrderingTerm, TableOrViewStatements;
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
    _tabController = TabController(length: 7, vsync: this);
    // Écouter les changements de la base de données
    widget.database.select(widget.database.rendezVous).watch().listen((_) {
      if (mounted && _tabController.index == 0) {
        // 0 est l'index de l'onglet rendez-vous
        setState(() {}); // Force la reconstruction
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
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
          _RendezVousTab(
              database: widget.database,
              key:
                  UniqueKey()), // Forcer la reconstruction avec une nouvelle clé
          _buildClientsTab(),
          _buildVetementsTab(),
          _buildReservationsTab(),
          _buildCautionsTab(),
          _buildAcomptesTab(),
          _buildPhotosTab(),
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

  Widget _buildClientsTab() {
    return StreamBuilder<List<Client>>(
      stream: widget.database.select(widget.database.clients).watch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final clients = snapshot.data!;
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

  Widget _buildVetementsTab() {
    return StreamBuilder<List<Vetement>>(
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

  Widget _buildReservationsTab() {
    return StreamBuilder<List<Reservation>>(
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

  Widget _buildCautionsTab() {
    return StreamBuilder<List<Caution>>(
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

  Widget _buildAcomptesTab() {
    return StreamBuilder<List<Acompte>>(
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

  Widget _buildPhotosTab() {
    return StreamBuilder<List<Photo>>(
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
  @override
  bool get wantKeepAlive => false; // Force la reconstruction

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('Construction du widget RendezVous');
    return StreamBuilder<List<RendezVousData>>(
      stream: widget.database.select(widget.database.rendezVous).watch(),
      builder: (context, snapshot) {
        print('État du StreamBuilder: ${snapshot.connectionState}');
        if (snapshot.hasError) {
          print('Erreur: ${snapshot.error}');
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final rendezVous = snapshot.data ?? [];
        print('Affichage final de ${rendezVous.length} rendez-vous');

        return ListView.builder(
          itemCount: rendezVous.length,
          itemBuilder: (context, index) {
            final rdv = rendezVous[index];
            return Card(
              child: ListTile(
                title: Text('RDV #${rdv.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Client ID: ${rdv.idClient}'),
                    Text('Date: ${rdv.date}'),
                    Text('Heure: ${rdv.heure}'),
                    Text('Durée: ${rdv.duree.inMinutes} min'),
                    Text('Motif: ${rdv.motif}'),
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
}
