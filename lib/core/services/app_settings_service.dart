// ignore_for_file: unused_field, prefer_final_fields, empty_catches

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../constants/app_strings.dart';
import 'app_config.dart';

abstract class AppSettingsService {
  late AppConfig _appConfig;
  late bool _isNearStores;
  late bool _showUpdateDialog;

  bool get isNearStores;
  bool get showUpdateDialog;
  AppConfig get appConfig;

  bool setShowUpdateDialog(bool value);
  void setUpRemoteConfig();
  void fetchAndSaveAppConfigs();

  void saveIsNearStoresSettings(bool value);
  Future<bool> getIsNearStoresSetting();
}

class AppSettingsServiceImpl implements AppSettingsService {
  final FirebaseRemoteConfig remoteConfig;

  AppSettingsServiceImpl({required this.remoteConfig});

  @override
  bool _isNearStores = false; // control is near you setting accross the app

  @override
  bool get isNearStores => _isNearStores;

  @override
  Future<bool> getIsNearStoresSetting() async {
    try {
      bool? value;
      if (!Hive.isBoxOpen(AppStrings.isNearStoresActivatedKey)) {
        await Hive.openBox<bool>(AppStrings.isNearStoresActivatedKey);
      }

      final box = Hive.box<bool>(AppStrings.isNearStoresActivatedKey);
      // get is near you setting saved from local storage
      value = box.get(AppStrings.isNearStoresActivatedKey);
      if (value != null) {
        _isNearStores = value;
        return value;
      } else {
        _isNearStores = true;
        return true;
      }
    } catch (err) {
      return _isNearStores;
    }
  }

  @override
  void saveIsNearStoresSettings(bool value) async {
    try {
      if (!Hive.isBoxOpen(AppStrings.isNearStoresActivatedKey)) {
        await Hive.openBox<bool>(AppStrings.isNearStoresActivatedKey);
      }

      final box = Hive.box<bool>(AppStrings.isNearStoresActivatedKey);
      box.put(AppStrings.isNearStoresActivatedKey,
          value); // change value in local storage
      _isNearStores = value; // change service settings for global use
    } catch (err) {
      debugPrint('failed to save setting');
    }
  }

  @override
  void fetchAndSaveAppConfigs() async {
    try {
      // fetch remote configs
      await remoteConfig.fetchAndActivate();
      final configs = remoteConfig.getAll();
      _appConfig = AppConfigFirebase.fromJson(
          configs); // set the app config object with fetched remote config
    } catch (err) {
      // this is the default app configs (change it according to current version)
      _appConfig = AppConfig(
          appVersion: '1.0.0', updateDescription: AppStrings.defaultUpdateText);
    }
  }

  @override
  AppConfig _appConfig = AppConfig();

  @override
  AppConfig get appConfig => _appConfig;

  @override
  bool _showUpdateDialog = true;

  @override
  bool get showUpdateDialog => _showUpdateDialog;

  @override
  bool setShowUpdateDialog(bool value) => _showUpdateDialog = value;

  @override
  void setUpRemoteConfig() async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 2),
          minimumFetchInterval: Duration.zero));
    } catch (e) {}
  }
}
