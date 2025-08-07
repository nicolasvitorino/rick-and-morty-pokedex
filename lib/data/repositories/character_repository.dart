import '../../core/services/api_service.dart';
import '../models/character.dart';

class CharacterRepository {
  final ApiService api;

  CharacterRepository(this.api);

  Future<List<Character>> fetchCharacters(int page) async {
    final data = await api.get('character/?page=$page');
    final results = data['results'] as List;
    return results.map((json) => Character.fromJson(json)).toList();
  }

  Future<Character> fetchCharacterById(int id) async {
    final data = await api.get('character/$id');
    return Character.fromJson(data);
  }
}
