// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      id: (json['id'] as num?)?.toInt(),
      appName: json['app_name'] as String?,
      appApiUrl: json['app_api_url'] as String?,
      appApiKey: json['app_api_key'] as String?,
      appVersion: json['app_version'] as String?,
      appDescription: json['app_description'] as String?,
      appLogo: json['app_logo'] as String?,
      androidAppVersion: json['android_app_version'] as String?,
      iosAppVersion: json['ios_app_version'] as String?,
      iosAppLink: json['ios_app_link'] as String?,
      androidAppLink: json['android_app_link'] as String?,
      privacyPolicyLink: json['privacy_policy_link'] as String?,
      termsOfServiceLink: json['terms_of_service_link'] as String?,
      contactEmail: json['contact_email'] as String?,
      contactPhone: json['contact_phone'] as String?,
      contactAddress: json['contact_address'] as String?,
      facebookLink: json['facebook_link'] as String?,
      twitterLink: json['twitter_link'] as String?,
      linkedinLink: json['linkedin_link'] as String?,
      maintenanceMode: json['maintenance_mode'] as bool?,
      mapApiKey: json['map_api_key'] as String?,
      defaultMapStyle: json['default_map_style'] as String?,
      isFacebookLoginEnabled: json['is_facebook_login_enabled'] as bool?,
      isGoogleLoginEnabled: json['is_google_login_enabled'] as bool?,
      isOsmLoginEnabled: json['is_osm_login_enabled'] as bool?,
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'id': instance.id,
      'app_name': instance.appName,
      'app_api_url': instance.appApiUrl,
      'app_api_key': instance.appApiKey,
      'app_version': instance.appVersion,
      'app_description': instance.appDescription,
      'app_logo': instance.appLogo,
      'android_app_version': instance.androidAppVersion,
      'ios_app_version': instance.iosAppVersion,
      'ios_app_link': instance.iosAppLink,
      'android_app_link': instance.androidAppLink,
      'privacy_policy_link': instance.privacyPolicyLink,
      'terms_of_service_link': instance.termsOfServiceLink,
      'contact_email': instance.contactEmail,
      'contact_phone': instance.contactPhone,
      'contact_address': instance.contactAddress,
      'facebook_link': instance.facebookLink,
      'twitter_link': instance.twitterLink,
      'linkedin_link': instance.linkedinLink,
      'maintenance_mode': instance.maintenanceMode,
      'map_api_key': instance.mapApiKey,
      'default_map_style': instance.defaultMapStyle,
      'is_facebook_login_enabled': instance.isFacebookLoginEnabled,
      'is_google_login_enabled': instance.isGoogleLoginEnabled,
      'is_osm_login_enabled': instance.isOsmLoginEnabled,
    };
