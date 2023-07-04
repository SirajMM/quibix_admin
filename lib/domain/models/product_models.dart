class Products {
  final String productName;
  final String subname;
  final String category;
  final String quantity;
  final String price;
  final String color;
  final String description;
  final List? imageList;
  final String? id;

  Products({
    required this.productName,
    required this.subname,
    required this.category,
    required this.quantity,
    required this.price,
    required this.color,
    required this.description,
    this.imageList,
    this.id,
  });
}
