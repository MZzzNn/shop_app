import 'package:shop_app/modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

bool isDarkC = true;

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, LoginScreen());
  });
}

String token = '';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}
