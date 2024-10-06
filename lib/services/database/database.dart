import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/customer_details.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/models/order_details.dart';

class Database {
  final CollectionReference orderDetails =
      FirebaseFirestore.instance.collection('orderDetails');

  final CollectionReference customerDetails =
      FirebaseFirestore.instance.collection('customerDetails');

  final CollectionReference cartDetails =
      FirebaseFirestore.instance.collection('cartDetails');

  Future<void> saveOrderDetails(OrderDetails orderCollection) async {
    try {
      await orderDetails
          .doc(orderCollection.userId) // Use userId as document ID
          .set(orderCollection.toMap()); // Save the order details
    } catch (e) {
      throw Exception(e); // Rethrow if needed for error handling
    }
  }

  Future<OrderDetails?> getOrderDetails(String userId) async {
    try {
      final docSnapshot = await orderDetails.doc(userId).get();

      if (docSnapshot.exists) {
        // Map the document data back to an OrderDetails object
        final orderData = docSnapshot.data() as Map<String, dynamic>;
        return OrderDetails.fromMap(orderData);
      } else {
        // Handle case where the document does not exist
        return null;
      }
    } catch (e) {
      throw Exception(e); // Handle any errors
    }
  }

// Save customer details to Firestore
  Future<void> saveCustomerDetails(
      String userId, CustomerDetails newCustomerDetails) async {
    // Add the new customer details to Firestore and get the document reference
    DocumentReference docRef =
        await customerDetails.add(newCustomerDetails.toMap());

    // Update the newCustomerDetails object with the generated document ID
    newCustomerDetails.documentId =
        docRef.id; // Store the generated document ID

    // Optionally, you can also update Firestore with the document ID
    await docRef.update({'documentId': newCustomerDetails.documentId});
  }

  // fetch all customer details from Firestore according to their document id
  Future<List<CustomerDetails>> getCustomerDetails() async {
    QuerySnapshot snapshot = await customerDetails.get();
    return snapshot.docs.map((doc) {
      // Include the document ID in the map passed to fromMap
      return CustomerDetails.fromMap({
        'documentId': doc.id, // Capture the document ID
        ...doc.data() as Map<String, dynamic>, // Spread the other fields
      });
    }).toList();
  }

  // edit and update customer details in Firestore

  Future<void> updateCustomerDetails(
      String documentId, CustomerDetails updatedCustomerDetails) async {
    DocumentReference docRef = customerDetails.doc(documentId);
    await docRef.update(updatedCustomerDetails.toMap());
  }

  // save cart detaits to Firestore

  Future<void> saveCartDetails(String userId, List<CartItem> cartItems) async {
    List<Map<String, dynamic>> cart = cartItems.map((cartItem) {
      return {
        'food': cartItem.food.name,
        'quantity': cartItem.quantity,
        'totalPrice': cartItem.totalPrice,
        'addons': cartItem.selectedAddons
            .map((addon) => {
                  'name': addon.name,
                  'price': addon.price,
                })
            .toList(),
      };
    }).toList();

    await cartDetails.doc(userId).set({
      'userId': userId,
      'cart': cart,
    });
  }

  // _remove cart details from Firestore after the item is ordered
  Future<void> removeCartDetails(String userId, int indexToRemove) async {
    try {
      DocumentSnapshot snapshot = await cartDetails.doc(userId).get();
      List<dynamic> currentCart = snapshot.get('cart');

      if (indexToRemove >= 0 && indexToRemove < currentCart.length) {
        currentCart.removeAt(indexToRemove);
      } else {
        print("Index out of range");
        return;
      }

      await cartDetails.doc(userId).update({
        'cart': currentCart,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  // remove all the cart from the Firestore
  Future<void> removeAllCartDetails(String userId) async {
    await cartDetails.doc(userId).delete();
  }

  // fetch cart details from Firestore
  Future<List<Map<String, dynamic>>> getCartDetails(String userId) async {
    // Retrieve the document for the given user ID
    DocumentSnapshot snapshot = await cartDetails.doc(userId).get();

    // Check if the document exists
    if (snapshot.exists) {
      // Extract data from the snapshot
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Retrieve the cart list from the data
      List<dynamic> cartData = data['cart'] as List<dynamic>? ?? [];

      // Convert to a list of maps
      List<Map<String, dynamic>> cartItems = [];

      for (var item in cartData) {
        if (item is Map<String, dynamic>) {
          cartItems.add(item);
        } else {
          print("Unexpected item in cart: $item");
        }
      }

      return cartItems;
    } else {
      // Return an empty list if the document does not exist
      return [];
    }
  }
}
