import 'package:cassiopee_couture_app/src/menu/gestion/gestion_tasks_view.dart';
import 'package:flutter/material.dart';
import '../../../../database/database.dart';
import 'package:drift/drift.dart' show ComparableExpr, innerJoin;

class RendezVousSection extends StatefulWidget {
  final AppDatabase database;

  const RendezVousSection({super.key, required this.database});

  @override
  State<RendezVousSection> createState() => _RendezVousSectionState();
}

class _RendezVousSectionState extends State<RendezVousSection> {
  Stream<List<RendezVousWithClient>> _getRendezVousDuJour() {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);

    print('Date recherchée: $startOfDay');
    print('Requête des rendez-vous...');

    return (widget.database.select(widget.database.rendezVous))
        .join([
          innerJoin(
            widget.database.clients,
            widget.database.clients.id
                .equalsExp(widget.database.rendezVous.idClient),
          ),
        ])
        .watch()
        .map((rows) {
          print('Rendez-vous trouvés (total): ${rows.length}');
          rows.forEach((row) {
            final rdv = row.readTable(widget.database.rendezVous);
            print(
                'RDV trouvé - ID: ${rdv.id}, Date: ${rdv.date}, Heure: ${rdv.heure}');

            // Comparaison des dates
            final rdvDate = DateTime(
              rdv.date.year,
              rdv.date.month,
              rdv.date.day,
            );
            print(
                'Comparaison: ${rdvDate.isAtSameMomentAs(startOfDay)} (${rdvDate} == ${startOfDay})');
          });

          // Filtrer les rendez-vous pour aujourd'hui
          final todayRdv = rows.where((row) {
            final rdv = row.readTable(widget.database.rendezVous);
            final rdvDate = DateTime(
              rdv.date.year,
              rdv.date.month,
              rdv.date.day,
            );
            return rdvDate.isAtSameMomentAs(startOfDay);
          });

          return todayRdv.map((row) {
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
          }).toList();
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RendezVousWithClient>>(
      stream: _getRendezVousDuJour(),
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
                subtitle: Text('${rdv.heure} - ${rdv.motif}'),
                trailing: Text('${rdv.duree.inMinutes} min'),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
