import 'package:app1/cart/bloc/cart_bloc.dart';
import 'package:app1/catalog/bloc/catalog_bloc.dart';
import 'package:app1/catalog/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Catalog extends StatelessWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CatalogAppBar(),
          BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is CatalogLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return CatalogListItem(
                          state.catalog.getByPosition(index));
                    },
                    childCount: state.catalog.itemNames.length,
                  ),
                );
              }
              return const SliverFillRemaining(
                child: Center(
                  child: Text("Something went wrong"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CatalogListItem extends StatelessWidget {
  const CatalogListItem(this.item);

  final Item item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ColoredBox(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
                child: Text(
              "${item.name}",
              style: Theme.of(context).textTheme.headline6,
            )),
            const SizedBox(width: 24),
            AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,required this.item
  }) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          final isInCart = state.cart.items.contains(item);
          return TextButton(
            style: TextButton.styleFrom(onSurface: Theme.of(context).primaryColor),
            onPressed:isInCart ? null : () => context.read<CartBloc>().add(CartItemAdded(item:item)),
            child: isInCart ? Icon(Icons.check, semanticLabel: "ADDED") : const Text("ADD"),
          );
        }
        return const Text("Something went wrong!");
      },
    );
  }
}

class CatalogAppBar extends StatelessWidget {
  const CatalogAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: const Text("Catalog"),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: Icon(Icons.shopping_cart))
      ],
    );
  }
}
