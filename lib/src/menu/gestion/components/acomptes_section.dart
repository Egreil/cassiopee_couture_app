import 'package:cassiopee_couture_app/src/menu/gestion/gestion_tasks_view.dart';
import 'package:drift/drift.dart' show innerJoin;
import 'package:flutter/material.dart';
import '../../../../database/database.dart';

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
  Stream<List<AcompteWithClientAndVetement>> _getAcomptes() {
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

              // Filtrer les paiements complets vs acomptes
              if (widget.isPaiementComplet &&
                  acompte.montant != vetement.prix) {
                return null;
              }
              if (!widget.isPaiementComplet &&
                  acompte.montant == vetement.prix) {
                return null;
              }

              return AcompteWithClientAndVetement(
                id: acompte.id,
                montant: acompte.montant,
                datePaiement: acompte.datePaiement,
                paye: acompte.paye,
                client: client,
                vetement: vetement,
              );
            })
            .where((element) => element != null)
            .cast<AcompteWithClientAndVetement>()
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AcompteWithClientAndVetement>>(
      stream: _getAcomptes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final acomptes = snapshot.data ?? [];
        return Column(
          children: acomptes.map((acompte) {
            return Card(
              child: ListTile(
                title: Text(acompte.vetement.nom),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Client: ${acompte.client.prenom} ${acompte.client.nom}'),
                    Text('Tél: ${acompte.client.numero}'),
                  ],
                ),
                trailing: Text('${acompte.montant.toStringAsFixed(2)} €'),
                isThreeLine: true,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
