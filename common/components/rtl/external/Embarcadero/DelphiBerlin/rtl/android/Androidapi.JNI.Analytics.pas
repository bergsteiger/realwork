{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Analytics;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes;

type
// ===== Forward declarations =====

  JAnalyticsThread_ClientIdCallback = interface;//com.google.analytics.tracking.android.AnalyticsThread$ClientIdCallback
  JCampaignTrackingReceiver = interface;//com.google.analytics.tracking.android.CampaignTrackingReceiver
  JCampaignTrackingService = interface;//com.google.analytics.tracking.android.CampaignTrackingService
  JEasyTracker = interface;//com.google.analytics.tracking.android.EasyTracker
  JExceptionParser = interface;//com.google.analytics.tracking.android.ExceptionParser
  JExceptionReporter = interface;//com.google.analytics.tracking.android.ExceptionReporter
  JGAServiceManager = interface;//com.google.analytics.tracking.android.GAServiceManager
  JGoogleAnalytics = interface;//com.google.analytics.tracking.android.GoogleAnalytics
  JGoogleAnalytics_AppOptOutCallback = interface;//com.google.analytics.tracking.android.GoogleAnalytics$AppOptOutCallback
  Jandroid_Log = interface;//com.google.analytics.tracking.android.Log
  JModelFields = interface;//com.google.analytics.tracking.android.ModelFields
  JServiceManager = interface;//com.google.analytics.tracking.android.ServiceManager
  JStandardExceptionParser = interface;//com.google.analytics.tracking.android.StandardExceptionParser
  JTracker = interface;//com.google.analytics.tracking.android.Tracker
  JTransaction = interface;//com.google.analytics.tracking.android.Transaction
  JTransaction_Builder = interface;//com.google.analytics.tracking.android.Transaction$Builder
  JTransaction_Item = interface;//com.google.analytics.tracking.android.Transaction$Item
  JItem_Builder = interface;//com.google.analytics.tracking.android.Transaction$Item$Builder

// ===== Interface declarations =====

  JAnalyticsThread_ClientIdCallbackClass = interface(IJavaClass)
    ['{F5905273-CD1E-4B68-90FE-CD12E7E85A50}']
  end;

  [JavaSignature('com/google/analytics/tracking/android/AnalyticsThread$ClientIdCallback')]
  JAnalyticsThread_ClientIdCallback = interface(IJavaInstance)
    ['{56B9191B-76F9-42B3-AD76-9759A4B77883}']
    procedure reportClientId(paramString: JString); cdecl;
  end;
  TJAnalyticsThread_ClientIdCallback = class(TJavaGenericImport<JAnalyticsThread_ClientIdCallbackClass, JAnalyticsThread_ClientIdCallback>) end;

  JCampaignTrackingReceiverClass = interface(JBroadcastReceiverClass)
    ['{9BBDCFAD-93AC-40E9-9D5C-D4A6848033D2}']
    {class} function init: JCampaignTrackingReceiver; cdecl;
  end;

  [JavaSignature('com/google/analytics/tracking/android/CampaignTrackingReceiver')]
  JCampaignTrackingReceiver = interface(JBroadcastReceiver)
    ['{5ABB75C6-3E3B-4B83-AA3C-ACBD240EA4E6}']
    procedure onReceive(ctx: JContext; intent: JIntent); cdecl;
  end;
  TJCampaignTrackingReceiver = class(TJavaGenericImport<JCampaignTrackingReceiverClass, JCampaignTrackingReceiver>) end;

  JCampaignTrackingServiceClass = interface(JIntentServiceClass)
    ['{72BFE8D6-3F6D-402B-9D5D-EE14ADB67970}']
    {class} function init(name: JString): JCampaignTrackingService; cdecl; overload;
    {class} function init: JCampaignTrackingService; cdecl; overload;
  end;

  [JavaSignature('com/google/analytics/tracking/android/CampaignTrackingService')]
  JCampaignTrackingService = interface(JIntentService)
    ['{0AF1D352-0263-48DB-AE7B-F9D08FD54140}']
  end;
  TJCampaignTrackingService = class(TJavaGenericImport<JCampaignTrackingServiceClass, JCampaignTrackingService>) end;

  JEasyTrackerClass = interface(JObjectClass)
    ['{8499D0D6-D2B3-431C-954C-7250D3ABABDD}']
    {class} function getInstance: JEasyTracker; cdecl;
    {class} function getTracker: JTracker; cdecl;
  end;

  [JavaSignature('com/google/analytics/tracking/android/EasyTracker')]
  JEasyTracker = interface(JObject)
    ['{BD4D421D-03C7-45BA-B4AA-7DBA624F5642}']
    procedure activityStart(activity: JActivity); cdecl;
    procedure activityStop(activity: JActivity); cdecl;
    procedure dispatch; cdecl;
    procedure setContext(ctx: JContext); cdecl;
  end;
  TJEasyTracker = class(TJavaGenericImport<JEasyTrackerClass, JEasyTracker>) end;

  JExceptionParserClass = interface(IJavaClass)
    ['{27FAA6C4-A988-4B87-B703-03A90F6BEE78}']
  end;

  [JavaSignature('com/google/analytics/tracking/android/ExceptionParser')]
  JExceptionParser = interface(IJavaInstance)
    ['{427A0D60-A7AD-49A6-ADEA-8F49CE492A1D}']
    function getDescription(paramString: JString; paramThrowable: JThrowable): JString; cdecl;
  end;
  TJExceptionParser = class(TJavaGenericImport<JExceptionParserClass, JExceptionParser>) end;

  JExceptionReporterClass = interface(JObjectClass)
    ['{AF7794E6-3812-4DD2-8ED6-77B29824DA3B}']
    {class} function init(tracker: JTracker; serviceManager: JServiceManager; originalHandler: JThread_UncaughtExceptionHandler; context: JContext): JExceptionReporter; cdecl;
  end;

  [JavaSignature('com/google/analytics/tracking/android/ExceptionReporter')]
  JExceptionReporter = interface(JObject)
    ['{25437F3C-CB55-4607-9126-568AA64C8E6B}']
    function getExceptionParser: JExceptionParser; cdecl;
    procedure setExceptionParser(exceptionParser: JExceptionParser); cdecl;
    procedure uncaughtException(t: JThread; e: JThrowable); cdecl;
  end;
  TJExceptionReporter = class(TJavaGenericImport<JExceptionReporterClass, JExceptionReporter>) end;

  JGAServiceManagerClass = interface(JObjectClass)
    ['{CB723915-880E-40E1-AD91-2EB757F17443}']
    {class} function getInstance: JGAServiceManager; cdecl;
  end;

  [JavaSignature('com/google/analytics/tracking/android/GAServiceManager')]
  JGAServiceManager = interface(JObject)
    ['{27A7DD22-6714-41C9-B78A-7DF99AE31B7F}']
    procedure dispatch; cdecl;
    procedure setDispatchPeriod(dispatchPeriodInSeconds: Integer); cdecl;
    procedure updateConnectivityStatus(connected: Boolean); cdecl;
  end;
  TJGAServiceManager = class(TJavaGenericImport<JGAServiceManagerClass, JGAServiceManager>) end;

  JGoogleAnalyticsClass = interface(JObjectClass)
    ['{69864765-05B2-4142-8709-A377F7A47F98}']
    {class} function getInstance(context: JContext): JGoogleAnalytics; cdecl;
  end;

  [JavaSignature('com/google/analytics/tracking/android/GoogleAnalytics')]
  JGoogleAnalytics = interface(JObject)
    ['{2D7EB39C-3279-41C5-B6BA-0B42DF6C613D}']
    procedure closeTracker(tracker: JTracker); cdecl;
    function getDefaultTracker: JTracker; cdecl;
    function getTracker(trackingId: JString): JTracker; cdecl;
    function isDebugEnabled: Boolean; cdecl;
    procedure requestAppOptOut(callback: JGoogleAnalytics_AppOptOutCallback); cdecl;
    procedure sendHit(hit: JMap); cdecl;
    procedure setAppOptOut(optOut: Boolean); cdecl;
    procedure setDebug(debug: Boolean); cdecl;
    procedure setDefaultTracker(tracker: JTracker); cdecl;
  end;
  TJGoogleAnalytics = class(TJavaGenericImport<JGoogleAnalyticsClass, JGoogleAnalytics>) end;

  JGoogleAnalytics_AppOptOutCallbackClass = interface(IJavaClass)
    ['{0D3DAF93-8A52-4EED-8F9A-9F986495BA4D}']
  end;

  [JavaSignature('com/google/analytics/tracking/android/GoogleAnalytics$AppOptOutCallback')]
  JGoogleAnalytics_AppOptOutCallback = interface(IJavaInstance)
    ['{DB8992E3-FEFA-4BB1-98B9-F44BB465F278}']
    procedure reportAppOptOut(paramBoolean: Boolean); cdecl;
  end;
  TJGoogleAnalytics_AppOptOutCallback = class(TJavaGenericImport<JGoogleAnalytics_AppOptOutCallbackClass, JGoogleAnalytics_AppOptOutCallback>) end;

  Jandroid_LogClass = interface(JObjectClass)
    ['{3042F41F-E9CB-4B25-8731-D36CC6C53B36}']
    {class} function init: Jandroid_Log; cdecl;
    {class} function d(msg: JString): Integer; cdecl;
    {class} function dDebug(msg: JString): Integer; cdecl;
    {class} function e(msg: JString): Integer; cdecl;
    {class} function eDebug(msg: JString): Integer; cdecl;
    {class} function i(msg: JString): Integer; cdecl;
    {class} function iDebug(msg: JString): Integer; cdecl;
    {class} function isDebugEnabled: Boolean; cdecl;
    {class} procedure setDebug(debug: Boolean); cdecl;
    {class} function v(msg: JString): Integer; cdecl;
    {class} function vDebug(msg: JString): Integer; cdecl;
    {class} function w(msg: JString): Integer; cdecl;
    {class} function wDebug(msg: JString): Integer; cdecl;
  end;

  [JavaSignature('com/google/analytics/tracking/android/Log')]
  Jandroid_Log = interface(JObject)
    ['{E246D977-8DBD-4CDB-BD16-8D4AB1F84DCE}']
  end;
  TJandroid_Log = class(TJavaGenericImport<Jandroid_LogClass, Jandroid_Log>) end;

  JModelFieldsClass = interface(JObjectClass)
    ['{87CD99C9-E1DB-4D40-BBBB-67ED070AAE4D}']
    {class} function _GetANDROID_APP_UID: JString; cdecl;
    {class} function _GetANONYMIZE_IP: JString; cdecl;
    {class} function _GetAPI_VERSION: JString; cdecl;
    {class} function _GetAPP_ID: JString; cdecl;
    {class} function _GetAPP_INSTALLER_ID: JString; cdecl;
    {class} function _GetAPP_NAME: JString; cdecl;
    {class} function _GetAPP_SCREEN: JString; cdecl;
    {class} function _GetAPP_VERSION: JString; cdecl;
    {class} function _GetAPP_VIEW: JString; cdecl;
    {class} function _GetCACHE_BUSTER: JString; cdecl;
    {class} function _GetCAMPAIGN: JString; cdecl;
    {class} function _GetCAMPAIGN_CONTENT: JString; cdecl;
    {class} function _GetCAMPAIGN_ID: JString; cdecl;
    {class} function _GetCAMPAIGN_KEYWORD: JString; cdecl;
    {class} function _GetCAMPAIGN_MEDIUM: JString; cdecl;
    {class} function _GetCAMPAIGN_NAME: JString; cdecl;
    {class} function _GetCAMPAIGN_SOURCE: JString; cdecl;
    {class} function _GetCLIENT_ID: JString; cdecl;
    {class} function _GetCONTENT_GROUPING: JString; cdecl;
    {class} function _GetCUSTOM_DIMENSION: JString; cdecl;
    {class} function _GetCUSTOM_METRIC: JString; cdecl;
    {class} function _GetDCLID: JString; cdecl;
    {class} function _GetDESCRIPTION: JString; cdecl;
    {class} function _GetENCODING: JString; cdecl;
    {class} function _GetEVENT: JString; cdecl;
    {class} function _GetEVENT_ACTION: JString; cdecl;
    {class} function _GetEVENT_CATEGORY: JString; cdecl;
    {class} function _GetEVENT_LABEL: JString; cdecl;
    {class} function _GetEVENT_VALUE: JString; cdecl;
    {class} function _GetEXCEPTION: JString; cdecl;
    {class} function _GetEXCEPTION_THREAD_NAME: JString; cdecl;
    {class} function _GetEX_DESCRIPTION: JString; cdecl;
    {class} function _GetEX_FATAL: JString; cdecl;
    {class} function _GetFLASH_VERSION: JString; cdecl;
    {class} function _GetGCLID: JString; cdecl;
    {class} function _GetGMOB_T: JString; cdecl;
    {class} function _GetHIT_TYPE: JString; cdecl;
    {class} function _GetITEM: JString; cdecl;
    {class} function _GetITEM_CATEGORY: JString; cdecl;
    {class} function _GetITEM_CODE: JString; cdecl;
    {class} function _GetITEM_NAME: JString; cdecl;
    {class} function _GetITEM_PRICE: JString; cdecl;
    {class} function _GetITEM_QUANTITY: JString; cdecl;
    {class} function _GetJAVA_ENABLED: JString; cdecl;
    {class} function _GetLANGUAGE: JString; cdecl;
    {class} function _GetNON_INTERACTION: JString; cdecl;
    {class} function _GetPAGE: JString; cdecl;
    {class} function _GetQUEUE_TIME: JString; cdecl;
    {class} function _GetRAW_EXCEPTION: JString; cdecl;
    {class} function _GetREFERRER: JString; cdecl;
    {class} function _GetSAMPLE_RATE: JString; cdecl;
    {class} function _GetSCREEN_COLORS: JString; cdecl;
    {class} function _GetSCREEN_RESOLUTION: JString; cdecl;
    {class} function _GetSESSION_CONTROL: JString; cdecl;
    {class} function _GetSOCIAL: JString; cdecl;
    {class} function _GetSOCIAL_ACTION: JString; cdecl;
    {class} function _GetSOCIAL_NETWORK: JString; cdecl;
    {class} function _GetSOCIAL_TARGET: JString; cdecl;
    {class} function _GetTIMING: JString; cdecl;
    {class} function _GetTIMING_CATEGORY: JString; cdecl;
    {class} function _GetTIMING_LABEL: JString; cdecl;
    {class} function _GetTIMING_VALUE: JString; cdecl;
    {class} function _GetTIMING_VAR: JString; cdecl;
    {class} function _GetTITLE: JString; cdecl;
    {class} function _GetTRACKING_ID: JString; cdecl;
    {class} function _GetTRANSACTION: JString; cdecl;
    {class} function _GetTRANSACTION_AFFILIATION: JString; cdecl;
    {class} function _GetTRANSACTION_ID: JString; cdecl;
    {class} function _GetTRANSACTION_SHIPPING: JString; cdecl;
    {class} function _GetTRANSACTION_TAX: JString; cdecl;
    {class} function _GetTRANSACTION_TOTAL: JString; cdecl;
    {class} function _GetUSE_SECURE: JString; cdecl;
    {class} function _GetVIEWPORT_SIZE: JString; cdecl;
    {class} function init: JModelFields; cdecl;
    {class} property ANDROID_APP_UID: JString read _GetANDROID_APP_UID;
    {class} property ANONYMIZE_IP: JString read _GetANONYMIZE_IP;
    {class} property API_VERSION: JString read _GetAPI_VERSION;
    {class} property APP_ID: JString read _GetAPP_ID;
    {class} property APP_INSTALLER_ID: JString read _GetAPP_INSTALLER_ID;
    {class} property APP_NAME: JString read _GetAPP_NAME;
    {class} property APP_SCREEN: JString read _GetAPP_SCREEN;
    {class} property APP_VERSION: JString read _GetAPP_VERSION;
    {class} property APP_VIEW: JString read _GetAPP_VIEW;
    {class} property CACHE_BUSTER: JString read _GetCACHE_BUSTER;
    {class} property CAMPAIGN: JString read _GetCAMPAIGN;
    {class} property CAMPAIGN_CONTENT: JString read _GetCAMPAIGN_CONTENT;
    {class} property CAMPAIGN_ID: JString read _GetCAMPAIGN_ID;
    {class} property CAMPAIGN_KEYWORD: JString read _GetCAMPAIGN_KEYWORD;
    {class} property CAMPAIGN_MEDIUM: JString read _GetCAMPAIGN_MEDIUM;
    {class} property CAMPAIGN_NAME: JString read _GetCAMPAIGN_NAME;
    {class} property CAMPAIGN_SOURCE: JString read _GetCAMPAIGN_SOURCE;
    {class} property CLIENT_ID: JString read _GetCLIENT_ID;
    {class} property CONTENT_GROUPING: JString read _GetCONTENT_GROUPING;
    {class} property CUSTOM_DIMENSION: JString read _GetCUSTOM_DIMENSION;
    {class} property CUSTOM_METRIC: JString read _GetCUSTOM_METRIC;
    {class} property DCLID: JString read _GetDCLID;
    {class} property DESCRIPTION: JString read _GetDESCRIPTION;
    {class} property ENCODING: JString read _GetENCODING;
    {class} property EVENT: JString read _GetEVENT;
    {class} property EVENT_ACTION: JString read _GetEVENT_ACTION;
    {class} property EVENT_CATEGORY: JString read _GetEVENT_CATEGORY;
    {class} property EVENT_LABEL: JString read _GetEVENT_LABEL;
    {class} property EVENT_VALUE: JString read _GetEVENT_VALUE;
    {class} property EXCEPTION: JString read _GetEXCEPTION;
    {class} property EXCEPTION_THREAD_NAME: JString read _GetEXCEPTION_THREAD_NAME;
    {class} property EX_DESCRIPTION: JString read _GetEX_DESCRIPTION;
    {class} property EX_FATAL: JString read _GetEX_FATAL;
    {class} property FLASH_VERSION: JString read _GetFLASH_VERSION;
    {class} property GCLID: JString read _GetGCLID;
    {class} property GMOB_T: JString read _GetGMOB_T;
    {class} property HIT_TYPE: JString read _GetHIT_TYPE;
    {class} property ITEM: JString read _GetITEM;
    {class} property ITEM_CATEGORY: JString read _GetITEM_CATEGORY;
    {class} property ITEM_CODE: JString read _GetITEM_CODE;
    {class} property ITEM_NAME: JString read _GetITEM_NAME;
    {class} property ITEM_PRICE: JString read _GetITEM_PRICE;
    {class} property ITEM_QUANTITY: JString read _GetITEM_QUANTITY;
    {class} property JAVA_ENABLED: JString read _GetJAVA_ENABLED;
    {class} property LANGUAGE: JString read _GetLANGUAGE;
    {class} property NON_INTERACTION: JString read _GetNON_INTERACTION;
    {class} property PAGE: JString read _GetPAGE;
    {class} property QUEUE_TIME: JString read _GetQUEUE_TIME;
    {class} property RAW_EXCEPTION: JString read _GetRAW_EXCEPTION;
    {class} property REFERRER: JString read _GetREFERRER;
    {class} property SAMPLE_RATE: JString read _GetSAMPLE_RATE;
    {class} property SCREEN_COLORS: JString read _GetSCREEN_COLORS;
    {class} property SCREEN_RESOLUTION: JString read _GetSCREEN_RESOLUTION;
    {class} property SESSION_CONTROL: JString read _GetSESSION_CONTROL;
    {class} property SOCIAL: JString read _GetSOCIAL;
    {class} property SOCIAL_ACTION: JString read _GetSOCIAL_ACTION;
    {class} property SOCIAL_NETWORK: JString read _GetSOCIAL_NETWORK;
    {class} property SOCIAL_TARGET: JString read _GetSOCIAL_TARGET;
    {class} property TIMING: JString read _GetTIMING;
    {class} property TIMING_CATEGORY: JString read _GetTIMING_CATEGORY;
    {class} property TIMING_LABEL: JString read _GetTIMING_LABEL;
    {class} property TIMING_VALUE: JString read _GetTIMING_VALUE;
    {class} property TIMING_VAR: JString read _GetTIMING_VAR;
    {class} property TITLE: JString read _GetTITLE;
    {class} property TRACKING_ID: JString read _GetTRACKING_ID;
    {class} property TRANSACTION: JString read _GetTRANSACTION;
    {class} property TRANSACTION_AFFILIATION: JString read _GetTRANSACTION_AFFILIATION;
    {class} property TRANSACTION_ID: JString read _GetTRANSACTION_ID;
    {class} property TRANSACTION_SHIPPING: JString read _GetTRANSACTION_SHIPPING;
    {class} property TRANSACTION_TAX: JString read _GetTRANSACTION_TAX;
    {class} property TRANSACTION_TOTAL: JString read _GetTRANSACTION_TOTAL;
    {class} property USE_SECURE: JString read _GetUSE_SECURE;
    {class} property VIEWPORT_SIZE: JString read _GetVIEWPORT_SIZE;
  end;

  [JavaSignature('com/google/analytics/tracking/android/ModelFields')]
  JModelFields = interface(JObject)
    ['{B50F6065-F244-4D64-9CCB-4095FF443D0D}']
  end;
  TJModelFields = class(TJavaGenericImport<JModelFieldsClass, JModelFields>) end;

  JServiceManagerClass = interface(IJavaClass)
    ['{B7235021-91AE-4B45-B235-65E57379A58F}']
  end;

  [JavaSignature('com/google/analytics/tracking/android/ServiceManager')]
  JServiceManager = interface(IJavaInstance)
    ['{38258C12-E458-47CE-A63E-12782C752B1C}']
    procedure dispatch; cdecl;
    procedure setDispatchPeriod(paramInt: Integer); cdecl;
    procedure updateConnectivityStatus(paramBoolean: Boolean); cdecl;
  end;
  TJServiceManager = class(TJavaGenericImport<JServiceManagerClass, JServiceManager>) end;

  JStandardExceptionParserClass = interface(JObjectClass)
    ['{B1126ECF-50B9-442F-BEAF-ED15D973DBCD}']
    {class} function init(context: JContext; additionalPackages: JCollection): JStandardExceptionParser; cdecl;
  end;

  [JavaSignature('com/google/analytics/tracking/android/StandardExceptionParser')]
  JStandardExceptionParser = interface(JObject)
    ['{87DE064D-2FE7-46C0-A45F-77387B2A1A98}']
    function getDescription(threadName: JString; t: JThrowable): JString; cdecl;
    procedure setIncludedPackages(context: JContext; additionalPackages: JCollection); cdecl;
  end;
  TJStandardExceptionParser = class(TJavaGenericImport<JStandardExceptionParserClass, JStandardExceptionParser>) end;

  JTrackerClass = interface(JObjectClass)
    ['{B2627961-C102-411C-9B33-CE86DC1CBDC7}']
  end;

  [JavaSignature('com/google/analytics/tracking/android/Tracker')]
  JTracker = interface(JObject)
    ['{2AE4F241-3111-4159-A659-40955A45B7E3}']
    procedure close; cdecl;
    function constructEvent(category: JString; action: JString; label_: JString; value: JLong): JMap; cdecl;
    function constructException(exceptionDescription: JString; fatal: Boolean): JMap; cdecl;
    function constructRawException(threadName: JString; exception: JThrowable; fatal: Boolean): JMap; cdecl;
    function constructSocial(network: JString; action: JString; target: JString): JMap; cdecl;
    function constructTiming(category: JString; intervalInMilliseconds: Int64; name: JString; label_: JString): JMap; cdecl;
    function constructTransaction(trans: JTransaction): JMap; cdecl;
    function &get(key: JString): JString; cdecl;
    function getAppId: JString; cdecl;
    function getAppInstallerId: JString; cdecl;
    function getExceptionParser: JExceptionParser; cdecl;
    function getSampleRate: Double; cdecl;
    function getTrackingId: JString; cdecl;
    function isAnonymizeIpEnabled: Boolean; cdecl;
    function isUseSecure: Boolean; cdecl;
    procedure send(hitType: JString; params: JMap); cdecl;
    procedure sendEvent(category: JString; action: JString; label_: JString; value: JLong); cdecl;
    procedure sendException(description: JString; fatal: Boolean); cdecl; overload;
    procedure sendException(threadName: JString; exception: JThrowable; fatal: Boolean); cdecl; overload;
    procedure sendSocial(network: JString; action: JString; target: JString); cdecl;
    procedure sendTiming(category: JString; intervalInMilliseconds: Int64; name: JString; label_: JString); cdecl;
    procedure sendTransaction(transaction: JTransaction); cdecl;
    procedure sendView; cdecl; overload;
    procedure sendView(appScreen: JString); cdecl; overload;
    procedure &set(key: JString; value: JString); cdecl;
    procedure setAnonymizeIp(anonymizeIp: Boolean); cdecl;
    procedure setAppId(appId: JString); cdecl;
    procedure setAppInstallerId(appInstallerId: JString); cdecl;
    procedure setAppName(appName: JString); cdecl;
    procedure setAppScreen(appScreen: JString); cdecl;
    procedure setAppVersion(appVersion: JString); cdecl;
    procedure setCampaign(campaign: JString); cdecl;
    procedure setCustomDimension(index: Integer; value: JString); cdecl;
    procedure setCustomDimensionsAndMetrics(dimensions: JMap; metrics: JMap); cdecl;
    procedure setCustomMetric(index: Integer; value: JLong); cdecl;
    procedure setExceptionParser(exceptionParser: JExceptionParser); cdecl;
    procedure setReferrer(referrer: JString); cdecl;
    procedure setSampleRate(sampleRate: Double); cdecl;
    procedure setStartSession(startSession: Boolean); cdecl;
    procedure setThrottlingEnabled(throttlingEnabled: Boolean); cdecl;
    procedure setUseSecure(useSecure: Boolean); cdecl;
    procedure trackEvent(category: JString; action: JString; label_: JString; value: JLong); cdecl;//Deprecated
    procedure trackException(description: JString; fatal: Boolean); cdecl; overload;//Deprecated
    procedure trackException(threadName: JString; exception: JThrowable; fatal: Boolean); cdecl; overload;//Deprecated
    procedure trackSocial(network: JString; action: JString; target: JString); cdecl;//Deprecated
    procedure trackTiming(category: JString; intervalInMilliseconds: Int64; name: JString; label_: JString); cdecl;//Deprecated
    procedure trackTransaction(transaction: JTransaction); cdecl;//Deprecated
    procedure trackView; cdecl; overload;//Deprecated
    procedure trackView(appScreen: JString); cdecl; overload;//Deprecated
  end;
  TJTracker = class(TJavaGenericImport<JTrackerClass, JTracker>) end;

  JTransactionClass = interface(JObjectClass)
    ['{28763069-CEB0-4D82-9B5F-023427DB6153}']
  end;

  [JavaSignature('com/google/analytics/tracking/android/Transaction')]
  JTransaction = interface(JObject)
    ['{90F8AAE4-659D-4A92-91F5-FEF97EEECEA0}']
    procedure addItem(item: JTransaction_Item); cdecl;
    function getAffiliation: JString; cdecl;
    function getCurrencyCode: JString; cdecl;
    function getItems: JList; cdecl;
    function getShippingCostInMicros: Int64; cdecl;
    function getTotalCostInMicros: Int64; cdecl;
    function getTotalTaxInMicros: Int64; cdecl;
    function getTransactionId: JString; cdecl;
  end;
  TJTransaction = class(TJavaGenericImport<JTransactionClass, JTransaction>) end;

  JTransaction_BuilderClass = interface(JObjectClass)
    ['{042AF3D5-7D57-4656-8A94-A8D5938BE96F}']
    {class} function init(transactionId: JString; totalCostInMicros: Int64): JTransaction_Builder; cdecl;
  end;

  [JavaSignature('com/google/analytics/tracking/android/Transaction$Builder')]
  JTransaction_Builder = interface(JObject)
    ['{AAFE40C1-0964-4EB7-B035-983C84BE1F13}']
    function build: JTransaction; cdecl;
    function setAffiliation(affiliation: JString): JTransaction_Builder; cdecl;
    function setCurrencyCode(currencyCode: JString): JTransaction_Builder; cdecl;
    function setShippingCostInMicros(shippingCostInMicros: Int64): JTransaction_Builder; cdecl;
    function setTotalTaxInMicros(totalTaxInMicros: Int64): JTransaction_Builder; cdecl;
  end;
  TJTransaction_Builder = class(TJavaGenericImport<JTransaction_BuilderClass, JTransaction_Builder>) end;

  JTransaction_ItemClass = interface(JObjectClass)
    ['{2A64E0A4-BF0B-4DFA-9658-0682CE2AD6AA}']
  end;

  [JavaSignature('com/google/analytics/tracking/android/Transaction$Item')]
  JTransaction_Item = interface(JObject)
    ['{A9B5E013-D50F-4BAB-BECA-0E443060C755}']
    function getCategory: JString; cdecl;
    function getName: JString; cdecl;
    function getPriceInMicros: Int64; cdecl;
    function getQuantity: Int64; cdecl;
    function getSKU: JString; cdecl;
  end;
  TJTransaction_Item = class(TJavaGenericImport<JTransaction_ItemClass, JTransaction_Item>) end;

  JItem_BuilderClass = interface(JObjectClass)
    ['{0934FF65-7A08-434E-B03F-695732A0E409}']
    {class} function init(SKU: JString; name: JString; priceInMicros: Int64; quantity: Int64): JItem_Builder; cdecl;
  end;

  [JavaSignature('com/google/analytics/tracking/android/Transaction$Item$Builder')]
  JItem_Builder = interface(JObject)
    ['{2F7E85FE-FA41-4F65-91DD-055211F20FC4}']
    function build: JTransaction_Item; cdecl;
    function setProductCategory(productCategory: JString): JItem_Builder; cdecl;
  end;
  TJItem_Builder = class(TJavaGenericImport<JItem_BuilderClass, JItem_Builder>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JAnalyticsThread_ClientIdCallback', TypeInfo(Androidapi.JNI.Analytics.JAnalyticsThread_ClientIdCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JCampaignTrackingReceiver', TypeInfo(Androidapi.JNI.Analytics.JCampaignTrackingReceiver));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JCampaignTrackingService', TypeInfo(Androidapi.JNI.Analytics.JCampaignTrackingService));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JEasyTracker', TypeInfo(Androidapi.JNI.Analytics.JEasyTracker));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JExceptionParser', TypeInfo(Androidapi.JNI.Analytics.JExceptionParser));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JExceptionReporter', TypeInfo(Androidapi.JNI.Analytics.JExceptionReporter));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JGAServiceManager', TypeInfo(Androidapi.JNI.Analytics.JGAServiceManager));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JGoogleAnalytics', TypeInfo(Androidapi.JNI.Analytics.JGoogleAnalytics));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JGoogleAnalytics_AppOptOutCallback', TypeInfo(Androidapi.JNI.Analytics.JGoogleAnalytics_AppOptOutCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.Jandroid_Log', TypeInfo(Androidapi.JNI.Analytics.Jandroid_Log));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JModelFields', TypeInfo(Androidapi.JNI.Analytics.JModelFields));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JServiceManager', TypeInfo(Androidapi.JNI.Analytics.JServiceManager));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JStandardExceptionParser', TypeInfo(Androidapi.JNI.Analytics.JStandardExceptionParser));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JTracker', TypeInfo(Androidapi.JNI.Analytics.JTracker));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JTransaction', TypeInfo(Androidapi.JNI.Analytics.JTransaction));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JTransaction_Builder', TypeInfo(Androidapi.JNI.Analytics.JTransaction_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JTransaction_Item', TypeInfo(Androidapi.JNI.Analytics.JTransaction_Item));
  TRegTypes.RegisterType('Androidapi.JNI.Analytics.JItem_Builder', TypeInfo(Androidapi.JNI.Analytics.JItem_Builder));
end;

initialization
  RegisterTypes;
end.


