import 'package:cassiopee_couture_app/src/menu/gestion/gestion_tasks_view.dart';
import 'package:drift/drift.dart' show innerJoin;
import 'package:flutter/material.dart';
import '../../../../database/database.dart';
import '../../../acomptes/acompte_validation_view.dart';

class AcomptesSection extends StatefulWidget {
  final AppDatabase database;
  final bool
      isPaiementComplet; // true pour paiements complets, false pour acomptes

  const AcomptesSection({
    super.key,
    required this.database,
    required this.isPaiementComplet,
  });

  @override
  State<AcomptesSection> createState() => _AcomptesSectionState();
}

class _AcomptesSectionState extends State<AcomptesSection> {
  late Future<List<AcompteWithClientAndVetement>> _acomptesFuture;

  @override
  void initState() {
    super.initState();
    _refreshAcomptes();
  }

  void _refreshAcomptes() {
    setState(() {
      _acomptesFuture = _getAcomptes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AcompteWithClientAndVetement>>(
      future: _acomptesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Aucun acompte à afficher'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final acompte = snapshot.data![index];
            return Card(
              child: ListTile(
                title: Text('${acompte.client.prenom} ${acompte.client.nom}'),
                subtitle: Text(
                    'Acompte: ${acompte.montant}€ - ${acompte.vetement.nom}'),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcompteValidationView(
                        database: widget.database,
                        acompte: acompte,
                      ),
                    ),
                  );
                  if (result == true) {
                    _refreshAcomptes(); // Rafraîchir la liste après validation
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<List<AcompteWithClientAndVetement>> _getAcomptes() async {
    final results = await (widget.database.select(widget.database.acomptes)
          ..where((a) => a.paye.equals(widget.isPaiementComplet ? 1 : 0)))
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
    ]).get();

    return results.map((row) {
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
    }).toList();
  }
}
