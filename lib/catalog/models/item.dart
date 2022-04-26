import 'package:flutter/material.dart';

class Item{
  Item(this.id, this.name) : color = Colors.primaries[id];
  
  final int id;
  final String name;
  final Color color;
  final int price = 42;
}