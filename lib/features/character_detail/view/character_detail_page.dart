import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rm_pokedex/features/character_detail/widgets/character_detail_widget.dart';
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

            return CharacterDetailWidget(character: character);
          },
        ),
      ),
    );
  }
}
