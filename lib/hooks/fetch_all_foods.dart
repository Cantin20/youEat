import 'package:flutter/material.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/api_eror.dart';
import 'package:youeat/models/foods_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:youeat/models/hook_models/foods_hooks.dart';

FetchFoods useFetchAllFoods(String code) {
  final foods = useState<List<FoodsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse(
          '$appBaseUrl/api/foods/byCode/$code'); // Update the URL if needed
      final response = await http.get(url);
      if (response.statusCode == 200) {
        foods.value = foodsModelFromJson(response.body);
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

  return FetchFoods(
    data: foods.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
