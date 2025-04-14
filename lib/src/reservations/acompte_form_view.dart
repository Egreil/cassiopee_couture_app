import 'package:flutter/material.dart';
import '../../database/database.dart';
import '../../database/tables.dart';
import 'package:cassiopee_couture_app/src/theme/app_theme.dart';

class AcompteFormView extends StatefulWidget {
  final AppDatabase database;
  final int reservationId;
  final double montantTotal;

  const AcompteFormView({
    super.key,
    required this.database,
    required this.reservationId,
    required this.montantTotal,
  });

  @override
  State<AcompteFormView> createState() => _AcompteFormViewState();
}

class _AcompteFormViewState extends State<AcompteFormView> {
  final _formKey = GlobalKey<FormState>();
  late final double _montantSuggere;
  final _montantController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _montantSuggere = widget.montantTotal * 0.3;
    _montantController.text = _montantSuggere.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acompte')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Montant total: ${widget.montantTotal.toStringAsFixed(2)}€',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Acompte suggéré (30%): ${_montantSuggere.toStringAsFixed(2)}€',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _montantController,
                decoration: const InputDecoration(
                  labelText: 'Montant de l\'acompte (€)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un montant';
                  }
                  final montant = double.tryParse(value);
                  if (montant == null || montant <= 0) {
                    return 'Montant invalide';
                  }
                  if (montant > widget.montantTotal) {
                    return 'L\'acompte ne peut pas dépasser le montant total';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Spacer(),
              // Boutons d'action
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.terracotta.withOpacity(0.7),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _finaliserReservation(false),
                      child: const Text(
                        'En attente',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.terracotta,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _finaliserReservation(true),
                      child: const Text(
                        'Valider l\'acompte',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _finaliserReservation(bool avecAcompte) async {
    if (!avecAcompte || _formKey.currentState!.validate()) {
      try {
        if (avecAcompte) {
          await widget.database.into(widget.database.acomptes).insert(
                AcomptesCompanion.insert(
                  idReservation: widget.reservationId,
                  montant: double.parse(_montantController.text),
                  paye: 1,
                  datePaiement: DateTime.now(),
                ),
              );
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(avecAcompte
                  ? 'Acompte enregistré'
                  : 'Réservation en attente'),
            ),
          );
          // Retour au menu principal en vidant la pile de navigation
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _montantController.dispose();
    super.dispose();
  }
}
