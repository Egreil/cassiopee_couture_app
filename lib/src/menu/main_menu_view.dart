import 'package:cassiopee_couture_app/database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../vetements/vetements_grid_view.dart';
import 'gestion/gestion_tasks_view.dart';
import 'gestion/components/clients/clients_search_view.dart';
import 'vetements/vetement_form_view.dart';
import 'vetements/vetement_stats_view.dart';
import 'calendar/calendar_view.dart';
import 'gestion/rendez_vous_form_view.dart';
import 'debug/database_view.dart';

class MainMenuView extends StatelessWidget {
  final AppDatabase database;

  const MainMenuView({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        title: const Text('Cassiopée Couture'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMenuButton(
              context,
              'Catalogue',
              Icons.grid_view,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VetementsGridView(database: database),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildExpandableMenu(
              context,
              'Gestion',
              [
                _MenuItem(
                  'Tâches du jour',
                  Icons.task,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GestionTasksView(database: database),
                    ),
                  ),
                ),
                _MenuItem(
                  'Recherche clients',
                  Icons.people,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ClientsSearchView(database: database),
                    ),
                  ),
                ),
                _MenuItem(
                  'Nouveau vêtement',
                  Icons.add_circle,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VetementFormView(database: database),
                    ),
                  ),
                ),
                _MenuItem(
                  'Statistiques vêtements',
                  Icons.analytics,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VetementStatsView(database: database),
                    ),
                  ),
                ),
                _MenuItem(
                  'Calendrier',
                  Icons.calendar_month,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarView(database: database),
                    ),
                  ),
                ),
                _MenuItem(
                  'Nouveau rendez-vous',
                  Icons.event_available,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RendezVousFormView(database: database),
                    ),
                  ),
                ),
              ],
            ),
            if (kDebugMode)
              _buildMenuButton(
                context,
                'Base de données',
                Icons.storage,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DatabaseView(database: database),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.terracotta,
        foregroundColor: AppTheme.blancCasse,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableMenu(
    BuildContext context,
    String title,
    List<_MenuItem> items,
  ) {
    return Card(
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        children: items
            .map((item) => ListTile(
                  leading: Icon(item.icon, color: AppTheme.terracotta),
                  title: Text(item.title),
                  onTap: item.onTap,
                ))
            .toList(),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  _MenuItem(this.title, this.icon, this.onTap);
}
