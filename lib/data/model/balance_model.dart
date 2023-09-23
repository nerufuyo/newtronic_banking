class Balance {
  final List<Balances> balances;

  Balance({
    required this.balances,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        balances:
            List<Balances>.from(json["data"].map((x) => Balances.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(balances.map((x) => x.toJson())),
      };
}

class Balances {
  final String cardName;
  final String cardNumber;
  final String balance;
  final String expiryDate;
  final String id;

  Balances({
    required this.cardName,
    required this.cardNumber,
    required this.balance,
    required this.expiryDate,
    required this.id,
  });

  factory Balances.fromJson(Map<String, dynamic> json) => Balances(
        cardName: json["card_name"],
        cardNumber: json["card_number"],
        balance: json["balance"],
        expiryDate: json["expiry_Date"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "card_name": cardName,
        "card_number": cardNumber,
        "balance": balance,
        "expiry_Date": expiryDate,
        "id": id,
      };
}
