import 'package:app1/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: ColoredBox(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(32),
              child: CartList(),
            )),
            const Divider(
              height: 4,
              color: Colors.black,
            ),
            TotalPrice(),
          ],
        ),
      ),
    );
  }
}

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return CircularProgressIndicator();
              }
              if (state is CartLoaded) {
                return Text(
                  '\$${state.cart.totalPrice}',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 48),
                );
              }
              return const Text("Something went wrong");
            },
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Buying not Started yet!")));
              },
              child: Text("BUY"))
        ],
      ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is CartLoading) {
        return const CircularProgressIndicator();
      }
      if (state is CartLoaded) {
        return ListView.builder(
            itemCount: state.cart.items.length,
            itemBuilder: ((context, index) {
              return Material(
                child: ListTile(
                  leading: const Icon(Icons.done),
                  title: Text(
                    "${state.cart.items[index].name}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            }));
      }
      return const Text("something went wrong");
    });
  }
}
