import 'package:cassiopee_couture_app/src/theme/app_theme.dart';
import 'package:drift/drift.dart'
    show
        BooleanExpressionOperators,
        ComparableExpr,
        Constant,
        Expression,
        OrderingTerm;
import 'package:flutter/material.dart';
import '../../database/database.dart';
import 'vetement_details_screen.dart';

class VetementsGridView extends StatefulWidget {
  final AppDatabase database;
  final Client? initialClient;

  const VetementsGridView({
    super.key,
    required this.database,
    this.initialClient,
  });

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
  Client? selectedClient;
  bool _showOnlyFavorites = false;
  List<int> _favoris = [];

  @override
  void initState() {
    super.initState();
    selectedClient = widget.initialClient;
    _loadFavoris();
  }

  Future<void> _loadFavoris() async {
    if (selectedClient != null) {
      final favoris = await (widget.database.select(widget.database.favoris)
            ..where((f) => f.idClient.equals(selectedClient!.id)))
          .get();
      setState(() {
        _favoris = favoris.map((f) => f.idVetement).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        title: Text(selectedClient != null
            ? 'Mme ${selectedClient?.nom}'
            : 'Catalogue'),
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
          if (selectedClient != null)
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: _showOnlyFavorites ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _showOnlyFavorites = !_showOnlyFavorites;
                });
              },
              tooltip: 'Afficher uniquement les favoris',
            ),
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
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VetementDetailsScreen(
                    database: widget.database,
                    vetementId: vetement.id,
                    client: selectedClient,
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
          if (selectedClient != null)
            Positioned(
              top: 8,
              right: 8,
              child: FavoriButton(
                vetementId: vetement.id,
                clientId: selectedClient!.id,
                database: widget.database,
                initialFavori: _favoris.contains(vetement.id),
                onToggle: (bool isFavori) =>
                    _toggleFavoriLocally(vetement.id, isFavori),
              ),
            ),
        ],
      ),
    );
  }

  void _toggleFavoriLocally(int vetementId, bool isFavori) {
    setState(() {
      if (isFavori) {
        _favoris.add(vetementId);
      } else {
        _favoris.remove(vetementId);
      }
    });
  }

  Stream<List<(Vetement, List<Photo>)>> _getVetementsWithPhotos() {
    return (widget.database.select(widget.database.vetements)
          ..where((v) {
            Expression<bool> predicate = const Constant(true);

            // Filtre des favoris
            if (_showOnlyFavorites && selectedClient != null) {
              predicate = predicate & v.id.isIn(_favoris);
            }

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

class ClientSelectorDialog extends StatelessWidget {
  final AppDatabase database;

  const ClientSelectorDialog({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sélectionner un client'),
      content: SizedBox(
        width: double.maxFinite,
        child: StreamBuilder<List<Client>>(
          stream: (database.select(database.clients)
                ..orderBy([
                  (t) => OrderingTerm(expression: t.nom),
                  (t) => OrderingTerm(expression: t.prenom),
                ]))
              .watch(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final clients = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];
                return ListTile(
                  title: Text('${client.prenom} ${client.nom}'),
                  subtitle: Text(client.numero),
                  onTap: () => Navigator.of(context).pop(client),
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
      ],
    );
  }
}

// Nouveau widget pour le bouton favori
class FavoriButton extends StatefulWidget {
  final int vetementId;
  final int clientId;
  final AppDatabase database;
  final bool initialFavori;
  final Function(bool)? onToggle;

  const FavoriButton({
    super.key,
    required this.vetementId,
    required this.clientId,
    required this.database,
    required this.initialFavori,
    this.onToggle,
  });

  @override
  State<FavoriButton> createState() => _FavoriButtonState();
}

class _FavoriButtonState extends State<FavoriButton> {
  late bool isFavori;

  @override
  void initState() {
    super.initState();
    isFavori = widget.initialFavori;
  }

  Future<void> _toggleFavori() async {
    try {
      final existingFavori =
          await (widget.database.select(widget.database.favoris)
                ..where((f) =>
                    f.idClient.equals(widget.clientId) &
                    f.idVetement.equals(widget.vetementId)))
              .getSingleOrNull();

      if (existingFavori == null) {
        await widget.database.into(widget.database.favoris).insert(
              FavorisCompanion.insert(
                idClient: widget.clientId,
                idVetement: widget.vetementId,
              ),
            );
        setState(() => isFavori = true);
        widget.onToggle?.call(true);
      } else {
        await (widget.database.delete(widget.database.favoris)
              ..where((f) => f.id.equals(existingFavori.id)))
            .go();
        setState(() => isFavori = false);
        widget.onToggle?.call(false);
      }
    } catch (e) {
      // Gérer l'erreur si nécessaire
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavori ? Icons.favorite : Icons.favorite_border,
        color: isFavori ? Colors.red : Colors.grey,
      ),
      onPressed: _toggleFavori,
    );
  }
}
