import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/api_eror.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:youeat/models/hook_models/restaurant_hook.dart';
import 'package:youeat/models/restaurant_model.dart';

FetchRestaurant useFetchRestaurant(String id) {
  final restaurants = useState<RestaurantsModel?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      
      Uri url = Uri.parse(
          '$appBaseUrl/api/restaurant/byId/$id'); // Update the URL if needed

      final response = await http.get(url);

      if (response.statusCode == 200) {
        var restaurant = jsonDecode(response.body);
        restaurants.value = RestaurantsModel.fromJson(restaurant);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchRestaurant(
    data: restaurants.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
