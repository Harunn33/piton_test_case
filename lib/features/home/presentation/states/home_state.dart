import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piton_test_case/features/home/data/model/category/category_response_model.dart';
import 'package:piton_test_case/features/home/data/model/product/resp/product_response_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required bool isLoading,
    required TextEditingController searchController,
    required List<CategoryItemModel> categories,
    required CategoryItemModel? selectedCategory,
    required List<Product> products,
    required List<Product> searchedProducts,
    required List<ProductResponseModel> allProductsByCategory,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
        isLoading: false,
        searchController: TextEditingController(),
        categories: [],
        selectedCategory: null,
        products: [],
        searchedProducts: [],
        allProductsByCategory: [],
      );
}
