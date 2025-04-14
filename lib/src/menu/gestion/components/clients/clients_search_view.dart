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
  String _searchQuery = '';
  List<Client> _allClients = [];

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    final clients = await widget.database.select(widget.database.clients).get();
    setState(() {
      _allClients = clients;
    });
  }

  List<Client> _getFilteredClients() {
    return _allClients.where((client) {
      final searchStr = _searchQuery.toLowerCase();
      return client.nom.toLowerCase().contains(searchStr) ||
          client.prenom.toLowerCase().contains(searchStr) ||
          client.numero.contains(searchStr);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredClients = _getFilteredClients();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => setState(() => _searchQuery = value),
          decoration: const InputDecoration(
            hintText: 'Rechercher un client...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _openClientForm(),
          ),
        ],
      ),
      body: _allClients.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: filteredClients.length,
              itemBuilder: (context, index) {
                final client = filteredClients[index];
                return ListTile(
                  title: Text('${client.prenom} ${client.nom}'),
                  subtitle: Text(client.numero),
                  onTap: () => Navigator.pop(context, client),
                );
              },
            ),
    );
  }

  Future<void> _openClientForm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientFormView(
          database: widget.database,
          readOnly: false,
        ),
      ),
    );

    if (result == true) {
      _loadClients(); // Recharger la liste après l'ajout
    }
  }
}
