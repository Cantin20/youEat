// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:youeat/constants/constants.dart';

class UserLocationController extends GetxController {
  RxBool _isDefault = false.obs;
  bool get isDefault => _isDefault.value;

  set setIsDefault(bool value) {
    _isDefault.value = value;
  }

  RxInt _tabIndex = 0.obs;

  int get tabIndex => _tabIndex.value;

  set setTabIndex(int value) {
    _tabIndex.value = value;
  }

  LatLng position = const LatLng(3.8132776520957274, 11.557988810807808);

  void setPosition(LatLng value) {
    value = position;
    update();
  }

  RxString _address = ''.obs;

  String get address => _address.value;

  set setAddress(String value) {
    _address.value = value;
  }

  RxString _postalCode = ''.obs;

  String get postalCode => _postalCode.value;

  set setPostalCode(String value) {
    _postalCode.value = value;
  }

  void getUserAddress(LatLng position) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$API_KEY');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(response.statusCode);
      print(responseBody);

      final address = responseBody['results'][0]['formatted_address'];
      setAddress = address;

      final addressComponent = responseBody['results'][0]['address_components'];

      for (var component in addressComponent) {
        if (component['types'].contains('postal_code')) {
          setPostalCode = component['long_name'];
        }
      }
    }
  }

 void addAddress(String data) async {
  final box = GetStorage();
  String accessToken = box.read("token");

  Uri url = Uri.parse('$appBaseUrl/api/address');

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  };

  try {
    var response = await http.post(url, headers: headers, body: data);

    if (response.statusCode == 200) {
      // Successfully added address
      final responseBody = jsonDecode(response.body);
      // Perform any additional actions here, like updating the UI or saving data
      Get.snackbar('Success', 'Address added successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      // Handle other status codes
      final errorBody = jsonDecode(response.body);
      Get.snackbar('Error', errorBody['message'] ?? 'Failed to add address.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  } catch (e) {
    debugPrint('Error adding address: $e');
    Get.snackbar('Error', 'An error occurred while adding the address.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
}

}
