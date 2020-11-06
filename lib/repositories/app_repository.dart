import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';

class AppRepository {
  static AppRepository _instance;

  AppRepository._internal() {
    _instance = this;
  }

  factory AppRepository() => _instance ?? AppRepository._internal();

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users_customers');
  final CollectionReference _countries =
      FirebaseFirestore.instance.collection('countries');
  final CollectionReference _orders =
      FirebaseFirestore.instance.collection('orders');
  // ignore: non_constant_identifier_names
  final CollectionReference pickup_subscribers =
      FirebaseFirestore.instance.collection('pickup_subscribers');

  final head = 'head';
  final outlets = 'outlets';
  final pricing = 'pricing';

  // Future upgradeUser(String userid) async {
  //   try {
  //     // Upload order data
  //     DocumentReference _orderDoc = _orders.doc(orderId);
  //
  //     await _orderDoc.update({'$field_status.$field_index': 2});
  //     print("Confirmed Collection");
  //   } catch (e) {
  //     print(e);
  //     throw 'Error: $e, Please try again later';
  //   }
  // }

  /*Stream getOrders(User user) {
    return _orders
        .where(User.field_uid, isEqualTo: user.uid)
        .orderBy(field_timeStamp)
        .snapshots();
  }

  Future confirmCollection(String orderId) async {
    try {
      // Upload order data
      DocumentReference _orderDoc = _orders.doc(orderId);

      await _orderDoc.update({'$field_status.$field_index': 2});
      print("Confirmed Collection");
    } catch (e) {
      print(e);
      throw 'Error: $e, Please try again later';
    }
  }

  Future confirmDelivery(String orderId) async {
    try {
      // Upload order data
      DocumentReference _orderDoc = _orders.doc(orderId);

      await _orderDoc.update({'$field_status.$field_index': 4});
      print("Confirmed Delivery");
    } catch (e) {
      print(e);
      throw 'Error: $e, Please try again later';
    }
  }

  Future uploadWPSettings(String uid, {WeeklyPickupSettings settings}) async {
    // Upload user data
    return pickup_subscribers.doc(uid).set(settings.toMap());
  }

  Future<Pricing> getPricing(User user, {String pricingId}) async {
    // Get pricingId
    // From Locality
    pricingId ??= user.address?.locality?.pricingId ??
        // or Outlet
        await getOutlet(address: user?.address)
            .then((value) => value?.pricingId) ??
        // or Head
        head;

    user.address.state.ref ??= await _getStateRef(user.address);

    // Get pricing
    return user.address.state.ref.collection(pricing).doc(pricingId).get().then(
      (pricing) async {
        if (pricing.exists) {
          // Get Available Promotions
          return getPromotions(user.uid).then((promotions) =>
              Future.value(Pricing.fromMap(pricing.data(), promotions.docs)));
        } else {
          // Get pricing from nearest Outlet
          return getPricing(user,
              pricingId: await getOutlet(address: user?.address)
                      .then((value) => value?.pricingId) ??
                  // or Head
                  head);
        }
      },
    );
    //user.address.stateRef.
  }

  Future<QuerySnapshot> getPromotions(String uid) async => PaymentRepository()
      .activePromotions
      .where(User.field_uid, isEqualTo: uid)
      .get();*/
}
