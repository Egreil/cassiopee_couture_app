import 'package:cassiopee_couture_app/src/reservations/reservation_form_view.dart';
import 'package:flutter/material.dart';
import '../../database/database.dart';
import 'vetement_details_view.dart';

class VetementDetailsScreen extends StatelessWidget {
  final AppDatabase database;
  final int vetementId;
  final Client? client; // Client qui consulte le catalogue

  const VetementDetailsScreen({
    super.key,
    required this.database,
    required this.vetementId,
    this.client, // Ajout du paramètre client
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du vêtement'),
        actions: [
          if (client !=
              null) // N'afficher le bouton que si un client est sélectionné
            IconButton(
              icon: const Icon(Icons.shopping_cart_checkout),
              onPressed: () => _createReservation(context),
            ),
        ],
      ),
      body: StreamBuilder<(Vetement, List<Photo>)>(
        stream: _getVetementWithPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Erreur: ${snapshot.error}')),
            );
          }

          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: Text('Vêtement non trouvé')),
            );
          }

          final (vetement, photos) = snapshot.data!;
          return VetementDetailsView(
            vetement: vetement,
            photos: photos,
          );
        },
      ),
    );
  }

  void _createReservation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationFormView(
          database: database,
          vetementId: vetementId,
          client: client, // Passage du client à la vue de réservation
        ),
      ),
    );
  }

  Stream<(Vetement, List<Photo>)> _getVetementWithPhotos() {
    return (database.select(database.vetements)
          ..where((v) => v.id.equals(vetementId)))
        .watchSingle()
        .asyncMap((vetement) async {
      final photos = await (database.select(database.photos)
            ..where((p) => p.idVetement.equals(vetementId)))
          .get();
      return (vetement, photos);
    });
  }
}
