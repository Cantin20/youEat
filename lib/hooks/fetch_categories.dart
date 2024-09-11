import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/api_eror.dart';
import 'package:youeat/models/categories.dart';
import 'package:youeat/models/hook_models/fetch_results.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchCategories() {
  final categoriesItems = useState<List<CategoryModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('$appBaseUrl/api/category/random'); // Update the URL if needed
      final response = await http.get(url);

      

      if (response.statusCode == 200) {
        categoriesItems.value = categoryModelFromJson(response.body);
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
    data: categoriesItems.value,
    error: error.value,
    isLoading: isLoading.value,
    refetch: refetch,
  );
}
