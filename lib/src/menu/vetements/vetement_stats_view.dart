import 'package:flutter/material.dart';
import '../../../database/database.dart';
import '../../theme/app_theme.dart';

class VetementStatsView extends StatelessWidget {
  final AppDatabase database;

  const VetementStatsView({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        title: const Text('Statistiques Vêtements'),
      ),
      body: StreamBuilder<List<Vetement>>(
        stream: _getVetements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          final vetements = snapshot.data ?? [];
          return ListView.builder(
            itemCount: vetements.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final vetement = vetements[index];
              return _buildVetementStatsCard(vetement);
            },
          );
        },
      ),
    );
  }

  Widget _buildVetementStatsCard(Vetement vetement) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vetement.nom,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            StreamBuilder<VetementStats>(
              stream: _getVetementStats(vetement.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final stats = snapshot.data!;
                return Column(
                  children: [
                    _buildStatRow(
                        'Nombre de réservations', stats.nbReservations),
                    _buildStatRow('Revenu total', '${stats.revenuTotal}€'),
                    _buildStatRow('Dernière location',
                        stats.derniereLocation?.toString() ?? 'Jamais loué'),
                    _buildStatRow('Taux d\'occupation',
                        '${(stats.tauxOccupation * 100).toStringAsFixed(1)}%'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.terracotta,
            ),
          ),
        ],
      ),
    );
  }

  Stream<List<Vetement>> _getVetements() {
    return (database.select(database.vetements)).watch();
  }

  Stream<VetementStats> _getVetementStats(int vetementId) {
    // TODO: Implémenter le calcul des statistiques
    return Stream.value(VetementStats(
      nbReservations: 0,
      revenuTotal: 0,
      derniereLocation: null,
      tauxOccupation: 0,
    ));
  }
}

class VetementStats {
  final int nbReservations;
  final double revenuTotal;
  final DateTime? derniereLocation;
  final double tauxOccupation;

  VetementStats({
    required this.nbReservations,
    required this.revenuTotal,
    this.derniereLocation,
    required this.tauxOccupation,
  });
}
