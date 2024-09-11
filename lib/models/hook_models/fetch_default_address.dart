import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/address_response.dart';
import 'package:youeat/models/api_eror.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:youeat/models/hook_models/fetch_results.dart';

FetchHook useFetchDefault() {
  final box = GetStorage();
  final addresses = useState<AddressResponse?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    String accessToken = box.read("token");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    isLoading.value = true;

    try {
      Uri url = Uri.parse(
          '$appBaseUrl/api/address/default'); // Update the URL if needed
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = response.body;
        var decoded = jsonDecode(data);
        addresses.value = AddressResponse.fromJson(decoded);
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
    data: addresses.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
