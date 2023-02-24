// ignore_for_file: unused_field

abstract class AppSettingsService {
  late String _appVersion;
  String get appVersion;
  void setAppVersion(String appVersion);
}

class AppSettingsServiceImpl implements AppSettingsService {
  @override
  String _appVersion = '1.0.0';
  @override
  String get appVersion => _appVersion;
  @override
  void setAppVersion(String version) {
    _appVersion = version;
  }
}
