// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxString _category = ''.obs;

  String get categoryValue => _category.value;

  set UpdateCategory(String value) {
    _category.value = value; 
  }

  RxString _title = ''.obs;

  String get titleValue => _title.value;

  set UpdateTitle(String value) {
    _title.value = value;
  }
}
