import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import '../../../../../database/database.dart';

class ClientFormView extends StatefulWidget {
  final AppDatabase database;
  final Client? client; // null pour un nouveau client
  final bool readOnly;

  const ClientFormView({
    super.key,
    required this.database,
    this.client,
    this.readOnly = false,
  });

  @override
  State<ClientFormView> createState() => _ClientFormViewState();
}

class _ClientFormViewState extends State<ClientFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _adresseController = TextEditingController();
  final _numeroController = TextEditingController();
  final _mailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _nomController.text = widget.client!.nom;
      _prenomController.text = widget.client!.prenom;
      _adresseController.text = widget.client!.adresse;
      _numeroController.text = widget.client!.numero;
      _mailController.text = widget.client!.mail ?? '';
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _adresseController.dispose();
    _numeroController.dispose();
    _mailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.client == null
            ? 'Nouveau client'
            : widget.readOnly
                ? 'Détails du client'
                : 'Modifier le client'),
        actions: [
          if (widget.readOnly && widget.client != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientFormView(
                      database: widget.database,
                      client: widget.client,
                      readOnly: false,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                readOnly: widget.readOnly,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
                readOnly: widget.readOnly,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prénom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _adresseController,
                decoration: const InputDecoration(
                  labelText: 'Adresse',
                  border: OutlineInputBorder(),
                ),
                readOnly: widget.readOnly,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une adresse';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(
                  labelText: 'Numéro de téléphone',
                  border: OutlineInputBorder(),
                ),
                readOnly: widget.readOnly,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un numéro de téléphone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mailController,
                decoration: const InputDecoration(
                  labelText: 'Email (optionnel)',
                  border: OutlineInputBorder(),
                ),
                readOnly: widget.readOnly,
                keyboardType: TextInputType.emailAddress,
              ),
              if (!widget.readOnly) ...[
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveClient,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Enregistrer'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveClient() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.client == null) {
          // Ajout d'un nouveau client
          final client = ClientsCompanion.insert(
            nom: _nomController.text,
            prenom: _prenomController.text,
            adresse: _adresseController.text,
            numero: _numeroController.text,
            mail: Value(
                _mailController.text.isEmpty ? null : _mailController.text),
          );

          await widget.database.into(widget.database.clients).insert(client);
        } else {
          // Modification d'un client existant
          await (widget.database.update(widget.database.clients)
                ..where((t) => t.id.equals(widget.client!.id)))
              .write(ClientsCompanion(
            nom: Value(_nomController.text),
            prenom: Value(_prenomController.text),
            adresse: Value(_adresseController.text),
            numero: Value(_numeroController.text),
            mail: Value(
                _mailController.text.isEmpty ? null : _mailController.text),
          ));
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Client enregistré avec succès'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
