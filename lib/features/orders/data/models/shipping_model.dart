class ShippingAddressModel {
  final String? name;
  final String? address;
  final String? city;
  final String? email;
  final String? phone;
  final String? addressDescription;

  ShippingAddressModel({
    required this.name,
    required this.address,
    required this.city,
    required this.email,
    required this.phone,
    required this.addressDescription,
  });

  toJson() => {
    "name": name,
    "address": address,
    "city": city,
    "email": email,
    "phone": phone,
    "addressDescription": addressDescription,
  };

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      ShippingAddressModel(
        name: json["name"],
        address: json["address"],
        city: json["city"],
        email: json["email"],
        phone: json["phone"],
        addressDescription: json["addressDescription"],
      );
}
