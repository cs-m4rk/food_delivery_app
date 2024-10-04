import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/customer_details.dart';

class Database {
  final CollectionReference orderDetails =
      FirebaseFirestore.instance.collection('orderDetails');

  final CollectionReference customerDetails =
      FirebaseFirestore.instance.collection('customerDetails');

  // save orders to Firestore
  Future<void> saveOrderDetails(String userId, String orderId,
      List<CartItem> cartItems, double totalPrice) async {
    List<Map<String, dynamic>> orders = cartItems.map((cartItem) {
      return {
        'food': cartItem.food.name,
        'quantity': cartItem.quantity,
        'addons': cartItem.selectedAddons
            .map((addon) => {
                  'name': addon.name,
                  'price': addon.price,
                })
            .toList(),
      };
    }).toList();

    await orderDetails.add({
      'userId': userId,
      'orders': orders,
      'totalPrice': totalPrice,
      'createdAt': Timestamp.now(),
    });
  }

// save customer details to Firestore
  Future<void> saveCustomerDetails(CustomerDetails newCustomerDetails) async {
    await customerDetails.add(newCustomerDetails.toMap());
  }

// fetch all customer details from Firestore
  Future<List<CustomerDetails>> getCustomerDetails() async {
    QuerySnapshot snapshot = await customerDetails.get();
    return snapshot.docs.map((doc) {
      return CustomerDetails.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
