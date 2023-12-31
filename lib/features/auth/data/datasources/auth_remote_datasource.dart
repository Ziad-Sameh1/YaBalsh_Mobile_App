import 'package:yabalash_mobile_app/core/api/remote_data_api/endpoints.dart';
import 'package:yabalash_mobile_app/core/api/remote_data_api/headers.dart';
import 'package:yabalash_mobile_app/core/api/remote_data_api/rest_api_provider.dart';
import 'package:yabalash_mobile_app/features/auth/data/models/check_user_response_model.dart';
import 'package:yabalash_mobile_app/features/auth/data/models/login_request_model.dart';
import 'package:yabalash_mobile_app/features/auth/data/models/login_response_model.dart';
import 'package:yabalash_mobile_app/features/auth/data/models/register_request_model.dart';
import 'package:yabalash_mobile_app/features/auth/data/models/register_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> loginUser(
      {required LoginRequestModel loginRequest});

  Future<RegisterResponseModel> registerUser(
      {required RegisterRequestModel requestModel});

  Future<RegisterResponseModel> getCurrentCustomer();

  Future<CheckUserRegisterdResponseModel> checkUserRegistered(
      {required String phoneNumber});

  Future<bool> registerDevice(
      {required String deviceId, required String token});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final RestApiProvider restApiProvider;

  AuthRemoteDataSourceImpl({required this.restApiProvider});
  @override
  Future<LoginResponseModel> loginUser(
      {required LoginRequestModel loginRequest}) async {
    final response =
        await restApiProvider.post(loginEndpoint, body: loginRequest.toJson());

    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<RegisterResponseModel> registerUser(
      {required RegisterRequestModel requestModel}) async {
    final response = await restApiProvider.post(registerEndPoint,
        body: requestModel.toJson());

    return RegisterResponseModel.fromJson(response);
  }

  @override
  Future<RegisterResponseModel> getCurrentCustomer() async {
    final response = await restApiProvider.get(getCurrentUserEndpoint,
        headers: ApiHeaders.authorizationHeaders);

    return RegisterResponseModel.fromJson(response);
  }

  @override
  Future<CheckUserRegisterdResponseModel> checkUserRegistered(
      {required String phoneNumber}) async {
    final response = await restApiProvider.get(checkUserRegisteredEndpoint,
        queryParams: {'phoneNumber': phoneNumber});

    return CheckUserRegisterdResponseModel.fromJson(response);
  }

  @override
  Future<bool> registerDevice(
      {required String deviceId, required String token}) async {
    final response = await restApiProvider.post(devicesEndpoint,
        body: {'deviceId': deviceId},
        headers: {'authorization': 'Bearer $token'});

    return response['data'] as bool;
  }
}
