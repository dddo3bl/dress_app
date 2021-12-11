class StoreCategory {
  int fabric_id;
  String fabric_name, color;
  num fabric_m_price, tax_amount;

  StoreCategory(this.fabric_id, this.fabric_name, this.color,
      this.fabric_m_price, this.tax_amount);

  factory StoreCategory.fromJson(Map<String, dynamic> map) {
    return StoreCategory(map['fabric_id'], map['fabric_name'], map['color'],
        map['price_per_m'], map['tax_amount']);
  }
}
