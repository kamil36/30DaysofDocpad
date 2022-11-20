class CatalogModel {
  static final Items = [
    Item(
      id: "Docpad-1",
      name: "iPhone 12 Pro",
      desc: "Apple iPhone 12th Generation",
      price: 10500,
      color: "Red",
      image: "assets/images/iphone12pro.jpg",
    )
  ];
}

class Item {
  final String id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  Item(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.color,
      required this.image});
}
