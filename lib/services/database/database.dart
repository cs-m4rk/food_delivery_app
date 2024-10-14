import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/customer_details.dart';
import 'package:food_delivery_app/models/order_details.dart';
import 'package:food_delivery_app/models/user.dart';

class Database {
  final CollectionReference orderDetails =
      FirebaseFirestore.instance.collection('orderDetails');

  final CollectionReference customerDetails =
      FirebaseFirestore.instance.collection('customerDetails');

  final CollectionReference cartDetails =
      FirebaseFirestore.instance.collection('cartDetails');
  final CollectionReference userDetails =
      FirebaseFirestore.instance.collection('userDetails');

  // Save order details to Firestore
  Future<void> saveOrderDetails(OrderDetails orderCollection) async {
    try {
      await orderDetails
          .doc(orderCollection.userId)
          .set(orderCollection.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

// Fetch order details from Firestore
  Future<OrderDetails?> getOrderDetails(String userId) async {
    try {
      final docSnapshot = await orderDetails.doc(userId).get();

      if (docSnapshot.exists) {
        final orderData = docSnapshot.data() as Map<String, dynamic>;
        return OrderDetails.fromMap(orderData);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

// Save customer details to Firestore
  Future<void> saveCustomerDetails(
      String userId, CustomerDetails newCustomerDetails) async {
    DocumentReference docRef =
        await customerDetails.add(newCustomerDetails.toMap());

    newCustomerDetails.documentId = docRef.id;

    await docRef.update({'documentId': newCustomerDetails.documentId});
  }

  // fetch all customer details from Firestore according to their document id
  Stream<List<CustomerDetails>> getCustomerDetails(String userId) {
    // Listen for real-time updates where the userId matches
    return customerDetails
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return CustomerDetails.fromMap({
          'documentId': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
      }).toList();
    });
  }

  // edit and update customer details in Firestore
  Future<void> updateCustomerDetails(
      String documentId, CustomerDetails updatedCustomerDetails) async {
    DocumentReference docRef = customerDetails.doc(documentId);
    await docRef.update(updatedCustomerDetails.toMap());
  }

  // save cart detaits to Firestore
  Future<void> saveCartDetails(String userId, CartItem cartItem) async {
    // Get the reference to the user's cart subcollection
    CollectionReference cartCollection =
        cartDetails.doc(userId).collection('cart');

    // Add the cart item to the collection
    await cartCollection.add(cartItem.toMap());
  }

  Stream<List<CartItem>> getCartDetails(String userId) {
    CollectionReference cartCollection =
        cartDetails.doc(userId).collection('cart');

    // Use snapshots() to listen for real-time updates
    return cartCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return CartItem.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
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

  // save user details to Firestore
  Future<void> saveUserDetails(User userDetails, String userId) async {
    try {
      await this.userDetails.doc(userId).set(userDetails.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  // fetch user details from Firestore
Stream<User?> getUserDetails(String userId) async* {
  try {
    final docSnapshot = await userDetails.doc(userId).get();

    if (docSnapshot.exists) {
      final userData = docSnapshot.data() as Map<String, dynamic>;
      yield User.fromMap(userData);
    } else {
      yield null;
    }
  } catch (e) {
    throw Exception(e);
  }
}
  // update user details in Firestore
  Future<void> updateUserDetails(User updatedUserDetails, String userId) async {
    try {
      await userDetails.doc(userId).update(updatedUserDetails.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  //upload image to Firestore
  Future<String> uploadProfileImageToStorage(
      Uint8List imageFile, String userId) async {
    try {
      final ref = FirebaseStorage.instance.ref('profile_images/$userId.png');

      String uploadedImageUrl = await ref.putData(imageFile).then((snapshot) {
        return snapshot.ref.getDownloadURL();
      });

      return uploadedImageUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      throw e;
    }
  }
}
