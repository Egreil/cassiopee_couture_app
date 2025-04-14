import 'package:cassiopee_couture_app/database/database.dart';
import 'package:cassiopee_couture_app/database/tables.dart';
import 'package:cassiopee_couture_app/src/menu/gestion/components/clients/clients_search_view.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cassiopee_couture_app/src/reservations/acompte_form_view.dart';

class ReservationFormView extends StatefulWidget {
  final AppDatabase database;
  final int vetementId;
  final Client? client;

  const ReservationFormView({
    super.key,
    required this.database,
    required this.vetementId,
    this.client,
  });

  @override
  State<ReservationFormView> createState() => _ReservationFormViewState();
}

class _ReservationFormViewState extends State<ReservationFormView> {
  final _formKey = GlobalKey<FormState>();
  Client? _selectedClient;
  late DateTime _dateSortie;
  late DateTime _dateRetourPrevue;
  late Future<Vetement> _vetement;
  final _avanceController = TextEditingController();
  static const PRIX_JOURNALIER = 25.0;
  final _reductionController = TextEditingController(text: '0');
  bool _isReductionPourcentage = false;
  late double _prixTotal;
  late double _acompte;

  @override
  void initState() {
    super.initState();
    _selectedClient = widget.client;
    _dateSortie = DateTime.now().add(const Duration(days: 3));
    _dateRetourPrevue = _dateSortie.add(const Duration(days: 7));
    _vetement = (widget.database.select(widget.database.vetements)
          ..where((v) => v.id.equals(widget.vetementId)))
        .getSingle();
    _calculerPrix();
  }

  void _calculerPrix() {
    final dureeLocation = _dateRetourPrevue.difference(_dateSortie).inDays + 1;
    final prixBase = PRIX_JOURNALIER * dureeLocation;
    final reductionValue = double.tryParse(_reductionController.text) ?? 0;

    if (_isReductionPourcentage) {
      final pourcentageReduction = reductionValue.clamp(0, 100);
      _prixTotal = prixBase * (1 - pourcentageReduction / 100);
    } else {
      _prixTotal = prixBase - reductionValue.clamp(0, prixBase);
    }

    _acompte = _prixTotal * 0.3;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle Réservation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveReservation,
          ),
        ],
      ),
      body: FutureBuilder<Vetement>(
        future: _vetement,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final vetement = snapshot.data!;
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Informations du vêtement
                Card(
                  child: ListTile(
                    title: Text(vetement.nom),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Prix: ${vetement.prix}€'),
                        Text('Caution: ${vetement.prix}€'),
                      ],
                    ),
                    leading: const Icon(Icons.checkroom),
                    isThreeLine: true,
                  ),
                ),
                const SizedBox(height: 16),

                // Sélecteur de client
                Card(
                  child: ListTile(
                    title: Text(_selectedClient == null
                        ? 'Sélectionner un client'
                        : '${_selectedClient!.prenom} ${_selectedClient!.nom}'),
                    subtitle: _selectedClient == null
                        ? const Text('Cliquez pour sélectionner')
                        : Text(_selectedClient!.numero),
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: _selectClient,
                  ),
                ),

                const SizedBox(height: 16),
                // Date de sortie
                ListTile(
                  title: Text(
                      'Date de sortie: ${_dateSortie.day}/${_dateSortie.month}/${_dateSortie.year}'),
                  leading: const Icon(Icons.event_available),
                  onTap: () => _selectDate(true),
                ),

                const SizedBox(height: 16),

                // Date de retour prévue
                ListTile(
                  title: Text(
                      'Date de retour prévue: ${_dateRetourPrevue.day}/${_dateRetourPrevue.month}/${_dateRetourPrevue.year}'),
                  leading: const Icon(Icons.event_repeat),
                  onTap: () => _selectDate(false),
                ),

                const SizedBox(height: 16),
                // Durée et prix
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Durée: ${_dateRetourPrevue.difference(_dateSortie).inDays + 1} jours',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Prix journalier: ${PRIX_JOURNALIER.toStringAsFixed(2)}€',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        // Réduction
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _reductionController,
                                decoration: InputDecoration(
                                  labelText:
                                      'Réduction ${_isReductionPourcentage ? '(%)' : '(€)'}',
                                  border: const OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => _calculerPrix(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(_isReductionPourcentage
                                  ? Icons.percent
                                  : Icons.euro),
                              onPressed: () {
                                setState(() {
                                  _isReductionPourcentage =
                                      !_isReductionPourcentage;
                                  _reductionController.text = '0';
                                  _calculerPrix();
                                });
                              },
                              tooltip: 'Basculer entre % et €',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Prix total (non modifiable)
                        TextFormField(
                          key: ValueKey(_prixTotal),
                          initialValue: _prixTotal.toStringAsFixed(2),
                          decoration: const InputDecoration(
                            labelText: 'Prix total (€)',
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                        const SizedBox(height: 8),
                        // Acompte (non modifiable)
                        TextFormField(
                          key: ValueKey(_acompte),
                          initialValue: _acompte.toStringAsFixed(2),
                          decoration: const InputDecoration(
                            labelText: 'Acompte (30%) (€)',
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectClient() async {
    final selectedClient = await Navigator.push<Client>(
      context,
      MaterialPageRoute(
        builder: (context) => ClientsSearchView(database: widget.database),
      ),
    );

    if (selectedClient != null) {
      setState(() {
        _selectedClient = selectedClient;
      });
    }
  }

  Future<void> _selectDate(bool isSortie) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isSortie ? _dateSortie : _dateRetourPrevue,
      firstDate: isSortie ? DateTime.now() : _dateSortie,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isSortie) {
          _dateSortie = picked;
          if (_dateRetourPrevue.isBefore(_dateSortie)) {
            _dateRetourPrevue = _dateSortie.add(const Duration(days: 7));
          }
        } else {
          _dateRetourPrevue = picked;
        }
        _calculerPrix();
      });
    }
  }

  Future<void> _saveReservation() async {
    if (_formKey.currentState!.validate() && _selectedClient != null) {
      try {
        final vetement = await _vetement;
        final now = DateTime.now();

        final reservationId =
            await widget.database.into(widget.database.reservations).insert(
                  ReservationsCompanion.insert(
                    idVetement: widget.vetementId,
                    idClient: _selectedClient!.id,
                    dateReservation: now,
                    dateSortie: _dateSortie,
                    dateRetour: Value(_dateRetourPrevue),
                  ),
                );

        await widget.database.into(widget.database.cautions).insert(
              CautionsCompanion.insert(
                montant: vetement.prix,
                statut: CautionStatus.EA,
                idReservation: reservationId,
                dateReception: now,
              ),
            );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AcompteFormView(
                database: widget.database,
                reservationId: reservationId,
                montantTotal: _prixTotal,
              ),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }
}
