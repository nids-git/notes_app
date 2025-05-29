import 'package:flutter_app/utils/apiService.dart';
import 'package:get/get.dart';
import '../model/dataModel.dart';

class DataController extends GetxController{
  final ApiService apiService = ApiService();
  var dataList = <DataModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      final fetchData = (await apiService.fetchPosts())!;
      if (fetchData != null) {
        dataList.clear();
        dataList.addAll(fetchData);
        print('List Data: ${dataList.length}');
        print('List Data: ${dataList.toString()}');
      } else {
        print('fetchPosts returned null');
      }
    } catch(e) {
      Get.snackbar('Error', 'Failed to fetch data');
    } finally {
      isLoading(false);
    }
  }

}