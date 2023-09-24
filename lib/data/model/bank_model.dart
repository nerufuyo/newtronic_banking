class Bank {
  final List<Banks> banks;

  Bank({
    required this.banks,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        banks: List<Banks>.from(json["banks"].map((x) => Banks.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
      };
}

class Banks {
  final int id;
  final String name;
  final String number;
  final String image;

  Banks({
    required this.id,
    required this.name,
    required this.number,
    required this.image,
  });

  factory Banks.fromJson(Map<String, dynamic> json) => Banks(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number": number,
        "image": image,
      };
}
