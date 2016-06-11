{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Telephony;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os;

type
// ===== Forward declarations =====

  JCarrierConfigManager = interface;//android.telephony.CarrierConfigManager
  JCellIdentityCdma = interface;//android.telephony.CellIdentityCdma
  JCellIdentityGsm = interface;//android.telephony.CellIdentityGsm
  JCellIdentityLte = interface;//android.telephony.CellIdentityLte
  JCellIdentityWcdma = interface;//android.telephony.CellIdentityWcdma
  JCellInfo = interface;//android.telephony.CellInfo
  JCellInfoCdma = interface;//android.telephony.CellInfoCdma
  JCellInfoGsm = interface;//android.telephony.CellInfoGsm
  JCellInfoLte = interface;//android.telephony.CellInfoLte
  JCellInfoWcdma = interface;//android.telephony.CellInfoWcdma
  JCellLocation = interface;//android.telephony.CellLocation
  JCellSignalStrength = interface;//android.telephony.CellSignalStrength
  JCellSignalStrengthCdma = interface;//android.telephony.CellSignalStrengthCdma
  JCellSignalStrengthGsm = interface;//android.telephony.CellSignalStrengthGsm
  JCellSignalStrengthLte = interface;//android.telephony.CellSignalStrengthLte
  JCellSignalStrengthWcdma = interface;//android.telephony.CellSignalStrengthWcdma
  JPhoneStateListener = interface;//android.telephony.PhoneStateListener
  JCustomPhoneStateListener = interface;//android.telephony.CustomPhoneStateListener
  JICustomPhoneStateListener = interface;//android.telephony.ICustomPhoneStateListener
  JIccOpenLogicalChannelResponse = interface;//android.telephony.IccOpenLogicalChannelResponse
  JNeighboringCellInfo = interface;//android.telephony.NeighboringCellInfo
  JPhoneNumberFormattingTextWatcher = interface;//android.telephony.PhoneNumberFormattingTextWatcher
  JPhoneNumberUtils = interface;//android.telephony.PhoneNumberUtils
  JServiceState = interface;//android.telephony.ServiceState
  JSignalStrength = interface;//android.telephony.SignalStrength
  JSmsManager = interface;//android.telephony.SmsManager
  JSmsMessage = interface;//android.telephony.SmsMessage
  JSmsMessage_MessageClass = interface;//android.telephony.SmsMessage$MessageClass
  JSmsMessage_SubmitPdu = interface;//android.telephony.SmsMessage$SubmitPdu
  JSubscriptionInfo = interface;//android.telephony.SubscriptionInfo
  JSubscriptionManager = interface;//android.telephony.SubscriptionManager
  JSubscriptionManager_OnSubscriptionsChangedListener = interface;//android.telephony.SubscriptionManager$OnSubscriptionsChangedListener
  JTelephonyManager = interface;//android.telephony.TelephonyManager
  JCdmaCellLocation = interface;//android.telephony.cdma.CdmaCellLocation
  JGsmCellLocation = interface;//android.telephony.gsm.GsmCellLocation
  Jgsm_SmsManager = interface;//android.telephony.gsm.SmsManager
  Jgsm_SmsMessage = interface;//android.telephony.gsm.SmsMessage
  Jgsm_SmsMessage_MessageClass = interface;//android.telephony.gsm.SmsMessage$MessageClass
  Jgsm_SmsMessage_SubmitPdu = interface;//android.telephony.gsm.SmsMessage$SubmitPdu

// ===== Interface declarations =====

  JCarrierConfigManagerClass = interface(JObjectClass)
    ['{8164A855-B878-453D-BE18-688B0A72A983}']
    {class} function _GetACTION_CARRIER_CONFIG_CHANGED: JString; cdecl;
    {class} function _GetKEY_ADDITIONAL_CALL_SETTING_BOOL: JString; cdecl;
    {class} function _GetKEY_ALLOW_EMERGENCY_NUMBERS_IN_CALL_LOG_BOOL: JString; cdecl;
    {class} function _GetKEY_ALLOW_LOCAL_DTMF_TONES_BOOL: JString; cdecl;
    {class} function _GetKEY_APN_EXPAND_BOOL: JString; cdecl;
    {class} function _GetKEY_AUTO_RETRY_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_CARRIER_ALLOW_TURNOFF_IMS_BOOL: JString; cdecl;
    {class} function _GetKEY_CARRIER_SETTINGS_ENABLE_BOOL: JString; cdecl;
    {class} function _GetKEY_CARRIER_VOLTE_AVAILABLE_BOOL: JString; cdecl;
    {class} function _GetKEY_CARRIER_VOLTE_PROVISIONING_REQUIRED_BOOL: JString; cdecl;
    {class} function _GetKEY_CARRIER_VOLTE_TTY_SUPPORTED_BOOL: JString; cdecl;
    {class} function _GetKEY_CARRIER_VT_AVAILABLE_BOOL: JString; cdecl;
    {class} function _GetKEY_CARRIER_VVM_PACKAGE_NAME_STRING: JString; cdecl;
    {class} function _GetKEY_CARRIER_WFC_IMS_AVAILABLE_BOOL: JString; cdecl;
    {class} function _GetKEY_CDMA_NONROAMING_NETWORKS_STRING_ARRAY: JString; cdecl;
    {class} function _GetKEY_CDMA_ROAMING_NETWORKS_STRING_ARRAY: JString; cdecl;
    {class} function _GetKEY_CSP_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_DEFAULT_SIM_CALL_MANAGER_STRING: JString; cdecl;
    {class} function _GetKEY_DISABLE_CDMA_ACTIVATION_CODE_BOOL: JString; cdecl;
    {class} function _GetKEY_DTMF_TYPE_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_ENABLE_DIALER_KEY_VIBRATION_BOOL: JString; cdecl;
    {class} function _GetKEY_FORCE_HOME_NETWORK_BOOL: JString; cdecl;
    {class} function _GetKEY_GSM_NONROAMING_NETWORKS_STRING_ARRAY: JString; cdecl;
    {class} function _GetKEY_GSM_ROAMING_NETWORKS_STRING_ARRAY: JString; cdecl;
    {class} function _GetKEY_HAS_IN_CALL_NOISE_SUPPRESSION_BOOL: JString; cdecl;
    {class} function _GetKEY_HIDE_CARRIER_NETWORK_SETTINGS_BOOL: JString; cdecl;
    {class} function _GetKEY_HIDE_SIM_LOCK_SETTINGS_BOOL: JString; cdecl;
    {class} function _GetKEY_IGNORE_SIM_NETWORK_LOCKED_EVENTS_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_ALIAS_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_ALIAS_MAX_CHARS_INT: JString; cdecl;
    {class} function _GetKEY_MMS_ALIAS_MIN_CHARS_INT: JString; cdecl;
    {class} function _GetKEY_MMS_ALLOW_ATTACH_AUDIO_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_APPEND_TRANSACTION_ID_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_EMAIL_GATEWAY_NUMBER_STRING: JString; cdecl;
    {class} function _GetKEY_MMS_GROUP_MMS_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_HTTP_PARAMS_STRING: JString; cdecl;
    {class} function _GetKEY_MMS_HTTP_SOCKET_TIMEOUT_INT: JString; cdecl;
    {class} function _GetKEY_MMS_MAX_IMAGE_HEIGHT_INT: JString; cdecl;
    {class} function _GetKEY_MMS_MAX_IMAGE_WIDTH_INT: JString; cdecl;
    {class} function _GetKEY_MMS_MAX_MESSAGE_SIZE_INT: JString; cdecl;
    {class} function _GetKEY_MMS_MESSAGE_TEXT_MAX_SIZE_INT: JString; cdecl;
    {class} function _GetKEY_MMS_MMS_DELIVERY_REPORT_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_MMS_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_MMS_READ_REPORT_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_MULTIPART_SMS_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_NAI_SUFFIX_STRING: JString; cdecl;
    {class} function _GetKEY_MMS_NOTIFY_WAP_MMSC_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_RECIPIENT_LIMIT_INT: JString; cdecl;
    {class} function _GetKEY_MMS_SEND_MULTIPART_SMS_AS_SEPARATE_MESSAGES_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_SHOW_CELL_BROADCAST_APP_LINKS_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_SMS_DELIVERY_REPORT_ENABLED_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_SMS_TO_MMS_TEXT_LENGTH_THRESHOLD_INT: JString; cdecl;
    {class} function _GetKEY_MMS_SMS_TO_MMS_TEXT_THRESHOLD_INT: JString; cdecl;
    {class} function _GetKEY_MMS_SUBJECT_MAX_LENGTH_INT: JString; cdecl;
    {class} function _GetKEY_MMS_SUPPORT_HTTP_CHARSET_HEADER_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_SUPPORT_MMS_CONTENT_DISPOSITION_BOOL: JString; cdecl;
    {class} function _GetKEY_MMS_UA_PROF_TAG_NAME_STRING: JString; cdecl;
    {class} function _GetKEY_MMS_UA_PROF_URL_STRING: JString; cdecl;
    {class} function _GetKEY_MMS_USER_AGENT_STRING: JString; cdecl;
    {class} function _GetKEY_OPERATOR_SELECTION_EXPAND_BOOL: JString; cdecl;
    {class} function _GetKEY_PREFER_2G_BOOL: JString; cdecl;
    {class} function _GetKEY_SHOW_APN_SETTING_CDMA_BOOL: JString; cdecl;
    {class} function _GetKEY_SHOW_CDMA_CHOICES_BOOL: JString; cdecl;
    {class} function _GetKEY_SHOW_ONSCREEN_DIAL_BUTTON_BOOL: JString; cdecl;
    {class} function _GetKEY_SIM_NETWORK_UNLOCK_ALLOW_DISMISS_BOOL: JString; cdecl;
    {class} function _GetKEY_SUPPORT_PAUSE_IMS_VIDEO_CALLS_BOOL: JString; cdecl;
    {class} function _GetKEY_SUPPORT_SWAP_AFTER_MERGE_BOOL: JString; cdecl;
    {class} function _GetKEY_USE_HFA_FOR_PROVISIONING_BOOL: JString; cdecl;
    {class} function _GetKEY_USE_OTASP_FOR_PROVISIONING_BOOL: JString; cdecl;
    {class} function _GetKEY_VOICEMAIL_NOTIFICATION_PERSISTENT_BOOL: JString; cdecl;
    {class} function _GetKEY_VOICE_PRIVACY_DISABLE_UI_BOOL: JString; cdecl;
    {class} function _GetKEY_VOLTE_REPLACEMENT_RAT_INT: JString; cdecl;
    {class} function _GetKEY_VVM_DESTINATION_NUMBER_STRING: JString; cdecl;
    {class} function _GetKEY_VVM_PORT_NUMBER_INT: JString; cdecl;
    {class} function _GetKEY_VVM_TYPE_STRING: JString; cdecl;
    {class} function _GetKEY_WORLD_PHONE_BOOL: JString; cdecl;
    {class} property ACTION_CARRIER_CONFIG_CHANGED: JString read _GetACTION_CARRIER_CONFIG_CHANGED;
    {class} property KEY_ADDITIONAL_CALL_SETTING_BOOL: JString read _GetKEY_ADDITIONAL_CALL_SETTING_BOOL;
    {class} property KEY_ALLOW_EMERGENCY_NUMBERS_IN_CALL_LOG_BOOL: JString read _GetKEY_ALLOW_EMERGENCY_NUMBERS_IN_CALL_LOG_BOOL;
    {class} property KEY_ALLOW_LOCAL_DTMF_TONES_BOOL: JString read _GetKEY_ALLOW_LOCAL_DTMF_TONES_BOOL;
    {class} property KEY_APN_EXPAND_BOOL: JString read _GetKEY_APN_EXPAND_BOOL;
    {class} property KEY_AUTO_RETRY_ENABLED_BOOL: JString read _GetKEY_AUTO_RETRY_ENABLED_BOOL;
    {class} property KEY_CARRIER_ALLOW_TURNOFF_IMS_BOOL: JString read _GetKEY_CARRIER_ALLOW_TURNOFF_IMS_BOOL;
    {class} property KEY_CARRIER_SETTINGS_ENABLE_BOOL: JString read _GetKEY_CARRIER_SETTINGS_ENABLE_BOOL;
    {class} property KEY_CARRIER_VOLTE_AVAILABLE_BOOL: JString read _GetKEY_CARRIER_VOLTE_AVAILABLE_BOOL;
    {class} property KEY_CARRIER_VOLTE_PROVISIONING_REQUIRED_BOOL: JString read _GetKEY_CARRIER_VOLTE_PROVISIONING_REQUIRED_BOOL;
    {class} property KEY_CARRIER_VOLTE_TTY_SUPPORTED_BOOL: JString read _GetKEY_CARRIER_VOLTE_TTY_SUPPORTED_BOOL;
    {class} property KEY_CARRIER_VT_AVAILABLE_BOOL: JString read _GetKEY_CARRIER_VT_AVAILABLE_BOOL;
    {class} property KEY_CARRIER_VVM_PACKAGE_NAME_STRING: JString read _GetKEY_CARRIER_VVM_PACKAGE_NAME_STRING;
    {class} property KEY_CARRIER_WFC_IMS_AVAILABLE_BOOL: JString read _GetKEY_CARRIER_WFC_IMS_AVAILABLE_BOOL;
    {class} property KEY_CDMA_NONROAMING_NETWORKS_STRING_ARRAY: JString read _GetKEY_CDMA_NONROAMING_NETWORKS_STRING_ARRAY;
    {class} property KEY_CDMA_ROAMING_NETWORKS_STRING_ARRAY: JString read _GetKEY_CDMA_ROAMING_NETWORKS_STRING_ARRAY;
    {class} property KEY_CSP_ENABLED_BOOL: JString read _GetKEY_CSP_ENABLED_BOOL;
    {class} property KEY_DEFAULT_SIM_CALL_MANAGER_STRING: JString read _GetKEY_DEFAULT_SIM_CALL_MANAGER_STRING;
    {class} property KEY_DISABLE_CDMA_ACTIVATION_CODE_BOOL: JString read _GetKEY_DISABLE_CDMA_ACTIVATION_CODE_BOOL;
    {class} property KEY_DTMF_TYPE_ENABLED_BOOL: JString read _GetKEY_DTMF_TYPE_ENABLED_BOOL;
    {class} property KEY_ENABLE_DIALER_KEY_VIBRATION_BOOL: JString read _GetKEY_ENABLE_DIALER_KEY_VIBRATION_BOOL;
    {class} property KEY_FORCE_HOME_NETWORK_BOOL: JString read _GetKEY_FORCE_HOME_NETWORK_BOOL;
    {class} property KEY_GSM_NONROAMING_NETWORKS_STRING_ARRAY: JString read _GetKEY_GSM_NONROAMING_NETWORKS_STRING_ARRAY;
    {class} property KEY_GSM_ROAMING_NETWORKS_STRING_ARRAY: JString read _GetKEY_GSM_ROAMING_NETWORKS_STRING_ARRAY;
    {class} property KEY_HAS_IN_CALL_NOISE_SUPPRESSION_BOOL: JString read _GetKEY_HAS_IN_CALL_NOISE_SUPPRESSION_BOOL;
    {class} property KEY_HIDE_CARRIER_NETWORK_SETTINGS_BOOL: JString read _GetKEY_HIDE_CARRIER_NETWORK_SETTINGS_BOOL;
    {class} property KEY_HIDE_SIM_LOCK_SETTINGS_BOOL: JString read _GetKEY_HIDE_SIM_LOCK_SETTINGS_BOOL;
    {class} property KEY_IGNORE_SIM_NETWORK_LOCKED_EVENTS_BOOL: JString read _GetKEY_IGNORE_SIM_NETWORK_LOCKED_EVENTS_BOOL;
    {class} property KEY_MMS_ALIAS_ENABLED_BOOL: JString read _GetKEY_MMS_ALIAS_ENABLED_BOOL;
    {class} property KEY_MMS_ALIAS_MAX_CHARS_INT: JString read _GetKEY_MMS_ALIAS_MAX_CHARS_INT;
    {class} property KEY_MMS_ALIAS_MIN_CHARS_INT: JString read _GetKEY_MMS_ALIAS_MIN_CHARS_INT;
    {class} property KEY_MMS_ALLOW_ATTACH_AUDIO_BOOL: JString read _GetKEY_MMS_ALLOW_ATTACH_AUDIO_BOOL;
    {class} property KEY_MMS_APPEND_TRANSACTION_ID_BOOL: JString read _GetKEY_MMS_APPEND_TRANSACTION_ID_BOOL;
    {class} property KEY_MMS_EMAIL_GATEWAY_NUMBER_STRING: JString read _GetKEY_MMS_EMAIL_GATEWAY_NUMBER_STRING;
    {class} property KEY_MMS_GROUP_MMS_ENABLED_BOOL: JString read _GetKEY_MMS_GROUP_MMS_ENABLED_BOOL;
    {class} property KEY_MMS_HTTP_PARAMS_STRING: JString read _GetKEY_MMS_HTTP_PARAMS_STRING;
    {class} property KEY_MMS_HTTP_SOCKET_TIMEOUT_INT: JString read _GetKEY_MMS_HTTP_SOCKET_TIMEOUT_INT;
    {class} property KEY_MMS_MAX_IMAGE_HEIGHT_INT: JString read _GetKEY_MMS_MAX_IMAGE_HEIGHT_INT;
    {class} property KEY_MMS_MAX_IMAGE_WIDTH_INT: JString read _GetKEY_MMS_MAX_IMAGE_WIDTH_INT;
    {class} property KEY_MMS_MAX_MESSAGE_SIZE_INT: JString read _GetKEY_MMS_MAX_MESSAGE_SIZE_INT;
    {class} property KEY_MMS_MESSAGE_TEXT_MAX_SIZE_INT: JString read _GetKEY_MMS_MESSAGE_TEXT_MAX_SIZE_INT;
    {class} property KEY_MMS_MMS_DELIVERY_REPORT_ENABLED_BOOL: JString read _GetKEY_MMS_MMS_DELIVERY_REPORT_ENABLED_BOOL;
    {class} property KEY_MMS_MMS_ENABLED_BOOL: JString read _GetKEY_MMS_MMS_ENABLED_BOOL;
    {class} property KEY_MMS_MMS_READ_REPORT_ENABLED_BOOL: JString read _GetKEY_MMS_MMS_READ_REPORT_ENABLED_BOOL;
    {class} property KEY_MMS_MULTIPART_SMS_ENABLED_BOOL: JString read _GetKEY_MMS_MULTIPART_SMS_ENABLED_BOOL;
    {class} property KEY_MMS_NAI_SUFFIX_STRING: JString read _GetKEY_MMS_NAI_SUFFIX_STRING;
    {class} property KEY_MMS_NOTIFY_WAP_MMSC_ENABLED_BOOL: JString read _GetKEY_MMS_NOTIFY_WAP_MMSC_ENABLED_BOOL;
    {class} property KEY_MMS_RECIPIENT_LIMIT_INT: JString read _GetKEY_MMS_RECIPIENT_LIMIT_INT;
    {class} property KEY_MMS_SEND_MULTIPART_SMS_AS_SEPARATE_MESSAGES_BOOL: JString read _GetKEY_MMS_SEND_MULTIPART_SMS_AS_SEPARATE_MESSAGES_BOOL;
    {class} property KEY_MMS_SHOW_CELL_BROADCAST_APP_LINKS_BOOL: JString read _GetKEY_MMS_SHOW_CELL_BROADCAST_APP_LINKS_BOOL;
    {class} property KEY_MMS_SMS_DELIVERY_REPORT_ENABLED_BOOL: JString read _GetKEY_MMS_SMS_DELIVERY_REPORT_ENABLED_BOOL;
    {class} property KEY_MMS_SMS_TO_MMS_TEXT_LENGTH_THRESHOLD_INT: JString read _GetKEY_MMS_SMS_TO_MMS_TEXT_LENGTH_THRESHOLD_INT;
    {class} property KEY_MMS_SMS_TO_MMS_TEXT_THRESHOLD_INT: JString read _GetKEY_MMS_SMS_TO_MMS_TEXT_THRESHOLD_INT;
    {class} property KEY_MMS_SUBJECT_MAX_LENGTH_INT: JString read _GetKEY_MMS_SUBJECT_MAX_LENGTH_INT;
    {class} property KEY_MMS_SUPPORT_HTTP_CHARSET_HEADER_BOOL: JString read _GetKEY_MMS_SUPPORT_HTTP_CHARSET_HEADER_BOOL;
    {class} property KEY_MMS_SUPPORT_MMS_CONTENT_DISPOSITION_BOOL: JString read _GetKEY_MMS_SUPPORT_MMS_CONTENT_DISPOSITION_BOOL;
    {class} property KEY_MMS_UA_PROF_TAG_NAME_STRING: JString read _GetKEY_MMS_UA_PROF_TAG_NAME_STRING;
    {class} property KEY_MMS_UA_PROF_URL_STRING: JString read _GetKEY_MMS_UA_PROF_URL_STRING;
    {class} property KEY_MMS_USER_AGENT_STRING: JString read _GetKEY_MMS_USER_AGENT_STRING;
    {class} property KEY_OPERATOR_SELECTION_EXPAND_BOOL: JString read _GetKEY_OPERATOR_SELECTION_EXPAND_BOOL;
    {class} property KEY_PREFER_2G_BOOL: JString read _GetKEY_PREFER_2G_BOOL;
    {class} property KEY_SHOW_APN_SETTING_CDMA_BOOL: JString read _GetKEY_SHOW_APN_SETTING_CDMA_BOOL;
    {class} property KEY_SHOW_CDMA_CHOICES_BOOL: JString read _GetKEY_SHOW_CDMA_CHOICES_BOOL;
    {class} property KEY_SHOW_ONSCREEN_DIAL_BUTTON_BOOL: JString read _GetKEY_SHOW_ONSCREEN_DIAL_BUTTON_BOOL;
    {class} property KEY_SIM_NETWORK_UNLOCK_ALLOW_DISMISS_BOOL: JString read _GetKEY_SIM_NETWORK_UNLOCK_ALLOW_DISMISS_BOOL;
    {class} property KEY_SUPPORT_PAUSE_IMS_VIDEO_CALLS_BOOL: JString read _GetKEY_SUPPORT_PAUSE_IMS_VIDEO_CALLS_BOOL;
    {class} property KEY_SUPPORT_SWAP_AFTER_MERGE_BOOL: JString read _GetKEY_SUPPORT_SWAP_AFTER_MERGE_BOOL;
    {class} property KEY_USE_HFA_FOR_PROVISIONING_BOOL: JString read _GetKEY_USE_HFA_FOR_PROVISIONING_BOOL;
    {class} property KEY_USE_OTASP_FOR_PROVISIONING_BOOL: JString read _GetKEY_USE_OTASP_FOR_PROVISIONING_BOOL;
    {class} property KEY_VOICEMAIL_NOTIFICATION_PERSISTENT_BOOL: JString read _GetKEY_VOICEMAIL_NOTIFICATION_PERSISTENT_BOOL;
    {class} property KEY_VOICE_PRIVACY_DISABLE_UI_BOOL: JString read _GetKEY_VOICE_PRIVACY_DISABLE_UI_BOOL;
    {class} property KEY_VOLTE_REPLACEMENT_RAT_INT: JString read _GetKEY_VOLTE_REPLACEMENT_RAT_INT;
    {class} property KEY_VVM_DESTINATION_NUMBER_STRING: JString read _GetKEY_VVM_DESTINATION_NUMBER_STRING;
    {class} property KEY_VVM_PORT_NUMBER_INT: JString read _GetKEY_VVM_PORT_NUMBER_INT;
    {class} property KEY_VVM_TYPE_STRING: JString read _GetKEY_VVM_TYPE_STRING;
    {class} property KEY_WORLD_PHONE_BOOL: JString read _GetKEY_WORLD_PHONE_BOOL;
  end;

  [JavaSignature('android/telephony/CarrierConfigManager')]
  JCarrierConfigManager = interface(JObject)
    ['{11F40FA1-334D-4683-9D44-7A888F2661B8}']
    function getConfig: JPersistableBundle; cdecl;
    function getConfigForSubId(subId: Integer): JPersistableBundle; cdecl;
    procedure notifyConfigChangedForSubId(subId: Integer); cdecl;
  end;
  TJCarrierConfigManager = class(TJavaGenericImport<JCarrierConfigManagerClass, JCarrierConfigManager>) end;

  JCellIdentityCdmaClass = interface(JObjectClass)
    ['{47D53089-08D3-430B-8D56-2B54959C6F8A}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/telephony/CellIdentityCdma')]
  JCellIdentityCdma = interface(JObject)
    ['{D2456865-988D-40AE-B4B3-42471181056E}']
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getBasestationId: Integer; cdecl;
    function getLatitude: Integer; cdecl;
    function getLongitude: Integer; cdecl;
    function getNetworkId: Integer; cdecl;
    function getSystemId: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellIdentityCdma = class(TJavaGenericImport<JCellIdentityCdmaClass, JCellIdentityCdma>) end;

  JCellIdentityGsmClass = interface(JObjectClass)
    ['{F238DC50-40FA-4093-BDA2-2839208E79CE}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/telephony/CellIdentityGsm')]
  JCellIdentityGsm = interface(JObject)
    ['{9DD941A0-7403-4CD9-B000-22D4E7500A6D}']
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getCid: Integer; cdecl;
    function getLac: Integer; cdecl;
    function getMcc: Integer; cdecl;
    function getMnc: Integer; cdecl;
    function getPsc: Integer; cdecl;//Deprecated
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellIdentityGsm = class(TJavaGenericImport<JCellIdentityGsmClass, JCellIdentityGsm>) end;

  JCellIdentityLteClass = interface(JObjectClass)
    ['{3F1A9F22-BF62-4D7C-ABA7-ECECF9725F68}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/telephony/CellIdentityLte')]
  JCellIdentityLte = interface(JObject)
    ['{A1796A99-CC9C-47E8-97EA-E7AF5B27A5BE}']
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getCi: Integer; cdecl;
    function getMcc: Integer; cdecl;
    function getMnc: Integer; cdecl;
    function getPci: Integer; cdecl;
    function getTac: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellIdentityLte = class(TJavaGenericImport<JCellIdentityLteClass, JCellIdentityLte>) end;

  JCellIdentityWcdmaClass = interface(JObjectClass)
    ['{F9C9B6D7-9DB2-4E50-8B47-7CC9F5EC7ED6}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/telephony/CellIdentityWcdma')]
  JCellIdentityWcdma = interface(JObject)
    ['{1B622051-779D-4813-9CA6-992ABA3535D0}']
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getCid: Integer; cdecl;
    function getLac: Integer; cdecl;
    function getMcc: Integer; cdecl;
    function getMnc: Integer; cdecl;
    function getPsc: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellIdentityWcdma = class(TJavaGenericImport<JCellIdentityWcdmaClass, JCellIdentityWcdma>) end;

  JCellInfoClass = interface(JObjectClass)
    ['{D5A9AC63-0BEA-45CB-A8E3-6DCBA1B9FD89}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/telephony/CellInfo')]
  JCellInfo = interface(JObject)
    ['{726F121A-E75C-4A37-B6CB-9DA886794FDF}']
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getTimeStamp: Int64; cdecl;
    function hashCode: Integer; cdecl;
    function isRegistered: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellInfo = class(TJavaGenericImport<JCellInfoClass, JCellInfo>) end;

  JCellInfoCdmaClass = interface(JCellInfoClass)
    ['{553A50F7-6149-45ED-9077-17F3A93B024A}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} //CREATOR is defined in parent interface
  end;

  [JavaSignature('android/telephony/CellInfoCdma')]
  JCellInfoCdma = interface(JCellInfo)
    ['{AF6F61BE-45A9-46D4-A45F-D1B71A4F7152}']
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getCellIdentity: JCellIdentityCdma; cdecl;
    function getCellSignalStrength: JCellSignalStrengthCdma; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellInfoCdma = class(TJavaGenericImport<JCellInfoCdmaClass, JCellInfoCdma>) end;

  JCellInfoGsmClass = interface(JCellInfoClass)
    ['{EF7AB5EA-EE8E-42F6-8652-E50E630E46B4}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} //CREATOR is defined in parent interface
  end;

  [JavaSignature('android/telephony/CellInfoGsm')]
  JCellInfoGsm = interface(JCellInfo)
    ['{0E1045BB-B110-4AC7-803F-1BECCD8F9C3C}']
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getCellIdentity: JCellIdentityGsm; cdecl;
    function getCellSignalStrength: JCellSignalStrengthGsm; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellInfoGsm = class(TJavaGenericImport<JCellInfoGsmClass, JCellInfoGsm>) end;

  JCellInfoLteClass = interface(JCellInfoClass)
    ['{ED725D53-684B-4A2F-814F-9A9650AAF0F4}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} //CREATOR is defined in parent interface
  end;

  [JavaSignature('android/telephony/CellInfoLte')]
  JCellInfoLte = interface(JCellInfo)
    ['{8C7BB823-B037-49B8-8FBA-8C8AFE1F5177}']
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getCellIdentity: JCellIdentityLte; cdecl;
    function getCellSignalStrength: JCellSignalStrengthLte; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellInfoLte = class(TJavaGenericImport<JCellInfoLteClass, JCellInfoLte>) end;

  JCellInfoWcdmaClass = interface(JCellInfoClass)
    ['{D77AEE44-3759-4C79-8D70-4E323C80C5FC}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} //CREATOR is defined in parent interface
  end;

  [JavaSignature('android/telephony/CellInfoWcdma')]
  JCellInfoWcdma = interface(JCellInfo)
    ['{6B66E6E1-BF02-48EA-9B98-5D891AA80788}']
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getCellIdentity: JCellIdentityWcdma; cdecl;
    function getCellSignalStrength: JCellSignalStrengthWcdma; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellInfoWcdma = class(TJavaGenericImport<JCellInfoWcdmaClass, JCellInfoWcdma>) end;

  JCellLocationClass = interface(JObjectClass)
    ['{048C4A3E-4C00-40E1-A471-364959ED7986}']
    {class} function init: JCellLocation; cdecl;
    {class} function getEmpty: JCellLocation; cdecl;
    {class} procedure requestLocationUpdate; cdecl;
  end;

  [JavaSignature('android/telephony/CellLocation')]
  JCellLocation = interface(JObject)
    ['{769C920D-0E68-4A1D-ABA3-42894B5742C8}']
  end;
  TJCellLocation = class(TJavaGenericImport<JCellLocationClass, JCellLocation>) end;

  JCellSignalStrengthClass = interface(JObjectClass)
    ['{2E408E0B-E6EF-450A-BE16-FE6258E458B9}']
    {class} function _GetSIGNAL_STRENGTH_GOOD: Integer; cdecl;
    {class} function _GetSIGNAL_STRENGTH_GREAT: Integer; cdecl;
    {class} function _GetSIGNAL_STRENGTH_MODERATE: Integer; cdecl;
    {class} function _GetSIGNAL_STRENGTH_NONE_OR_UNKNOWN: Integer; cdecl;
    {class} function _GetSIGNAL_STRENGTH_POOR: Integer; cdecl;
    {class} property SIGNAL_STRENGTH_GOOD: Integer read _GetSIGNAL_STRENGTH_GOOD;
    {class} property SIGNAL_STRENGTH_GREAT: Integer read _GetSIGNAL_STRENGTH_GREAT;
    {class} property SIGNAL_STRENGTH_MODERATE: Integer read _GetSIGNAL_STRENGTH_MODERATE;
    {class} property SIGNAL_STRENGTH_NONE_OR_UNKNOWN: Integer read _GetSIGNAL_STRENGTH_NONE_OR_UNKNOWN;
    {class} property SIGNAL_STRENGTH_POOR: Integer read _GetSIGNAL_STRENGTH_POOR;
  end;

  [JavaSignature('android/telephony/CellSignalStrength')]
  JCellSignalStrength = interface(JObject)
    ['{E28FDB30-AFA1-40FC-98B8-C2267E1532E0}']
    function equals(o: JObject): Boolean; cdecl;
    function getAsuLevel: Integer; cdecl;
    function getDbm: Integer; cdecl;
    function getLevel: Integer; cdecl;
    function hashCode: Integer; cdecl;
  end;
  TJCellSignalStrength = class(TJavaGenericImport<JCellSignalStrengthClass, JCellSignalStrength>) end;

  JCellSignalStrengthCdmaClass = interface(JCellSignalStrengthClass)
    ['{01B4BDE1-698E-4773-B65E-89BEC2EB3074}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/telephony/CellSignalStrengthCdma')]
  JCellSignalStrengthCdma = interface(JCellSignalStrength)
    ['{06C07B11-232F-40E1-9072-885B7D40F92D}']
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getAsuLevel: Integer; cdecl;
    function getCdmaDbm: Integer; cdecl;
    function getCdmaEcio: Integer; cdecl;
    function getCdmaLevel: Integer; cdecl;
    function getDbm: Integer; cdecl;
    function getEvdoDbm: Integer; cdecl;
    function getEvdoEcio: Integer; cdecl;
    function getEvdoLevel: Integer; cdecl;
    function getEvdoSnr: Integer; cdecl;
    function getLevel: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellSignalStrengthCdma = class(TJavaGenericImport<JCellSignalStrengthCdmaClass, JCellSignalStrengthCdma>) end;

  JCellSignalStrengthGsmClass = interface(JCellSignalStrengthClass)
    ['{BC14D3AE-FBE8-4778-9922-2DC549FAA3A3}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/telephony/CellSignalStrengthGsm')]
  JCellSignalStrengthGsm = interface(JCellSignalStrength)
    ['{17546ED7-86F4-4A5F-A432-9D0477B4F29C}']
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getAsuLevel: Integer; cdecl;
    function getDbm: Integer; cdecl;
    function getLevel: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellSignalStrengthGsm = class(TJavaGenericImport<JCellSignalStrengthGsmClass, JCellSignalStrengthGsm>) end;

  JCellSignalStrengthLteClass = interface(JCellSignalStrengthClass)
    ['{B2AEC25C-986C-49A8-85F0-5CF96A9E0856}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/telephony/CellSignalStrengthLte')]
  JCellSignalStrengthLte = interface(JCellSignalStrength)
    ['{C0E93090-5675-481F-8BB4-5642161E3393}']
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getAsuLevel: Integer; cdecl;
    function getDbm: Integer; cdecl;
    function getLevel: Integer; cdecl;
    function getTimingAdvance: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellSignalStrengthLte = class(TJavaGenericImport<JCellSignalStrengthLteClass, JCellSignalStrengthLte>) end;

  JCellSignalStrengthWcdmaClass = interface(JCellSignalStrengthClass)
    ['{2DEBF0C2-DE83-4B07-98A8-BF6CE9070ADF}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/telephony/CellSignalStrengthWcdma')]
  JCellSignalStrengthWcdma = interface(JCellSignalStrength)
    ['{09E2490B-D681-44B3-8C18-F4543582F1A3}']
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getAsuLevel: Integer; cdecl;
    function getDbm: Integer; cdecl;
    function getLevel: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCellSignalStrengthWcdma = class(TJavaGenericImport<JCellSignalStrengthWcdmaClass, JCellSignalStrengthWcdma>) end;

  JPhoneStateListenerClass = interface(JObjectClass)
    ['{897EC9F9-957F-4942-859D-50BCED64009B}']
    {class} function _GetLISTEN_CALL_FORWARDING_INDICATOR: Integer; cdecl;
    {class} function _GetLISTEN_CALL_STATE: Integer; cdecl;
    {class} function _GetLISTEN_CELL_INFO: Integer; cdecl;
    {class} function _GetLISTEN_CELL_LOCATION: Integer; cdecl;
    {class} function _GetLISTEN_DATA_ACTIVITY: Integer; cdecl;
    {class} function _GetLISTEN_DATA_CONNECTION_STATE: Integer; cdecl;
    {class} function _GetLISTEN_MESSAGE_WAITING_INDICATOR: Integer; cdecl;
    {class} function _GetLISTEN_NONE: Integer; cdecl;
    {class} function _GetLISTEN_SERVICE_STATE: Integer; cdecl;
    {class} function _GetLISTEN_SIGNAL_STRENGTH: Integer; cdecl;
    {class} function _GetLISTEN_SIGNAL_STRENGTHS: Integer; cdecl;
    {class} function init: JPhoneStateListener; cdecl;
    {class} property LISTEN_CALL_FORWARDING_INDICATOR: Integer read _GetLISTEN_CALL_FORWARDING_INDICATOR;
    {class} property LISTEN_CALL_STATE: Integer read _GetLISTEN_CALL_STATE;
    {class} property LISTEN_CELL_INFO: Integer read _GetLISTEN_CELL_INFO;
    {class} property LISTEN_CELL_LOCATION: Integer read _GetLISTEN_CELL_LOCATION;
    {class} property LISTEN_DATA_ACTIVITY: Integer read _GetLISTEN_DATA_ACTIVITY;
    {class} property LISTEN_DATA_CONNECTION_STATE: Integer read _GetLISTEN_DATA_CONNECTION_STATE;
    {class} property LISTEN_MESSAGE_WAITING_INDICATOR: Integer read _GetLISTEN_MESSAGE_WAITING_INDICATOR;
    {class} property LISTEN_NONE: Integer read _GetLISTEN_NONE;
    {class} property LISTEN_SERVICE_STATE: Integer read _GetLISTEN_SERVICE_STATE;
    {class} property LISTEN_SIGNAL_STRENGTH: Integer read _GetLISTEN_SIGNAL_STRENGTH;
    {class} property LISTEN_SIGNAL_STRENGTHS: Integer read _GetLISTEN_SIGNAL_STRENGTHS;
  end;

  [JavaSignature('android/telephony/PhoneStateListener')]
  JPhoneStateListener = interface(JObject)
    ['{50CE10E1-C584-4145-BC72-65BFA48BB281}']
    procedure onCallForwardingIndicatorChanged(cfi: Boolean); cdecl;
    procedure onCallStateChanged(state: Integer; incomingNumber: JString); cdecl;
    procedure onCellInfoChanged(cellInfo: JList); cdecl;
    procedure onCellLocationChanged(location: JCellLocation); cdecl;
    procedure onDataActivity(direction: Integer); cdecl;
    procedure onDataConnectionStateChanged(state: Integer); cdecl; overload;
    procedure onDataConnectionStateChanged(state: Integer; networkType: Integer); cdecl; overload;
    procedure onMessageWaitingIndicatorChanged(mwi: Boolean); cdecl;
    procedure onServiceStateChanged(serviceState: JServiceState); cdecl;
    procedure onSignalStrengthChanged(asu: Integer); cdecl;//Deprecated
    procedure onSignalStrengthsChanged(signalStrength: JSignalStrength); cdecl;
  end;
  TJPhoneStateListener = class(TJavaGenericImport<JPhoneStateListenerClass, JPhoneStateListener>) end;

  JCustomPhoneStateListenerClass = interface(JPhoneStateListenerClass)
    ['{94FF7ECE-DF9C-41E3-B9E7-9E44DC0127BB}']
    {class} function init(listener: JICustomPhoneStateListener): JCustomPhoneStateListener; cdecl;
  end;

  [JavaSignature('android/telephony/CustomPhoneStateListener')]
  JCustomPhoneStateListener = interface(JPhoneStateListener)
    ['{753BA66D-E86F-4345-89FC-7BC79F6B5C5A}']
    procedure onCallForwardingIndicatorChanged(cfi: Boolean); cdecl;
    procedure onCallStateChanged(state: Integer; incomingNumber: JString); cdecl;
    procedure onCellInfoChanged(cellInfo: JList); cdecl;
    procedure onCellLocationChanged(location: JCellLocation); cdecl;
    procedure onDataActivity(direction: Integer); cdecl;
    procedure onDataConnectionStateChanged(state: Integer); cdecl; overload;
    procedure onDataConnectionStateChanged(state: Integer; networkType: Integer); cdecl; overload;
    procedure onMessageWaitingIndicatorChanged(mwi: Boolean); cdecl;
    procedure onServiceStateChanged(serviceState: JServiceState); cdecl;
    procedure onSignalStrengthChanged(asu: Integer); cdecl;
    procedure onSignalStrengthsChanged(signalStrength: JSignalStrength); cdecl;
  end;
  TJCustomPhoneStateListener = class(TJavaGenericImport<JCustomPhoneStateListenerClass, JCustomPhoneStateListener>) end;

  JICustomPhoneStateListenerClass = interface(IJavaClass)
    ['{2B3FDA31-7A12-4ADC-B81C-B7E9D37ADD09}']
  end;

  [JavaSignature('android/telephony/ICustomPhoneStateListener')]
  JICustomPhoneStateListener = interface(IJavaInstance)
    ['{C8ABB706-0034-43DA-B768-F095F9ABE215}']
    procedure onCallForwardingIndicatorChanged(cfi: Boolean); cdecl;
    procedure onCallStateChanged(state: Integer; incomingNumber: JString); cdecl;
    procedure onCellInfoChanged(cellInfo: JList); cdecl;
    procedure onCellLocationChanged(location: JCellLocation); cdecl;
    procedure onDataActivity(direction: Integer); cdecl;
    procedure onDataConnectionStateChanged(state: Integer); cdecl; overload;
    procedure onDataConnectionStateChanged(state: Integer; networkType: Integer); cdecl; overload;
    procedure onMessageWaitingIndicatorChanged(mwi: Boolean); cdecl;
    procedure onServiceStateChanged(serviceState: JServiceState); cdecl;
    procedure onSignalStrengthChanged(asu: Integer); cdecl;
    procedure onSignalStrengthsChanged(signalStrength: JSignalStrength); cdecl;
  end;
  TJICustomPhoneStateListener = class(TJavaGenericImport<JICustomPhoneStateListenerClass, JICustomPhoneStateListener>) end;

  JIccOpenLogicalChannelResponseClass = interface(JObjectClass)
    ['{BADEDECF-3EFB-4912-9478-37C4ADCDC8A3}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetINVALID_CHANNEL: Integer; cdecl;
    {class} function _GetSTATUS_MISSING_RESOURCE: Integer; cdecl;
    {class} function _GetSTATUS_NO_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_NO_SUCH_ELEMENT: Integer; cdecl;
    {class} function _GetSTATUS_UNKNOWN_ERROR: Integer; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property INVALID_CHANNEL: Integer read _GetINVALID_CHANNEL;
    {class} property STATUS_MISSING_RESOURCE: Integer read _GetSTATUS_MISSING_RESOURCE;
    {class} property STATUS_NO_ERROR: Integer read _GetSTATUS_NO_ERROR;
    {class} property STATUS_NO_SUCH_ELEMENT: Integer read _GetSTATUS_NO_SUCH_ELEMENT;
    {class} property STATUS_UNKNOWN_ERROR: Integer read _GetSTATUS_UNKNOWN_ERROR;
  end;

  [JavaSignature('android/telephony/IccOpenLogicalChannelResponse')]
  JIccOpenLogicalChannelResponse = interface(JObject)
    ['{75F3CEEA-52CC-4693-8E6A-264831D23AC9}']
    function describeContents: Integer; cdecl;
    function getChannel: Integer; cdecl;
    function getSelectResponse: TJavaArray<Byte>; cdecl;
    function getStatus: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJIccOpenLogicalChannelResponse = class(TJavaGenericImport<JIccOpenLogicalChannelResponseClass, JIccOpenLogicalChannelResponse>) end;

  JNeighboringCellInfoClass = interface(JObjectClass)
    ['{EB3E8F37-13C7-4E29-9015-FE80FD8BD4A7}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetUNKNOWN_CID: Integer; cdecl;
    {class} function _GetUNKNOWN_RSSI: Integer; cdecl;
    {class} function init: JNeighboringCellInfo; cdecl; overload;//Deprecated
    {class} function init(rssi: Integer; cid: Integer): JNeighboringCellInfo; cdecl; overload;//Deprecated
    {class} function init(rssi: Integer; location: JString; radioType: Integer): JNeighboringCellInfo; cdecl; overload;
    {class} function init(in_: JParcel): JNeighboringCellInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property UNKNOWN_CID: Integer read _GetUNKNOWN_CID;
    {class} property UNKNOWN_RSSI: Integer read _GetUNKNOWN_RSSI;
  end;

  [JavaSignature('android/telephony/NeighboringCellInfo')]
  JNeighboringCellInfo = interface(JObject)
    ['{8BF5BF7B-3E55-4C97-A2A5-11C1D079EF73}']
    function describeContents: Integer; cdecl;
    function getCid: Integer; cdecl;
    function getLac: Integer; cdecl;
    function getNetworkType: Integer; cdecl;
    function getPsc: Integer; cdecl;
    function getRssi: Integer; cdecl;
    procedure setCid(cid: Integer); cdecl;//Deprecated
    procedure setRssi(rssi: Integer); cdecl;//Deprecated
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJNeighboringCellInfo = class(TJavaGenericImport<JNeighboringCellInfoClass, JNeighboringCellInfo>) end;

  JPhoneNumberFormattingTextWatcherClass = interface(JObjectClass)
    ['{41B14776-2EE7-4DE2-8E4E-C1E936C866C1}']
    {class} function init: JPhoneNumberFormattingTextWatcher; cdecl; overload;
    {class} function init(countryCode: JString): JPhoneNumberFormattingTextWatcher; cdecl; overload;
  end;

  [JavaSignature('android/telephony/PhoneNumberFormattingTextWatcher')]
  JPhoneNumberFormattingTextWatcher = interface(JObject)
    ['{891E6B45-DD52-484F-8E52-5F5272FC56DC}']
    procedure afterTextChanged(s: JEditable); cdecl;
    procedure beforeTextChanged(s: JCharSequence; start: Integer; count: Integer; after: Integer); cdecl;
    procedure onTextChanged(s: JCharSequence; start: Integer; before: Integer; count: Integer); cdecl;
  end;
  TJPhoneNumberFormattingTextWatcher = class(TJavaGenericImport<JPhoneNumberFormattingTextWatcherClass, JPhoneNumberFormattingTextWatcher>) end;

  JPhoneNumberUtilsClass = interface(JObjectClass)
    ['{B641F06B-F83E-4853-BAA9-1939B5B5C231}']
    {class} function _GetFORMAT_JAPAN: Integer; cdecl;
    {class} function _GetFORMAT_NANP: Integer; cdecl;
    {class} function _GetFORMAT_UNKNOWN: Integer; cdecl;
    {class} function _GetPAUSE: Char; cdecl;
    {class} function _GetTOA_International: Integer; cdecl;
    {class} function _GetTOA_Unknown: Integer; cdecl;
    {class} function _GetWAIT: Char; cdecl;
    {class} function _GetWILD: Char; cdecl;
    {class} function init: JPhoneNumberUtils; cdecl;
    {class} procedure addTtsSpan(s: JSpannable; start: Integer; endExclusive: Integer); cdecl;
    {class} function calledPartyBCDFragmentToString(bytes: TJavaArray<Byte>; offset: Integer; length: Integer): JString; cdecl;
    {class} function calledPartyBCDToString(bytes: TJavaArray<Byte>; offset: Integer; length: Integer): JString; cdecl;
    {class} function compare(a: JString; b: JString): Boolean; cdecl; overload;
    {class} function compare(context: JContext; a: JString; b: JString): Boolean; cdecl; overload;
    {class} function convertKeypadLettersToDigits(input: JString): JString; cdecl;
    {class} function createTtsSpan(phoneNumberString: JString): JTtsSpan; cdecl;
    {class} function createTtsSpannable(phoneNumber: JCharSequence): JCharSequence; cdecl;
    {class} function extractNetworkPortion(phoneNumber: JString): JString; cdecl;
    {class} function extractPostDialPortion(phoneNumber: JString): JString; cdecl;
    {class} procedure formatJapaneseNumber(text: JEditable); cdecl;//Deprecated
    {class} procedure formatNanpNumber(text: JEditable); cdecl;//Deprecated
    {class} function formatNumber(source: JString): JString; cdecl; overload;//Deprecated
    {class} procedure formatNumber(text: JEditable; defaultFormattingType: Integer); cdecl; overload;//Deprecated
    {class} function formatNumber(phoneNumber: JString; defaultCountryIso: JString): JString; cdecl; overload;
    {class} function formatNumber(phoneNumber: JString; phoneNumberE164: JString; defaultCountryIso: JString): JString; cdecl; overload;
    {class} function formatNumberToE164(phoneNumber: JString; defaultCountryIso: JString): JString; cdecl;
    {class} function formatNumberToRFC3966(phoneNumber: JString; defaultCountryIso: JString): JString; cdecl;
    {class} function getFormatTypeForLocale(locale: JLocale): Integer; cdecl;//Deprecated
    {class} function getNumberFromIntent(intent: JIntent; context: JContext): JString; cdecl;
    {class} function getStrippedReversed(phoneNumber: JString): JString; cdecl;
    {class} function is12Key(c: Char): Boolean; cdecl;
    {class} function isDialable(c: Char): Boolean; cdecl;
    {class} function isEmergencyNumber(number: JString): Boolean; cdecl;
    {class} function isGlobalPhoneNumber(phoneNumber: JString): Boolean; cdecl;
    {class} function isISODigit(c: Char): Boolean; cdecl;
    {class} function isLocalEmergencyNumber(context: JContext; number: JString): Boolean; cdecl;
    {class} function isNonSeparator(c: Char): Boolean; cdecl;
    {class} function isReallyDialable(c: Char): Boolean; cdecl;
    {class} function isStartsPostDial(c: Char): Boolean; cdecl;
    {class} function isVoiceMailNumber(number: JString): Boolean; cdecl;
    {class} function isWellFormedSmsAddress(address: JString): Boolean; cdecl;
    {class} function networkPortionToCalledPartyBCD(s: JString): TJavaArray<Byte>; cdecl;
    {class} function networkPortionToCalledPartyBCDWithLength(s: JString): TJavaArray<Byte>; cdecl;
    {class} function normalizeNumber(phoneNumber: JString): JString; cdecl;
    {class} function numberToCalledPartyBCD(number: JString): TJavaArray<Byte>; cdecl;
    {class} function replaceUnicodeDigits(number: JString): JString; cdecl;
    {class} function stringFromStringAndTOA(s: JString; TOA: Integer): JString; cdecl;
    {class} function stripSeparators(phoneNumber: JString): JString; cdecl;
    {class} function toCallerIDMinMatch(phoneNumber: JString): JString; cdecl;
    {class} function toaFromString(s: JString): Integer; cdecl;
    {class} property FORMAT_JAPAN: Integer read _GetFORMAT_JAPAN;
    {class} property FORMAT_NANP: Integer read _GetFORMAT_NANP;
    {class} property FORMAT_UNKNOWN: Integer read _GetFORMAT_UNKNOWN;
    {class} property PAUSE: Char read _GetPAUSE;
    {class} property TOA_International: Integer read _GetTOA_International;
    {class} property TOA_Unknown: Integer read _GetTOA_Unknown;
    {class} property WAIT: Char read _GetWAIT;
    {class} property WILD: Char read _GetWILD;
  end;

  [JavaSignature('android/telephony/PhoneNumberUtils')]
  JPhoneNumberUtils = interface(JObject)
    ['{8217405F-564B-4CA0-AF0A-3FEEE87A0444}']
  end;
  TJPhoneNumberUtils = class(TJavaGenericImport<JPhoneNumberUtilsClass, JPhoneNumberUtils>) end;

  JServiceStateClass = interface(JObjectClass)
    ['{5E369BCE-8950-478C-88C1-1612B0C7999C}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetSTATE_EMERGENCY_ONLY: Integer; cdecl;
    {class} function _GetSTATE_IN_SERVICE: Integer; cdecl;
    {class} function _GetSTATE_OUT_OF_SERVICE: Integer; cdecl;
    {class} function _GetSTATE_POWER_OFF: Integer; cdecl;
    {class} function init: JServiceState; cdecl; overload;
    {class} function init(s: JServiceState): JServiceState; cdecl; overload;
    {class} function init(in_: JParcel): JServiceState; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property STATE_EMERGENCY_ONLY: Integer read _GetSTATE_EMERGENCY_ONLY;
    {class} property STATE_IN_SERVICE: Integer read _GetSTATE_IN_SERVICE;
    {class} property STATE_OUT_OF_SERVICE: Integer read _GetSTATE_OUT_OF_SERVICE;
    {class} property STATE_POWER_OFF: Integer read _GetSTATE_POWER_OFF;
  end;

  [JavaSignature('android/telephony/ServiceState')]
  JServiceState = interface(JObject)
    ['{981444BD-E25C-4943-97AE-C21D85913DEF}']
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getIsManualSelection: Boolean; cdecl;
    function getOperatorAlphaLong: JString; cdecl;
    function getOperatorAlphaShort: JString; cdecl;
    function getOperatorNumeric: JString; cdecl;
    function getRoaming: Boolean; cdecl;
    function getState: Integer; cdecl;
    function hashCode: Integer; cdecl;
    procedure setIsManualSelection(isManual: Boolean); cdecl;
    procedure setOperatorName(longName: JString; shortName: JString; numeric: JString); cdecl;
    procedure setRoaming(roaming: Boolean); cdecl;
    procedure setState(state: Integer); cdecl;
    procedure setStateOff; cdecl;
    procedure setStateOutOfService; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJServiceState = class(TJavaGenericImport<JServiceStateClass, JServiceState>) end;

  JSignalStrengthClass = interface(JObjectClass)
    ['{C579E9F5-9291-4F6F-B4BE-8C8522EE8C5E}']
  end;

  [JavaSignature('android/telephony/SignalStrength')]
  JSignalStrength = interface(JObject)
    ['{1260215B-42EC-4F73-8FFB-168FABD93E9A}']
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getCdmaDbm: Integer; cdecl;
    function getCdmaEcio: Integer; cdecl;
    function getEvdoDbm: Integer; cdecl;
    function getEvdoEcio: Integer; cdecl;
    function getEvdoSnr: Integer; cdecl;
    function getGsmBitErrorRate: Integer; cdecl;
    function getGsmSignalStrength: Integer; cdecl;
    function getLevel: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function isGsm: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJSignalStrength = class(TJavaGenericImport<JSignalStrengthClass, JSignalStrength>) end;

  JSmsManagerClass = interface(JObjectClass)
    ['{5FD2ABA7-01A0-4AA1-BDE6-B125CD6A6752}']
    {class} function _GetEXTRA_MMS_DATA: JString; cdecl;
    {class} function _GetEXTRA_MMS_HTTP_STATUS: JString; cdecl;
    {class} function _GetMMS_CONFIG_ALIAS_ENABLED: JString; cdecl;
    {class} function _GetMMS_CONFIG_ALIAS_MAX_CHARS: JString; cdecl;
    {class} function _GetMMS_CONFIG_ALIAS_MIN_CHARS: JString; cdecl;
    {class} function _GetMMS_CONFIG_ALLOW_ATTACH_AUDIO: JString; cdecl;
    {class} function _GetMMS_CONFIG_APPEND_TRANSACTION_ID: JString; cdecl;
    {class} function _GetMMS_CONFIG_EMAIL_GATEWAY_NUMBER: JString; cdecl;
    {class} function _GetMMS_CONFIG_GROUP_MMS_ENABLED: JString; cdecl;
    {class} function _GetMMS_CONFIG_HTTP_PARAMS: JString; cdecl;
    {class} function _GetMMS_CONFIG_HTTP_SOCKET_TIMEOUT: JString; cdecl;
    {class} function _GetMMS_CONFIG_MAX_IMAGE_HEIGHT: JString; cdecl;
    {class} function _GetMMS_CONFIG_MAX_IMAGE_WIDTH: JString; cdecl;
    {class} function _GetMMS_CONFIG_MAX_MESSAGE_SIZE: JString; cdecl;
    {class} function _GetMMS_CONFIG_MESSAGE_TEXT_MAX_SIZE: JString; cdecl;
    {class} function _GetMMS_CONFIG_MMS_DELIVERY_REPORT_ENABLED: JString; cdecl;
    {class} function _GetMMS_CONFIG_MMS_ENABLED: JString; cdecl;
    {class} function _GetMMS_CONFIG_MMS_READ_REPORT_ENABLED: JString; cdecl;
    {class} function _GetMMS_CONFIG_MULTIPART_SMS_ENABLED: JString; cdecl;
    {class} function _GetMMS_CONFIG_NAI_SUFFIX: JString; cdecl;
    {class} function _GetMMS_CONFIG_NOTIFY_WAP_MMSC_ENABLED: JString; cdecl;
    {class} function _GetMMS_CONFIG_RECIPIENT_LIMIT: JString; cdecl;
    {class} function _GetMMS_CONFIG_SEND_MULTIPART_SMS_AS_SEPARATE_MESSAGES: JString; cdecl;
    {class} function _GetMMS_CONFIG_SHOW_CELL_BROADCAST_APP_LINKS: JString; cdecl;
    {class} function _GetMMS_CONFIG_SMS_DELIVERY_REPORT_ENABLED: JString; cdecl;
    {class} function _GetMMS_CONFIG_SMS_TO_MMS_TEXT_LENGTH_THRESHOLD: JString; cdecl;
    {class} function _GetMMS_CONFIG_SMS_TO_MMS_TEXT_THRESHOLD: JString; cdecl;
    {class} function _GetMMS_CONFIG_SUBJECT_MAX_LENGTH: JString; cdecl;
    {class} function _GetMMS_CONFIG_SUPPORT_HTTP_CHARSET_HEADER: JString; cdecl;
    {class} function _GetMMS_CONFIG_SUPPORT_MMS_CONTENT_DISPOSITION: JString; cdecl;
    {class} function _GetMMS_CONFIG_UA_PROF_TAG_NAME: JString; cdecl;
    {class} function _GetMMS_CONFIG_UA_PROF_URL: JString; cdecl;
    {class} function _GetMMS_CONFIG_USER_AGENT: JString; cdecl;
    {class} function _GetMMS_ERROR_CONFIGURATION_ERROR: Integer; cdecl;
    {class} function _GetMMS_ERROR_HTTP_FAILURE: Integer; cdecl;
    {class} function _GetMMS_ERROR_INVALID_APN: Integer; cdecl;
    {class} function _GetMMS_ERROR_IO_ERROR: Integer; cdecl;
    {class} function _GetMMS_ERROR_NO_DATA_NETWORK: Integer; cdecl;
    {class} function _GetMMS_ERROR_RETRY: Integer; cdecl;
    {class} function _GetMMS_ERROR_UNABLE_CONNECT_MMS: Integer; cdecl;
    {class} function _GetMMS_ERROR_UNSPECIFIED: Integer; cdecl;
    {class} function _GetRESULT_ERROR_GENERIC_FAILURE: Integer; cdecl;
    {class} function _GetRESULT_ERROR_NO_SERVICE: Integer; cdecl;
    {class} function _GetRESULT_ERROR_NULL_PDU: Integer; cdecl;
    {class} function _GetRESULT_ERROR_RADIO_OFF: Integer; cdecl;
    {class} function _GetSTATUS_ON_ICC_FREE: Integer; cdecl;
    {class} function _GetSTATUS_ON_ICC_READ: Integer; cdecl;
    {class} function _GetSTATUS_ON_ICC_SENT: Integer; cdecl;
    {class} function _GetSTATUS_ON_ICC_UNREAD: Integer; cdecl;
    {class} function _GetSTATUS_ON_ICC_UNSENT: Integer; cdecl;
    {class} function getDefault: JSmsManager; cdecl;
    {class} function getDefaultSmsSubscriptionId: Integer; cdecl;
    {class} function getSmsManagerForSubscriptionId(subId: Integer): JSmsManager; cdecl;
    {class} property EXTRA_MMS_DATA: JString read _GetEXTRA_MMS_DATA;
    {class} property EXTRA_MMS_HTTP_STATUS: JString read _GetEXTRA_MMS_HTTP_STATUS;
    {class} property MMS_CONFIG_ALIAS_ENABLED: JString read _GetMMS_CONFIG_ALIAS_ENABLED;
    {class} property MMS_CONFIG_ALIAS_MAX_CHARS: JString read _GetMMS_CONFIG_ALIAS_MAX_CHARS;
    {class} property MMS_CONFIG_ALIAS_MIN_CHARS: JString read _GetMMS_CONFIG_ALIAS_MIN_CHARS;
    {class} property MMS_CONFIG_ALLOW_ATTACH_AUDIO: JString read _GetMMS_CONFIG_ALLOW_ATTACH_AUDIO;
    {class} property MMS_CONFIG_APPEND_TRANSACTION_ID: JString read _GetMMS_CONFIG_APPEND_TRANSACTION_ID;
    {class} property MMS_CONFIG_EMAIL_GATEWAY_NUMBER: JString read _GetMMS_CONFIG_EMAIL_GATEWAY_NUMBER;
    {class} property MMS_CONFIG_GROUP_MMS_ENABLED: JString read _GetMMS_CONFIG_GROUP_MMS_ENABLED;
    {class} property MMS_CONFIG_HTTP_PARAMS: JString read _GetMMS_CONFIG_HTTP_PARAMS;
    {class} property MMS_CONFIG_HTTP_SOCKET_TIMEOUT: JString read _GetMMS_CONFIG_HTTP_SOCKET_TIMEOUT;
    {class} property MMS_CONFIG_MAX_IMAGE_HEIGHT: JString read _GetMMS_CONFIG_MAX_IMAGE_HEIGHT;
    {class} property MMS_CONFIG_MAX_IMAGE_WIDTH: JString read _GetMMS_CONFIG_MAX_IMAGE_WIDTH;
    {class} property MMS_CONFIG_MAX_MESSAGE_SIZE: JString read _GetMMS_CONFIG_MAX_MESSAGE_SIZE;
    {class} property MMS_CONFIG_MESSAGE_TEXT_MAX_SIZE: JString read _GetMMS_CONFIG_MESSAGE_TEXT_MAX_SIZE;
    {class} property MMS_CONFIG_MMS_DELIVERY_REPORT_ENABLED: JString read _GetMMS_CONFIG_MMS_DELIVERY_REPORT_ENABLED;
    {class} property MMS_CONFIG_MMS_ENABLED: JString read _GetMMS_CONFIG_MMS_ENABLED;
    {class} property MMS_CONFIG_MMS_READ_REPORT_ENABLED: JString read _GetMMS_CONFIG_MMS_READ_REPORT_ENABLED;
    {class} property MMS_CONFIG_MULTIPART_SMS_ENABLED: JString read _GetMMS_CONFIG_MULTIPART_SMS_ENABLED;
    {class} property MMS_CONFIG_NAI_SUFFIX: JString read _GetMMS_CONFIG_NAI_SUFFIX;
    {class} property MMS_CONFIG_NOTIFY_WAP_MMSC_ENABLED: JString read _GetMMS_CONFIG_NOTIFY_WAP_MMSC_ENABLED;
    {class} property MMS_CONFIG_RECIPIENT_LIMIT: JString read _GetMMS_CONFIG_RECIPIENT_LIMIT;
    {class} property MMS_CONFIG_SEND_MULTIPART_SMS_AS_SEPARATE_MESSAGES: JString read _GetMMS_CONFIG_SEND_MULTIPART_SMS_AS_SEPARATE_MESSAGES;
    {class} property MMS_CONFIG_SHOW_CELL_BROADCAST_APP_LINKS: JString read _GetMMS_CONFIG_SHOW_CELL_BROADCAST_APP_LINKS;
    {class} property MMS_CONFIG_SMS_DELIVERY_REPORT_ENABLED: JString read _GetMMS_CONFIG_SMS_DELIVERY_REPORT_ENABLED;
    {class} property MMS_CONFIG_SMS_TO_MMS_TEXT_LENGTH_THRESHOLD: JString read _GetMMS_CONFIG_SMS_TO_MMS_TEXT_LENGTH_THRESHOLD;
    {class} property MMS_CONFIG_SMS_TO_MMS_TEXT_THRESHOLD: JString read _GetMMS_CONFIG_SMS_TO_MMS_TEXT_THRESHOLD;
    {class} property MMS_CONFIG_SUBJECT_MAX_LENGTH: JString read _GetMMS_CONFIG_SUBJECT_MAX_LENGTH;
    {class} property MMS_CONFIG_SUPPORT_HTTP_CHARSET_HEADER: JString read _GetMMS_CONFIG_SUPPORT_HTTP_CHARSET_HEADER;
    {class} property MMS_CONFIG_SUPPORT_MMS_CONTENT_DISPOSITION: JString read _GetMMS_CONFIG_SUPPORT_MMS_CONTENT_DISPOSITION;
    {class} property MMS_CONFIG_UA_PROF_TAG_NAME: JString read _GetMMS_CONFIG_UA_PROF_TAG_NAME;
    {class} property MMS_CONFIG_UA_PROF_URL: JString read _GetMMS_CONFIG_UA_PROF_URL;
    {class} property MMS_CONFIG_USER_AGENT: JString read _GetMMS_CONFIG_USER_AGENT;
    {class} property MMS_ERROR_CONFIGURATION_ERROR: Integer read _GetMMS_ERROR_CONFIGURATION_ERROR;
    {class} property MMS_ERROR_HTTP_FAILURE: Integer read _GetMMS_ERROR_HTTP_FAILURE;
    {class} property MMS_ERROR_INVALID_APN: Integer read _GetMMS_ERROR_INVALID_APN;
    {class} property MMS_ERROR_IO_ERROR: Integer read _GetMMS_ERROR_IO_ERROR;
    {class} property MMS_ERROR_NO_DATA_NETWORK: Integer read _GetMMS_ERROR_NO_DATA_NETWORK;
    {class} property MMS_ERROR_RETRY: Integer read _GetMMS_ERROR_RETRY;
    {class} property MMS_ERROR_UNABLE_CONNECT_MMS: Integer read _GetMMS_ERROR_UNABLE_CONNECT_MMS;
    {class} property MMS_ERROR_UNSPECIFIED: Integer read _GetMMS_ERROR_UNSPECIFIED;
    {class} property RESULT_ERROR_GENERIC_FAILURE: Integer read _GetRESULT_ERROR_GENERIC_FAILURE;
    {class} property RESULT_ERROR_NO_SERVICE: Integer read _GetRESULT_ERROR_NO_SERVICE;
    {class} property RESULT_ERROR_NULL_PDU: Integer read _GetRESULT_ERROR_NULL_PDU;
    {class} property RESULT_ERROR_RADIO_OFF: Integer read _GetRESULT_ERROR_RADIO_OFF;
    {class} property STATUS_ON_ICC_FREE: Integer read _GetSTATUS_ON_ICC_FREE;
    {class} property STATUS_ON_ICC_READ: Integer read _GetSTATUS_ON_ICC_READ;
    {class} property STATUS_ON_ICC_SENT: Integer read _GetSTATUS_ON_ICC_SENT;
    {class} property STATUS_ON_ICC_UNREAD: Integer read _GetSTATUS_ON_ICC_UNREAD;
    {class} property STATUS_ON_ICC_UNSENT: Integer read _GetSTATUS_ON_ICC_UNSENT;
  end;

  [JavaSignature('android/telephony/SmsManager')]
  JSmsManager = interface(JObject)
    ['{8C75DE6B-0BC5-4B5B-9B70-E714A01033E0}']
    function divideMessage(text: JString): JArrayList; cdecl;
    procedure downloadMultimediaMessage(context: JContext; locationUrl: JString; contentUri: Jnet_Uri; configOverrides: JBundle; downloadedIntent: JPendingIntent); cdecl;
    function getCarrierConfigValues: JBundle; cdecl;
    function getSubscriptionId: Integer; cdecl;
    procedure injectSmsPdu(pdu: TJavaArray<Byte>; format: JString; receivedIntent: JPendingIntent); cdecl;
    procedure sendDataMessage(destinationAddress: JString; scAddress: JString; destinationPort: SmallInt; data: TJavaArray<Byte>; sentIntent: JPendingIntent; deliveryIntent: JPendingIntent); cdecl;
    procedure sendMultimediaMessage(context: JContext; contentUri: Jnet_Uri; locationUrl: JString; configOverrides: JBundle; sentIntent: JPendingIntent); cdecl;
    procedure sendMultipartTextMessage(destinationAddress: JString; scAddress: JString; parts: JArrayList; sentIntents: JArrayList; deliveryIntents: JArrayList); cdecl;
    procedure sendTextMessage(destinationAddress: JString; scAddress: JString; text: JString; sentIntent: JPendingIntent; deliveryIntent: JPendingIntent); cdecl;
  end;
  TJSmsManager = class(TJavaGenericImport<JSmsManagerClass, JSmsManager>) end;

  JSmsMessageClass = interface(JObjectClass)
    ['{227C1E7B-3064-474A-8930-D244309E7D27}']
    {class} function _GetENCODING_16BIT: Integer; cdecl;
    {class} function _GetENCODING_7BIT: Integer; cdecl;
    {class} function _GetENCODING_8BIT: Integer; cdecl;
    {class} function _GetENCODING_UNKNOWN: Integer; cdecl;
    {class} function _GetMAX_USER_DATA_BYTES: Integer; cdecl;
    {class} function _GetMAX_USER_DATA_BYTES_WITH_HEADER: Integer; cdecl;
    {class} function _GetMAX_USER_DATA_SEPTETS: Integer; cdecl;
    {class} function _GetMAX_USER_DATA_SEPTETS_WITH_HEADER: Integer; cdecl;
    {class} function calculateLength(msgBody: JCharSequence; use7bitOnly: Boolean): TJavaArray<Integer>; cdecl; overload;
    {class} function calculateLength(messageBody: JString; use7bitOnly: Boolean): TJavaArray<Integer>; cdecl; overload;
    {class} function createFromPdu(pdu: TJavaArray<Byte>): JSmsMessage; cdecl; overload;//Deprecated
    {class} function createFromPdu(pdu: TJavaArray<Byte>; format: JString): JSmsMessage; cdecl; overload;
    {class} function getSubmitPdu(scAddress: JString; destinationAddress: JString; message: JString; statusReportRequested: Boolean): JSmsMessage_SubmitPdu; cdecl; overload;
    {class} function getSubmitPdu(scAddress: JString; destinationAddress: JString; destinationPort: SmallInt; data: TJavaArray<Byte>; statusReportRequested: Boolean): JSmsMessage_SubmitPdu; cdecl; overload;
    {class} function getTPLayerLengthForPDU(pdu: JString): Integer; cdecl;
    {class} property ENCODING_16BIT: Integer read _GetENCODING_16BIT;
    {class} property ENCODING_7BIT: Integer read _GetENCODING_7BIT;
    {class} property ENCODING_8BIT: Integer read _GetENCODING_8BIT;
    {class} property ENCODING_UNKNOWN: Integer read _GetENCODING_UNKNOWN;
    {class} property MAX_USER_DATA_BYTES: Integer read _GetMAX_USER_DATA_BYTES;
    {class} property MAX_USER_DATA_BYTES_WITH_HEADER: Integer read _GetMAX_USER_DATA_BYTES_WITH_HEADER;
    {class} property MAX_USER_DATA_SEPTETS: Integer read _GetMAX_USER_DATA_SEPTETS;
    {class} property MAX_USER_DATA_SEPTETS_WITH_HEADER: Integer read _GetMAX_USER_DATA_SEPTETS_WITH_HEADER;
  end;

  [JavaSignature('android/telephony/SmsMessage')]
  JSmsMessage = interface(JObject)
    ['{012AA641-B8DD-4F6A-9056-98498FB0B05C}']
    function getDisplayMessageBody: JString; cdecl;
    function getDisplayOriginatingAddress: JString; cdecl;
    function getEmailBody: JString; cdecl;
    function getEmailFrom: JString; cdecl;
    function getIndexOnIcc: Integer; cdecl;
    function getIndexOnSim: Integer; cdecl;//Deprecated
    function getMessageBody: JString; cdecl;
    function getMessageClass: JSmsMessage_MessageClass; cdecl;
    function getOriginatingAddress: JString; cdecl;
    function getPdu: TJavaArray<Byte>; cdecl;
    function getProtocolIdentifier: Integer; cdecl;
    function getPseudoSubject: JString; cdecl;
    function getServiceCenterAddress: JString; cdecl;
    function getStatus: Integer; cdecl;
    function getStatusOnIcc: Integer; cdecl;
    function getStatusOnSim: Integer; cdecl;//Deprecated
    function getTimestampMillis: Int64; cdecl;
    function getUserData: TJavaArray<Byte>; cdecl;
    function isCphsMwiMessage: Boolean; cdecl;
    function isEmail: Boolean; cdecl;
    function isMWIClearMessage: Boolean; cdecl;
    function isMWISetMessage: Boolean; cdecl;
    function isMwiDontStore: Boolean; cdecl;
    function isReplace: Boolean; cdecl;
    function isReplyPathPresent: Boolean; cdecl;
    function isStatusReportMessage: Boolean; cdecl;
  end;
  TJSmsMessage = class(TJavaGenericImport<JSmsMessageClass, JSmsMessage>) end;

  JSmsMessage_MessageClassClass = interface(JEnumClass)
    ['{02240F3E-83D9-4ED3-9C44-6F739AD319F1}']
    {class} function _GetCLASS_0: JSmsMessage_MessageClass; cdecl;
    {class} function _GetCLASS_1: JSmsMessage_MessageClass; cdecl;
    {class} function _GetCLASS_2: JSmsMessage_MessageClass; cdecl;
    {class} function _GetCLASS_3: JSmsMessage_MessageClass; cdecl;
    {class} function _GetUNKNOWN: JSmsMessage_MessageClass; cdecl;
    {class} function valueOf(name: JString): JSmsMessage_MessageClass; cdecl;
    {class} function values: TJavaObjectArray<JSmsMessage_MessageClass>; cdecl;
    {class} property CLASS_0: JSmsMessage_MessageClass read _GetCLASS_0;
    {class} property CLASS_1: JSmsMessage_MessageClass read _GetCLASS_1;
    {class} property CLASS_2: JSmsMessage_MessageClass read _GetCLASS_2;
    {class} property CLASS_3: JSmsMessage_MessageClass read _GetCLASS_3;
    {class} property UNKNOWN: JSmsMessage_MessageClass read _GetUNKNOWN;
  end;

  [JavaSignature('android/telephony/SmsMessage$MessageClass')]
  JSmsMessage_MessageClass = interface(JEnum)
    ['{A7AA6F95-590D-48F9-9EAD-7DEF27FB0AD3}']
  end;
  TJSmsMessage_MessageClass = class(TJavaGenericImport<JSmsMessage_MessageClassClass, JSmsMessage_MessageClass>) end;

  JSmsMessage_SubmitPduClass = interface(JObjectClass)
    ['{3B92B0B3-1E7C-418F-B5DD-222AD433A5AC}']
  end;

  [JavaSignature('android/telephony/SmsMessage$SubmitPdu')]
  JSmsMessage_SubmitPdu = interface(JObject)
    ['{D69C5B7B-6E92-4599-A3ED-EBB174FEDB68}']
    function _GetencodedMessage: TJavaArray<Byte>; cdecl;
    procedure _SetencodedMessage(Value: TJavaArray<Byte>); cdecl;
    function _GetencodedScAddress: TJavaArray<Byte>; cdecl;
    procedure _SetencodedScAddress(Value: TJavaArray<Byte>); cdecl;
    function toString: JString; cdecl;
    property encodedMessage: TJavaArray<Byte> read _GetencodedMessage write _SetencodedMessage;
    property encodedScAddress: TJavaArray<Byte> read _GetencodedScAddress write _SetencodedScAddress;
  end;
  TJSmsMessage_SubmitPdu = class(TJavaGenericImport<JSmsMessage_SubmitPduClass, JSmsMessage_SubmitPdu>) end;

  JSubscriptionInfoClass = interface(JObjectClass)
    ['{1ECF5C35-07D4-477C-96B9-6F00EC3944B6}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/telephony/SubscriptionInfo')]
  JSubscriptionInfo = interface(JObject)
    ['{2B00AA07-B712-4597-8FA6-05EBB3B1C58E}']
    function createIconBitmap(context: JContext): JBitmap; cdecl;
    function describeContents: Integer; cdecl;
    function getCarrierName: JCharSequence; cdecl;
    function getCountryIso: JString; cdecl;
    function getDataRoaming: Integer; cdecl;
    function getDisplayName: JCharSequence; cdecl;
    function getIccId: JString; cdecl;
    function getIconTint: Integer; cdecl;
    function getMcc: Integer; cdecl;
    function getMnc: Integer; cdecl;
    function getNumber: JString; cdecl;
    function getSimSlotIndex: Integer; cdecl;
    function getSubscriptionId: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJSubscriptionInfo = class(TJavaGenericImport<JSubscriptionInfoClass, JSubscriptionInfo>) end;

  JSubscriptionManagerClass = interface(JObjectClass)
    ['{119324F9-C6B0-4E89-94F1-0EAB9CA0287E}']
    {class} function _GetDATA_ROAMING_DISABLE: Integer; cdecl;
    {class} function _GetDATA_ROAMING_ENABLE: Integer; cdecl;
    {class} function from(context: JContext): JSubscriptionManager; cdecl;
    {class} property DATA_ROAMING_DISABLE: Integer read _GetDATA_ROAMING_DISABLE;
    {class} property DATA_ROAMING_ENABLE: Integer read _GetDATA_ROAMING_ENABLE;
  end;

  [JavaSignature('android/telephony/SubscriptionManager')]
  JSubscriptionManager = interface(JObject)
    ['{0029EBE7-5EF6-4C05-A608-8BB19F2FB263}']
    procedure addOnSubscriptionsChangedListener(listener: JSubscriptionManager_OnSubscriptionsChangedListener); cdecl;
    function getActiveSubscriptionInfo(subId: Integer): JSubscriptionInfo; cdecl;
    function getActiveSubscriptionInfoCount: Integer; cdecl;
    function getActiveSubscriptionInfoCountMax: Integer; cdecl;
    function getActiveSubscriptionInfoForSimSlotIndex(slotIdx: Integer): JSubscriptionInfo; cdecl;
    function getActiveSubscriptionInfoList: JList; cdecl;
    function isNetworkRoaming(subId: Integer): Boolean; cdecl;
    procedure removeOnSubscriptionsChangedListener(listener: JSubscriptionManager_OnSubscriptionsChangedListener); cdecl;
  end;
  TJSubscriptionManager = class(TJavaGenericImport<JSubscriptionManagerClass, JSubscriptionManager>) end;

  JSubscriptionManager_OnSubscriptionsChangedListenerClass = interface(JObjectClass)
    ['{F2559847-2FB4-4AE0-90CB-7FF3B0D44875}']
    {class} function init: JSubscriptionManager_OnSubscriptionsChangedListener; cdecl;
  end;

  [JavaSignature('android/telephony/SubscriptionManager$OnSubscriptionsChangedListener')]
  JSubscriptionManager_OnSubscriptionsChangedListener = interface(JObject)
    ['{36F98257-7442-4AB5-8854-928260DC45BF}']
    procedure onSubscriptionsChanged; cdecl;
  end;
  TJSubscriptionManager_OnSubscriptionsChangedListener = class(TJavaGenericImport<JSubscriptionManager_OnSubscriptionsChangedListenerClass, JSubscriptionManager_OnSubscriptionsChangedListener>) end;

  JTelephonyManagerClass = interface(JObjectClass)
    ['{543679F3-38DC-4FCA-ADCD-648A27B9B5DD}']
    {class} function _GetACTION_CONFIGURE_VOICEMAIL: JString; cdecl;
    {class} function _GetACTION_PHONE_STATE_CHANGED: JString; cdecl;
    {class} function _GetACTION_RESPOND_VIA_MESSAGE: JString; cdecl;
    {class} function _GetCALL_STATE_IDLE: Integer; cdecl;
    {class} function _GetCALL_STATE_OFFHOOK: Integer; cdecl;
    {class} function _GetCALL_STATE_RINGING: Integer; cdecl;
    {class} function _GetDATA_ACTIVITY_DORMANT: Integer; cdecl;
    {class} function _GetDATA_ACTIVITY_IN: Integer; cdecl;
    {class} function _GetDATA_ACTIVITY_INOUT: Integer; cdecl;
    {class} function _GetDATA_ACTIVITY_NONE: Integer; cdecl;
    {class} function _GetDATA_ACTIVITY_OUT: Integer; cdecl;
    {class} function _GetDATA_CONNECTED: Integer; cdecl;
    {class} function _GetDATA_CONNECTING: Integer; cdecl;
    {class} function _GetDATA_DISCONNECTED: Integer; cdecl;
    {class} function _GetDATA_SUSPENDED: Integer; cdecl;
    {class} function _GetEXTRA_INCOMING_NUMBER: JString; cdecl;
    {class} function _GetEXTRA_STATE: JString; cdecl;
    {class} function _GetEXTRA_STATE_IDLE: JString; cdecl;
    {class} function _GetEXTRA_STATE_OFFHOOK: JString; cdecl;
    {class} function _GetEXTRA_STATE_RINGING: JString; cdecl;
    {class} function _GetNETWORK_TYPE_1xRTT: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_CDMA: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_EDGE: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_EHRPD: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_EVDO_0: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_EVDO_A: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_EVDO_B: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_GPRS: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_HSDPA: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_HSPA: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_HSPAP: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_HSUPA: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_IDEN: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_LTE: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_UMTS: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_UNKNOWN: Integer; cdecl;
    {class} function _GetPHONE_TYPE_CDMA: Integer; cdecl;
    {class} function _GetPHONE_TYPE_GSM: Integer; cdecl;
    {class} function _GetPHONE_TYPE_NONE: Integer; cdecl;
    {class} function _GetPHONE_TYPE_SIP: Integer; cdecl;
    {class} function _GetSIM_STATE_ABSENT: Integer; cdecl;
    {class} function _GetSIM_STATE_NETWORK_LOCKED: Integer; cdecl;
    {class} function _GetSIM_STATE_PIN_REQUIRED: Integer; cdecl;
    {class} function _GetSIM_STATE_PUK_REQUIRED: Integer; cdecl;
    {class} function _GetSIM_STATE_READY: Integer; cdecl;
    {class} function _GetSIM_STATE_UNKNOWN: Integer; cdecl;
    {class} function _GetVVM_TYPE_CVVM: JString; cdecl;
    {class} function _GetVVM_TYPE_OMTP: JString; cdecl;
    {class} property ACTION_CONFIGURE_VOICEMAIL: JString read _GetACTION_CONFIGURE_VOICEMAIL;
    {class} property ACTION_PHONE_STATE_CHANGED: JString read _GetACTION_PHONE_STATE_CHANGED;
    {class} property ACTION_RESPOND_VIA_MESSAGE: JString read _GetACTION_RESPOND_VIA_MESSAGE;
    {class} property CALL_STATE_IDLE: Integer read _GetCALL_STATE_IDLE;
    {class} property CALL_STATE_OFFHOOK: Integer read _GetCALL_STATE_OFFHOOK;
    {class} property CALL_STATE_RINGING: Integer read _GetCALL_STATE_RINGING;
    {class} property DATA_ACTIVITY_DORMANT: Integer read _GetDATA_ACTIVITY_DORMANT;
    {class} property DATA_ACTIVITY_IN: Integer read _GetDATA_ACTIVITY_IN;
    {class} property DATA_ACTIVITY_INOUT: Integer read _GetDATA_ACTIVITY_INOUT;
    {class} property DATA_ACTIVITY_NONE: Integer read _GetDATA_ACTIVITY_NONE;
    {class} property DATA_ACTIVITY_OUT: Integer read _GetDATA_ACTIVITY_OUT;
    {class} property DATA_CONNECTED: Integer read _GetDATA_CONNECTED;
    {class} property DATA_CONNECTING: Integer read _GetDATA_CONNECTING;
    {class} property DATA_DISCONNECTED: Integer read _GetDATA_DISCONNECTED;
    {class} property DATA_SUSPENDED: Integer read _GetDATA_SUSPENDED;
    {class} property EXTRA_INCOMING_NUMBER: JString read _GetEXTRA_INCOMING_NUMBER;
    {class} property EXTRA_STATE: JString read _GetEXTRA_STATE;
    {class} property EXTRA_STATE_IDLE: JString read _GetEXTRA_STATE_IDLE;
    {class} property EXTRA_STATE_OFFHOOK: JString read _GetEXTRA_STATE_OFFHOOK;
    {class} property EXTRA_STATE_RINGING: JString read _GetEXTRA_STATE_RINGING;
    {class} property NETWORK_TYPE_1xRTT: Integer read _GetNETWORK_TYPE_1xRTT;
    {class} property NETWORK_TYPE_CDMA: Integer read _GetNETWORK_TYPE_CDMA;
    {class} property NETWORK_TYPE_EDGE: Integer read _GetNETWORK_TYPE_EDGE;
    {class} property NETWORK_TYPE_EHRPD: Integer read _GetNETWORK_TYPE_EHRPD;
    {class} property NETWORK_TYPE_EVDO_0: Integer read _GetNETWORK_TYPE_EVDO_0;
    {class} property NETWORK_TYPE_EVDO_A: Integer read _GetNETWORK_TYPE_EVDO_A;
    {class} property NETWORK_TYPE_EVDO_B: Integer read _GetNETWORK_TYPE_EVDO_B;
    {class} property NETWORK_TYPE_GPRS: Integer read _GetNETWORK_TYPE_GPRS;
    {class} property NETWORK_TYPE_HSDPA: Integer read _GetNETWORK_TYPE_HSDPA;
    {class} property NETWORK_TYPE_HSPA: Integer read _GetNETWORK_TYPE_HSPA;
    {class} property NETWORK_TYPE_HSPAP: Integer read _GetNETWORK_TYPE_HSPAP;
    {class} property NETWORK_TYPE_HSUPA: Integer read _GetNETWORK_TYPE_HSUPA;
    {class} property NETWORK_TYPE_IDEN: Integer read _GetNETWORK_TYPE_IDEN;
    {class} property NETWORK_TYPE_LTE: Integer read _GetNETWORK_TYPE_LTE;
    {class} property NETWORK_TYPE_UMTS: Integer read _GetNETWORK_TYPE_UMTS;
    {class} property NETWORK_TYPE_UNKNOWN: Integer read _GetNETWORK_TYPE_UNKNOWN;
    {class} property PHONE_TYPE_CDMA: Integer read _GetPHONE_TYPE_CDMA;
    {class} property PHONE_TYPE_GSM: Integer read _GetPHONE_TYPE_GSM;
    {class} property PHONE_TYPE_NONE: Integer read _GetPHONE_TYPE_NONE;
    {class} property PHONE_TYPE_SIP: Integer read _GetPHONE_TYPE_SIP;
    {class} property SIM_STATE_ABSENT: Integer read _GetSIM_STATE_ABSENT;
    {class} property SIM_STATE_NETWORK_LOCKED: Integer read _GetSIM_STATE_NETWORK_LOCKED;
    {class} property SIM_STATE_PIN_REQUIRED: Integer read _GetSIM_STATE_PIN_REQUIRED;
    {class} property SIM_STATE_PUK_REQUIRED: Integer read _GetSIM_STATE_PUK_REQUIRED;
    {class} property SIM_STATE_READY: Integer read _GetSIM_STATE_READY;
    {class} property SIM_STATE_UNKNOWN: Integer read _GetSIM_STATE_UNKNOWN;
    {class} property VVM_TYPE_CVVM: JString read _GetVVM_TYPE_CVVM;
    {class} property VVM_TYPE_OMTP: JString read _GetVVM_TYPE_OMTP;
  end;

  [JavaSignature('android/telephony/TelephonyManager')]
  JTelephonyManager = interface(JObject)
    ['{7725226B-9F82-4BFA-B1DE-3960703BB92C}']
    function canChangeDtmfToneLength: Boolean; cdecl;
    function getAllCellInfo: JList; cdecl;
    function getCallState: Integer; cdecl;
    function getCellLocation: JCellLocation; cdecl;
    function getDataActivity: Integer; cdecl;
    function getDataState: Integer; cdecl;
    function getDeviceId: JString; cdecl; overload;
    function getDeviceId(slotId: Integer): JString; cdecl; overload;
    function getDeviceSoftwareVersion: JString; cdecl;
    function getGroupIdLevel1: JString; cdecl;
    function getLine1Number: JString; cdecl;
    function getMmsUAProfUrl: JString; cdecl;
    function getMmsUserAgent: JString; cdecl;
    function getNeighboringCellInfo: JList; cdecl;//Deprecated
    function getNetworkCountryIso: JString; cdecl;
    function getNetworkOperator: JString; cdecl;
    function getNetworkOperatorName: JString; cdecl;
    function getNetworkType: Integer; cdecl;
    function getPhoneCount: Integer; cdecl;
    function getPhoneType: Integer; cdecl;
    function getSimCountryIso: JString; cdecl;
    function getSimOperator: JString; cdecl;
    function getSimOperatorName: JString; cdecl;
    function getSimSerialNumber: JString; cdecl;
    function getSimState: Integer; cdecl;
    function getSubscriberId: JString; cdecl;
    function getVoiceMailAlphaTag: JString; cdecl;
    function getVoiceMailNumber: JString; cdecl;
    function hasCarrierPrivileges: Boolean; cdecl;
    function hasIccCard: Boolean; cdecl;
    function iccCloseLogicalChannel(channel: Integer): Boolean; cdecl;
    function iccExchangeSimIO(fileID: Integer; command: Integer; p1: Integer; p2: Integer; p3: Integer; filePath: JString): TJavaArray<Byte>; cdecl;
    function iccOpenLogicalChannel(AID: JString): JIccOpenLogicalChannelResponse; cdecl;
    function iccTransmitApduBasicChannel(cla: Integer; instruction: Integer; p1: Integer; p2: Integer; p3: Integer; data: JString): JString; cdecl;
    function iccTransmitApduLogicalChannel(channel: Integer; cla: Integer; instruction: Integer; p1: Integer; p2: Integer; p3: Integer; data: JString): JString; cdecl;
    function isHearingAidCompatibilitySupported: Boolean; cdecl;
    function isNetworkRoaming: Boolean; cdecl;
    function isSmsCapable: Boolean; cdecl;
    function isTtyModeSupported: Boolean; cdecl;
    function isVoiceCapable: Boolean; cdecl;
    function isWorldPhone: Boolean; cdecl;
    procedure listen(listener: JPhoneStateListener; events: Integer); cdecl;
    function sendEnvelopeWithStatus(content: JString): JString; cdecl;
    function setLine1NumberForDisplay(alphaTag: JString; number: JString): Boolean; cdecl;
    function setOperatorBrandOverride(brand: JString): Boolean; cdecl;
    function setPreferredNetworkTypeToGlobal: Boolean; cdecl;
    function setVoiceMailNumber(alphaTag: JString; number: JString): Boolean; cdecl;
  end;
  TJTelephonyManager = class(TJavaGenericImport<JTelephonyManagerClass, JTelephonyManager>) end;

  JCdmaCellLocationClass = interface(JCellLocationClass)
    ['{0287239E-831E-4687-B06D-87243B3FC994}']
    {class} function init: JCdmaCellLocation; cdecl; overload;
    {class} function init(bundle: JBundle): JCdmaCellLocation; cdecl; overload;
    {class} function convertQuartSecToDecDegrees(quartSec: Integer): Double; cdecl;
  end;

  [JavaSignature('android/telephony/cdma/CdmaCellLocation')]
  JCdmaCellLocation = interface(JCellLocation)
    ['{30F5155B-56EB-4449-A3B2-90BFE8F170EB}']
    function equals(o: JObject): Boolean; cdecl;
    procedure fillInNotifierBundle(bundleToFill: JBundle); cdecl;
    function getBaseStationId: Integer; cdecl;
    function getBaseStationLatitude: Integer; cdecl;
    function getBaseStationLongitude: Integer; cdecl;
    function getNetworkId: Integer; cdecl;
    function getSystemId: Integer; cdecl;
    function hashCode: Integer; cdecl;
    procedure setCellLocationData(baseStationId: Integer; baseStationLatitude: Integer; baseStationLongitude: Integer); cdecl; overload;
    procedure setCellLocationData(baseStationId: Integer; baseStationLatitude: Integer; baseStationLongitude: Integer; systemId: Integer; networkId: Integer); cdecl; overload;
    procedure setStateInvalid; cdecl;
    function toString: JString; cdecl;
  end;
  TJCdmaCellLocation = class(TJavaGenericImport<JCdmaCellLocationClass, JCdmaCellLocation>) end;

  JGsmCellLocationClass = interface(JCellLocationClass)
    ['{31FDA1F7-0041-4FF2-91D2-F15D974EAC2C}']
    {class} function init: JGsmCellLocation; cdecl; overload;
    {class} function init(bundle: JBundle): JGsmCellLocation; cdecl; overload;
  end;

  [JavaSignature('android/telephony/gsm/GsmCellLocation')]
  JGsmCellLocation = interface(JCellLocation)
    ['{D09EE10D-C54B-40AB-AE80-461A6AC0DB66}']
    function equals(o: JObject): Boolean; cdecl;
    procedure fillInNotifierBundle(m: JBundle); cdecl;
    function getCid: Integer; cdecl;
    function getLac: Integer; cdecl;
    function getPsc: Integer; cdecl;
    function hashCode: Integer; cdecl;
    procedure setLacAndCid(lac: Integer; cid: Integer); cdecl;
    procedure setStateInvalid; cdecl;
    function toString: JString; cdecl;
  end;
  TJGsmCellLocation = class(TJavaGenericImport<JGsmCellLocationClass, JGsmCellLocation>) end;

  Jgsm_SmsManagerClass = interface(JObjectClass)
    ['{17F8CCF3-8CA3-4E7C-86AA-CD21CF9AE9C5}']
    {class} function _GetRESULT_ERROR_GENERIC_FAILURE: Integer; cdecl;
    {class} function _GetRESULT_ERROR_NO_SERVICE: Integer; cdecl;
    {class} function _GetRESULT_ERROR_NULL_PDU: Integer; cdecl;
    {class} function _GetRESULT_ERROR_RADIO_OFF: Integer; cdecl;
    {class} function _GetSTATUS_ON_SIM_FREE: Integer; cdecl;
    {class} function _GetSTATUS_ON_SIM_READ: Integer; cdecl;
    {class} function _GetSTATUS_ON_SIM_SENT: Integer; cdecl;
    {class} function _GetSTATUS_ON_SIM_UNREAD: Integer; cdecl;
    {class} function _GetSTATUS_ON_SIM_UNSENT: Integer; cdecl;
    {class} function getDefault: Jgsm_SmsManager; cdecl;//Deprecated
    {class} property RESULT_ERROR_GENERIC_FAILURE: Integer read _GetRESULT_ERROR_GENERIC_FAILURE;
    {class} property RESULT_ERROR_NO_SERVICE: Integer read _GetRESULT_ERROR_NO_SERVICE;
    {class} property RESULT_ERROR_NULL_PDU: Integer read _GetRESULT_ERROR_NULL_PDU;
    {class} property RESULT_ERROR_RADIO_OFF: Integer read _GetRESULT_ERROR_RADIO_OFF;
    {class} property STATUS_ON_SIM_FREE: Integer read _GetSTATUS_ON_SIM_FREE;
    {class} property STATUS_ON_SIM_READ: Integer read _GetSTATUS_ON_SIM_READ;
    {class} property STATUS_ON_SIM_SENT: Integer read _GetSTATUS_ON_SIM_SENT;
    {class} property STATUS_ON_SIM_UNREAD: Integer read _GetSTATUS_ON_SIM_UNREAD;
    {class} property STATUS_ON_SIM_UNSENT: Integer read _GetSTATUS_ON_SIM_UNSENT;
  end;

  [JavaSignature('android/telephony/gsm/SmsManager')]
  Jgsm_SmsManager = interface(JObject)
    ['{0E3A70E1-7A4B-4480-896E-62E41FBF913E}']
    function divideMessage(text: JString): JArrayList; cdecl;//Deprecated
    procedure sendDataMessage(destinationAddress: JString; scAddress: JString; destinationPort: SmallInt; data: TJavaArray<Byte>; sentIntent: JPendingIntent; deliveryIntent: JPendingIntent); cdecl;//Deprecated
    procedure sendMultipartTextMessage(destinationAddress: JString; scAddress: JString; parts: JArrayList; sentIntents: JArrayList; deliveryIntents: JArrayList); cdecl;//Deprecated
    procedure sendTextMessage(destinationAddress: JString; scAddress: JString; text: JString; sentIntent: JPendingIntent; deliveryIntent: JPendingIntent); cdecl;//Deprecated
  end;
  TJgsm_SmsManager = class(TJavaGenericImport<Jgsm_SmsManagerClass, Jgsm_SmsManager>) end;

  Jgsm_SmsMessageClass = interface(JObjectClass)
    ['{F5132C01-2558-4829-8125-7EACA7B45F08}']
    {class} function _GetENCODING_16BIT: Integer; cdecl;
    {class} function _GetENCODING_7BIT: Integer; cdecl;
    {class} function _GetENCODING_8BIT: Integer; cdecl;
    {class} function _GetENCODING_UNKNOWN: Integer; cdecl;
    {class} function _GetMAX_USER_DATA_BYTES: Integer; cdecl;
    {class} function _GetMAX_USER_DATA_SEPTETS: Integer; cdecl;
    {class} function _GetMAX_USER_DATA_SEPTETS_WITH_HEADER: Integer; cdecl;
    {class} function init: Jgsm_SmsMessage; cdecl;//Deprecated
    {class} function calculateLength(messageBody: JCharSequence; use7bitOnly: Boolean): TJavaArray<Integer>; cdecl; overload;//Deprecated
    {class} function calculateLength(messageBody: JString; use7bitOnly: Boolean): TJavaArray<Integer>; cdecl; overload;//Deprecated
    {class} function createFromPdu(pdu: TJavaArray<Byte>): Jgsm_SmsMessage; cdecl;//Deprecated
    {class} function getSubmitPdu(scAddress: JString; destinationAddress: JString; message: JString; statusReportRequested: Boolean): Jgsm_SmsMessage_SubmitPdu; cdecl; overload;//Deprecated
    {class} function getSubmitPdu(scAddress: JString; destinationAddress: JString; destinationPort: SmallInt; data: TJavaArray<Byte>; statusReportRequested: Boolean): Jgsm_SmsMessage_SubmitPdu; cdecl; overload;//Deprecated
    {class} function getTPLayerLengthForPDU(pdu: JString): Integer; cdecl;//Deprecated
    {class} property ENCODING_16BIT: Integer read _GetENCODING_16BIT;
    {class} property ENCODING_7BIT: Integer read _GetENCODING_7BIT;
    {class} property ENCODING_8BIT: Integer read _GetENCODING_8BIT;
    {class} property ENCODING_UNKNOWN: Integer read _GetENCODING_UNKNOWN;
    {class} property MAX_USER_DATA_BYTES: Integer read _GetMAX_USER_DATA_BYTES;
    {class} property MAX_USER_DATA_SEPTETS: Integer read _GetMAX_USER_DATA_SEPTETS;
    {class} property MAX_USER_DATA_SEPTETS_WITH_HEADER: Integer read _GetMAX_USER_DATA_SEPTETS_WITH_HEADER;
  end;

  [JavaSignature('android/telephony/gsm/SmsMessage')]
  Jgsm_SmsMessage = interface(JObject)
    ['{71AD7E64-87CA-4EC5-BB5B-91DCB9A3F8D5}']
    function getDisplayMessageBody: JString; cdecl;//Deprecated
    function getDisplayOriginatingAddress: JString; cdecl;//Deprecated
    function getEmailBody: JString; cdecl;//Deprecated
    function getEmailFrom: JString; cdecl;//Deprecated
    function getIndexOnSim: Integer; cdecl;//Deprecated
    function getMessageBody: JString; cdecl;//Deprecated
    function getMessageClass: Jgsm_SmsMessage_MessageClass; cdecl;//Deprecated
    function getOriginatingAddress: JString; cdecl;//Deprecated
    function getPdu: TJavaArray<Byte>; cdecl;//Deprecated
    function getProtocolIdentifier: Integer; cdecl;//Deprecated
    function getPseudoSubject: JString; cdecl;//Deprecated
    function getServiceCenterAddress: JString; cdecl;//Deprecated
    function getStatus: Integer; cdecl;//Deprecated
    function getStatusOnSim: Integer; cdecl;//Deprecated
    function getTimestampMillis: Int64; cdecl;//Deprecated
    function getUserData: TJavaArray<Byte>; cdecl;//Deprecated
    function isCphsMwiMessage: Boolean; cdecl;//Deprecated
    function isEmail: Boolean; cdecl;//Deprecated
    function isMWIClearMessage: Boolean; cdecl;//Deprecated
    function isMWISetMessage: Boolean; cdecl;//Deprecated
    function isMwiDontStore: Boolean; cdecl;//Deprecated
    function isReplace: Boolean; cdecl;//Deprecated
    function isReplyPathPresent: Boolean; cdecl;//Deprecated
    function isStatusReportMessage: Boolean; cdecl;//Deprecated
  end;
  TJgsm_SmsMessage = class(TJavaGenericImport<Jgsm_SmsMessageClass, Jgsm_SmsMessage>) end;

  Jgsm_SmsMessage_MessageClassClass = interface(JEnumClass)
    ['{39AF35BE-04BA-4BA5-815F-EAF9192F6413}']
    {class} function _GetCLASS_0: Jgsm_SmsMessage_MessageClass; cdecl;
    {class} function _GetCLASS_1: Jgsm_SmsMessage_MessageClass; cdecl;
    {class} function _GetCLASS_2: Jgsm_SmsMessage_MessageClass; cdecl;
    {class} function _GetCLASS_3: Jgsm_SmsMessage_MessageClass; cdecl;
    {class} function _GetUNKNOWN: Jgsm_SmsMessage_MessageClass; cdecl;
    {class} function valueOf(name: JString): Jgsm_SmsMessage_MessageClass; cdecl;
    {class} function values: TJavaObjectArray<Jgsm_SmsMessage_MessageClass>; cdecl;
    {class} property CLASS_0: Jgsm_SmsMessage_MessageClass read _GetCLASS_0;
    {class} property CLASS_1: Jgsm_SmsMessage_MessageClass read _GetCLASS_1;
    {class} property CLASS_2: Jgsm_SmsMessage_MessageClass read _GetCLASS_2;
    {class} property CLASS_3: Jgsm_SmsMessage_MessageClass read _GetCLASS_3;
    {class} property UNKNOWN: Jgsm_SmsMessage_MessageClass read _GetUNKNOWN;
  end;

  [JavaSignature('android/telephony/gsm/SmsMessage$MessageClass')]
  Jgsm_SmsMessage_MessageClass = interface(JEnum)
    ['{2A8F0F0C-A782-40C9-A015-DEB6470488E3}']
  end;
  TJgsm_SmsMessage_MessageClass = class(TJavaGenericImport<Jgsm_SmsMessage_MessageClassClass, Jgsm_SmsMessage_MessageClass>) end;

  Jgsm_SmsMessage_SubmitPduClass = interface(JObjectClass)
    ['{1F8AD068-26C6-4018-AC53-2568912E18AC}']
    {class} function init: Jgsm_SmsMessage_SubmitPdu; cdecl;//Deprecated
  end;

  [JavaSignature('android/telephony/gsm/SmsMessage$SubmitPdu')]
  Jgsm_SmsMessage_SubmitPdu = interface(JObject)
    ['{F5357F33-764B-4656-9332-78162CB99DEF}']
    function _GetencodedMessage: TJavaArray<Byte>; cdecl;
    procedure _SetencodedMessage(Value: TJavaArray<Byte>); cdecl;
    function _GetencodedScAddress: TJavaArray<Byte>; cdecl;
    procedure _SetencodedScAddress(Value: TJavaArray<Byte>); cdecl;
    function toString: JString; cdecl;//Deprecated
    property encodedMessage: TJavaArray<Byte> read _GetencodedMessage write _SetencodedMessage;
    property encodedScAddress: TJavaArray<Byte> read _GetencodedScAddress write _SetencodedScAddress;
  end;
  TJgsm_SmsMessage_SubmitPdu = class(TJavaGenericImport<Jgsm_SmsMessage_SubmitPduClass, Jgsm_SmsMessage_SubmitPdu>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCarrierConfigManager', TypeInfo(Androidapi.JNI.Telephony.JCarrierConfigManager));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellIdentityCdma', TypeInfo(Androidapi.JNI.Telephony.JCellIdentityCdma));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellIdentityGsm', TypeInfo(Androidapi.JNI.Telephony.JCellIdentityGsm));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellIdentityLte', TypeInfo(Androidapi.JNI.Telephony.JCellIdentityLte));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellIdentityWcdma', TypeInfo(Androidapi.JNI.Telephony.JCellIdentityWcdma));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellInfo', TypeInfo(Androidapi.JNI.Telephony.JCellInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellInfoCdma', TypeInfo(Androidapi.JNI.Telephony.JCellInfoCdma));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellInfoGsm', TypeInfo(Androidapi.JNI.Telephony.JCellInfoGsm));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellInfoLte', TypeInfo(Androidapi.JNI.Telephony.JCellInfoLte));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellInfoWcdma', TypeInfo(Androidapi.JNI.Telephony.JCellInfoWcdma));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellLocation', TypeInfo(Androidapi.JNI.Telephony.JCellLocation));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellSignalStrength', TypeInfo(Androidapi.JNI.Telephony.JCellSignalStrength));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellSignalStrengthCdma', TypeInfo(Androidapi.JNI.Telephony.JCellSignalStrengthCdma));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellSignalStrengthGsm', TypeInfo(Androidapi.JNI.Telephony.JCellSignalStrengthGsm));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellSignalStrengthLte', TypeInfo(Androidapi.JNI.Telephony.JCellSignalStrengthLte));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCellSignalStrengthWcdma', TypeInfo(Androidapi.JNI.Telephony.JCellSignalStrengthWcdma));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JPhoneStateListener', TypeInfo(Androidapi.JNI.Telephony.JPhoneStateListener));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCustomPhoneStateListener', TypeInfo(Androidapi.JNI.Telephony.JCustomPhoneStateListener));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JICustomPhoneStateListener', TypeInfo(Androidapi.JNI.Telephony.JICustomPhoneStateListener));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JIccOpenLogicalChannelResponse', TypeInfo(Androidapi.JNI.Telephony.JIccOpenLogicalChannelResponse));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JNeighboringCellInfo', TypeInfo(Androidapi.JNI.Telephony.JNeighboringCellInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JPhoneNumberFormattingTextWatcher', TypeInfo(Androidapi.JNI.Telephony.JPhoneNumberFormattingTextWatcher));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JPhoneNumberUtils', TypeInfo(Androidapi.JNI.Telephony.JPhoneNumberUtils));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JServiceState', TypeInfo(Androidapi.JNI.Telephony.JServiceState));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JSignalStrength', TypeInfo(Androidapi.JNI.Telephony.JSignalStrength));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JSmsManager', TypeInfo(Androidapi.JNI.Telephony.JSmsManager));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JSmsMessage', TypeInfo(Androidapi.JNI.Telephony.JSmsMessage));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JSmsMessage_MessageClass', TypeInfo(Androidapi.JNI.Telephony.JSmsMessage_MessageClass));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JSmsMessage_SubmitPdu', TypeInfo(Androidapi.JNI.Telephony.JSmsMessage_SubmitPdu));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JSubscriptionInfo', TypeInfo(Androidapi.JNI.Telephony.JSubscriptionInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JSubscriptionManager', TypeInfo(Androidapi.JNI.Telephony.JSubscriptionManager));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JSubscriptionManager_OnSubscriptionsChangedListener', TypeInfo(Androidapi.JNI.Telephony.JSubscriptionManager_OnSubscriptionsChangedListener));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JTelephonyManager', TypeInfo(Androidapi.JNI.Telephony.JTelephonyManager));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JCdmaCellLocation', TypeInfo(Androidapi.JNI.Telephony.JCdmaCellLocation));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.JGsmCellLocation', TypeInfo(Androidapi.JNI.Telephony.JGsmCellLocation));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.Jgsm_SmsManager', TypeInfo(Androidapi.JNI.Telephony.Jgsm_SmsManager));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.Jgsm_SmsMessage', TypeInfo(Androidapi.JNI.Telephony.Jgsm_SmsMessage));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.Jgsm_SmsMessage_MessageClass', TypeInfo(Androidapi.JNI.Telephony.Jgsm_SmsMessage_MessageClass));
  TRegTypes.RegisterType('Androidapi.JNI.Telephony.Jgsm_SmsMessage_SubmitPdu', TypeInfo(Androidapi.JNI.Telephony.Jgsm_SmsMessage_SubmitPdu));
end;

initialization
  RegisterTypes;
end.


