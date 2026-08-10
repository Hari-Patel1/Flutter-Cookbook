class RecipeCollection {
  final String id;
  final String name;
  final String? description;

  /// IDs of recipes belonging to this collection.
  final List<String> recipeIds;

  final DateTime createdAt;

  const RecipeCollection({
    required this.id,
    required this.name,
    this.description,
    this.recipeIds = const [],
    required this.createdAt,
  });

  RecipeCollection copyWith({
    String? name,
    String? description,
    List<String>? recipeIds,
  }) {
    return RecipeCollection(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      recipeIds: recipeIds ?? this.recipeIds,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'recipeIds': recipeIds,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RecipeCollection.fromJson(Map<String, dynamic> json) {
    return RecipeCollection(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      recipeIds: List<String>.from(json['recipeIds'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}