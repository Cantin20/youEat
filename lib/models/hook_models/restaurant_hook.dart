import 'package:flutter/material.dart';
import 'package:youeat/models/restaurant_model.dart';

class FetchRestaurant {
  final RestaurantsModel? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback? refetch;

  FetchRestaurant({
    required this.data,
    required this.error,
    required this.isLoading,
    required this.refetch,
  });
}
