import 'package:cassiopee_couture_app/database/tables.dart';
import 'package:cassiopee_couture_app/src/menu/gestion/gestion_tasks_view.dart';
import 'package:drift/drift.dart' show ComparableExpr, innerJoin;
import 'package:flutter/material.dart';
import '../../../../../database/database.dart';

class CautionsSection extends StatefulWidget {
  final AppDatabase database;
  final CautionStatus status;

  const CautionsSection({
    super.key,
    required this.database,
    required this.status,
  });

  @override
  State<CautionsSection> createState() => _CautionsSectionState();
}

class _CautionsSectionState extends State<CautionsSection> {
  Stream<List<CautionWithClientAndReservation>> _getCautions() {
    return (widget.database.select(widget.database.cautions)
          ..where((r) => r.statut.equals(widget.status.name)))
        .join([
          innerJoin(
            widget.database.clients,
            widget.database.clients.id
                .equalsExp(widget.database.reservations.idClient),
          ),
          innerJoin(
            widget.database.reservations,
            widget.database.cautions.idReservation
                .equalsExp(widget.database.reservations.id),
          ),
        ])
        .watch()
        .map((rows) {
          print('Nombre de cautions trouvées ${widget.status}: ${rows.length}');
          return rows.map((row) {
            final caution = row.readTable(widget.database.cautions);
            final client = row.readTable(widget.database.clients);
            return CautionWithClientAndReservation(
              id: caution.id,
              montant: caution.montant,
              dateReception: caution.dateReception,
              client: client,
              idReservation: caution.idReservation,
            );
          }).toList();
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CautionWithClientAndReservation>>(
      stream: _getCautions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final cautions = snapshot.data ?? [];
        return Column(
          children: cautions.map((caution) {
            return Card(
              child: ListTile(
                title: Text('${caution.client.prenom} ${caution.client.nom}'),
                subtitle: Text('Tél: ${caution.client.numero}'),
                trailing: Text('${caution.montant.toStringAsFixed(2)} €'),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
