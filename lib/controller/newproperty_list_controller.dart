import 'package:dtbroker/service/newproperty_list_service.dart';
import 'package:get/get.dart';
import '../model/newproperty_list_model.dart';


class NewPropertyListController extends GetxController {
  final NewPropertyListService _service=NewPropertyListService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  //var propertyList = <Data>[].obs;
  var newlyAddedList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNewlyAdded();
  }

  Future<void> loadNewlyAdded() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _service.fetchProperties();

      if (response.status == true && response.data != null) {

        // ✅ Yaha filter kar sakte ho (latest / recent)
        newlyAddedList.assignAll(response.data!);

      } else {
        errorMessage.value = response.message ?? "No Data Found";
      }

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}