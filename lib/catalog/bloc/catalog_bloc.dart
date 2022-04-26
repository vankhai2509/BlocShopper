import 'package:app1/catalog/models/catalog.dart';
import 'package:app1/shopping_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc(this.shoppingRepository) : super(CatalogLoading());

  ShoppingRepository shoppingRepository;

  Stream<CatalogState> mapEventToState(CatalogEvent event) async*{
    if (event is CatalogStarted) {
      yield* _mapCatalogStartedToState();
    } 
  }
  Stream<CatalogState> _mapCatalogStartedToState() async*{
    yield CatalogLoading();
    try{
      final catalog = await shoppingRepository.loadCatalog();
      yield CatalogLoaded(Catalog(catalog));
    }
    catch (_){
      yield CatalogError();
    }
  }
} 