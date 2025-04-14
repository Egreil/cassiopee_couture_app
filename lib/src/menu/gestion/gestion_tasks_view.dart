import 'package:cassiopee_couture_app/database/tables.dart';
import 'package:drift/drift.dart' show TableOrViewStatements;
import 'package:flutter/material.dart';
import '../../../database/database.dart';
import '../../theme/app_theme.dart';
import 'components/rendez_vous_section.dart';
import 'components/cautions/cautions_section.dart';
import 'components/retours_section.dart';
import 'components/acomptes_section.dart';

class GestionTasksView extends StatefulWidget {
  final AppDatabase database;

  const GestionTasksView({super.key, required this.database});

  @override
  State<GestionTasksView> createState() => _GestionTasksViewState();
}

class _GestionTasksViewState extends State<GestionTasksView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scrollController = ScrollController();
  final List<String> _tabs = [
    'Rendez-vous',
    'Cautions à rendre',
    'Cautions à recevoir',
    'Retours',
    'Départs',
    'Acomptes',
    'Paiements',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final tabIndex = (currentScroll / (maxScroll / (_tabs.length - 1))).round();
    _tabController.animateTo(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
      // Écouter les changements dans la table rendez_vous
      stream: widget.database.select(widget.database.rendezVous).watch(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: AppTheme.blancCasse,
          appBar: AppBar(
            title: const Text('Tâches du jour'),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
              onTap: (index) {
                final position =
                    (index * _scrollController.position.maxScrollExtent) /
                        (_tabs.length - 1);
                _scrollController.animateTo(
                  position,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: _tabs.map((tab) => _buildSection(tab)).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(String title) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(height: 1, color: Colors.black12),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textDark,
                    ),
              ),
              StreamBuilder<TaskCount>(
                stream: _getSectionTaskCount(title),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox.shrink();
                  final count = snapshot.data!;

                  if (count.total == 0) {
                    return const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 24,
                    );
                  }

                  return Text(
                    '${count.completed}/${count.total}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: count.completed == count.total
                              ? Colors.green
                              : AppTheme.textDark,
                        ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionContent(title, []),
        ],
      ),
    );
  }

  Widget _buildSectionContent(String title, List<dynamic> items) {
    switch (title) {
      case 'Rendez-vous':
        return RendezVousSection(database: widget.database);
      case 'Cautions à rendre':
        return CautionsSection(
          database: widget.database,
          status: CautionStatus.AR,
        );
      case 'Cautions à recevoir':
        return CautionsSection(
          database: widget.database,
          status: CautionStatus.EA,
        );
      case 'Retours':
        return RetoursSection(
          database: widget.database,
          isRetour: true,
        );
      case 'Départs':
        return RetoursSection(
          database: widget.database,
          isRetour: false,
        );
      case 'Acomptes':
        return AcomptesSection(
          database: widget.database,
          isPaiementComplet: false,
        );
      case 'Paiements':
        return AcomptesSection(
          database: widget.database,
          isPaiementComplet: true,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Stream<TaskCount> _getSectionTaskCount(String title) {
    switch (title) {
      case 'Rendez-vous':
        return widget.database.rendezVous
            .select()
            .watch()
            .map((items) => TaskCount(0, items.length));
      case 'Cautions à rendre':
        return widget.database.cautions.select().watch().map((items) {
          final total = items.where((c) => c.statut == 'AR').length;
          return TaskCount(0, total);
        });
      // Autres cas similaires...
      default:
        return Stream.value(const TaskCount(0, 0));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class RendezVousWithClient {
  final int id;
  final DateTime date;
  final String heure;
  final Duration duree;
  final MotifRendezVous motif;
  final Client client;

  RendezVousWithClient({
    required this.id,
    required this.date,
    required this.heure,
    required this.duree,
    required this.motif,
    required this.client,
  });
}

class CautionWithClientAndVetement {
  final int id;
  final double montant;
  final DateTime dateReception;
  final Client client;
  final Vetement vetement;
  final String statut;

  const CautionWithClientAndVetement({
    required this.id,
    required this.montant,
    required this.dateReception,
    required this.client,
    required this.vetement,
    required this.statut,
  });
}

class RetourWithClientAndVetement {
  final int id;
  final DateTime dateRetour;
  final Client client;
  final Vetement vetement;

  RetourWithClientAndVetement({
    required this.id,
    required this.dateRetour,
    required this.client,
    required this.vetement,
  });
}

class AcompteWithClientAndVetement {
  final int id;
  final double montant;
  final DateTime datePaiement;
  final Client client;
  final Vetement vetement;
  final int paye;

  AcompteWithClientAndVetement({
    required this.id,
    required this.montant,
    required this.datePaiement,
    required this.client,
    required this.vetement,
    required this.paye,
  });
}

class CautionWithClientAndReservation {
  final int id;
  final double montant;
  final DateTime dateReception;
  final Client client;
  final int idReservation;

  const CautionWithClientAndReservation({
    required this.id,
    required this.montant,
    required this.dateReception,
    required this.client,
    required this.idReservation,
  });
}

class TaskCount {
  final int completed;
  final int total;

  const TaskCount(this.completed, this.total);
}
