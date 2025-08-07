import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/character_detail_view_model.dart';
import '../../../data/repositories/character_repository.dart';
import '../../../core/services/api_service.dart';

class CharacterDetailPage extends StatelessWidget {
  final int id;

  const CharacterDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CharacterDetailViewModel(CharacterRepository(ApiService()))
        ..fetchCharacter(id),
      child: Scaffold(
        appBar: AppBar(title: const Text('Details')),
        body: Consumer<CharacterDetailViewModel>(
          builder: (_, vm, __) {
            final character = vm.character;

            if (character == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  character.image,
                  height: 400,
                  width: 400,
                ),
                const SizedBox(height: 16),
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Status: ${character.status}',
                  style: TextStyle(
                    fontSize: 16,
                    color: character.status.toLowerCase() == 'alive'
                        ? Colors.lightGreen
                        : character.status.toLowerCase() == 'dead'
                            ? Colors.red
                            : Colors.black,
                  ),
                ),
                Text(
                  'Species: ${character.species}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Gender: ${character.gender}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Origin: ${character.origin['name'] ?? 'Unknown'}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
