import '../../core/services/api_service.dart';
import '../models/character.dart';

class CharacterRepository {
  final ApiService api;

  CharacterRepository(this.api);

  Future<List<Character>> fetchCharacters(int page) async {
    try {
      final data = await api.get('character/?page=$page');
      final results = data['results'] as List;
      return results.map((json) => Character.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load characters: $e');
    }
  }

  Future<Character> fetchCharacterById(int id) async {
    try {
      final data = await api.get('character/$id');
      return Character.fromJson(data);
    } catch (e) {
      throw Exception('Failed to load character: $e');
    }
  }

  Future<List<Character>> searchCharactersByName(String name) async {
    try {
      final data = await api.get('character/?name=$name');
      final results = data['results'] as List;
      return results.map((json) => Character.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to search characters: $e');
    }
  }
}
