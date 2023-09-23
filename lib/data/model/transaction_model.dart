class Transaction {
  final List<Transactions> transactions;

  Transaction({
    required this.transactions,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactions: List<Transactions>.from(
            json["transactions"].map((x) => Transactions.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transactions {
  final String id;
  final String name;
  final DateTime date;
  final String priceIdr;
  final String image;

  Transactions({
    required this.id,
    required this.name,
    required this.date,
    required this.priceIdr,
    required this.image,
  });

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        id: json["id"],
        name: json["name"],
        date: DateTime.parse(json["date"]),
        priceIdr: json["price_idr"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "price_idr": priceIdr,
        "image": image,
      };
}
