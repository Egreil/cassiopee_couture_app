import 'package:cassiopee_couture_app/src/theme/app_theme.dart';
import 'package:drift/drift.dart'
    show BooleanExpressionOperators, ComparableExpr, Constant, Expression;
import 'package:flutter/material.dart';
import '../../database/database.dart';
import 'vetement_details_screen.dart';

class VetementsGridView extends StatefulWidget {
  final AppDatabase database;

  const VetementsGridView({super.key, required this.database});

  @override
  State<VetementsGridView> createState() => _VetementsGridViewState();
}

class _VetementsGridViewState extends State<VetementsGridView> {
  String? selectedCategory;
  DateTime? startDate;
  DateTime? endDate;
  double? minTaille;
  double? maxTaille;
  double? minPoitrine;
  double? maxPoitrine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        title: const Text('Vêtements'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _buildFilterBar(),
        ),
      ),
      body: StreamBuilder<List<(Vetement, List<Photo>)>>(
        stream: _getVetementsWithPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          final vetements = snapshot.data ?? [];

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: vetements.length,
            itemBuilder: (context, index) {
              final (vetement, photos) = vetements[index];
              return _buildVetementCard(context, vetement, photos);
            },
          );
        },
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      color: AppTheme.terracotta.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Filtre par catégorie
          Expanded(
            child: DropdownButton<String>(
              value: selectedCategory,
              hint: const Text('Catégorie'),
              isExpanded: true,
              items: ['Tous', 'robe', 'jupe', 'haut']
                  .map((category) => DropdownMenuItem(
                        value: category == 'Tous' ? null : category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
          ),
          const SizedBox(width: 8),

          // Bouton pour ouvrir le dialogue de dates
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _showDateRangeDialog,
          ),

          // Bouton pour ouvrir le dialogue des mesures
          IconButton(
            icon: const Icon(Icons.straighten),
            onPressed: _showMeasuresDialog,
          ),
        ],
      ),
    );
  }

  Future<void> _showDateRangeDialog() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: startDate != null && endDate != null
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
    );
    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  Future<void> _showMeasuresDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mesures'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedCategory != 'haut') ...[
              _buildRangeField(
                'Tour de taille (cm)',
                minTaille,
                maxTaille,
                (min, max) {
                  setState(() {
                    minTaille = min;
                    maxTaille = max;
                  });
                },
              ),
            ],
            if (selectedCategory != 'jupe') ...[
              _buildRangeField(
                'Tour de poitrine (cm)',
                minPoitrine,
                maxPoitrine,
                (min, max) {
                  setState(() {
                    minPoitrine = min;
                    maxPoitrine = max;
                  });
                },
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Widget _buildRangeField(
    String label,
    double? currentMin,
    double? currentMax,
    Function(double?, double?) onChanged,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Min $label',
            ),
            keyboardType: TextInputType.number,
            controller:
                TextEditingController(text: currentMin?.toString() ?? ''),
            onChanged: (value) {
              onChanged(
                double.tryParse(value),
                currentMax,
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Max $label',
            ),
            keyboardType: TextInputType.number,
            controller:
                TextEditingController(text: currentMax?.toString() ?? ''),
            onChanged: (value) {
              onChanged(
                currentMin,
                double.tryParse(value),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVetementCard(
      BuildContext context, Vetement vetement, List<Photo> photos) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VetementDetailsScreen(
                database: widget.database,
                vetementId: vetement.id,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: photos.isNotEmpty
                  ? Image.network(
                      photos.first.url,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppTheme.blancCasse,
                          child: Icon(Icons.image_not_supported,
                              color: AppTheme.textLight),
                        );
                      },
                    )
                  : Container(
                      color: AppTheme.blancCasse,
                      child: Icon(Icons.image_not_supported,
                          color: AppTheme.textLight),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vetement.nom,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${vetement.prix}€',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.terracotta,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<(Vetement, List<Photo>)>> _getVetementsWithPhotos() {
    return (widget.database.select(widget.database.vetements)
          ..where((v) {
            Expression<bool> predicate = const Constant(true);

            // Filtre par catégorie
            if (selectedCategory != null) {
              predicate = predicate & v.category.equals(selectedCategory!);
            }

            // Filtre par mesures
            if (selectedCategory != 'haut') {
              if (minTaille != null) {
                predicate =
                    predicate & v.tourTaille.isBiggerOrEqualValue(minTaille!);
              }
              if (maxTaille != null) {
                predicate =
                    predicate & v.tourTaille.isSmallerOrEqualValue(maxTaille!);
              }
            }

            if (selectedCategory != 'jupe') {
              if (minPoitrine != null) {
                predicate = predicate &
                    v.tourPoitrine.isBiggerOrEqualValue(minPoitrine!);
              }
              if (maxPoitrine != null) {
                predicate = predicate &
                    v.tourPoitrine.isSmallerOrEqualValue(maxPoitrine!);
              }
            }

            return predicate;
          }))
        .watch()
        .asyncMap((vetements) async {
      final results = <(Vetement, List<Photo>)>[];
      for (final vetement in vetements) {
        // Vérifier la disponibilité si des dates sont sélectionnées
        if (startDate != null && endDate != null) {
          final reservations =
              await (widget.database.select(widget.database.reservations)
                    ..where((r) => r.idVetement.equals(vetement.id)))
                  .get();

          bool isAvailable = true;
          for (final reservation in reservations) {
            if (reservation.dateReservation.isBefore(endDate!) &&
                reservation.dateSortie.isAfter(startDate!)) {
              isAvailable = false;
              break;
            }
          }
          if (!isAvailable) continue;
        }

        final photos = await (widget.database.select(widget.database.photos)
              ..where((p) => p.idVetement.equals(vetement.id)))
            .get();
        results.add((vetement, photos));
      }
      return results;
    });
  }
}
