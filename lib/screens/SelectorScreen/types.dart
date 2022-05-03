import 'package:flutter/material.dart';

class SelectedItem {
  final String name;
  final double price;
  final double quantity;

  const SelectedItem(this.name, this.price, this.quantity);
}

class Person {
  final String id;
  final Color color;
  final String? name;

  List<SelectedItem> items;

  double cost;

  Person(
      {required this.id,
      required this.color,
      this.cost = 0,
      this.name,
      List<SelectedItem>? items})
      : items = items ?? [];
}
