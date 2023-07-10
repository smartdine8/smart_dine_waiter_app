import 'dart:convert';

WaiterTable waiterTableFromJson(String str) =>
    WaiterTable.fromMap(json.decode(str));
String waiterTableToJson(WaiterTable data) => json.encode(data.toMap());

class WaiterTable {
  WaiterTable({
    this.isBillPaid,
    this.isOrderPlaced,
    this.isOccupied,
    this.tableCapacity,
    this.tableId,
    this.tableName,
  });

  bool? isBillPaid;
  bool? isOrderPlaced;
  bool? isOccupied;
  int? tableCapacity;
  String? tableId;
  String? tableName;

  factory WaiterTable.fromMap(Map<String, dynamic> json) => WaiterTable(
        isBillPaid: json['is_bill_paid'] ?? false,
        isOrderPlaced: json['is_order_placed'] ?? false,
        isOccupied: json['is_occupied'] ?? false,
        tableCapacity: json['total_capacity'] != null
            ? int.parse(json['total_capacity'])
            : 0,
        tableId: json['table_id'] ?? '',
        tableName: json['table_name'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'is_bill_paid': isBillPaid,
        'is_order_placed': isOrderPlaced,
        'is_occupied': isOccupied,
        'total_capacity': tableCapacity,
        'table_id': tableId,
        'table_name': tableName,
      };

  WaiterTable copyWith({
    bool? isBillPaid,
    bool? isOrderPlaced,
    bool? isOccupied,
    int? tableCapacity,
    String? tableId,
    String? tableName,
  }) =>
      WaiterTable(
        isBillPaid: isBillPaid ?? this.isBillPaid,
        isOrderPlaced: isOrderPlaced ?? this.isOrderPlaced,
        isOccupied: isOccupied ?? this.isOccupied,
        tableCapacity: tableCapacity ?? this.tableCapacity,
        tableId: tableId ?? this.tableId,
        tableName: tableName ?? this.tableName,
      );
}
