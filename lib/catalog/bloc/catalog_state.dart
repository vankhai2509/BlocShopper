part of 'catalog_bloc.dart';

abstract class CatalogState{}
enum Etc{
  CatalogEvent,
  CatalogState
}
class CatalogLoading extends CatalogState{}

class CatalogLoaded extends CatalogState{
  CatalogLoaded(this.catalog);
  Catalog catalog;
}

class CatalogError extends CatalogState{} 