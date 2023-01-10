class Player {
  int? id;
  final String name;
  final String shortname;

  Player({this.id, required this.name, required this.shortname});

  //forsqlite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shortname': shortname,
    };
  }

  //for debugging
  @override
  String toString() {
    return 'Player(id: $id, name: $name, shortname: $shortname';
  }
}
