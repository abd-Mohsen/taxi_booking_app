import 'package:get/get.dart';
import 'package:taxi_booking_app/models/driver_model.dart';
import 'package:taxi_booking_app/models/fare_rules_model.dart';
import 'package:taxi_booking_app/models/taxi_data_model.dart';
import '../services/remote_services/taxi_data_service.dart';

class TaxiDataController extends GetxController {
  @override
  void onInit() {
    // fetchTaxiData();
    super.onInit();
  }

  final List<DriverModel> drivers = [];
  FareRulesModel? fareRules;

  bool isLoading = false;
  void toggleLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> fetchTaxiData() async {
    toggleLoading(true);
    TaxiDataModel? taxiData = await TaxiDataService().fetchTaxiData();
    if (taxiData == null) {
      await Future.delayed(Duration(seconds: 8));
      await fetchTaxiData();
    } else {
      drivers.addAll(taxiData.drivers);
      fareRules = taxiData.fareRules;
    }
    toggleLoading(false);
  }
}
