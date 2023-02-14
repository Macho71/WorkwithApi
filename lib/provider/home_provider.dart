import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:workwithapi/repository/currency_repository.dart';

import '../models/currency_model.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    getCurrency();
  }
  CurrencyRepository currencyRepository = CurrencyRepository();
  String error = "";
  bool isLoading = false;
  Box<CurrencyModel>? data;

  void getCurrency() async {
    isLoading = true;
    notifyListeners();
    await currencyRepository.getCurrency().then((dynamic response) {
      if (response is Box<CurrencyModel>) {
        isLoading = false;
        data = response;
        notifyListeners();
      } else {
        isLoading = false;
        error = response;
        notifyListeners();
      }
    });
  }
}
