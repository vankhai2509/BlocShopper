import 'package:app1/catalog/models/item.dart';
class Catalog{
  Catalog(this.itemNames);
  List<String> itemNames;
  Item getById(int id) => Item(id, itemNames[id]);
  Item getByPosition(int position) => getById(position);
  
}