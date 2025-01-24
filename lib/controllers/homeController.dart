import 'package:bcccoin/utils/http_util.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var http = HttpUtil.getInstance();
  reinitHttp() {
    HttpUtil.instance = null;
    http = HttpUtil.getInstance();
  }
}
