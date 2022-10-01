import 'dart:convert';

class ItemModel {
  final String name;
  final double price;
  final String date;
  ItemModel({
    required this.name,
    required this.price,
    required this.date,
  });

  ItemModel copyWith({
    String? name,
    double? price,
    String? date,
  }) {
    return ItemModel(
      name: name ?? this.name,
      price: price ?? this.price,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'date': date,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() => 'Irem(name: $name, price: $price, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.name == name &&
        other.price == price &&
        other.date == date;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ date.hashCode;
}
