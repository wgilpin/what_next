// Import the test package and Counter class

import 'package:flutter_test/flutter_test.dart';
import 'package:what_next/src/controllers/service_controller.dart';
import 'package:what_next/src/models/service.dart';

void main() {
  late ServiceCtl srv;
  group('Service Controller', () {
    setUp(() {
      srv = ServiceCtl();
      srv.serviceList.add(
          Service(title: 'Other', fileName: 'other.png', url: 'other/url'));
      srv.serviceList.add(Service(
          title: 'Netflix', fileName: 'netflix.png', url: 'netflix/url'));
      srv.serviceList.add(
          Service(title: 'Amazon', fileName: 'amazon.png', url: 'amazon/url'));
    });

    test('serviceList should have 3 entries', () {
      expect(srv.serviceList.length, equals(3));
    });
    test('getUrlForService should return other by default', () {
      var url = srv.getUrlForService('');
      expect(url, 'other/url');
    });

    test('getUrlForService should return correct url', () {
      var url = srv.getUrlForService('Netflix');
      expect(url, 'netflix/url');
      url = srv.getUrlForService('Amazon');
      expect(url, 'amazon/url');
      url = srv.getUrlForService('Other');
      expect(url, 'other/url');
    });
  });
}
