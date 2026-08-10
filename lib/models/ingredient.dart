class Ingredient {
  final String name;
  final double? quantity;
  final String? unit;
  final String? notes;

  const Ingredient({
    required this.name,
    this.quantity,
    this.unit,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'notes': notes,
    };
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? '',
      quantity: json['quantity'] != null
          ? (json['quantity'] as num).toDouble()
          : null,
      unit: json['unit'],
      notes: json['notes'],
    );
  }
}