import 'package:cassiopee_couture_app/src/menu/gestion/gestion_tasks_view.dart';
import 'package:cassiopee_couture_app/src/vetements/vetements_grid_view.dart';
import 'package:flutter/material.dart';
import '../../../../database/database.dart';
import 'package:drift/drift.dart' show ComparableExpr, innerJoin;

class RendezVousWithClient {
  final RendezVousData rendezVous;
  final Client client;

  RendezVousWithClient({required this.rendezVous, required this.client});
}

class RendezVousSection extends StatefulWidget {
  final AppDatabase database;
  const RendezVousSection({super.key, required this.database});

  @override
  State<RendezVousSection> createState() => _RendezVousSectionState();
}

class _RendezVousSectionState extends State<RendezVousSection> {
  late DateTime today;
  late DateTime startOfDay;
  late Future<List<RendezVousWithClient>> _rdvsDuJour;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    startOfDay = DateTime(today.year, today.month, today.day);
    _initializeRdvsDuJour();
  }

  void _initializeRdvsDuJour() {
    setState(() {
      _rdvsDuJour = (widget.database.select(widget.database.rendezVous)
            ..where((rdv) => rdv.date.equals(startOfDay)))
          .join([
            innerJoin(
              widget.database.clients,
              widget.database.clients.id
                  .equalsExp(widget.database.rendezVous.idClient),
            ),
          ])
          .get()
          .then((rows) => rows.map((row) {
                final rdv = row.readTable(widget.database.rendezVous);
                final client = row.readTable(widget.database.clients);
                return RendezVousWithClient(rendezVous: rdv, client: client);
              }).toList());
    });
  }

  Future<void> _rendezVousDuJour() async {
    _initializeRdvsDuJour();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _rendezVousDuJour,
      child: FutureBuilder<List<RendezVousWithClient>>(
        future: _rdvsDuJour,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final rendezVous = snapshot.data ?? [];
          return Column(
            children: rendezVous.map((rdv) {
              return Card(
                child: ListTile(
                  title: Text('${rdv.client.prenom} ${rdv.client.nom}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${rdv.rendezVous.heure} - ${rdv.rendezVous.motif}'),
                      Text('Tél: ${rdv.client.numero}'),
                    ],
                  ),
                  trailing: Text('${rdv.rendezVous.duree.inMinutes} min'),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VetementsGridView(
                          database: widget.database,
                          initialClient: rdv.client,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
