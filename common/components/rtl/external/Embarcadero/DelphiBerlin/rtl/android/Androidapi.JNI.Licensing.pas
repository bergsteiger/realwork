{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Licensing;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os;

type
// ===== Forward declarations =====

  JAESObfuscator = interface;//com.google.android.vending.licensing.AESObfuscator
  JAPKExpansionPolicy = interface;//com.google.android.vending.licensing.APKExpansionPolicy
  JDeviceLimiter = interface;//com.google.android.vending.licensing.DeviceLimiter
  JILicenseResultListener = interface;//com.google.android.vending.licensing.ILicenseResultListener
  JILicenseResultListener_Stub = interface;//com.google.android.vending.licensing.ILicenseResultListener$Stub
  JILicensingService = interface;//com.google.android.vending.licensing.ILicensingService
  JILicensingService_Stub = interface;//com.google.android.vending.licensing.ILicensingService$Stub
  JLicenseChecker = interface;//com.google.android.vending.licensing.LicenseChecker
  JLicenseCheckerCallback = interface;//com.google.android.vending.licensing.LicenseCheckerCallback
  JNullDeviceLimiter = interface;//com.google.android.vending.licensing.NullDeviceLimiter
  JObfuscator = interface;//com.google.android.vending.licensing.Obfuscator
  Jlicensing_Policy = interface;//com.google.android.vending.licensing.Policy
  JPreferenceObfuscator = interface;//com.google.android.vending.licensing.PreferenceObfuscator
  JResponseData = interface;//com.google.android.vending.licensing.ResponseData
  JServerManagedPolicy = interface;//com.google.android.vending.licensing.ServerManagedPolicy
  JStrictPolicy = interface;//com.google.android.vending.licensing.StrictPolicy
  JValidationException = interface;//com.google.android.vending.licensing.ValidationException
  Jutil_Base64 = interface;//com.google.android.vending.licensing.util.Base64
  JBase64DecoderException = interface;//com.google.android.vending.licensing.util.Base64DecoderException

// ===== Interface declarations =====

  JAESObfuscatorClass = interface(JObjectClass)
    ['{55A9ACD3-C1B7-4F85-9580-1B151CE1986B}']
    {class} function init(salt: TJavaArray<Byte>; applicationId: JString; deviceId: JString): JAESObfuscator; cdecl;
  end;

  [JavaSignature('com/google/android/vending/licensing/AESObfuscator')]
  JAESObfuscator = interface(JObject)
    ['{F5976BA5-419E-4168-B27F-A345008BFF85}']
    function obfuscate(original: JString; key: JString): JString; cdecl;
    function unobfuscate(obfuscated: JString; key: JString): JString; cdecl;
  end;
  TJAESObfuscator = class(TJavaGenericImport<JAESObfuscatorClass, JAESObfuscator>) end;

  JAPKExpansionPolicyClass = interface(JObjectClass)
    ['{C28EBC8B-3CE0-494D-8A22-397740B7C8D0}']
    {class} function _GetMAIN_FILE_URL_INDEX: Integer; cdecl;
    {class} function _GetPATCH_FILE_URL_INDEX: Integer; cdecl;
    {class} function init(context: JContext; obfuscator: JObfuscator): JAPKExpansionPolicy; cdecl;
    {class} property MAIN_FILE_URL_INDEX: Integer read _GetMAIN_FILE_URL_INDEX;
    {class} property PATCH_FILE_URL_INDEX: Integer read _GetPATCH_FILE_URL_INDEX;
  end;

  [JavaSignature('com/google/android/vending/licensing/APKExpansionPolicy')]
  JAPKExpansionPolicy = interface(JObject)
    ['{CE25C415-6076-496D-A80B-13C5CDB18E54}']
    function allowAccess: Boolean; cdecl;
    function getExpansionFileName(index: Integer): JString; cdecl;
    function getExpansionFileSize(index: Integer): Int64; cdecl;
    function getExpansionURL(index: Integer): JString; cdecl;
    function getExpansionURLCount: Integer; cdecl;
    function getMaxRetries: Int64; cdecl;
    function getRetryCount: Int64; cdecl;
    function getRetryUntil: Int64; cdecl;
    function getValidityTimestamp: Int64; cdecl;
    procedure processServerResponse(response: Integer; rawData: JResponseData); cdecl;
    procedure resetPolicy; cdecl;
    procedure setExpansionFileName(index: Integer; name: JString); cdecl;
    procedure setExpansionFileSize(index: Integer; size: Int64); cdecl;
    procedure setExpansionURL(index: Integer; URL: JString); cdecl;
  end;
  TJAPKExpansionPolicy = class(TJavaGenericImport<JAPKExpansionPolicyClass, JAPKExpansionPolicy>) end;

  JDeviceLimiterClass = interface(IJavaClass)
    ['{F152865E-AB95-4A30-8169-8ACA1522144D}']
  end;

  [JavaSignature('com/google/android/vending/licensing/DeviceLimiter')]
  JDeviceLimiter = interface(IJavaInstance)
    ['{EBB6D37F-98E4-4488-A84B-117DEE31E9E4}']
    function isDeviceAllowed(userId: JString): Integer; cdecl;
  end;
  TJDeviceLimiter = class(TJavaGenericImport<JDeviceLimiterClass, JDeviceLimiter>) end;

  JILicenseResultListenerClass = interface(JIInterfaceClass)
    ['{8735CD6F-44B9-45F4-863D-345922715267}']
  end;

  [JavaSignature('com/google/android/vending/licensing/ILicenseResultListener')]
  JILicenseResultListener = interface(JIInterface)
    ['{5068B9E1-9E56-4821-9734-5FB7C6A8DC85}']
    procedure verifyLicense(responseCode: Integer; signedData: JString; signature: JString); cdecl;
  end;
  TJILicenseResultListener = class(TJavaGenericImport<JILicenseResultListenerClass, JILicenseResultListener>) end;

  JILicenseResultListener_StubClass = interface(JBinderClass)
    ['{48180ACB-E93B-43F2-AD3B-A73F7A176B41}']
    {class} function init: JILicenseResultListener_Stub; cdecl;
    {class} function asInterface(obj: JIBinder): JILicenseResultListener; cdecl;
  end;

  [JavaSignature('com/google/android/vending/licensing/ILicenseResultListener$Stub')]
  JILicenseResultListener_Stub = interface(JBinder)
    ['{960F10A1-8592-4C50-8506-B589D1EA9A64}']
    function asBinder: JIBinder; cdecl;
    function onTransact(code: Integer; data: JParcel; reply: JParcel; flags: Integer): Boolean; cdecl;
  end;
  TJILicenseResultListener_Stub = class(TJavaGenericImport<JILicenseResultListener_StubClass, JILicenseResultListener_Stub>) end;

  JILicensingServiceClass = interface(JIInterfaceClass)
    ['{5B7B7AF1-8283-4DCE-BA6B-7DAA989E6C20}']
  end;

  [JavaSignature('com/google/android/vending/licensing/ILicensingService')]
  JILicensingService = interface(JIInterface)
    ['{624CBEA8-0C84-4AC6-8061-38FAF9A7F6E8}']
    procedure checkLicense(nonce: Int64; packageName: JString; listener: JILicenseResultListener); cdecl;
  end;
  TJILicensingService = class(TJavaGenericImport<JILicensingServiceClass, JILicensingService>) end;

  JILicensingService_StubClass = interface(JBinderClass)
    ['{CD2987DA-F1BB-4DDB-ADC6-88C108C2EAFE}']
    {class} function init: JILicensingService_Stub; cdecl;
    {class} function asInterface(obj: JIBinder): JILicensingService; cdecl;
  end;

  [JavaSignature('com/google/android/vending/licensing/ILicensingService$Stub')]
  JILicensingService_Stub = interface(JBinder)
    ['{10038698-0D70-479A-8064-FFD14E43F22E}']
    function asBinder: JIBinder; cdecl;
    function onTransact(code: Integer; data: JParcel; reply: JParcel; flags: Integer): Boolean; cdecl;
  end;
  TJILicensingService_Stub = class(TJavaGenericImport<JILicensingService_StubClass, JILicensingService_Stub>) end;

  JLicenseCheckerClass = interface(JObjectClass)
    ['{7D5CBCE6-32D5-4DC4-A9A9-83ED7DCB5958}']
    {class} function init(context: JContext; policy: Jlicensing_Policy; encodedPublicKey: JString): JLicenseChecker; cdecl;
  end;

  [JavaSignature('com/google/android/vending/licensing/LicenseChecker')]
  JLicenseChecker = interface(JObject)
    ['{26319EFF-5FE5-4EA8-83E4-5319E4493A23}']
    procedure checkAccess(callback: JLicenseCheckerCallback); cdecl;
    procedure onDestroy; cdecl;
    procedure onServiceConnected(name: JComponentName; service: JIBinder); cdecl;
    procedure onServiceDisconnected(name: JComponentName); cdecl;
  end;
  TJLicenseChecker = class(TJavaGenericImport<JLicenseCheckerClass, JLicenseChecker>) end;

  JLicenseCheckerCallbackClass = interface(IJavaClass)
    ['{95961C5E-E8BE-401F-B4AF-799653921CFD}']
    {class} function _GetERROR_CHECK_IN_PROGRESS: Integer; cdecl;
    {class} function _GetERROR_INVALID_PACKAGE_NAME: Integer; cdecl;
    {class} function _GetERROR_INVALID_PUBLIC_KEY: Integer; cdecl;
    {class} function _GetERROR_MISSING_PERMISSION: Integer; cdecl;
    {class} function _GetERROR_NON_MATCHING_UID: Integer; cdecl;
    {class} function _GetERROR_NOT_MARKET_MANAGED: Integer; cdecl;
    {class} property ERROR_CHECK_IN_PROGRESS: Integer read _GetERROR_CHECK_IN_PROGRESS;
    {class} property ERROR_INVALID_PACKAGE_NAME: Integer read _GetERROR_INVALID_PACKAGE_NAME;
    {class} property ERROR_INVALID_PUBLIC_KEY: Integer read _GetERROR_INVALID_PUBLIC_KEY;
    {class} property ERROR_MISSING_PERMISSION: Integer read _GetERROR_MISSING_PERMISSION;
    {class} property ERROR_NON_MATCHING_UID: Integer read _GetERROR_NON_MATCHING_UID;
    {class} property ERROR_NOT_MARKET_MANAGED: Integer read _GetERROR_NOT_MARKET_MANAGED;
  end;

  [JavaSignature('com/google/android/vending/licensing/LicenseCheckerCallback')]
  JLicenseCheckerCallback = interface(IJavaInstance)
    ['{89E61A05-026B-47D3-A198-82364C9B5B53}']
    procedure allow(reason: Integer); cdecl;
    procedure applicationError(errorCode: Integer); cdecl;
    procedure dontAllow(reason: Integer); cdecl;
  end;
  TJLicenseCheckerCallback = class(TJavaGenericImport<JLicenseCheckerCallbackClass, JLicenseCheckerCallback>) end;

  JNullDeviceLimiterClass = interface(JObjectClass)
    ['{FBE817CC-5C88-432C-9BDC-99B7AF895EAD}']
    {class} function init: JNullDeviceLimiter; cdecl;
  end;

  [JavaSignature('com/google/android/vending/licensing/NullDeviceLimiter')]
  JNullDeviceLimiter = interface(JObject)
    ['{126F2762-80F7-4EC6-80AC-3690A7C1198F}']
    function isDeviceAllowed(userId: JString): Integer; cdecl;
  end;
  TJNullDeviceLimiter = class(TJavaGenericImport<JNullDeviceLimiterClass, JNullDeviceLimiter>) end;

  JObfuscatorClass = interface(IJavaClass)
    ['{D7285329-4BFC-4697-B88E-4E12886CE4EC}']
  end;

  [JavaSignature('com/google/android/vending/licensing/Obfuscator')]
  JObfuscator = interface(IJavaInstance)
    ['{C2298636-8597-49FF-AE0A-86C9EC98AA65}']
    function obfuscate(original: JString; key: JString): JString; cdecl;
    function unobfuscate(obfuscated: JString; key: JString): JString; cdecl;
  end;
  TJObfuscator = class(TJavaGenericImport<JObfuscatorClass, JObfuscator>) end;

  Jlicensing_PolicyClass = interface(IJavaClass)
    ['{F30F5194-7323-46CA-A1FA-D375AB185678}']
    {class} function _GetLICENSED: Integer; cdecl;
    {class} function _GetNOT_LICENSED: Integer; cdecl;
    {class} function _GetRETRY: Integer; cdecl;
    {class} property LICENSED: Integer read _GetLICENSED;
    {class} property NOT_LICENSED: Integer read _GetNOT_LICENSED;
    {class} property RETRY: Integer read _GetRETRY;
  end;

  [JavaSignature('com/google/android/vending/licensing/Policy')]
  Jlicensing_Policy = interface(IJavaInstance)
    ['{F8932C2C-7AF9-48E4-B9CA-B48F44904783}']
    function allowAccess: Boolean; cdecl;
    procedure processServerResponse(response: Integer; rawData: JResponseData); cdecl;
  end;
  TJlicensing_Policy = class(TJavaGenericImport<Jlicensing_PolicyClass, Jlicensing_Policy>) end;

  JPreferenceObfuscatorClass = interface(JObjectClass)
    ['{3F1D2984-06B0-4DFB-9D0E-93E8F80F1944}']
    {class} function init(sp: JSharedPreferences; o: JObfuscator): JPreferenceObfuscator; cdecl;
  end;

  [JavaSignature('com/google/android/vending/licensing/PreferenceObfuscator')]
  JPreferenceObfuscator = interface(JObject)
    ['{9E65AF7D-F6EB-4E6C-8472-A8D3E4362376}']
    procedure commit; cdecl;
    function getString(key: JString; defValue: JString): JString; cdecl;
    procedure putString(key: JString; value: JString); cdecl;
  end;
  TJPreferenceObfuscator = class(TJavaGenericImport<JPreferenceObfuscatorClass, JPreferenceObfuscator>) end;

  JResponseDataClass = interface(JObjectClass)
    ['{6FB3D196-51DD-44FF-9C24-E7663EBC017F}']
    {class} function init: JResponseData; cdecl;
    {class} function parse(responseData: JString): JResponseData; cdecl;
  end;

  [JavaSignature('com/google/android/vending/licensing/ResponseData')]
  JResponseData = interface(JObject)
    ['{D4CAD4F3-A0F1-45CA-B7AE-E1B14AF600B0}']
    function _Getextra: JString; cdecl;
    procedure _Setextra(Value: JString); cdecl;
    function _Getnonce: Integer; cdecl;
    procedure _Setnonce(Value: Integer); cdecl;
    function _GetpackageName: JString; cdecl;
    procedure _SetpackageName(Value: JString); cdecl;
    function _GetresponseCode: Integer; cdecl;
    procedure _SetresponseCode(Value: Integer); cdecl;
    function _Gettimestamp: Int64; cdecl;
    procedure _Settimestamp(Value: Int64); cdecl;
    function _GetuserId: JString; cdecl;
    procedure _SetuserId(Value: JString); cdecl;
    function _GetversionCode: JString; cdecl;
    procedure _SetversionCode(Value: JString); cdecl;
    function toString: JString; cdecl;
    property extra: JString read _Getextra write _Setextra;
    property nonce: Integer read _Getnonce write _Setnonce;
    property packageName: JString read _GetpackageName write _SetpackageName;
    property responseCode: Integer read _GetresponseCode write _SetresponseCode;
    property timestamp: Int64 read _Gettimestamp write _Settimestamp;
    property userId: JString read _GetuserId write _SetuserId;
    property versionCode: JString read _GetversionCode write _SetversionCode;
  end;
  TJResponseData = class(TJavaGenericImport<JResponseDataClass, JResponseData>) end;

  JServerManagedPolicyClass = interface(JObjectClass)
    ['{A17DDC78-5806-4E9F-B6DB-93D43B1FEF1F}']
    {class} function init(context: JContext; obfuscator: JObfuscator): JServerManagedPolicy; cdecl;
  end;

  [JavaSignature('com/google/android/vending/licensing/ServerManagedPolicy')]
  JServerManagedPolicy = interface(JObject)
    ['{DE9A9C94-AE7B-42E6-9352-C2F5DA01F458}']
    function allowAccess: Boolean; cdecl;
    function getMaxRetries: Int64; cdecl;
    function getRetryCount: Int64; cdecl;
    function getRetryUntil: Int64; cdecl;
    function getValidityTimestamp: Int64; cdecl;
    procedure processServerResponse(response: Integer; rawData: JResponseData); cdecl;
  end;
  TJServerManagedPolicy = class(TJavaGenericImport<JServerManagedPolicyClass, JServerManagedPolicy>) end;

  JStrictPolicyClass = interface(JObjectClass)
    ['{75D0AA86-C7B0-4904-B502-CB80E1450F8B}']
    {class} function init: JStrictPolicy; cdecl;
  end;

  [JavaSignature('com/google/android/vending/licensing/StrictPolicy')]
  JStrictPolicy = interface(JObject)
    ['{6C413FE6-AC6C-4B00-B658-71AC298B9051}']
    function allowAccess: Boolean; cdecl;
    procedure processServerResponse(response: Integer; rawData: JResponseData); cdecl;
  end;
  TJStrictPolicy = class(TJavaGenericImport<JStrictPolicyClass, JStrictPolicy>) end;

  JValidationExceptionClass = interface(JExceptionClass)
    ['{4E036DD9-2488-4860-B92E-F9888A45A003}']
    {class} function init: JValidationException; cdecl; overload;
    {class} function init(s: JString): JValidationException; cdecl; overload;
  end;

  [JavaSignature('com/google/android/vending/licensing/ValidationException')]
  JValidationException = interface(JException)
    ['{E0A5A0D7-AE87-4C02-830B-8FCB67BF2C9C}']
  end;
  TJValidationException = class(TJavaGenericImport<JValidationExceptionClass, JValidationException>) end;

  Jutil_Base64Class = interface(JObjectClass)
    ['{93BCFD52-79EC-4F15-8C10-49BE6EE35041}']
    {class} function _GetDECODE: Boolean; cdecl;
    {class} function _GetENCODE: Boolean; cdecl;
    {class} function decode(s: JString): TJavaArray<Byte>; cdecl; overload;
    {class} function decode(source: TJavaArray<Byte>): TJavaArray<Byte>; cdecl; overload;
    {class} function decode(source: TJavaArray<Byte>; off: Integer; len: Integer): TJavaArray<Byte>; cdecl; overload;
    {class} function decode(source: TJavaArray<Byte>; off: Integer; len: Integer; decodabet: TJavaArray<Byte>): TJavaArray<Byte>; cdecl; overload;
    {class} function decodeWebSafe(s: JString): TJavaArray<Byte>; cdecl; overload;
    {class} function decodeWebSafe(source: TJavaArray<Byte>): TJavaArray<Byte>; cdecl; overload;
    {class} function decodeWebSafe(source: TJavaArray<Byte>; off: Integer; len: Integer): TJavaArray<Byte>; cdecl; overload;
    {class} function encode(source: TJavaArray<Byte>): JString; cdecl; overload;
    {class} function encode(source: TJavaArray<Byte>; off: Integer; len: Integer; alphabet: TJavaArray<Byte>; doPadding: Boolean): JString; cdecl; overload;
    {class} function encode(source: TJavaArray<Byte>; off: Integer; len: Integer; alphabet: TJavaArray<Byte>; maxLineLength: Integer): TJavaArray<Byte>; cdecl; overload;
    {class} function encodeWebSafe(source: TJavaArray<Byte>; doPadding: Boolean): JString; cdecl;
    {class} property DECODE: Boolean read _GetDECODE;
    {class} property ENCODE: Boolean read _GetENCODE;
  end;

  [JavaSignature('com/google/android/vending/licensing/util/Base64')]
  Jutil_Base64 = interface(JObject)
    ['{FF441DE6-1F42-4C8E-B748-126F00309AB3}']
  end;
  TJutil_Base64 = class(TJavaGenericImport<Jutil_Base64Class, Jutil_Base64>) end;

  JBase64DecoderExceptionClass = interface(JExceptionClass)
    ['{8E5D4C35-4522-46F4-8B48-1969172871DD}']
    {class} function init: JBase64DecoderException; cdecl; overload;
    {class} function init(s: JString): JBase64DecoderException; cdecl; overload;
  end;

  [JavaSignature('com/google/android/vending/licensing/util/Base64DecoderException')]
  JBase64DecoderException = interface(JException)
    ['{15F9F8C7-65B4-4DDB-B6A6-ADBACF394DFF}']
  end;
  TJBase64DecoderException = class(TJavaGenericImport<JBase64DecoderExceptionClass, JBase64DecoderException>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JAESObfuscator', TypeInfo(Androidapi.JNI.Licensing.JAESObfuscator));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JAPKExpansionPolicy', TypeInfo(Androidapi.JNI.Licensing.JAPKExpansionPolicy));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JDeviceLimiter', TypeInfo(Androidapi.JNI.Licensing.JDeviceLimiter));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JILicenseResultListener', TypeInfo(Androidapi.JNI.Licensing.JILicenseResultListener));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JILicenseResultListener_Stub', TypeInfo(Androidapi.JNI.Licensing.JILicenseResultListener_Stub));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JILicensingService', TypeInfo(Androidapi.JNI.Licensing.JILicensingService));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JILicensingService_Stub', TypeInfo(Androidapi.JNI.Licensing.JILicensingService_Stub));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JLicenseChecker', TypeInfo(Androidapi.JNI.Licensing.JLicenseChecker));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JLicenseCheckerCallback', TypeInfo(Androidapi.JNI.Licensing.JLicenseCheckerCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JNullDeviceLimiter', TypeInfo(Androidapi.JNI.Licensing.JNullDeviceLimiter));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JObfuscator', TypeInfo(Androidapi.JNI.Licensing.JObfuscator));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.Jlicensing_Policy', TypeInfo(Androidapi.JNI.Licensing.Jlicensing_Policy));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JPreferenceObfuscator', TypeInfo(Androidapi.JNI.Licensing.JPreferenceObfuscator));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JResponseData', TypeInfo(Androidapi.JNI.Licensing.JResponseData));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JServerManagedPolicy', TypeInfo(Androidapi.JNI.Licensing.JServerManagedPolicy));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JStrictPolicy', TypeInfo(Androidapi.JNI.Licensing.JStrictPolicy));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JValidationException', TypeInfo(Androidapi.JNI.Licensing.JValidationException));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.Jutil_Base64', TypeInfo(Androidapi.JNI.Licensing.Jutil_Base64));
  TRegTypes.RegisterType('Androidapi.JNI.Licensing.JBase64DecoderException', TypeInfo(Androidapi.JNI.Licensing.JBase64DecoderException));
end;

initialization
  RegisterTypes;
end.


