import 'package:get/get.dart';
import 'package:youeat/models/additive_obs.dart';
import 'package:youeat/models/foods_model.dart';

class FoodController extends GetxController {
  RxInt currentPage = 0.obs;
  bool initialCheckedValue = false;

  var additivesList = <AdditiveObs>[].obs;

  void changedPage(int index) {
    currentPage.value = index;
  }

  RxInt count = 1.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }

  void loadAdditives(List<Additive> additives) {
    additivesList.clear();

    for (var additiveInfo in additives) {
      var additive = AdditiveObs(
        id: additiveInfo.id,
        title: additiveInfo.title,
        price: additiveInfo.price,
        checked: initialCheckedValue,
      );
      if (additives.length == additivesList.length) {
        // Condition check, if needed
      } else {
        additivesList.add(additive);
      }
    }
  }

  List<String> getCartAdditive() {
    List<String> additives = [];

    for (var additive in additivesList) {
      if (additive.isChecked.value && !additives.contains(additive.title)) {
        additives.add(additive.title);
      } else if (!additive.isChecked.value &&
          additives.contains(additive.title)) {
        additives.remove(additive.title);
      }
    }
    return additives;
  }

  RxInt _totalPrice = 0.obs; // Changed to RxInt

  int get additivePrice => _totalPrice.value;

  set setTotalPrice(int newPrice) {
    _totalPrice.value = newPrice;
  }

  int getTotalPrice() {
    int totalPrice = 0;

    for (var additive in additivesList) {
      if (additive.isChecked.value) {
        // Convert price to int using tryParse or handle as 0 if conversion fails
        totalPrice += (int.tryParse(additive.price.toString()) ?? 0);
      }
    }
    setTotalPrice = totalPrice;
    return totalPrice;
  }
}
