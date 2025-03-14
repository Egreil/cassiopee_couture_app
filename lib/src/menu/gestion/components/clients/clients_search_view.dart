import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';
import '../../../../../database/database.dart';
import 'client_form_view.dart'; // Ajustez ce chemin selon l'emplacement réel

class ClientsSearchView extends StatefulWidget {
  final AppDatabase database;

  const ClientsSearchView({super.key, required this.database});

  @override
  State<ClientsSearchView> createState() => _ClientsSearchViewState();
}

class _ClientsSearchViewState extends State<ClientsSearchView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openClientForm({Client? client, bool readOnly = false}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientFormView(
          database: widget.database,
          client: client,
          readOnly: readOnly,
        ),
      ),
    );

    if (result == true) {
      // Force le rebuild du widget pour rafraîchir la liste
      setState(() {
        _searchController.clear();
        _searchQuery = '';
      });
    }
  }

  Stream<List<Client>> _getClients() {
    return (widget.database.select(widget.database.clients)
          ..orderBy([
            (t) => OrderingTerm(expression: t.nom),
            (t) => OrderingTerm(expression: t.prenom),
          ]))
        .watch()
        .distinct();
  }

  @override
  Widget build(BuildContext context) {
    print('Building ClientsSearchView');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechercher un client'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _openClientForm(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher un client',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Client>>(
              stream: _getClients(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final allClients = snapshot.data!;
                final filteredClients = allClients.where((client) {
                  final searchStr = _searchQuery.toLowerCase();
                  return client.nom.toLowerCase().contains(searchStr) ||
                      client.prenom.toLowerCase().contains(searchStr) ||
                      client.numero.contains(searchStr);
                }).toList();

                if (filteredClients.isEmpty) {
                  return const Center(
                    child: Text('Aucun client trouvé'),
                  );
                }

                return ListView.builder(
                  itemCount: filteredClients.length,
                  itemBuilder: (context, index) {
                    final client = filteredClients[index];
                    print('vue build');
                    return ListTile(
                      title: Text('${client.prenom} ${client.nom}'),
                      subtitle: Text(client.numero),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () =>
                            _openClientForm(client: client, readOnly: true),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
