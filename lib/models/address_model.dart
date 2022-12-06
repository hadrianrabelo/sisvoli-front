class AddressModel {
  String? zipCode;
  String? number;
  String? street;
  String? district;
  String? complement;
  int? cityId;

  AddressModel(
      {this.zipCode,
        this.number,
        this.street,
        this.district,
        this.complement,
        this.cityId});

  AddressModel.fromJson(Map<String, dynamic> json) {
    zipCode = json['zipCode'];
    number = json['number'];
    street = json['street'];
    district = json['district'];
    complement = json['complement'];
    cityId = json['cityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zipCode'] = zipCode;
    data['number'] = number;
    data['street'] = street;
    data['district'] = district;
    data['complement'] = complement;
    data['cityId'] = cityId;
    return data;
  }
}