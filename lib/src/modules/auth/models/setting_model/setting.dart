import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable()
class Setting {
  int? id;
  @JsonKey(name: 'app_name')
  String? appName;
  @JsonKey(name: 'app_api_url')
  String? appApiUrl;
  @JsonKey(name: 'app_api_key')
  String? appApiKey;
  @JsonKey(name: 'app_version')
  String? appVersion;
  @JsonKey(name: 'app_description')
  String? appDescription;
  @JsonKey(name: 'app_logo')
  String? appLogo;
  @JsonKey(name: 'android_app_version')
  String? androidAppVersion;
  @JsonKey(name: 'ios_app_version')
  String? iosAppVersion;
  @JsonKey(name: 'ios_app_link')
  String? iosAppLink;
  @JsonKey(name: 'android_app_link')
  String? androidAppLink;
  @JsonKey(name: 'privacy_policy_link')
  String? privacyPolicyLink;
  @JsonKey(name: 'terms_of_service_link')
  String? termsOfServiceLink;
  @JsonKey(name: 'contact_email')
  String? contactEmail;
  @JsonKey(name: 'contact_phone')
  String? contactPhone;
  @JsonKey(name: 'contact_address')
  String? contactAddress;
  @JsonKey(name: 'facebook_link')
  String? facebookLink;
  @JsonKey(name: 'twitter_link')
  String? twitterLink;
  @JsonKey(name: 'linkedin_link')
  String? linkedinLink;
  @JsonKey(name: 'maintenance_mode')
  bool? maintenanceMode;
  @JsonKey(name: 'map_api_key')
  String? mapApiKey;
  @JsonKey(name: 'default_map_style')
  String? defaultMapStyle;
  @JsonKey(name: 'is_facebook_login_enabled')
  bool? isFacebookLoginEnabled;
  @JsonKey(name: 'is_google_login_enabled')
  bool? isGoogleLoginEnabled;
  @JsonKey(name: 'is_osm_login_enabled')
  bool? isOsmLoginEnabled;

  Setting({
    this.id,
    this.appName,
    this.appApiUrl,
    this.appApiKey,
    this.appVersion,
    this.appDescription,
    this.appLogo,
    this.androidAppVersion,
    this.iosAppVersion,
    this.iosAppLink,
    this.androidAppLink,
    this.privacyPolicyLink,
    this.termsOfServiceLink,
    this.contactEmail,
    this.contactPhone,
    this.contactAddress,
    this.facebookLink,
    this.twitterLink,
    this.linkedinLink,
    this.maintenanceMode,
    this.mapApiKey,
    this.defaultMapStyle,
    this.isFacebookLoginEnabled,
    this.isGoogleLoginEnabled,
    this.isOsmLoginEnabled,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return _$SettingFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}
