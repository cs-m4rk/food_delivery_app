import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/customer_details.dart';

class OrderDetails {
  final String userId;
  final List<CartItem> cartItems;
  final CustomerDetails customerDetails;
  final String paymentMethod;
  final double totalPrice;
  final double shippingFee;
  final double subTotalPrice;
  final DateTime createdAt;

  OrderDetails({
    required this.userId,
    required this.cartItems,
    required this.customerDetails,
    required this.paymentMethod,
    required this.totalPrice,
    required this.shippingFee,
    required this.subTotalPrice,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'cartItems': cartItems.map((cartItem) => cartItem.toMap()).toList(),
      'customerDetails': customerDetails.toMap(),
      'paymentMethod': paymentMethod,
      'totalPrice': totalPrice,
      'shippingFee': shippingFee,
      'subTotalPrice': subTotalPrice,
      'createdAt': createdAt,
    };
  }

  factory OrderDetails.fromMap(Map<String, dynamic> map) {
    return OrderDetails(
      userId: map['userId'],
      cartItems: List<CartItem>.from(
        map['cartItems'].map((item) => CartItem.fromMap(item)),
      ),
      customerDetails: CustomerDetails.fromMap(map['customerDetails']),
      paymentMethod: map['paymentMethod'],
      totalPrice: map['totalPrice'],
      shippingFee: map['shippingFee'],
      subTotalPrice: map['subTotalPrice'],
      createdAt: map['createdAt'].toDate(),
    );
  }
}
