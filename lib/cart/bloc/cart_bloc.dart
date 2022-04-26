
import 'package:app1/cart/models/cart.dart';
import 'package:app1/shopping_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app1/catalog/models/item.dart';


part 'cart_event.dart';
part 'cart_state.dart';
class CartBloc extends Bloc<CartEvent, CartState>{
  CartBloc({required this.shoppingRepository}): super(CartLoading());
  ShoppingRepository shoppingRepository;
  @override
  Stream<CartState> mapEventToState(CartEvent event) async*{
    if (event is CartStarted){
      yield* _mapCartStartedToState();
    }else if (event is CartItemAdded){
      yield* _mapCartItemAddedToState(event, state);
    }
  }
  Stream<CartState> _mapCartStartedToState() async*{
    yield CartLoading();
    try {
      final cart = await shoppingRepository.loadCart();
      yield CartLoaded(Cart(items: [...cart]));
    }catch (_) {
      yield CartError();
    }
  }
 Stream<CartState> _mapCartItemAddedToState(CartItemAdded event, CartState state) async*{
   if(state is CartLoaded){
     try{
       shoppingRepository.itemAddedToCart(event.item);
       yield CartLoaded(Cart(items: [...state.cart.items, event.item]));
     }catch(_){
       yield CartError();
     }
   }
 }
}