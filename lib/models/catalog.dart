class CatalogModel {
  // Static list to hold catalog items
  static List<Item> items = [];

  // Get an item by ID, returns null if not found
  Item? getById(int id) {
    try {
      return items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null; // Return null if not found
    }
  }

  // Get an item by position, throws exception if position is invalid
  Item getByPosition(int pos) {
    if (pos < 0 || pos >= items.length) {
      throw IndexError(pos, items); // Throws error if position is out of bounds
    }
    return items[pos];
  }
}

// Model for individual catalog items
class Item {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  // Convert Item to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "image": image,
      };

  // Create Item from JSON
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toDouble(),
        image: json["image"],
      );
}
