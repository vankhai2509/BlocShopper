part of 'cart_bloc.dart';

abstract class CartEvent{}

class CartStarted extends CartEvent{}
class CartItemAdded extends CartEvent{
  CartItemAdded({required this.item});
  Item item;
}