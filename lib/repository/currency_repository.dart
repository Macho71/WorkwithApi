import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workwithapi/get_data_service.dart';
import 'package:workwithapi/models/currency_model.dart';

class CurrencyRepository {
  GetCurrencyService getCurrencyService = GetCurrencyService();
  Box<CurrencyModel>? currencyBox;

  Future<dynamic> getCurrency() async {
    dynamic response = await getCurrencyService.getCurrency();
    if (response is List<CurrencyModel>) {
      await openBox();
      await writeToBox(response);
      return currencyBox;
    } else {
      return response;
    }
  }

  void registerAdapters() {
    Hive.registerAdapter(CurrencyModelAdapter());
  }

  Future<void> openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    currencyBox = await Hive.openBox<CurrencyModel>("currency");
  }

  Future<void> writeToBox(List<CurrencyModel> data) async {
    await currencyBox!.clear();
    for (CurrencyModel element in data) {
      await currencyBox!.add(element);
    }
  }
}
