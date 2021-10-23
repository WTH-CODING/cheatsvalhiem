class Spawnable {
  Spawnable({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.type,
    required this.criticalItem,
  });

  int id;
  String itemName;
  int quantity;
  String type;
  bool criticalItem;

  factory Spawnable.fromJson(Map<dynamic, dynamic> json) => Spawnable(
        id: json["id"],
        itemName: json["item"],
        quantity: json["quantity"],
        type: json["type"],
        criticalItem: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item": itemName,
        "quantity": quantity,
        "type": type,
        "flag": criticalItem,
      };
}
