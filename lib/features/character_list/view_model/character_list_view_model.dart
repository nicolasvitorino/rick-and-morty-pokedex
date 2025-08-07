import 'package:flutter/material.dart';
import '../../../data/models/character.dart';
import '../../../data/repositories/character_repository.dart';

class CharacterListViewModel extends ChangeNotifier {
  final CharacterRepository repository;

  CharacterListViewModel(this.repository);

  final List<Character> _characters = [];
  List<Character> get characters => _characters;

  int _currentPage = 1;
  final int _totalPages = 42;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchCharacters() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      if (_currentPage > _totalPages) return;

      final newCharacters = await repository.fetchCharacters(_currentPage);
      _characters.addAll(newCharacters);
      _currentPage++;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
