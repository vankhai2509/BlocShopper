import 'package:app1/cart/bloc/cart_bloc.dart';
import 'package:app1/catalog/bloc/catalog_bloc.dart';
import 'package:app1/cart/views/cart_page.dart';
import 'package:app1/catalog/views/catalog_page.dart';
import 'package:app1/shopping_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CatalogBloc(ShoppingRepository())..add(CatalogStarted()),
        ),
        BlocProvider(
          create: (context) =>
              CartBloc(shoppingRepository: ShoppingRepository())..add(CartStarted()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Catalog(),
          '/cart': (context) => CartPage(),
        },
      ),
    );
  }
}
