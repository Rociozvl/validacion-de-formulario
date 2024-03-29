import 'dart:convert';

class Product {
    bool available;
    String name;
    String? picture;
    double price;
    String? id;

    Product({
        required this.available,
        required this.name,
        this.picture,
        required this.price,
        this.id
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
    };

    Product copy ()=> Product(
      available: available,
       name: name, 
       price: price,
       picture: picture,
       id: id
       );
}