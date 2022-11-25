import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:what_next/src/models/service.dart';

class ServiceCtl extends GetxController {
  List<Service> serviceList = RxList<Service>([]);

  @override
  void onReady() {
    super.onReady();
    debugPrint('ServiceController onReady');
    fetchAllServices();
  }

  // get all services
  Future<void> fetchAllServices() async {
    final storageRef = FirebaseStorage.instance.ref().child("logos");
    final listResult = await storageRef.listAll();
    serviceList.clear();
    for (var srv in listResult.items) {
      // The items under storageRef.
      var title = basenameWithoutExtension(srv.name);
      var filename = basename(srv.name);
      var service = Service(title: title, fileName: filename);
      await service.fetchImageUrl();
      serviceList.add(service);
    }
    // move the default service to the top
    var otherIdx =
        serviceList.indexWhere((element) => element.title == 'Other');
    var temp = serviceList[0];
    serviceList[0] = serviceList[otherIdx];
    serviceList[otherIdx] = temp;
    debugPrint('fetchAllServices: ${serviceList.length}');
  }

  String getUrlForService(String service) {
    var srv = serviceList.firstWhere((element) => element.title == service);
    return srv.url!;
  }
}
