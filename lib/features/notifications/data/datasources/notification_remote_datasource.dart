import 'package:yabalash_mobile_app/core/api/remote_data_api/endpoints.dart';
import 'package:yabalash_mobile_app/core/api/remote_data_api/rest_api_provider.dart';
import 'package:yabalash_mobile_app/features/notifications/data/models/notification_response_model.dart';
import 'package:yabalash_mobile_app/features/notifications/domain/entities/notification.dart';

abstract class NotificationRemoteDataSource {
  Future<List<Notification>> getAllNotifications({int? page});
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final RestApiProvider restApiProvider;

  NotificationRemoteDataSourceImpl({required this.restApiProvider});
  @override
  Future<List<Notification>> getAllNotifications({int? page}) async {
    final response = await restApiProvider.get(notificationsEndpoint,
        queryParams: page != null ? {'page': page} : null);
    final decodeData = NotificationResponseModel.fromJson(response);
    return decodeData.data as List<Notification>;
  }
}
