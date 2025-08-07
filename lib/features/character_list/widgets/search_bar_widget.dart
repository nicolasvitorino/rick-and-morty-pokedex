import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rm_pokedex/features/character_list/view_model/character_list_view_model.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterListViewModel>(
      builder: (context, vm, _) {
        return TextField(
          onChanged: vm.onSearchChanged,
          autofocus: false,
          decoration: const InputDecoration(
            hintText: 'Search character...',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            hintStyle: TextStyle(color: Colors.black),
          ),
          style: const TextStyle(color: Colors.black),
        );
      },
    );
  }
}
