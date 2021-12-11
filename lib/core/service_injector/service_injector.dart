import 'package:api_flutter/core/service/service_export.dart';

class Serviceinjector {
  ApiService apiService = ApiService();
  ContactService contactService = ContactService();
  DialogService dialogService = DialogService();
}

Serviceinjector si = Serviceinjector();
