import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/api_eror.dart';
import 'package:youeat/models/cart_response.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:youeat/models/hook_models/fetch_results.dart';

FetchHook fetchCart() {
  final box = GetStorage();
  final cart = useState<List<CartResponse>?>(null);
  final isLoading = useState<bool>(false);
  final error =
      useState<Exception?>(null); // Change to String for error messages
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    String accessToken =
        box.read("token"); // Default to an empty string if null

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/cart'); // Update the URL if needed
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        cart.value = cartResponseFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      // Directly convert the error to a string for simplicity
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

  return FetchHook(
    data: cart.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
