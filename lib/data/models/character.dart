class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final String gender;
  final Map<String, dynamic> origin;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.gender,
    required this.origin,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
      gender: json['gender'],
      origin: json['origin'],
    );
  }
}
