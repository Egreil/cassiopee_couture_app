import 'package:flutter/material.dart';
import '../../database/database.dart';
import 'vetement_details_view.dart';

class VetementDetailsScreen extends StatelessWidget {
  final AppDatabase database;
  final int vetementId;

  const VetementDetailsScreen({
    super.key,
    required this.database,
    required this.vetementId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<(Vetement, List<Photo>)>(
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
