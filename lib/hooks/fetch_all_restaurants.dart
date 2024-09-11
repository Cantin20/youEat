import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/api_eror.dart';
import 'package:youeat/models/hook_models/fetch_results.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:youeat/models/restaurant_model.dart';

FetchHook useFetchAllRestaurants(String code) {
  final restaurants = useState<List<RestaurantsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url =
          Uri.parse('$appBaseUrl/api/restaurant/all/$code'); // Update the URL if needed
      final response = await http.get(url);
      if (response.statusCode == 200) {
        restaurants.value = restaurantsModelFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      error.value = e as Exception;
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

  return FetchHook(
    data: restaurants.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
