import 'package:flutter/material.dart';

class CharacterDetailWidget extends StatelessWidget {
  final dynamic character;

  const CharacterDetailWidget({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth >= 600;

        Widget characterImage = Image.network(
          character.image,
          height: isWideScreen
              ? MediaQuery.of(context).size.height * 0.6
              : MediaQuery.of(context).size.height * 0.4,
          width: isWideScreen
              ? MediaQuery.of(context).size.height * 0.6
              : MediaQuery.of(context).size.height * 0.4,
          fit: BoxFit.cover,
        );

        Widget detailsColumn = Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: isWideScreen
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
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
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Gender: ${character.gender}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Origin: ${character.origin['name'] ?? 'Unknown'}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: isWideScreen
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    characterImage,
                    detailsColumn,
                    Spacer(),
                  ],
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      characterImage,
                      const SizedBox(height: 16),
                      detailsColumn,
                    ],
                  ),
                ),
        );
      },
    );
  }
}
