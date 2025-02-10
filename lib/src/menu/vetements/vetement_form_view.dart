import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../database/database.dart';
import '../../theme/app_theme.dart';
import 'package:drift/drift.dart' hide Column;

class VetementFormView extends StatefulWidget {
  final AppDatabase database;

  const VetementFormView({super.key, required this.database});

  @override
  State<VetementFormView> createState() => _VetementFormViewState();
}

class _VetementFormViewState extends State<VetementFormView> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCategory;
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _couleursController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _longueurTotaleController =
      TextEditingController();
  final TextEditingController _tourTailleController = TextEditingController();
  final TextEditingController _tourPoitrineController = TextEditingController();
  final TextEditingController _commentaireController = TextEditingController();
  final TextEditingController _cautionController = TextEditingController();
  final TextEditingController _etatController = TextEditingController();
  List<String> photoUrls = [];
  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedPhotos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blancCasse,
      appBar: AppBar(
        title: const Text('Nouveau Vêtement'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Catégorie
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Catégorie *',
                  border: OutlineInputBorder(),
                ),
                items: ['robe', 'jupe', 'haut']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Veuillez choisir une catégorie' : null,
              ),
              const SizedBox(height: 16),

              // Nom
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Ce champ est requis' : null,
              ),
              const SizedBox(height: 16),

              // Couleurs
              TextFormField(
                controller: _couleursController,
                decoration: const InputDecoration(
                  labelText: 'Couleurs *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Ce champ est requis' : null,
              ),
              const SizedBox(height: 16),

              // Prix
              TextFormField(
                controller: _prixController,
                decoration: const InputDecoration(
                  labelText: 'Prix (€) *',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Ce champ est requis';
                  if (double.tryParse(value!) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Caution
              TextFormField(
                controller: _cautionController,
                decoration: const InputDecoration(
                  labelText: 'Caution (€) *',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Ce champ est requis';
                  if (double.tryParse(value!) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // État
              TextFormField(
                controller: _etatController,
                decoration: const InputDecoration(
                  labelText: 'État *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Ce champ est requis' : null,
              ),
              const SizedBox(height: 16),

              // Mesures conditionnelles selon la catégorie
              if (selectedCategory != 'haut') ...[
                TextFormField(
                  controller: _tourTailleController,
                  decoration: const InputDecoration(
                    labelText: 'Tour de taille (cm)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
              ],

              if (selectedCategory != 'jupe') ...[
                TextFormField(
                  controller: _tourPoitrineController,
                  decoration: const InputDecoration(
                    labelText: 'Tour de poitrine (cm)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
              ],

              TextFormField(
                controller: _longueurTotaleController,
                decoration: const InputDecoration(
                  labelText: 'Longueur totale (cm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Commentaire
              TextFormField(
                controller: _commentaireController,
                decoration: const InputDecoration(
                  labelText: 'Commentaire',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImages,
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text('Ajouter des photos'),
                  ),
                  if (selectedPhotos.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedPhotos.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Stack(
                              children: [
                                Image.file(
                                  File(selectedPhotos[index].path),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.remove_circle),
                                    color: Colors.red,
                                    onPressed: () => _removePhoto(index),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.terracotta,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _submitForm,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          selectedPhotos.addAll(images);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la sélection des photos: $e')),
        );
      }
    }
  }

  void _removePhoto(int index) {
    setState(() {
      selectedPhotos.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final vetement = VetementsCompanion.insert(
          nom: _nomController.text,
          category: selectedCategory!,
          couleurs: _couleursController.text,
          prix: double.parse(_prixController.text),
          // caution: double.parse(_cautionController.text),
          // etat: _etatController.text,
          tourTaille: Value(double.tryParse(_tourTailleController.text)),
          tourPoitrine:
              Value(double.tryParse(_tourPoitrineController.text) ?? 0),
          longueurTotale: double.tryParse(_longueurTotaleController.text) ?? 0,
          commentaire: Value(_commentaireController.text),
        );

        final vetementId = await widget.database
            .into(widget.database.vetements)
            .insert(vetement);

        for (final photo in selectedPhotos) {
          await widget.database.into(widget.database.photos).insert(
                PhotosCompanion.insert(
                  idVetement: vetementId,
                  url: photo.path,
                ),
              );
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Vêtement et photos ajoutés avec succès')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de l\'ajout: $e')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _couleursController.dispose();
    _prixController.dispose();
    _longueurTotaleController.dispose();
    _tourTailleController.dispose();
    _tourPoitrineController.dispose();
    _commentaireController.dispose();
    _cautionController.dispose();
    _etatController.dispose();
    super.dispose();
  }
}
