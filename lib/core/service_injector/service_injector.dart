import 'package:api_flutter/core/service/service_export.dart';

class Serviceinjector {
  ApiService apiService = ApiService();
  ContactService contactService = ContactService();
  RouterService routerService = RouterService();
  DialogService dialogService = DialogService();
  UtilityService utilityService = UtilityService();
}

Serviceinjector si = Serviceinjector();
