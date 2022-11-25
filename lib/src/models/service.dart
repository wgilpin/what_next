import 'package:firebase_storage/firebase_storage.dart';

class Service {
  String title;
  String fileName;
  String? url;

  Service({
    required this.title,
    required this.fileName,
    this.url,
  });

  Future<void> fetchImageUrl() async {
    url = await FirebaseStorage.instance
        .ref('/logos')
        .child(fileName)
        .getDownloadURL();
  }
}
