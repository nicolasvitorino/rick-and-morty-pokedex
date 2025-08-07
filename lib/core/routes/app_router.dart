import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rm_pokedex/features/character_list/view/character_list_page.dart';
import 'package:rm_pokedex/features/character_detail/view/character_detail_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'character_list',
      builder: (context, state) => const CharacterListPage(),
    ),
    GoRoute(
      path: '/character/:id',
      name: 'character_detail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CharacterDetailPage(id: id);
      },
    ),
  ],
);
