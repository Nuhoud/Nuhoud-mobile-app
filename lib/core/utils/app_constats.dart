import 'cache_helper.dart';

String lang = "en";
const double kBorderRadius = 15;
const double kSizedBoxHeight = 25;
const double kVerticalPadding = 15;
const double kHorizontalPadding = 10;
bool isGuest = CacheHelper.getData(key: "token") == null ? true : false;
