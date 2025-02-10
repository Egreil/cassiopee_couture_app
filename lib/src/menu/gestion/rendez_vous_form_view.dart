import 'package:cassiopee_couture_app/database/tables.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import '../../../database/database.dart';
import '../../theme/app_theme.dart';

class RendezVousFormView extends StatefulWidget {
  final AppDatabase database;
  final Client? client;
  final RendezVousData? rendezVous;
  final bool readOnly;

  const RendezVousFormView({
    super.key,
    required this.database,
    this.client,
    this.rendezVous,
    this.readOnly = false,
  });

  @override
  State<RendezVousFormView> createState() => _RendezVousFormViewState();
}

class _RendezVousFormViewState extends State<RendezVousFormView> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  Client? _selectedClient;
  MotifRendezVous _selectedType = MotifRendezVous.motif;

  @override
  void initState() {
    super.initState();
    _selectedClient = widget.client;
    if (widget.rendezVous != null) {
      _selectedDate = widget.rendezVous!.date;
      _selectedTime = TimeOfDay(
        hour: widget.rendezVous!.date.hour,
        minute: widget.rendezVous!.date.minute,
      );
      _selectedType = widget.rendezVous!.motif;
      _loadClient();
    }
  }

  Future<void> _loadClient() async {
    if (widget.rendezVous != null) {
      final client = await (widget.database.select(widget.database.clients)
            ..where((c) => c.id.equals(widget.rendezVous!.idClient)))
          .getSingle();
      setState(() {
        _selectedClient = client;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        title: Text(widget.rendezVous == null
            ? 'Nouveau Rendez-vous'
            : widget.readOnly
                ? 'Détails du Rendez-vous'
                : 'Modifier Rendez-vous'),
        actions: [
          if (widget.rendezVous != null && !widget.readOnly)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _confirmDelete,
            ),
          if (widget.rendezVous != null && widget.readOnly)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RendezVousFormView(
                      database: widget.database,
                      rendezVous: widget.rendezVous,
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
              if (widget.client == null && widget.rendezVous == null) ...[
                StreamBuilder<List<Client>>(
                  stream:
                      widget.database.select(widget.database.clients).watch(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return DropdownButtonFormField<Client>(
                      value: _selectedClient,
                      decoration: const InputDecoration(
                        labelText: 'Client *',
                        border: OutlineInputBorder(),
                      ),
                      items: snapshot.data!.map((client) {
                        return DropdownMenuItem(
                          value: client,
                          child: Text('${client.prenom} ${client.nom}'),
                        );
                      }).toList(),
                      onChanged: (Client? value) {
                        setState(() {
                          _selectedClient = value;
                        });
                      },
                      validator: (value) => value == null
                          ? 'Veuillez sélectionner un client'
                          : null,
                    );
                  },
                ),
                const SizedBox(height: 16),
              ] else
                ListTile(
                  title: Text('Client'),
                  subtitle: Text(_selectedClient == null
                      ? 'Chargement...'
                      : '${_selectedClient!.prenom} ${_selectedClient!.nom}'),
                ),

              // Date
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Sélectionner une date *'
                    : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                trailing: const Icon(Icons.calendar_today),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Colors.grey),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                },
              ),
              if (_selectedDate == null)
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 8),
                  child: Text(
                    'Veuillez sélectionner une date',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Heure
              ListTile(
                title: Text(_selectedTime == null
                    ? 'Sélectionner une heure *'
                    : 'Heure: ${_selectedTime!.format(context)}'),
                trailing: const Icon(Icons.access_time),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Colors.grey),
                ),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime ?? TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      _selectedTime = time;
                    });
                  }
                },
              ),
              if (_selectedTime == null)
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 8),
                  child: Text(
                    'Veuillez sélectionner une heure',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Type de rendez-vous
              DropdownButtonFormField<MotifRendezVous>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type de rendez-vous *',
                  border: OutlineInputBorder(),
                ),
                items: MotifRendezVous.values.map((type) {
                  String label;
                  switch (type) {
                    case MotifRendezVous.motif:
                      label = 'Motif';
                      break;
                    case MotifRendezVous.essayage:
                      label = 'Essayage';
                      break;
                    case MotifRendezVous.consultation:
                      label = 'Consultation';
                      break;
                    case MotifRendezVous.retour:
                      label = 'Retour';
                      break;
                  }
                  return DropdownMenuItem(
                    value: type,
                    child: Text(label),
                  );
                }).toList(),
                onChanged: widget.readOnly
                    ? null
                    : (MotifRendezVous? value) {
                        if (value != null) {
                          setState(() {
                            _selectedType = value;
                          });
                        }
                      },
              ),
              const SizedBox(height: 16),

              if (!widget.readOnly)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.terracotta,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _submitForm,
                  child: Text(
                      widget.rendezVous == null ? 'Enregistrer' : 'Modifier'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: const Text('Voulez-vous vraiment supprimer ce rendez-vous ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      await _deleteRendezVous();
    }
  }

  Future<void> _deleteRendezVous() async {
    try {
      await (widget.database.delete(widget.database.rendezVous)
            ..where((r) => r.id.equals(widget.rendezVous!.id)))
          .go();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rendez-vous supprimé')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la suppression: $e')),
        );
      }
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner une date et une heure'),
          ),
        );
        return;
      }

      try {
        final dateTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );

        if (widget.rendezVous == null) {
          await widget.database.into(widget.database.rendezVous).insert(
                RendezVousCompanion.insert(
                  idClient: _selectedClient!.id,
                  date: dateTime,
                  heure: _selectedTime!.format(context),
                  duree: const Duration(minutes: 30),
                  motif: _selectedType,
                ),
              );
        } else {
          await (widget.database.update(widget.database.rendezVous)
                ..where((r) => r.id.equals(widget.rendezVous!.id)))
              .write(
            RendezVousCompanion(
              date: Value(dateTime),
              heure: Value(_selectedTime!.format(context)),
              duree: Value(const Duration(minutes: 30)),
              motif: Value(_selectedType),
            ),
          );
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.rendezVous == null
                  ? 'Rendez-vous ajouté avec succès'
                  : 'Rendez-vous modifié avec succès'),
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur: $e')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
