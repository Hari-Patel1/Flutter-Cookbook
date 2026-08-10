import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/recipe.dart';
import '../models/recipe_collection.dart';

class RecipeStorageService {
  static const String _fileName = 'cookbook.json';

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File(
      '${directory.path}/$_fileName',
    );
  }

  Future<Map<String, dynamic>> _loadData() async {
    final file = await _getFile();

    if (!await file.exists()) {
      return {
        'recipes': [],
        'collections': [],
      };
    }

    final contents = await file.readAsString();

    if (contents.trim().isEmpty) {
      return {
        'recipes': [],
        'collections': [],
      };
    }

    return jsonDecode(contents);
  }

  Future<void> _saveData(
      Map<String, dynamic> data,
      ) async {
    final file = await _getFile();

    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
    );
  }

  // --------------------------------------------------
  // RECIPES
  // --------------------------------------------------

  Future<List<Recipe>> getRecipes() async {
    final data = await _loadData();

    final recipes = data['recipes'] as List? ?? [];

    return recipes
        .map(
          (recipe) => Recipe.fromJson(
        Map<String, dynamic>.from(recipe),
      ),
    )
        .toList();
  }

  Future<void> saveRecipe(Recipe recipe) async {
    final data = await _loadData();

    final recipes = List<Map<String, dynamic>>.from(
      (data['recipes'] as List? ?? []).map(
            (recipe) => Map<String, dynamic>.from(recipe),
      ),
    );

    final index = recipes.indexWhere(
          (item) => item['id'] == recipe.id,
    );

    if (index >= 0) {
      recipes[index] = recipe.toJson();
    } else {
      recipes.add(recipe.toJson());
    }

    data['recipes'] = recipes;

    await _saveData(data);
  }

  Future<void> deleteRecipe(String id) async {
    final data = await _loadData();

    final recipes = List<Map<String, dynamic>>.from(
      (data['recipes'] as List? ?? []).map(
            (recipe) => Map<String, dynamic>.from(recipe),
      ),
    );

    recipes.removeWhere(
          (recipe) => recipe['id'] == id,
    );

    data['recipes'] = recipes;

    await _saveData(data);
  }

  // --------------------------------------------------
  // COLLECTIONS
  // --------------------------------------------------

  Future<List<RecipeCollection>> getCollections() async {
    final data = await _loadData();

    final collections =
        data['collections'] as List? ?? [];

    return collections
        .map(
          (collection) => RecipeCollection.fromJson(
        Map<String, dynamic>.from(collection),
      ),
    )
        .toList();
  }

  Future<void> saveCollection(
      RecipeCollection collection,
      ) async {
    final data = await _loadData();

    final collections = List<Map<String, dynamic>>.from(
      (data['collections'] as List? ?? []).map(
            (collection) => Map<String, dynamic>.from(collection),
      ),
    );

    final index = collections.indexWhere(
          (item) => item['id'] == collection.id,
    );

    if (index >= 0) {
      collections[index] = collection.toJson();
    } else {
      collections.add(collection.toJson());
    }

    data['collections'] = collections;

    await _saveData(data);
  }

  Future<void> deleteCollection(String id) async {
    final data = await _loadData();

    final collections = List<Map<String, dynamic>>.from(
      (data['collections'] as List? ?? []).map(
            (collection) => Map<String, dynamic>.from(collection),
      ),
    );

    collections.removeWhere(
          (collection) => collection['id'] == id,
    );

    data['collections'] = collections;

    await _saveData(data);
  }
}