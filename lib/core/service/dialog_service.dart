import 'package:fluttertoast/fluttertoast.dart';

class DialogService {
  showToaster(String message) {
    return Fluttertoast.showToast(msg: message);
  }
}
