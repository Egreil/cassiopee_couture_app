import 'package:cassiopee_couture_app/src/menu/gestion/gestion_tasks_view.dart';
import 'package:flutter/material.dart';
import '../../../../database/database.dart';
import 'package:drift/drift.dart' show innerJoin, ComparableExpr;

class RetoursSection extends StatefulWidget {
  final AppDatabase database;
  final bool isRetour; // true pour retours, false pour départs

  const RetoursSection({
    super.key,
    required this.database,
    required this.isRetour,
  });

  @override
  State<RetoursSection> createState() => _RetoursSectionState();
}

class _RetoursSectionState extends State<RetoursSection> {
  Stream<List<RetourWithClientAndVetement>> _getRetours() {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (widget.database.select(widget.database.reservations)
          ..where((r) => widget.isRetour
              ? r.dateRetour.isBetweenValues(startOfDay, endOfDay)
              : r.dateSortie.isBetweenValues(startOfDay, endOfDay)))
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
                dateRetour: widget.isRetour
                    ? reservation.dateRetour!
                    : reservation.dateSortie,
                client: client,
                vetement: vetement,
              );
            }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RetourWithClientAndVetement>>(
      stream: _getRetours(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final retours = snapshot.data ?? [];
        return Column(
          children: retours.map((retour) {
            return Card(
              child: ListTile(
                title: Text(retour.vetement.nom),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Client: ${retour.client.prenom} ${retour.client.nom}'),
                    Text('Tél: ${retour.client.numero}'),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
