class Currency{
  String code;
  double value;
  Currency(this.code, this.value);
}

class Country{
  String name;
  String code;
  String? flag;
  Currency? currency;
  Country({required this.name, required this.code, required this.currency});
}