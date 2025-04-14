import 'package:cassiopee_couture_app/src/menu/gestion/gestion_tasks_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl, canLaunchUrl;
import '../../database/database.dart';
import '../theme/app_theme.dart';
import 'package:drift/drift.dart' show Value;

class AcompteValidationView extends StatelessWidget {
  final AppDatabase database;
  final AcompteWithClientAndVetement acompte;

  const AcompteValidationView({
    super.key,
    required this.database,
    required this.acompte,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validation Acompte')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Informations de l'acompte
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Client: ${acompte.client.prenom} ${acompte.client.nom}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Vêtement: ${acompte.vetement.nom}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Montant: ${acompte.montant.toStringAsFixed(2)}€',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Bouton de validation
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.terracotta,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _validerAcompte(context),
              child: const Text(
                'Valider le paiement',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Bouton de relance
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.terracotta,
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: AppTheme.terracotta),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _envoyerRelance(context),
              child: const Text(
                'Envoyer une relance par email',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validerAcompte(BuildContext context) async {
    try {
      await (database.update(database.acomptes)
            ..where((a) => a.id.equals(acompte.id)))
          .write(AcomptesCompanion(
        paye: const Value(1),
        datePaiement: Value(DateTime.now()),
      ));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Acompte validé avec succès')),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  Future<void> _envoyerRelance(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: acompte.client.mail,
      query: 'subject=Relance acompte - Location vêtement'
          '&body=Bonjour ${acompte.client.prenom},\n\n'
          'Nous vous rappelons qu\'un acompte de ${acompte.montant}€ '
          'est en attente de paiement pour la location du vêtement '
          '"${acompte.vetement.nom}".\n\n'
          'Cordialement,\nCassiopée Couture',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Impossible d\'ouvrir le client mail')),
        );
      }
    }
  }
}
