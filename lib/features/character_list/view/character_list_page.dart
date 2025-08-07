import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rm_pokedex/features/character_detail/view/character_detail_page.dart';
import 'package:rm_pokedex/features/character_list/widgets/character_list_tile.dart';
import '../view_model/character_list_view_model.dart';
import '../../../data/repositories/character_repository.dart';
import '../../../core/services/api_service.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CharacterListViewModel(CharacterRepository(ApiService()))
        ..fetchCharacters(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Rick and Morty Characters',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Consumer<CharacterListViewModel>(
          builder: (_, vm, __) {
            if (vm.characters.isEmpty && vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.hasError && vm.characters.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(vm.errorMessage ?? 'Erro desconhecido'),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scroll) {
                if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
                  vm.fetchCharacters();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: vm.characters.length + (vm.isLoading ? 1 : 0),
                itemBuilder: (_, i) {
                  if (i < vm.characters.length) {
                    final character = vm.characters[i];
                    return CharacterListTile(
                      imageUrl: character.image,
                      name: character.name,
                      species: character.species,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CharacterDetailPage(id: character.id),
                          ),
                        );
                      },
                    );
                  } else {
                    if (vm.isLoading) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ));
                    } else if (vm.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(vm.errorMessage ?? 'Erro desconhecido'),
                          ],
                        ),
                      );
                    } else if (!vm.hasMore) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Você chegou ao fim da lista.'),
                      ));
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
                  ;
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
