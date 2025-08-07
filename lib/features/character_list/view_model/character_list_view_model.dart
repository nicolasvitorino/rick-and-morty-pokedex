import 'dart:async';

import 'package:flutter/material.dart';
import '../../../data/models/character.dart';
import '../../../data/repositories/character_repository.dart';

class CharacterListViewModel extends ChangeNotifier {
  final CharacterRepository repository;

  CharacterListViewModel(this.repository);

  final List<Character> _characters = [];
  List<Character> get characters =>
      _searchQuery.isEmpty ? _characters : _filteredCharacters;

  final List<Character> _filteredCharacters = [];

  int _currentPage = 1;
  int _totalPages = 42;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  bool get hasMore => _currentPage <= _totalPages;

  String _searchQuery = '';
  Timer? _debounce;

  Future<void> fetchCharacters() async {
    if (_isLoading || !hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newCharacters = await repository.fetchCharacters(_currentPage);
      _characters.addAll(newCharacters);
      _currentPage++;
    } catch (e) {
      _errorMessage = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchCharacters(String name) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await repository.searchCharactersByName(name);
      _characters
        ..clear()
        ..addAll(results);
    } catch (e) {
      _errorMessage = 'Erro: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        fetchCharacters();
      } else {
        searchCharacters(query);
      }
    });

    @override
    void dispose() {
      _debounce?.cancel();
      super.dispose();
    }
  }
}
