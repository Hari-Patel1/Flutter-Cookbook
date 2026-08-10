import 'dart:io';

import 'package:cookbookv2/models/ingredient.dart';
import 'package:cookbookv2/models/instruction_step.dart';
import 'package:cookbookv2/models/recipe.dart';
import 'package:cookbookv2/services/recipe_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ManualRecipeEditorPage extends StatefulWidget {
  final Recipe? recipe;

  const ManualRecipeEditorPage({
    super.key,
    this.recipe,
  });

  @override
  State<ManualRecipeEditorPage> createState() =>
      _ManualRecipeEditorPageState();
}

class _ManualRecipeEditorPageState
    extends State<ManualRecipeEditorPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _servingsController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _cookTimeController = TextEditingController();

  final RecipeStorageService _storage =
  RecipeStorageService();

  final List<_IngredientEntry> _ingredients = [];
  final List<_InstructionEntry> _instructions = [];

  File? _image;

  bool _saving = false;

  bool get _editing => widget.recipe != null;

  @override
  void initState() {
    super.initState();

    final recipe = widget.recipe;

    if (recipe != null) {
      _titleController.text = recipe.title;
      _descriptionController.text = recipe.description;

      if (recipe.servings != null) {
        _servingsController.text =
            recipe.servings.toString();
      }

      if (recipe.prepTimeMinutes != null) {
        _prepTimeController.text =
            recipe.prepTimeMinutes.toString();
      }

      if (recipe.cookTimeMinutes != null) {
        _cookTimeController.text =
            recipe.cookTimeMinutes.toString();
      }

      if (recipe.imagePath != null) {
        final file = File(recipe.imagePath!);

        if (file.existsSync()) {
          _image = file;
        }
      }

      for (final ingredient in recipe.ingredients) {
        _ingredients.add(
          _IngredientEntry(
            name: ingredient.name,
            quantity: ingredient.quantity,
            unit: ingredient.unit,
            notes: ingredient.notes,
          ),
        );
      }

      for (final instruction in recipe.instructions) {
        _instructions.add(
          _InstructionEntry(
            text: instruction.text,
            timerSeconds: instruction.timerSeconds,
          ),
        );
      }
    }

    if (_ingredients.isEmpty) {
      _addIngredient();
    }

    if (_instructions.isEmpty) {
      _addInstruction();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _servingsController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();

    for (final ingredient in _ingredients) {
      ingredient.dispose();
    }

    for (final instruction in _instructions) {
      instruction.dispose();
    }

    super.dispose();
  }

  // --------------------------------------------------
  // INGREDIENTS
  // --------------------------------------------------

  void _addIngredient() {
    setState(() {
      _ingredients.add(
        _IngredientEntry(),
      );
    });
  }

  void _removeIngredient(int index) {
    if (_ingredients.length == 1) return;

    setState(() {
      final ingredient = _ingredients.removeAt(index);
      ingredient.dispose();
    });
  }

  // --------------------------------------------------
  // INSTRUCTIONS
  // --------------------------------------------------

  void _addInstruction() {
    setState(() {
      _instructions.add(
        _InstructionEntry(),
      );
    });
  }

  void _removeInstruction(int index) {
    if (_instructions.length == 1) return;

    setState(() {
      final instruction =
      _instructions.removeAt(index);

      instruction.dispose();
    });
  }

  // --------------------------------------------------
  // IMAGE
  // --------------------------------------------------

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (picked == null) return;

    setState(() {
      _image = File(picked.path);
    });
  }

  // --------------------------------------------------
  // SAVE
  // --------------------------------------------------

  Future<void> _saveRecipe() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_ingredients.isEmpty) {
      _showMessage(
        'Add at least one ingredient.',
      );

      return;
    }

    if (_instructions.isEmpty) {
      _showMessage(
        'Add at least one instruction.',
      );

      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      final now = DateTime.now();

      final recipe = Recipe(
        id: widget.recipe?.id ??
            now.microsecondsSinceEpoch.toString(),

        title: _titleController.text.trim(),

        description:
        _descriptionController.text.trim(),

        imagePath: _image?.path,

        ingredients: _ingredients
            .where(
              (entry) =>
          entry.name.text.trim().isNotEmpty,
        )
            .map(
              (entry) => Ingredient(
            name: entry.name.text.trim(),

            quantity:
            _parseQuantity(
              entry.quantity.text,
            ),

            unit: entry.unit.text.trim().isEmpty
                ? null
                : entry.unit.text.trim(),

            notes: entry.notes.text.trim().isEmpty
                ? null
                : entry.notes.text.trim(),
          ),
        )
            .toList(),

        instructions: List.generate(
          _instructions.length,
              (index) {
            final instruction =
            _instructions[index];

            return InstructionStep(
              step: index + 1,

              text:
              instruction.text.text.trim(),

              timerSeconds:
              instruction.timerSeconds,
            );
          },
        ),

        servings: _parseInt(
          _servingsController.text,
        ),

        prepTimeMinutes: _parseInt(
          _prepTimeController.text,
        ),

        cookTimeMinutes: _parseInt(
          _cookTimeController.text,
        ),

        sourceType: 'manual',

        createdAt:
        widget.recipe?.createdAt ?? now,

        updatedAt: now,
      );

      await _storage.saveRecipe(recipe);

      if (!mounted) return;

      Navigator.of(context).pop(recipe);
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'Could not save recipe: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  double? _parseQuantity(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) return null;

    return double.tryParse(trimmed);
  }

  int? _parseInt(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) return null;

    return int.tryParse(trimmed);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // --------------------------------------------------
  // UI
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editing
              ? 'Edit Recipe'
              : 'Create Recipe',
        ),
        actions: [
          IconButton(
            tooltip: 'Save recipe',
            onPressed:
            _saving ? null : _saveRecipe,
            icon: const Icon(Icons.check),
          ),
        ],
      ),

      body: Form(
        key: _formKey,

        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [
            _buildBasicInformation(),

            const SizedBox(height: 30),

            _buildTimingInformation(),

            const SizedBox(height: 30),

            _buildIngredients(),

            const SizedBox(height: 30),

            _buildInstructions(),

            const SizedBox(height: 40),

            FilledButton.icon(
              onPressed:
              _saving ? null : _saveRecipe,

              icon: _saving
                  ? const SizedBox(
                width: 18,
                height: 18,
                child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
                  : const Icon(Icons.save),

              label: Text(
                _saving
                    ? 'Saving...'
                    : 'Save Recipe',
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // BASIC INFORMATION
  // --------------------------------------------------

  Widget _buildBasicInformation() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Text(
          'Recipe details',
          style: Theme.of(context)
              .textTheme
              .headlineSmall,
        ),

        const SizedBox(height: 16),

        GestureDetector(
          onTap: _pickImage,

          child: Container(
            height: 180,
            width: double.infinity,

            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(20),

              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
            ),

            clipBehavior: Clip.antiAlias,

            child: _image != null
                ? Image.file(
              _image!,
              fit: BoxFit.cover,
            )
                : Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [
                Icon(
                  Icons.add_a_photo_outlined,
                  size: 40,
                  color: Theme.of(context)
                      .colorScheme
                      .primary,
                ),

                const SizedBox(height: 10),

                const Text(
                  'Add recipe photo',
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        TextFormField(
          controller: _titleController,

          decoration:
          const InputDecoration(
            labelText: 'Recipe title',
            hintText: 'e.g. Chicken Tikka Masala',
            border: OutlineInputBorder(),
          ),

          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Enter a recipe title';
            }

            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller:
          _descriptionController,

          maxLines: 3,

          decoration:
          const InputDecoration(
            labelText: 'Description',
            hintText:
            'A short description of the recipe',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------
  // TIMING
  // --------------------------------------------------

  Widget _buildTimingInformation() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Text(
          'Recipe information',
          style: Theme.of(context)
              .textTheme
              .titleLarge,
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller:
                _servingsController,

                keyboardType:
                TextInputType.number,

                decoration:
                const InputDecoration(
                  labelText: 'Servings',
                  prefixIcon:
                  Icon(Icons.people_outline),
                  border:
                  OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: TextFormField(
                controller:
                _prepTimeController,

                keyboardType:
                TextInputType.number,

                decoration:
                const InputDecoration(
                  labelText: 'Prep (min)',
                  prefixIcon:
                  Icon(Icons.schedule),
                  border:
                  OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: TextFormField(
                controller:
                _cookTimeController,

                keyboardType:
                TextInputType.number,

                decoration:
                const InputDecoration(
                  labelText: 'Cook (min)',
                  prefixIcon:
                  Icon(Icons.timer_outlined),
                  border:
                  OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --------------------------------------------------
  // INGREDIENTS
  // --------------------------------------------------

  Widget _buildIngredients() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Ingredients',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge,
              ),
            ),

            IconButton(
              onPressed: _addIngredient,
              icon: const Icon(Icons.add),
            ),
          ],
        ),

        const SizedBox(height: 10),

        ...List.generate(
          _ingredients.length,
              (index) {
            final ingredient =
            _ingredients[index];

            return Padding(
              padding:
              const EdgeInsets.only(
                bottom: 12,
              ),

              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller:
                      ingredient.quantity,

                      keyboardType:
                      const TextInputType
                          .numberWithOptions(
                        decimal: true,
                      ),

                      decoration:
                      const InputDecoration(
                        labelText: 'Qty',
                        border:
                        OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller:
                      ingredient.unit,

                      decoration:
                      const InputDecoration(
                        labelText: 'Unit',
                        border:
                        OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller:
                      ingredient.name,

                      decoration:
                      const InputDecoration(
                        labelText: 'Ingredient',
                        border:
                        OutlineInputBorder(),
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed:
                    _ingredients.length == 1
                        ? null
                        : () =>
                        _removeIngredient(
                          index,
                        ),
                    icon: const Icon(
                      Icons.remove_circle_outline,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // --------------------------------------------------
  // INSTRUCTIONS
  // --------------------------------------------------

  Widget _buildInstructions() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Instructions',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge,
              ),
            ),

            IconButton(
              onPressed: _addInstruction,
              icon: const Icon(Icons.add),
            ),
          ],
        ),

        const SizedBox(height: 10),

        ...List.generate(
          _instructions.length,
              (index) {
            final instruction =
            _instructions[index];

            return Card(
              margin:
              const EdgeInsets.only(
                bottom: 12,
              ),

              child: Padding(
                padding:
                const EdgeInsets.all(12),

                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    CircleAvatar(
                      radius: 16,

                      child: Text(
                        '${index + 1}',
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            controller:
                            instruction.text,

                            maxLines: 4,

                            decoration:
                            const InputDecoration(
                              labelText:
                              'Instruction',
                              hintText:
                              'Describe what to do...',
                              border:
                              OutlineInputBorder(),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(
                                child:
                                OutlinedButton.icon(
                                  onPressed:
                                      () =>
                                      _setTimer(
                                        index,
                                      ),

                                  icon: const Icon(
                                    Icons.timer_outlined,
                                  ),

                                  label: Text(
                                    instruction
                                        .timerSeconds !=
                                        null
                                        ? _formatTimer(
                                      instruction
                                          .timerSeconds!,
                                    )
                                        : 'Add timer',
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 8,
                              ),

                              IconButton(
                                onPressed:
                                _instructions
                                    .length ==
                                    1
                                    ? null
                                    : () =>
                                    _removeInstruction(
                                      index,
                                    ),
                                icon: const Icon(
                                  Icons
                                      .remove_circle_outline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // --------------------------------------------------
  // TIMER
  // --------------------------------------------------

  Future<void> _setTimer(
      int index,
      ) async {
    final instruction =
    _instructions[index];

    final controller =
    TextEditingController(
      text: instruction.timerSeconds != null
          ? (instruction.timerSeconds! ~/ 60)
          .toString()
          : '',
    );

    final minutes =
    await showDialog<int>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Instruction timer',
          ),

          content: TextField(
            controller: controller,

            keyboardType:
            TextInputType.number,

            autofocus: true,

            decoration:
            const InputDecoration(
              labelText:
              'Minutes',
              suffixText: 'min',
            ),
          ),

          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),

              child: const Text('Cancel'),
            ),

            FilledButton(
              onPressed: () {
                final value =
                int.tryParse(
                  controller.text,
                );

                Navigator.pop(
                  context,
                  value,
                );
              },

              child: const Text('Set'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (!mounted) return;

    setState(() {
      instruction.timerSeconds =
      minutes == null
          ? null
          : minutes * 60;
    });
  }

  String _formatTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final remaining = seconds % 60;

    if (remaining == 0) {
      return '$minutes min timer';
    }

    return '${minutes}m ${remaining}s timer';
  }
}

// ==================================================
// TEMPORARY EDITOR STATE OBJECTS
// ==================================================

class _IngredientEntry {
  final TextEditingController name;
  final TextEditingController quantity;
  final TextEditingController unit;
  final TextEditingController notes;

  _IngredientEntry({
    String? name,
    double? quantity,
    String? unit,
    String? notes,
  })  : name = TextEditingController(text: name ?? ''),
        quantity = TextEditingController(
          text: quantity?.toString() ?? '',
        ),
        unit = TextEditingController(
          text: unit ?? '',
        ),
        notes = TextEditingController(
          text: notes ?? '',
        );

  void dispose() {
    name.dispose();
    quantity.dispose();
    unit.dispose();
    notes.dispose();
  }
}

class _InstructionEntry {
  final TextEditingController text;

  int? timerSeconds;

  _InstructionEntry({
    String? text,
    this.timerSeconds,
  }) : text = TextEditingController(
    text: text ?? '',
  );

  void dispose() {
    text.dispose();
  }
}