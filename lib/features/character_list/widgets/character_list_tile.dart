import 'package:flutter/material.dart';

class CharacterListTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String species;
  final VoidCallback onTap;
  const CharacterListTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.species,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imageUrl),
      title: Text(name),
      subtitle: Text(species),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      subtitleTextStyle: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }
}
