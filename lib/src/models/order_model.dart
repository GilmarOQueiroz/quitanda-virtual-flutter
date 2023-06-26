import 'cart_item_model.dart';

class OrderModel {
  String id;
  DateTime createdDataTime;
  DateTime overdueDataTime;
  List<CartItemModel> items;
  String status;
  String copyAndPaste;
  double total;

  OrderModel({
    required this.copyAndPaste,
    required this.createdDataTime,
    required this.id,
    required this.items,
    required this.overdueDataTime,
    required this.status,
    required this.total,
});
}