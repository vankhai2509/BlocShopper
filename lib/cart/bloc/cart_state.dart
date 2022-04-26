part of 'cart_bloc.dart';
abstract class CartState{}
enum Etc{
  CartEvent,
  CartState
}
class CartLoading extends CartState{}
class CartLoaded extends CartState{
  CartLoaded(this.cart);
  Cart cart;
}

class CartError extends CartState{}