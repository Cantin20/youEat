import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/api_eror.dart';

import 'package:http/http.dart' as http;
import 'package:youeat/models/success_model.dart';

class RegistrationController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setloading(bool newState) {
    _isLoading.value = newState;
  }

  void registrationFunction(String data) async {
    setloading = true;

    Uri url = Uri.parse('$appBaseUrl/register');

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 201) {
        var data = successModelFromJson(response.body);

        setloading = false;

        Get.back();

        Get.snackbar("You are succesfully registered ", data.message,
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Ionicons.fast_food_outline));
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar("Failed to registerd ", error.message,
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error_outline));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
