enum TypeAsset{
  cash(id: 0, name: 'Наличные'),
  card(id: 1, name: 'Карта');

  const TypeAsset({required this.id, required this.name});
  final int id;
  final String name;
}