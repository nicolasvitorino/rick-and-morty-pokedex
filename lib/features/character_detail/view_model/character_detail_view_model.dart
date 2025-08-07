import 'package:flutter/material.dart';
import '../../../data/models/character.dart';
import '../../../data/repositories/character_repository.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  final CharacterRepository repository;
  Character? character;

  CharacterDetailViewModel(this.repository);

  Future<void> fetchCharacter(int id) async {
    character = await repository.fetchCharacterById(id);
    notifyListeners();
  }
}
