import 'ingredient.dart';
import 'instruction_step.dart';

class Recipe {
  final String id;

  final String title;
  final String description;

  final String? imagePath;

  final List<Ingredient> ingredients;
  final List<InstructionStep> instructions;

  final int? servings;
  final int? prepTimeMinutes;
  final int? cookTimeMinutes;

  final List<String> tags;

  /// Where the recipe originally came from.
  ///
  /// Examples:
  /// "manual"
  /// "image"
  /// "url"
  final String sourceType;

  final String? sourceUrl;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Recipe({
    required this.id,
    required this.title,
    this.description = '',
    this.imagePath,
    this.ingredients = const [],
    this.instructions = const [],
    this.servings,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.tags = const [],
    this.sourceType = 'manual',
    this.sourceUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Recipe copyWith({
    String? title,
    String? description,
    String? imagePath,
    List<Ingredient>? ingredients,
    List<InstructionStep>? instructions,
    int? servings,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    List<String>? tags,
    String? sourceType,
    String? sourceUrl,
    DateTime? updatedAt,
  }) {
    return Recipe(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      servings: servings ?? this.servings,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      tags: tags ?? this.tags,
      sourceType: sourceType ?? this.sourceType,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'ingredients':
      ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'instructions':
      instructions.map((instruction) => instruction.toJson()).toList(),
      'servings': servings,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'tags': tags,
      'sourceType': sourceType,
      'sourceUrl': sourceUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imagePath: json['imagePath'],
      ingredients: (json['ingredients'] as List? ?? [])
          .map(
            (item) => Ingredient.fromJson(
          Map<String, dynamic>.from(item),
        ),
      )
          .toList(),
      instructions: (json['instructions'] as List? ?? [])
          .map(
            (item) => InstructionStep.fromJson(
          Map<String, dynamic>.from(item),
        ),
      )
          .toList(),
      servings: json['servings'],
      prepTimeMinutes: json['prepTimeMinutes'],
      cookTimeMinutes: json['cookTimeMinutes'],
      tags: List<String>.from(json['tags'] ?? []),
      sourceType: json['sourceType'] ?? 'manual',
      sourceUrl: json['sourceUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}