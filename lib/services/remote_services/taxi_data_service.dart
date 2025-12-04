import 'dart:convert';
import '../../main.dart';
import '../../models/taxi_data_model.dart';

class TaxiDataService {
  Future<TaxiDataModel?> fetchTaxiData() async {
    String? json = await api.getRequest("f852c2acc472148688b1", auth: false);
    if (json == null) return null;
    return TaxiDataModel.fromJson(jsonDecode(json));
  }
}
