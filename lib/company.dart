class Company {
  String id = "";
  String name = "";
  String? industry;
  String? employees;
  String? address1;
  String? address2;
  String? city;
  String? zip;
  Company(this.id, this.name);
  Company.fromJson(json) {

    id = getStringOrDefault(json['id']);
    name = getStringOrDefault(json['name']);
    industry = getStringOrDefault(json['industry']);
    employees = getStringOrDefault(json['employees']);
    address1 = getStringOrDefault(json['address1']);
    address2 = getStringOrDefault(json['address2']);
    city = getStringOrDefault(json['city']);
    zip = getStringOrDefault(json['zip']);

  }

  ///
  /// Flyweight factory, returns a list of companies with id, name
  ///
  static Future<List<Company>> fromJsonList(List<dynamic> list) async {
    var result = <Company>[];

    for (var el in list) {
      {result.add(Company(getStringOrDefault(el.id), getStringOrDefault(el.name)));};
    }
    return result;
  }

  static int getIntOrDefault(dynamic value) {
    return value is int ? value : 0;
  }

  static String getStringOrDefault(dynamic value) {
    return value is String ? value : '';
  }



  @override
  String toString() {
    return "id: $id, name: $name, industry: $industry, employees: $employees";
  }
}