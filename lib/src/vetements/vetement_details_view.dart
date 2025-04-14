import 'package:flutter/material.dart';
import '../../database/database.dart';
import '../../database/tables.dart';
import '../theme/app_theme.dart';

class VetementDetailsView extends StatelessWidget {
  final Vetement vetement;
  final List<Photo> photos;

  const VetementDetailsView({
    super.key,
    required this.vetement,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        title: Text(vetement.nom),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photos du vêtement
            if (photos.isNotEmpty)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(
                        photos[index].url,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 200,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.error),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),

            // Informations générales
            _buildInfoSection('Informations générales', [
              _buildInfoRow('Catégorie', vetement.category.name),
              _buildInfoRow(
                  'Événement',
                  vetement.evenement == TypeEvenement.soiree
                      ? 'Soirée'
                      : 'Mariage'),
              _buildInfoRow('Couleurs', vetement.couleurs),
              _buildInfoRow('Prix', '${vetement.prix}€'),
            ]),
            const SizedBox(height: 20),

            // Mesures
            _buildInfoSection('Mesures', [
              _buildInfoRow('Longueur totale', '${vetement.longueurTotale} cm'),
              if (vetement.tourTaille != null)
                _buildInfoRow('Tour de taille', '${vetement.tourTaille} cm'),
              if (vetement.tourPoitrine != null)
                _buildInfoRow(
                    'Tour de poitrine', '${vetement.tourPoitrine} cm'),
            ]),
            const SizedBox(height: 20),

            // Commentaire
            if (vetement.commentaire != null) ...[
              _buildInfoSection('Commentaire', [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(vetement.commentaire!),
                ),
              ]),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implémenter la modification du vêtement
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'AcuminProWide',
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: AppTheme.textDark,
              ),
            ),
          ),
          Divider(color: AppTheme.terracotta.withOpacity(0.2)),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'AcuminProWide',
              color: AppTheme.textLight,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'AcuminProWide',
              color: AppTheme.textDark,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
