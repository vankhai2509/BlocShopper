import 'catalog/models/item.dart';

const _delay = Duration(microseconds: 800);
const _catalog = [
  'Code Smell',
  'Control Flow',
  'Interpreter',
  'Recursion',
  'Sprint',
  'Heisenbug',
  'Spaghetti',
  'Hydra Code',
  'Off-By-One',
  'Scope',
  'CallBack',
  'Closure',
  'Automata',
  'Bit Shift',
  'Currying',
];

class ShoppingRepository{
  final _item  = <Item>[];
  Future<List<String>> loadCatalog() => Future.delayed(_delay, () => _catalog);
  Future<List<Item>> loadCart() => Future.delayed(_delay, () => _item);

  void itemAddedToCart(Item item) => _item.add(item);
}