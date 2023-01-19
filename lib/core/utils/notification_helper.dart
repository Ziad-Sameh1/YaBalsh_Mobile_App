import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../constants/app_strings.dart';
import '../routes/app_routes.dart';
import 'enums/search_navigation_screens.dart';

class NotificationHelper {
  static void initNotificationsPlatform() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(AppStrings.oneSignalAppId);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  static void handleOnNotificationRecived() {
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      print(event.notification.additionalData);
    });
  }

  static void handleOnNotificationOpened() {
    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      Get.toNamed(RouteHelper.getSearchRoute(), arguments: [
        SearchNavigationScreens.other,
        openedResult.notification.title
      ]);
    });
  }
}
