import 'package:app1/catalog/models/item.dart';
class Cart {
  Cart({required this.items});
  List<Item> items;
  int get totalPrice{
   return items.fold(0, (total, current) => total + current.price);
  }
}