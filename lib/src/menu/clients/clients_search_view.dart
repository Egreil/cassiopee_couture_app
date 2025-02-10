import 'package:drift/drift.dart'
    show BooleanExpressionOperators, Constant, StringExpressionOperators;
import 'package:flutter/material.dart';
import '../../../database/database.dart';
import '../../theme/app_theme.dart';

class ClientsSearchView extends StatefulWidget {
  final AppDatabase database;

  const ClientsSearchView({super.key, required this.database});

  @override
  State<ClientsSearchView> createState() => _ClientsSearchViewState();
}

class _ClientsSearchViewState extends State<ClientsSearchView> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        title: const Text('Recherche Clients'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un client...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Client>>(
              stream: _searchClients(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                }

                final clients = snapshot.data ?? [];

                if (clients.isEmpty) {
                  return const Center(
                    child: Text('Aucun client trouvé'),
                  );
                }

                return ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];
                    return _buildClientCard(client);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientCard(Client client) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text('${client.prenom} ${client.nom}'),
        subtitle: Text(client.mail ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => _showClientDetails(client),
        ),
      ),
    );
  }

  void _showClientDetails(Client client) {
    // TODO: Naviguer vers la vue détaillée du client
  }

  Stream<List<Client>> _searchClients() {
    return (widget.database.select(widget.database.clients)
          ..where((c) {
            if (searchQuery.isEmpty) return const Constant(true);
            return c.nom.like('%$searchQuery%') |
                c.prenom.like('%$searchQuery%') |
                c.mail.like('%$searchQuery%');
          }))
        .watch();
  }
}
