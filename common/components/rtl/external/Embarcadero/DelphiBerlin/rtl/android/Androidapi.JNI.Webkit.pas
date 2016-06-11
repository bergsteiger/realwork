{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Webkit;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Java.Security,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Print,
  Androidapi.JNI.Util,
  Androidapi.JNI.Widget;

type
// ===== Forward declarations =====

  JClientCertRequest = interface;//android.webkit.ClientCertRequest
  JConsoleMessage = interface;//android.webkit.ConsoleMessage
  JConsoleMessage_MessageLevel = interface;//android.webkit.ConsoleMessage$MessageLevel
  JCookieManager = interface;//android.webkit.CookieManager
  JCookieSyncManager = interface;//android.webkit.CookieSyncManager
  JDateSorter = interface;//android.webkit.DateSorter
  JDownloadListener = interface;//android.webkit.DownloadListener
  JGeolocationPermissions = interface;//android.webkit.GeolocationPermissions
  JGeolocationPermissions_Callback = interface;//android.webkit.GeolocationPermissions$Callback
  JHttpAuthHandler = interface;//android.webkit.HttpAuthHandler
  JJavascriptInterface = interface;//android.webkit.JavascriptInterface
  JJsResult = interface;//android.webkit.JsResult
  JJsPromptResult = interface;//android.webkit.JsPromptResult
  JMimeTypeMap = interface;//android.webkit.MimeTypeMap
  JPermissionRequest = interface;//android.webkit.PermissionRequest
  JPluginStub = interface;//android.webkit.PluginStub
  JSslErrorHandler = interface;//android.webkit.SslErrorHandler
  JURLUtil = interface;//android.webkit.URLUtil
  JValueCallback = interface;//android.webkit.ValueCallback
  JWebBackForwardList = interface;//android.webkit.WebBackForwardList
  JWebChromeClient = interface;//android.webkit.WebChromeClient
  JWebChromeClient_CustomViewCallback = interface;//android.webkit.WebChromeClient$CustomViewCallback
  JWebChromeClient_FileChooserParams = interface;//android.webkit.WebChromeClient$FileChooserParams
  JWebHistoryItem = interface;//android.webkit.WebHistoryItem
  JWebIconDatabase = interface;//android.webkit.WebIconDatabase
  JWebIconDatabase_IconListener = interface;//android.webkit.WebIconDatabase$IconListener
  JWebMessage = interface;//android.webkit.WebMessage
  JWebMessagePort = interface;//android.webkit.WebMessagePort
  JWebMessagePort_WebMessageCallback = interface;//android.webkit.WebMessagePort$WebMessageCallback
  JWebResourceError = interface;//android.webkit.WebResourceError
  JWebResourceRequest = interface;//android.webkit.WebResourceRequest
  JWebResourceResponse = interface;//android.webkit.WebResourceResponse
  JWebSettings = interface;//android.webkit.WebSettings
  JWebSettings_LayoutAlgorithm = interface;//android.webkit.WebSettings$LayoutAlgorithm
  JWebSettings_PluginState = interface;//android.webkit.WebSettings$PluginState
  JWebSettings_RenderPriority = interface;//android.webkit.WebSettings$RenderPriority
  JWebSettings_TextSize = interface;//android.webkit.WebSettings$TextSize
  JWebSettings_ZoomDensity = interface;//android.webkit.WebSettings$ZoomDensity
  JWebStorage = interface;//android.webkit.WebStorage
  JWebStorage_Origin = interface;//android.webkit.WebStorage$Origin
  JWebStorage_QuotaUpdater = interface;//android.webkit.WebStorage$QuotaUpdater
  JWebView = interface;//android.webkit.WebView
  JWebView_FindListener = interface;//android.webkit.WebView$FindListener
  JWebView_HitTestResult = interface;//android.webkit.WebView$HitTestResult
  JWebView_PictureListener = interface;//android.webkit.WebView$PictureListener
  JWebView_VisualStateCallback = interface;//android.webkit.WebView$VisualStateCallback
  JWebView_WebViewTransport = interface;//android.webkit.WebView$WebViewTransport
  JWebViewClient = interface;//android.webkit.WebViewClient
  JWebViewDatabase = interface;//android.webkit.WebViewDatabase
  JWebViewFragment = interface;//android.webkit.WebViewFragment

// ===== Interface declarations =====

  JClientCertRequestClass = interface(JObjectClass)
    ['{91624F2C-4EB1-48F2-91DD-A792988486B3}']
    {class} function init: JClientCertRequest; cdecl;
  end;

  [JavaSignature('android/webkit/ClientCertRequest')]
  JClientCertRequest = interface(JObject)
    ['{8BF18830-4FB6-4F4B-8351-9CFA03362E2A}']
    procedure cancel; cdecl;
    function getHost: JString; cdecl;
    function getKeyTypes: TJavaObjectArray<JString>; cdecl;
    function getPort: Integer; cdecl;
    function getPrincipals: TJavaObjectArray<JPrincipal>; cdecl;
    procedure ignore; cdecl;
    procedure proceed(privateKey: JPrivateKey; chain: TJavaObjectArray<JX509Certificate>); cdecl;
  end;
  TJClientCertRequest = class(TJavaGenericImport<JClientCertRequestClass, JClientCertRequest>) end;

  JConsoleMessageClass = interface(JObjectClass)
    ['{CBB5BC88-0DE7-4587-8D99-B2F2B69BD91C}']
    {class} function init(message: JString; sourceId: JString; lineNumber: Integer; msgLevel: JConsoleMessage_MessageLevel): JConsoleMessage; cdecl;
  end;

  [JavaSignature('android/webkit/ConsoleMessage')]
  JConsoleMessage = interface(JObject)
    ['{08638DAF-1309-4F99-9B6D-8998BF31A730}']
    function lineNumber: Integer; cdecl;
    function message: JString; cdecl;
    function messageLevel: JConsoleMessage_MessageLevel; cdecl;
    function sourceId: JString; cdecl;
  end;
  TJConsoleMessage = class(TJavaGenericImport<JConsoleMessageClass, JConsoleMessage>) end;

  JConsoleMessage_MessageLevelClass = interface(JEnumClass)
    ['{EBA1E801-E409-4FD2-B5D0-A21E3D73C05A}']
    {class} function _GetDEBUG: JConsoleMessage_MessageLevel; cdecl;
    {class} function _GetERROR: JConsoleMessage_MessageLevel; cdecl;
    {class} function _GetLOG: JConsoleMessage_MessageLevel; cdecl;
    {class} function _GetTIP: JConsoleMessage_MessageLevel; cdecl;
    {class} function _GetWARNING: JConsoleMessage_MessageLevel; cdecl;
    {class} function valueOf(name: JString): JConsoleMessage_MessageLevel; cdecl;
    {class} function values: TJavaObjectArray<JConsoleMessage_MessageLevel>; cdecl;
    {class} property DEBUG: JConsoleMessage_MessageLevel read _GetDEBUG;
    {class} property ERROR: JConsoleMessage_MessageLevel read _GetERROR;
    {class} property LOG: JConsoleMessage_MessageLevel read _GetLOG;
    {class} property TIP: JConsoleMessage_MessageLevel read _GetTIP;
    {class} property WARNING: JConsoleMessage_MessageLevel read _GetWARNING;
  end;

  [JavaSignature('android/webkit/ConsoleMessage$MessageLevel')]
  JConsoleMessage_MessageLevel = interface(JEnum)
    ['{D2D9F689-DB98-41EE-A319-0BE781C70A98}']
  end;
  TJConsoleMessage_MessageLevel = class(TJavaGenericImport<JConsoleMessage_MessageLevelClass, JConsoleMessage_MessageLevel>) end;

  JCookieManagerClass = interface(JObjectClass)
    ['{AA56EEB3-9124-4EA5-9C2D-F2A34B85A746}']
    {class} function init: JCookieManager; cdecl;
    {class} function allowFileSchemeCookies: Boolean; cdecl;
    {class} function getInstance: JCookieManager; cdecl;
    {class} procedure setAcceptFileSchemeCookies(accept: Boolean); cdecl;
  end;

  [JavaSignature('android/webkit/CookieManager')]
  JCookieManager = interface(JObject)
    ['{D034D488-20B0-40B1-B8E8-DBA885920119}']
    function acceptCookie: Boolean; cdecl;
    function acceptThirdPartyCookies(webview: JWebView): Boolean; cdecl;
    procedure flush; cdecl;
    function getCookie(url: JString): JString; cdecl;
    function hasCookies: Boolean; cdecl;
    procedure removeAllCookie; cdecl;//Deprecated
    procedure removeAllCookies(callback: JValueCallback); cdecl;
    procedure removeExpiredCookie; cdecl;//Deprecated
    procedure removeSessionCookie; cdecl;//Deprecated
    procedure removeSessionCookies(callback: JValueCallback); cdecl;
    procedure setAcceptCookie(accept: Boolean); cdecl;
    procedure setAcceptThirdPartyCookies(webview: JWebView; accept: Boolean); cdecl;
    procedure setCookie(url: JString; value: JString); cdecl; overload;
    procedure setCookie(url: JString; value: JString; callback: JValueCallback); cdecl; overload;
  end;
  TJCookieManager = class(TJavaGenericImport<JCookieManagerClass, JCookieManager>) end;

  JCookieSyncManagerClass = interface(JObjectClass)
    ['{96CCECF6-1D55-49E3-9DB6-A260AFD605BF}']
    {class} function createInstance(context: JContext): JCookieSyncManager; cdecl;
    {class} function getInstance: JCookieSyncManager; cdecl;
  end;

  [JavaSignature('android/webkit/CookieSyncManager')]
  JCookieSyncManager = interface(JObject)
    ['{A548B195-9703-456F-9ACB-26DF88014690}']
    procedure resetSync; cdecl;//Deprecated
    procedure startSync; cdecl;//Deprecated
    procedure stopSync; cdecl;//Deprecated
    procedure sync; cdecl;//Deprecated
  end;
  TJCookieSyncManager = class(TJavaGenericImport<JCookieSyncManagerClass, JCookieSyncManager>) end;

  JDateSorterClass = interface(JObjectClass)
    ['{E5ED8EFC-3CB5-4650-A9B3-6B09646B0C50}']
    {class} function _GetDAY_COUNT: Integer; cdecl;
    {class} function init(context: JContext): JDateSorter; cdecl;
    {class} property DAY_COUNT: Integer read _GetDAY_COUNT;
  end;

  [JavaSignature('android/webkit/DateSorter')]
  JDateSorter = interface(JObject)
    ['{566DE920-3B0F-4AF9-A8EF-BC81E5E3499B}']
    function getBoundary(index: Integer): Int64; cdecl;
    function getIndex(time: Int64): Integer; cdecl;
    function getLabel(index: Integer): JString; cdecl;
  end;
  TJDateSorter = class(TJavaGenericImport<JDateSorterClass, JDateSorter>) end;

  JDownloadListenerClass = interface(IJavaClass)
    ['{DAFCF031-2702-4450-A30A-8CBB59C687FA}']
  end;

  [JavaSignature('android/webkit/DownloadListener')]
  JDownloadListener = interface(IJavaInstance)
    ['{BB9F3B4B-B375-4870-AE50-66DDCB0253F8}']
    procedure onDownloadStart(url: JString; userAgent: JString; contentDisposition: JString; mimetype: JString; contentLength: Int64); cdecl;
  end;
  TJDownloadListener = class(TJavaGenericImport<JDownloadListenerClass, JDownloadListener>) end;

  JGeolocationPermissionsClass = interface(JObjectClass)
    ['{0EDFDB2D-5AA5-4B9F-AFF1-48B33D4DB768}']
    {class} function getInstance: JGeolocationPermissions; cdecl;
  end;

  [JavaSignature('android/webkit/GeolocationPermissions')]
  JGeolocationPermissions = interface(JObject)
    ['{3DB62872-CE2B-441A-880F-61853F0D1429}']
    procedure allow(origin: JString); cdecl;
    procedure clear(origin: JString); cdecl;
    procedure clearAll; cdecl;
    procedure getAllowed(origin: JString; callback: JValueCallback); cdecl;
    procedure getOrigins(callback: JValueCallback); cdecl;
  end;
  TJGeolocationPermissions = class(TJavaGenericImport<JGeolocationPermissionsClass, JGeolocationPermissions>) end;

  JGeolocationPermissions_CallbackClass = interface(IJavaClass)
    ['{38C6FDC6-38D6-4C2E-A2DA-2F548B75F1EA}']
  end;

  [JavaSignature('android/webkit/GeolocationPermissions$Callback')]
  JGeolocationPermissions_Callback = interface(IJavaInstance)
    ['{A8E62A13-B89F-4680-94F1-FAC7FC900D31}']
    procedure invoke(origin: JString; allow: Boolean; retain: Boolean); cdecl;
  end;
  TJGeolocationPermissions_Callback = class(TJavaGenericImport<JGeolocationPermissions_CallbackClass, JGeolocationPermissions_Callback>) end;

  JHttpAuthHandlerClass = interface(JHandlerClass)
    ['{F4F240E8-5AD8-4E01-A7F6-3F014FC5ED61}']
  end;

  [JavaSignature('android/webkit/HttpAuthHandler')]
  JHttpAuthHandler = interface(JHandler)
    ['{0E61C17C-91B0-4DF0-B85E-E270B4F69B4B}']
    procedure cancel; cdecl;
    procedure proceed(username: JString; password: JString); cdecl;
    function useHttpAuthUsernamePassword: Boolean; cdecl;
  end;
  TJHttpAuthHandler = class(TJavaGenericImport<JHttpAuthHandlerClass, JHttpAuthHandler>) end;

  JJavascriptInterfaceClass = interface(JObjectClass)
    ['{7D851A79-CBFE-4C5B-A5DC-44A4877FCF7B}']
  end;

  [JavaSignature('android/webkit/JavascriptInterface')]
  JJavascriptInterface = interface(JObject)
    ['{4F64688D-578A-4D9A-9FD3-1014C2FDFE50}']
  end;
  TJJavascriptInterface = class(TJavaGenericImport<JJavascriptInterfaceClass, JJavascriptInterface>) end;

  JJsResultClass = interface(JObjectClass)
    ['{EC8170B1-2E48-4399-8F0B-690249282CD8}']
  end;

  [JavaSignature('android/webkit/JsResult')]
  JJsResult = interface(JObject)
    ['{FB00569F-6419-40C9-AFE2-97632E5CB25B}']
    procedure cancel; cdecl;
    procedure confirm; cdecl;
  end;
  TJJsResult = class(TJavaGenericImport<JJsResultClass, JJsResult>) end;

  JJsPromptResultClass = interface(JJsResultClass)
    ['{87DB5C55-9E24-4E97-AEB9-5175CE44962F}']
  end;

  [JavaSignature('android/webkit/JsPromptResult')]
  JJsPromptResult = interface(JJsResult)
    ['{D88E5DFB-C1B1-444D-AA87-E71D6A50ED21}']
    procedure confirm(result: JString); cdecl;
  end;
  TJJsPromptResult = class(TJavaGenericImport<JJsPromptResultClass, JJsPromptResult>) end;

  JMimeTypeMapClass = interface(JObjectClass)
    ['{590CAE2F-22DD-48BB-8A6A-4B73936BA71C}']
    {class} function getFileExtensionFromUrl(url: JString): JString; cdecl;
    {class} function getSingleton: JMimeTypeMap; cdecl;
  end;

  [JavaSignature('android/webkit/MimeTypeMap')]
  JMimeTypeMap = interface(JObject)
    ['{40155926-B3E3-4365-99C5-A928F3EB30C7}']
    function getExtensionFromMimeType(mimeType: JString): JString; cdecl;
    function getMimeTypeFromExtension(extension: JString): JString; cdecl;
    function hasExtension(extension: JString): Boolean; cdecl;
    function hasMimeType(mimeType: JString): Boolean; cdecl;
  end;
  TJMimeTypeMap = class(TJavaGenericImport<JMimeTypeMapClass, JMimeTypeMap>) end;

  JPermissionRequestClass = interface(JObjectClass)
    ['{4F6758BC-07C6-481E-A18F-9605EB4E911A}']
    {class} function _GetRESOURCE_AUDIO_CAPTURE: JString; cdecl;
    {class} function _GetRESOURCE_MIDI_SYSEX: JString; cdecl;
    {class} function _GetRESOURCE_PROTECTED_MEDIA_ID: JString; cdecl;
    {class} function _GetRESOURCE_VIDEO_CAPTURE: JString; cdecl;
    {class} function init: JPermissionRequest; cdecl;
    {class} property RESOURCE_AUDIO_CAPTURE: JString read _GetRESOURCE_AUDIO_CAPTURE;
    {class} property RESOURCE_MIDI_SYSEX: JString read _GetRESOURCE_MIDI_SYSEX;
    {class} property RESOURCE_PROTECTED_MEDIA_ID: JString read _GetRESOURCE_PROTECTED_MEDIA_ID;
    {class} property RESOURCE_VIDEO_CAPTURE: JString read _GetRESOURCE_VIDEO_CAPTURE;
  end;

  [JavaSignature('android/webkit/PermissionRequest')]
  JPermissionRequest = interface(JObject)
    ['{89C3D143-C210-4D87-B945-373AEEE139BD}']
    procedure deny; cdecl;
    function getOrigin: Jnet_Uri; cdecl;
    function getResources: TJavaObjectArray<JString>; cdecl;
    procedure grant(resources: TJavaObjectArray<JString>); cdecl;
  end;
  TJPermissionRequest = class(TJavaGenericImport<JPermissionRequestClass, JPermissionRequest>) end;

  JPluginStubClass = interface(IJavaClass)
    ['{91084F0F-96A4-45B7-B49C-DD7FC6559594}']
  end;

  [JavaSignature('android/webkit/PluginStub')]
  JPluginStub = interface(IJavaInstance)
    ['{243F5981-F358-4C6C-AB67-08F1B0C2D706}']
    function getEmbeddedView(NPP: Integer; context: JContext): JView; cdecl;
    function getFullScreenView(NPP: Integer; context: JContext): JView; cdecl;
  end;
  TJPluginStub = class(TJavaGenericImport<JPluginStubClass, JPluginStub>) end;

  JSslErrorHandlerClass = interface(JHandlerClass)
    ['{9C90D0D5-1B1D-4969-979F-CA60801EE6BD}']
  end;

  [JavaSignature('android/webkit/SslErrorHandler')]
  JSslErrorHandler = interface(JHandler)
    ['{03C0743D-557A-4B5D-942C-8C2B15F645C3}']
    procedure cancel; cdecl;
    procedure proceed; cdecl;
  end;
  TJSslErrorHandler = class(TJavaGenericImport<JSslErrorHandlerClass, JSslErrorHandler>) end;

  JURLUtilClass = interface(JObjectClass)
    ['{F338F90A-949B-4324-ABB8-FEAE849ED7C9}']
    {class} function init: JURLUtil; cdecl;
    {class} function composeSearchUrl(inQuery: JString; template: JString; queryPlaceHolder: JString): JString; cdecl;
    {class} function decode(url: TJavaArray<Byte>): TJavaArray<Byte>; cdecl;
    {class} function guessFileName(url: JString; contentDisposition: JString; mimeType: JString): JString; cdecl;
    {class} function guessUrl(inUrl: JString): JString; cdecl;
    {class} function isAboutUrl(url: JString): Boolean; cdecl;
    {class} function isAssetUrl(url: JString): Boolean; cdecl;
    {class} function isContentUrl(url: JString): Boolean; cdecl;
    {class} function isCookielessProxyUrl(url: JString): Boolean; cdecl;//Deprecated
    {class} function isDataUrl(url: JString): Boolean; cdecl;
    {class} function isFileUrl(url: JString): Boolean; cdecl;
    {class} function isHttpUrl(url: JString): Boolean; cdecl;
    {class} function isHttpsUrl(url: JString): Boolean; cdecl;
    {class} function isJavaScriptUrl(url: JString): Boolean; cdecl;
    {class} function isNetworkUrl(url: JString): Boolean; cdecl;
    {class} function isValidUrl(url: JString): Boolean; cdecl;
    {class} function stripAnchor(url: JString): JString; cdecl;
  end;

  [JavaSignature('android/webkit/URLUtil')]
  JURLUtil = interface(JObject)
    ['{C40526A5-9EB7-414D-90AC-36D4F2B55993}']
  end;
  TJURLUtil = class(TJavaGenericImport<JURLUtilClass, JURLUtil>) end;

  JValueCallbackClass = interface(IJavaClass)
    ['{5CE4D0B0-6C4F-43BD-B57F-A06401A5FB2F}']
  end;

  [JavaSignature('android/webkit/ValueCallback')]
  JValueCallback = interface(IJavaInstance)
    ['{3B24779A-3678-4AD8-B421-A8A9C6F3E742}']
    procedure onReceiveValue(value: JObject); cdecl;
  end;
  TJValueCallback = class(TJavaGenericImport<JValueCallbackClass, JValueCallback>) end;

  JWebBackForwardListClass = interface(JObjectClass)
    ['{A07CD657-C6A4-4BB3-9DE1-5FAD34D2FAB3}']
    {class} function init: JWebBackForwardList; cdecl;
  end;

  [JavaSignature('android/webkit/WebBackForwardList')]
  JWebBackForwardList = interface(JObject)
    ['{CA2E0F5D-8FD8-4DDC-BDB4-73EB780AE1B9}']
    function getCurrentIndex: Integer; cdecl;
    function getCurrentItem: JWebHistoryItem; cdecl;
    function getItemAtIndex(index: Integer): JWebHistoryItem; cdecl;
    function getSize: Integer; cdecl;
  end;
  TJWebBackForwardList = class(TJavaGenericImport<JWebBackForwardListClass, JWebBackForwardList>) end;

  JWebChromeClientClass = interface(JObjectClass)
    ['{0DEC9AF7-FCC8-4616-86FD-4974D4FCB026}']
    {class} function init: JWebChromeClient; cdecl;
  end;

  [JavaSignature('android/webkit/WebChromeClient')]
  JWebChromeClient = interface(JObject)
    ['{B8E15ECA-8A1A-4321-8E4D-5881F6D8F9EF}']
    function getDefaultVideoPoster: JBitmap; cdecl;
    function getVideoLoadingProgressView: JView; cdecl;
    procedure getVisitedHistory(callback: TJavaObjectArray<JValueCallback>); cdecl;
    procedure onCloseWindow(window: JWebView); cdecl;
    procedure onConsoleMessage(message: JString; lineNumber: Integer; sourceID: JString); cdecl; overload;//Deprecated
    function onConsoleMessage(consoleMessage: JConsoleMessage): Boolean; cdecl; overload;
    function onCreateWindow(view: JWebView; isDialog: Boolean; isUserGesture: Boolean; resultMsg: JMessage): Boolean; cdecl;
    procedure onExceededDatabaseQuota(url: JString; databaseIdentifier: JString; quota: Int64; estimatedDatabaseSize: Int64; totalQuota: Int64; quotaUpdater: JWebStorage_QuotaUpdater); cdecl;//Deprecated
    procedure onGeolocationPermissionsHidePrompt; cdecl;
    procedure onGeolocationPermissionsShowPrompt(origin: JString; callback: JGeolocationPermissions_Callback); cdecl;
    procedure onHideCustomView; cdecl;
    function onJsAlert(view: JWebView; url: JString; message: JString; result: JJsResult): Boolean; cdecl;
    function onJsBeforeUnload(view: JWebView; url: JString; message: JString; result: JJsResult): Boolean; cdecl;
    function onJsConfirm(view: JWebView; url: JString; message: JString; result: JJsResult): Boolean; cdecl;
    function onJsPrompt(view: JWebView; url: JString; message: JString; defaultValue: JString; result: JJsPromptResult): Boolean; cdecl;
    function onJsTimeout: Boolean; cdecl;//Deprecated
    procedure onPermissionRequest(request: JPermissionRequest); cdecl;
    procedure onPermissionRequestCanceled(request: JPermissionRequest); cdecl;
    procedure onProgressChanged(view: JWebView; newProgress: Integer); cdecl;
    procedure onReachedMaxAppCacheSize(requiredStorage: Int64; quota: Int64; quotaUpdater: JWebStorage_QuotaUpdater); cdecl;//Deprecated
    procedure onReceivedIcon(view: JWebView; icon: JBitmap); cdecl;
    procedure onReceivedTitle(view: JWebView; title: JString); cdecl;
    procedure onReceivedTouchIconUrl(view: JWebView; url: JString; precomposed: Boolean); cdecl;
    procedure onRequestFocus(view: JWebView); cdecl;
    procedure onShowCustomView(view: JView; callback: JWebChromeClient_CustomViewCallback); cdecl; overload;
    procedure onShowCustomView(view: JView; requestedOrientation: Integer; callback: JWebChromeClient_CustomViewCallback); cdecl; overload;//Deprecated
    function onShowFileChooser(webView: JWebView; filePathCallback: TJavaObjectArray<JValueCallback>; fileChooserParams: JWebChromeClient_FileChooserParams): Boolean; cdecl;
  end;
  TJWebChromeClient = class(TJavaGenericImport<JWebChromeClientClass, JWebChromeClient>) end;

  JWebChromeClient_CustomViewCallbackClass = interface(IJavaClass)
    ['{4B9AF0A9-F503-4054-B3BF-498AD5CD50F8}']
  end;

  [JavaSignature('android/webkit/WebChromeClient$CustomViewCallback')]
  JWebChromeClient_CustomViewCallback = interface(IJavaInstance)
    ['{2C042439-AB81-4675-9E99-CA4E3C8D84E1}']
    procedure onCustomViewHidden; cdecl;
  end;
  TJWebChromeClient_CustomViewCallback = class(TJavaGenericImport<JWebChromeClient_CustomViewCallbackClass, JWebChromeClient_CustomViewCallback>) end;

  JWebChromeClient_FileChooserParamsClass = interface(JObjectClass)
    ['{58CF8E81-BB27-4084-9AFA-3186883B7E1C}']
    {class} function _GetMODE_OPEN: Integer; cdecl;
    {class} function _GetMODE_OPEN_MULTIPLE: Integer; cdecl;
    {class} function _GetMODE_SAVE: Integer; cdecl;
    {class} function init: JWebChromeClient_FileChooserParams; cdecl;
    {class} function parseResult(resultCode: Integer; data: JIntent): TJavaObjectArray<Jnet_Uri>; cdecl;
    {class} property MODE_OPEN: Integer read _GetMODE_OPEN;
    {class} property MODE_OPEN_MULTIPLE: Integer read _GetMODE_OPEN_MULTIPLE;
    {class} property MODE_SAVE: Integer read _GetMODE_SAVE;
  end;

  [JavaSignature('android/webkit/WebChromeClient$FileChooserParams')]
  JWebChromeClient_FileChooserParams = interface(JObject)
    ['{9D8E1736-3779-4E8A-BCCD-95DC4E1F5BF9}']
    function createIntent: JIntent; cdecl;
    function getAcceptTypes: TJavaObjectArray<JString>; cdecl;
    function getFilenameHint: JString; cdecl;
    function getMode: Integer; cdecl;
    function getTitle: JCharSequence; cdecl;
    function isCaptureEnabled: Boolean; cdecl;
  end;
  TJWebChromeClient_FileChooserParams = class(TJavaGenericImport<JWebChromeClient_FileChooserParamsClass, JWebChromeClient_FileChooserParams>) end;

  JWebHistoryItemClass = interface(JObjectClass)
    ['{58FE1F44-7620-49B7-BA50-CF97126D6C75}']
    {class} function init: JWebHistoryItem; cdecl;
  end;

  [JavaSignature('android/webkit/WebHistoryItem')]
  JWebHistoryItem = interface(JObject)
    ['{B4724762-EFAC-4E05-962A-0D3E7684730D}']
    function getFavicon: JBitmap; cdecl;
    function getOriginalUrl: JString; cdecl;
    function getTitle: JString; cdecl;
    function getUrl: JString; cdecl;
  end;
  TJWebHistoryItem = class(TJavaGenericImport<JWebHistoryItemClass, JWebHistoryItem>) end;

  JWebIconDatabaseClass = interface(JObjectClass)
    ['{1D432D65-2ABB-4EFD-A989-7D0DF89F8868}']
    {class} function init: JWebIconDatabase; cdecl;
    {class} function getInstance: JWebIconDatabase; cdecl;
  end;

  [JavaSignature('android/webkit/WebIconDatabase')]
  JWebIconDatabase = interface(JObject)
    ['{C036A43D-DD31-4FFF-8CAD-0ED5844378B6}']
    procedure close; cdecl;
    procedure open(path: JString); cdecl;
    procedure releaseIconForPageUrl(url: JString); cdecl;
    procedure removeAllIcons; cdecl;
    procedure requestIconForPageUrl(url: JString; listener: JWebIconDatabase_IconListener); cdecl;
    procedure retainIconForPageUrl(url: JString); cdecl;
  end;
  TJWebIconDatabase = class(TJavaGenericImport<JWebIconDatabaseClass, JWebIconDatabase>) end;

  JWebIconDatabase_IconListenerClass = interface(IJavaClass)
    ['{9C2AE70A-59E2-4133-9A2D-794B6288C89F}']
  end;

  [JavaSignature('android/webkit/WebIconDatabase$IconListener')]
  JWebIconDatabase_IconListener = interface(IJavaInstance)
    ['{9030BE72-BB1D-4A40-A452-7133B9C166B3}']
    procedure onReceivedIcon(url: JString; icon: JBitmap); cdecl;
  end;
  TJWebIconDatabase_IconListener = class(TJavaGenericImport<JWebIconDatabase_IconListenerClass, JWebIconDatabase_IconListener>) end;

  JWebMessageClass = interface(JObjectClass)
    ['{3E4E6BEF-5261-4B5F-9EA5-61622B9C60BD}']
    {class} function init(data: JString): JWebMessage; cdecl; overload;
    {class} function init(data: JString; ports: TJavaObjectArray<JWebMessagePort>): JWebMessage; cdecl; overload;
  end;

  [JavaSignature('android/webkit/WebMessage')]
  JWebMessage = interface(JObject)
    ['{3BAE79BA-181D-4C03-812C-593313A52FE8}']
    function getData: JString; cdecl;
    function getPorts: TJavaObjectArray<JWebMessagePort>; cdecl;
  end;
  TJWebMessage = class(TJavaGenericImport<JWebMessageClass, JWebMessage>) end;

  JWebMessagePortClass = interface(JObjectClass)
    ['{D2AD0E95-15FA-41AA-A49B-B0DEDB614602}']
  end;

  [JavaSignature('android/webkit/WebMessagePort')]
  JWebMessagePort = interface(JObject)
    ['{040782A9-B4B1-47EC-84DB-2AC7870E8732}']
    procedure close; cdecl;
    procedure postMessage(message: JWebMessage); cdecl;
    procedure setWebMessageCallback(callback: JWebMessagePort_WebMessageCallback); cdecl; overload;
    procedure setWebMessageCallback(callback: JWebMessagePort_WebMessageCallback; handler: JHandler); cdecl; overload;
  end;
  TJWebMessagePort = class(TJavaGenericImport<JWebMessagePortClass, JWebMessagePort>) end;

  JWebMessagePort_WebMessageCallbackClass = interface(JObjectClass)
    ['{F92724EB-BD77-4105-A1D5-93D9F79C8D61}']
    {class} function init: JWebMessagePort_WebMessageCallback; cdecl;
  end;

  [JavaSignature('android/webkit/WebMessagePort$WebMessageCallback')]
  JWebMessagePort_WebMessageCallback = interface(JObject)
    ['{17D28349-57BE-454E-AF4D-224BB847D4B9}']
    procedure onMessage(port: JWebMessagePort; message: JWebMessage); cdecl;
  end;
  TJWebMessagePort_WebMessageCallback = class(TJavaGenericImport<JWebMessagePort_WebMessageCallbackClass, JWebMessagePort_WebMessageCallback>) end;

  JWebResourceErrorClass = interface(JObjectClass)
    ['{A29C41A0-DDFC-4182-8F0C-70C7E9AA377B}']
  end;

  [JavaSignature('android/webkit/WebResourceError')]
  JWebResourceError = interface(JObject)
    ['{788DAB8E-BE04-409E-9202-10DCF4C3EE5C}']
    function getDescription: JCharSequence; cdecl;
    function getErrorCode: Integer; cdecl;
  end;
  TJWebResourceError = class(TJavaGenericImport<JWebResourceErrorClass, JWebResourceError>) end;

  JWebResourceRequestClass = interface(IJavaClass)
    ['{227EDBE7-EF39-48FF-AEB3-858336A022E0}']
  end;

  [JavaSignature('android/webkit/WebResourceRequest')]
  JWebResourceRequest = interface(IJavaInstance)
    ['{59DD3D63-E2EA-483E-BC4B-2A8FCB84DA47}']
    function getMethod: JString; cdecl;
    function getRequestHeaders: JMap; cdecl;
    function getUrl: Jnet_Uri; cdecl;
    function hasGesture: Boolean; cdecl;
    function isForMainFrame: Boolean; cdecl;
  end;
  TJWebResourceRequest = class(TJavaGenericImport<JWebResourceRequestClass, JWebResourceRequest>) end;

  JWebResourceResponseClass = interface(JObjectClass)
    ['{E3E5D0F5-A281-4D60-8941-A07A10D9151E}']
    {class} function init(mimeType: JString; encoding: JString; data: JInputStream): JWebResourceResponse; cdecl; overload;
    {class} function init(mimeType: JString; encoding: JString; statusCode: Integer; reasonPhrase: JString; responseHeaders: JMap; data: JInputStream): JWebResourceResponse; cdecl; overload;
  end;

  [JavaSignature('android/webkit/WebResourceResponse')]
  JWebResourceResponse = interface(JObject)
    ['{00365ED2-0D7C-4CF5-99AB-D8057E8322F2}']
    function getData: JInputStream; cdecl;
    function getEncoding: JString; cdecl;
    function getMimeType: JString; cdecl;
    function getReasonPhrase: JString; cdecl;
    function getResponseHeaders: JMap; cdecl;
    function getStatusCode: Integer; cdecl;
    procedure setData(data: JInputStream); cdecl;
    procedure setEncoding(encoding: JString); cdecl;
    procedure setMimeType(mimeType: JString); cdecl;
    procedure setResponseHeaders(headers: JMap); cdecl;
    procedure setStatusCodeAndReasonPhrase(statusCode: Integer; reasonPhrase: JString); cdecl;
  end;
  TJWebResourceResponse = class(TJavaGenericImport<JWebResourceResponseClass, JWebResourceResponse>) end;

  JWebSettingsClass = interface(JObjectClass)
    ['{602E6B04-981D-4A05-BA19-6ED02ADF24CA}']
    {class} function _GetLOAD_CACHE_ELSE_NETWORK: Integer; cdecl;
    {class} function _GetLOAD_CACHE_ONLY: Integer; cdecl;
    {class} function _GetLOAD_DEFAULT: Integer; cdecl;
    {class} function _GetLOAD_NORMAL: Integer; cdecl;
    {class} function _GetLOAD_NO_CACHE: Integer; cdecl;
    {class} function _GetMIXED_CONTENT_ALWAYS_ALLOW: Integer; cdecl;
    {class} function _GetMIXED_CONTENT_COMPATIBILITY_MODE: Integer; cdecl;
    {class} function _GetMIXED_CONTENT_NEVER_ALLOW: Integer; cdecl;
    {class} function init: JWebSettings; cdecl;
    {class} function getDefaultUserAgent(context: JContext): JString; cdecl;
    {class} property LOAD_CACHE_ELSE_NETWORK: Integer read _GetLOAD_CACHE_ELSE_NETWORK;
    {class} property LOAD_CACHE_ONLY: Integer read _GetLOAD_CACHE_ONLY;
    {class} property LOAD_DEFAULT: Integer read _GetLOAD_DEFAULT;
    {class} property LOAD_NORMAL: Integer read _GetLOAD_NORMAL;
    {class} property LOAD_NO_CACHE: Integer read _GetLOAD_NO_CACHE;
    {class} property MIXED_CONTENT_ALWAYS_ALLOW: Integer read _GetMIXED_CONTENT_ALWAYS_ALLOW;
    {class} property MIXED_CONTENT_COMPATIBILITY_MODE: Integer read _GetMIXED_CONTENT_COMPATIBILITY_MODE;
    {class} property MIXED_CONTENT_NEVER_ALLOW: Integer read _GetMIXED_CONTENT_NEVER_ALLOW;
  end;

  [JavaSignature('android/webkit/WebSettings')]
  JWebSettings = interface(JObject)
    ['{6F9320FD-C646-45CB-90A3-7985E5A1BAE8}']
    function enableSmoothTransition: Boolean; cdecl;//Deprecated
    function getAllowContentAccess: Boolean; cdecl;
    function getAllowFileAccess: Boolean; cdecl;
    function getAllowFileAccessFromFileURLs: Boolean; cdecl;
    function getAllowUniversalAccessFromFileURLs: Boolean; cdecl;
    function getBlockNetworkImage: Boolean; cdecl;
    function getBlockNetworkLoads: Boolean; cdecl;
    function getBuiltInZoomControls: Boolean; cdecl;
    function getCacheMode: Integer; cdecl;
    function getCursiveFontFamily: JString; cdecl;
    function getDatabaseEnabled: Boolean; cdecl;
    function getDatabasePath: JString; cdecl;//Deprecated
    function getDefaultFixedFontSize: Integer; cdecl;
    function getDefaultFontSize: Integer; cdecl;
    function getDefaultTextEncodingName: JString; cdecl;
    function getDefaultZoom: JWebSettings_ZoomDensity; cdecl;//Deprecated
    function getDisplayZoomControls: Boolean; cdecl;
    function getDomStorageEnabled: Boolean; cdecl;
    function getFantasyFontFamily: JString; cdecl;
    function getFixedFontFamily: JString; cdecl;
    function getJavaScriptCanOpenWindowsAutomatically: Boolean; cdecl;
    function getJavaScriptEnabled: Boolean; cdecl;
    function getLayoutAlgorithm: JWebSettings_LayoutAlgorithm; cdecl;
    function getLightTouchEnabled: Boolean; cdecl;//Deprecated
    function getLoadWithOverviewMode: Boolean; cdecl;
    function getLoadsImagesAutomatically: Boolean; cdecl;
    function getMediaPlaybackRequiresUserGesture: Boolean; cdecl;
    function getMinimumFontSize: Integer; cdecl;
    function getMinimumLogicalFontSize: Integer; cdecl;
    function getMixedContentMode: Integer; cdecl;
    function getOffscreenPreRaster: Boolean; cdecl;
    function getPluginState: JWebSettings_PluginState; cdecl;//Deprecated
    function getSansSerifFontFamily: JString; cdecl;
    function getSaveFormData: Boolean; cdecl;
    function getSavePassword: Boolean; cdecl;//Deprecated
    function getSerifFontFamily: JString; cdecl;
    function getStandardFontFamily: JString; cdecl;
    function getTextSize: JWebSettings_TextSize; cdecl;//Deprecated
    function getTextZoom: Integer; cdecl;
    function getUseWideViewPort: Boolean; cdecl;
    function getUserAgentString: JString; cdecl;
    procedure setAllowContentAccess(allow: Boolean); cdecl;
    procedure setAllowFileAccess(allow: Boolean); cdecl;
    procedure setAllowFileAccessFromFileURLs(flag: Boolean); cdecl;
    procedure setAllowUniversalAccessFromFileURLs(flag: Boolean); cdecl;
    procedure setAppCacheEnabled(flag: Boolean); cdecl;
    procedure setAppCacheMaxSize(appCacheMaxSize: Int64); cdecl;//Deprecated
    procedure setAppCachePath(appCachePath: JString); cdecl;
    procedure setBlockNetworkImage(flag: Boolean); cdecl;
    procedure setBlockNetworkLoads(flag: Boolean); cdecl;
    procedure setBuiltInZoomControls(enabled: Boolean); cdecl;
    procedure setCacheMode(mode: Integer); cdecl;
    procedure setCursiveFontFamily(font: JString); cdecl;
    procedure setDatabaseEnabled(flag: Boolean); cdecl;
    procedure setDatabasePath(databasePath: JString); cdecl;//Deprecated
    procedure setDefaultFixedFontSize(size: Integer); cdecl;
    procedure setDefaultFontSize(size: Integer); cdecl;
    procedure setDefaultTextEncodingName(encoding: JString); cdecl;
    procedure setDefaultZoom(zoom: JWebSettings_ZoomDensity); cdecl;//Deprecated
    procedure setDisplayZoomControls(enabled: Boolean); cdecl;
    procedure setDomStorageEnabled(flag: Boolean); cdecl;
    procedure setEnableSmoothTransition(enable: Boolean); cdecl;//Deprecated
    procedure setFantasyFontFamily(font: JString); cdecl;
    procedure setFixedFontFamily(font: JString); cdecl;
    procedure setGeolocationDatabasePath(databasePath: JString); cdecl;
    procedure setGeolocationEnabled(flag: Boolean); cdecl;
    procedure setJavaScriptCanOpenWindowsAutomatically(flag: Boolean); cdecl;
    procedure setJavaScriptEnabled(flag: Boolean); cdecl;
    procedure setLayoutAlgorithm(l: JWebSettings_LayoutAlgorithm); cdecl;
    procedure setLightTouchEnabled(enabled: Boolean); cdecl;//Deprecated
    procedure setLoadWithOverviewMode(overview: Boolean); cdecl;
    procedure setLoadsImagesAutomatically(flag: Boolean); cdecl;
    procedure setMediaPlaybackRequiresUserGesture(require: Boolean); cdecl;
    procedure setMinimumFontSize(size: Integer); cdecl;
    procedure setMinimumLogicalFontSize(size: Integer); cdecl;
    procedure setMixedContentMode(mode: Integer); cdecl;
    procedure setNeedInitialFocus(flag: Boolean); cdecl;
    procedure setOffscreenPreRaster(enabled: Boolean); cdecl;
    procedure setPluginState(state: JWebSettings_PluginState); cdecl;//Deprecated
    procedure setRenderPriority(priority: JWebSettings_RenderPriority); cdecl;//Deprecated
    procedure setSansSerifFontFamily(font: JString); cdecl;
    procedure setSaveFormData(save: Boolean); cdecl;
    procedure setSavePassword(save: Boolean); cdecl;//Deprecated
    procedure setSerifFontFamily(font: JString); cdecl;
    procedure setStandardFontFamily(font: JString); cdecl;
    procedure setSupportMultipleWindows(support: Boolean); cdecl;
    procedure setSupportZoom(support: Boolean); cdecl;
    procedure setTextSize(t: JWebSettings_TextSize); cdecl;//Deprecated
    procedure setTextZoom(textZoom: Integer); cdecl;
    procedure setUseWideViewPort(use: Boolean); cdecl;
    procedure setUserAgentString(ua: JString); cdecl;
    function supportMultipleWindows: Boolean; cdecl;
    function supportZoom: Boolean; cdecl;
  end;
  TJWebSettings = class(TJavaGenericImport<JWebSettingsClass, JWebSettings>) end;

  JWebSettings_LayoutAlgorithmClass = interface(JEnumClass)
    ['{6D48AC59-3F0B-4CE1-B9E3-C7A0894915A2}']
    {class} function _GetNARROW_COLUMNS: JWebSettings_LayoutAlgorithm; cdecl;
    {class} function _GetNORMAL: JWebSettings_LayoutAlgorithm; cdecl;
    {class} function _GetSINGLE_COLUMN: JWebSettings_LayoutAlgorithm; cdecl;
    {class} function _GetTEXT_AUTOSIZING: JWebSettings_LayoutAlgorithm; cdecl;
    {class} function valueOf(name: JString): JWebSettings_LayoutAlgorithm; cdecl;
    {class} function values: TJavaObjectArray<JWebSettings_LayoutAlgorithm>; cdecl;
    {class} property NARROW_COLUMNS: JWebSettings_LayoutAlgorithm read _GetNARROW_COLUMNS;
    {class} property NORMAL: JWebSettings_LayoutAlgorithm read _GetNORMAL;
    {class} property SINGLE_COLUMN: JWebSettings_LayoutAlgorithm read _GetSINGLE_COLUMN;
    {class} property TEXT_AUTOSIZING: JWebSettings_LayoutAlgorithm read _GetTEXT_AUTOSIZING;
  end;

  [JavaSignature('android/webkit/WebSettings$LayoutAlgorithm')]
  JWebSettings_LayoutAlgorithm = interface(JEnum)
    ['{907CB7D6-3ECB-449F-9BE5-D3E4FAF0A877}']
  end;
  TJWebSettings_LayoutAlgorithm = class(TJavaGenericImport<JWebSettings_LayoutAlgorithmClass, JWebSettings_LayoutAlgorithm>) end;

  JWebSettings_PluginStateClass = interface(JEnumClass)
    ['{3EEEE1A8-1A1C-4273-8FDA-795F1EC37C77}']
    {class} function _GetOFF: JWebSettings_PluginState; cdecl;
    {class} function _GetON: JWebSettings_PluginState; cdecl;
    {class} function _GetON_DEMAND: JWebSettings_PluginState; cdecl;
    {class} function valueOf(name: JString): JWebSettings_PluginState; cdecl;
    {class} function values: TJavaObjectArray<JWebSettings_PluginState>; cdecl;
    {class} property OFF: JWebSettings_PluginState read _GetOFF;
    {class} property ON: JWebSettings_PluginState read _GetON;
    {class} property ON_DEMAND: JWebSettings_PluginState read _GetON_DEMAND;
  end;

  [JavaSignature('android/webkit/WebSettings$PluginState')]
  JWebSettings_PluginState = interface(JEnum)
    ['{9E1FE39E-6E4B-41B5-A4F5-117A32289576}']
  end;
  TJWebSettings_PluginState = class(TJavaGenericImport<JWebSettings_PluginStateClass, JWebSettings_PluginState>) end;

  JWebSettings_RenderPriorityClass = interface(JEnumClass)
    ['{ABDCE7A7-56D3-4DAE-BD5E-6D8F882C652F}']
    {class} function _GetHIGH: JWebSettings_RenderPriority; cdecl;
    {class} function _GetLOW: JWebSettings_RenderPriority; cdecl;
    {class} function _GetNORMAL: JWebSettings_RenderPriority; cdecl;
    {class} function valueOf(name: JString): JWebSettings_RenderPriority; cdecl;
    {class} function values: TJavaObjectArray<JWebSettings_RenderPriority>; cdecl;
    {class} property HIGH: JWebSettings_RenderPriority read _GetHIGH;
    {class} property LOW: JWebSettings_RenderPriority read _GetLOW;
    {class} property NORMAL: JWebSettings_RenderPriority read _GetNORMAL;
  end;

  [JavaSignature('android/webkit/WebSettings$RenderPriority')]
  JWebSettings_RenderPriority = interface(JEnum)
    ['{00AA47AC-5C9B-4C40-9266-3DCCDB4E849B}']
  end;
  TJWebSettings_RenderPriority = class(TJavaGenericImport<JWebSettings_RenderPriorityClass, JWebSettings_RenderPriority>) end;

  JWebSettings_TextSizeClass = interface(JEnumClass)
    ['{ED845FF6-09FA-41C4-B3CD-81718A39E35D}']
    {class} function _GetLARGER: JWebSettings_TextSize; cdecl;
    {class} function _GetLARGEST: JWebSettings_TextSize; cdecl;
    {class} function _GetNORMAL: JWebSettings_TextSize; cdecl;
    {class} function _GetSMALLER: JWebSettings_TextSize; cdecl;
    {class} function _GetSMALLEST: JWebSettings_TextSize; cdecl;
    {class} function valueOf(name: JString): JWebSettings_TextSize; cdecl;
    {class} function values: TJavaObjectArray<JWebSettings_TextSize>; cdecl;
    {class} property LARGER: JWebSettings_TextSize read _GetLARGER;
    {class} property LARGEST: JWebSettings_TextSize read _GetLARGEST;
    {class} property NORMAL: JWebSettings_TextSize read _GetNORMAL;
    {class} property SMALLER: JWebSettings_TextSize read _GetSMALLER;
    {class} property SMALLEST: JWebSettings_TextSize read _GetSMALLEST;
  end;

  [JavaSignature('android/webkit/WebSettings$TextSize')]
  JWebSettings_TextSize = interface(JEnum)
    ['{416C0F01-FDDA-4159-9491-92F0241FFA7D}']
  end;
  TJWebSettings_TextSize = class(TJavaGenericImport<JWebSettings_TextSizeClass, JWebSettings_TextSize>) end;

  JWebSettings_ZoomDensityClass = interface(JEnumClass)
    ['{CF1B1626-5547-47A4-98A4-6CCFA10457DC}']
    {class} function _GetCLOSE: JWebSettings_ZoomDensity; cdecl;
    {class} function _GetFAR: JWebSettings_ZoomDensity; cdecl;
    {class} function _GetMEDIUM: JWebSettings_ZoomDensity; cdecl;
    {class} function valueOf(name: JString): JWebSettings_ZoomDensity; cdecl;
    {class} function values: TJavaObjectArray<JWebSettings_ZoomDensity>; cdecl;
    {class} property CLOSE: JWebSettings_ZoomDensity read _GetCLOSE;
    {class} property FAR: JWebSettings_ZoomDensity read _GetFAR;
    {class} property MEDIUM: JWebSettings_ZoomDensity read _GetMEDIUM;
  end;

  [JavaSignature('android/webkit/WebSettings$ZoomDensity')]
  JWebSettings_ZoomDensity = interface(JEnum)
    ['{99F8B33F-ADFF-4C54-9151-F0DC57EFF989}']
  end;
  TJWebSettings_ZoomDensity = class(TJavaGenericImport<JWebSettings_ZoomDensityClass, JWebSettings_ZoomDensity>) end;

  JWebStorageClass = interface(JObjectClass)
    ['{98C06137-20FC-44E2-B2F0-2D72D0FC3010}']
    {class} function getInstance: JWebStorage; cdecl;
  end;

  [JavaSignature('android/webkit/WebStorage')]
  JWebStorage = interface(JObject)
    ['{702F2A6D-0A1E-4916-B16D-8F8C492A03C5}']
    procedure deleteAllData; cdecl;
    procedure deleteOrigin(origin: JString); cdecl;
    procedure getOrigins(callback: JValueCallback); cdecl;
    procedure getQuotaForOrigin(origin: JString; callback: JValueCallback); cdecl;
    procedure getUsageForOrigin(origin: JString; callback: JValueCallback); cdecl;
    procedure setQuotaForOrigin(origin: JString; quota: Int64); cdecl;//Deprecated
  end;
  TJWebStorage = class(TJavaGenericImport<JWebStorageClass, JWebStorage>) end;

  JWebStorage_OriginClass = interface(JObjectClass)
    ['{2EBC8D88-82DC-40C6-86D1-F5F8407B9DB1}']
  end;

  [JavaSignature('android/webkit/WebStorage$Origin')]
  JWebStorage_Origin = interface(JObject)
    ['{EF23BA1B-CC0C-46D4-960F-DDB999281541}']
    function getOrigin: JString; cdecl;
    function getQuota: Int64; cdecl;
    function getUsage: Int64; cdecl;
  end;
  TJWebStorage_Origin = class(TJavaGenericImport<JWebStorage_OriginClass, JWebStorage_Origin>) end;

  JWebStorage_QuotaUpdaterClass = interface(IJavaClass)
    ['{C5E7DCCF-EBD2-466F-9916-D3C4F092EA21}']
  end;

  [JavaSignature('android/webkit/WebStorage$QuotaUpdater')]
  JWebStorage_QuotaUpdater = interface(IJavaInstance)
    ['{D6DE6F2C-845A-45FD-BC3E-10286ABF0E01}']
    procedure updateQuota(newQuota: Int64); cdecl;
  end;
  TJWebStorage_QuotaUpdater = class(TJavaGenericImport<JWebStorage_QuotaUpdaterClass, JWebStorage_QuotaUpdater>) end;

  JWebViewClass = interface(JAbsoluteLayoutClass)
    ['{57C30F7F-F8C7-4C19-859E-073DC4DA4250}']
    {class} function _GetSCHEME_GEO: JString; cdecl;
    {class} function _GetSCHEME_MAILTO: JString; cdecl;
    {class} function _GetSCHEME_TEL: JString; cdecl;
    {class} function init(context: JContext): JWebView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JWebView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer): JWebView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; defStyleRes: Integer): JWebView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyleAttr: Integer; privateBrowsing: Boolean): JWebView; cdecl; overload;//Deprecated
    {class} procedure clearClientCertPreferences(onCleared: JRunnable); cdecl;
    {class} procedure enableSlowWholeDocumentDraw; cdecl;
    {class} function findAddress(addr: JString): JString; cdecl;
    {class} procedure setWebContentsDebuggingEnabled(enabled: Boolean); cdecl;
    {class} property SCHEME_GEO: JString read _GetSCHEME_GEO;
    {class} property SCHEME_MAILTO: JString read _GetSCHEME_MAILTO;
    {class} property SCHEME_TEL: JString read _GetSCHEME_TEL;
  end;

  [JavaSignature('android/webkit/WebView')]
  JWebView = interface(JAbsoluteLayout)
    ['{0001776D-86A0-43B3-A64C-C6FEA095AD91}']
    procedure addJavascriptInterface(object_: JObject; name: JString); cdecl;
    function canGoBack: Boolean; cdecl;
    function canGoBackOrForward(steps: Integer): Boolean; cdecl;
    function canGoForward: Boolean; cdecl;
    function canZoomIn: Boolean; cdecl;//Deprecated
    function canZoomOut: Boolean; cdecl;//Deprecated
    function capturePicture: JPicture; cdecl;//Deprecated
    procedure clearCache(includeDiskFiles: Boolean); cdecl;
    procedure clearFormData; cdecl;
    procedure clearHistory; cdecl;
    procedure clearMatches; cdecl;
    procedure clearSslPreferences; cdecl;
    procedure clearView; cdecl;//Deprecated
    procedure computeScroll; cdecl;
    function copyBackForwardList: JWebBackForwardList; cdecl;
    function createPrintDocumentAdapter: JPrintDocumentAdapter; cdecl; overload;//Deprecated
    function createPrintDocumentAdapter(documentName: JString): JPrintDocumentAdapter; cdecl; overload;
    function createWebMessageChannel: TJavaObjectArray<JWebMessagePort>; cdecl;
    procedure destroy; cdecl;
    function dispatchKeyEvent(event: JKeyEvent): Boolean; cdecl;
    procedure documentHasImages(response: JMessage); cdecl;
    procedure evaluateJavascript(script: JString; resultCallback: JValueCallback); cdecl;
    function findAll(find: JString): Integer; cdecl;//Deprecated
    procedure findAllAsync(find: JString); cdecl;
    procedure findNext(forward: Boolean); cdecl;
    procedure flingScroll(vx: Integer; vy: Integer); cdecl;
    procedure freeMemory; cdecl;//Deprecated
    function getAccessibilityClassName: JCharSequence; cdecl;
    function getAccessibilityNodeProvider: JAccessibilityNodeProvider; cdecl;
    function getCertificate: JSslCertificate; cdecl;
    function getContentHeight: Integer; cdecl;
    function getFavicon: JBitmap; cdecl;
    function getHitTestResult: JWebView_HitTestResult; cdecl;
    function getHttpAuthUsernamePassword(host: JString; realm: JString): TJavaObjectArray<JString>; cdecl;
    function getOriginalUrl: JString; cdecl;
    function getProgress: Integer; cdecl;
    function getScale: Single; cdecl;//Deprecated
    function getSettings: JWebSettings; cdecl;
    function getTitle: JString; cdecl;
    function getUrl: JString; cdecl;
    procedure goBack; cdecl;
    procedure goBackOrForward(steps: Integer); cdecl;
    procedure goForward; cdecl;
    procedure invokeZoomPicker; cdecl;
    function isPrivateBrowsingEnabled: Boolean; cdecl;
    procedure loadData(data: JString; mimeType: JString; encoding: JString); cdecl;
    procedure loadDataWithBaseURL(baseUrl: JString; data: JString; mimeType: JString; encoding: JString; historyUrl: JString); cdecl;
    procedure loadUrl(url: JString; additionalHttpHeaders: JMap); cdecl; overload;
    procedure loadUrl(url: JString); cdecl; overload;
    procedure onChildViewAdded(parent: JView; child: JView); cdecl;//Deprecated
    procedure onChildViewRemoved(p: JView; child: JView); cdecl;//Deprecated
    function onCreateInputConnection(outAttrs: JEditorInfo): JInputConnection; cdecl;
    procedure onFinishTemporaryDetach; cdecl;
    function onGenericMotionEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onGlobalFocusChanged(oldFocus: JView; newFocus: JView); cdecl;//Deprecated
    function onHoverEvent(event: JMotionEvent): Boolean; cdecl;
    function onKeyDown(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyMultiple(keyCode: Integer; repeatCount: Integer; event: JKeyEvent): Boolean; cdecl;
    function onKeyUp(keyCode: Integer; event: JKeyEvent): Boolean; cdecl;
    procedure onPause; cdecl;
    procedure onProvideVirtualStructure(structure: JViewStructure); cdecl;
    procedure onResume; cdecl;
    procedure onStartTemporaryDetach; cdecl;
    function onTouchEvent(event: JMotionEvent): Boolean; cdecl;
    function onTrackballEvent(event: JMotionEvent): Boolean; cdecl;
    procedure onWindowFocusChanged(hasWindowFocus: Boolean); cdecl;
    function overlayHorizontalScrollbar: Boolean; cdecl;//Deprecated
    function overlayVerticalScrollbar: Boolean; cdecl;//Deprecated
    function pageDown(bottom: Boolean): Boolean; cdecl;
    function pageUp(top: Boolean): Boolean; cdecl;
    procedure pauseTimers; cdecl;
    function performLongClick: Boolean; cdecl;
    procedure postUrl(url: JString; postData: TJavaArray<Byte>); cdecl;
    procedure postVisualStateCallback(requestId: Int64; callback: JWebView_VisualStateCallback); cdecl;
    procedure postWebMessage(message: JWebMessage; targetOrigin: Jnet_Uri); cdecl;
    procedure reload; cdecl;
    procedure removeJavascriptInterface(name: JString); cdecl;
    function requestChildRectangleOnScreen(child: JView; rect: JRect; immediate: Boolean): Boolean; cdecl;
    function requestFocus(direction: Integer; previouslyFocusedRect: JRect): Boolean; cdecl;
    procedure requestFocusNodeHref(hrefMsg: JMessage); cdecl;
    procedure requestImageRef(msg: JMessage); cdecl;
    function restoreState(inState: JBundle): JWebBackForwardList; cdecl;
    procedure resumeTimers; cdecl;
    procedure savePassword(host: JString; username: JString; password: JString); cdecl;//Deprecated
    function saveState(outState: JBundle): JWebBackForwardList; cdecl;
    procedure saveWebArchive(filename: JString); cdecl; overload;
    procedure saveWebArchive(basename: JString; autoname: Boolean; callback: JValueCallback); cdecl; overload;
    procedure setBackgroundColor(color: Integer); cdecl;
    procedure setCertificate(certificate: JSslCertificate); cdecl;//Deprecated
    procedure setDownloadListener(listener: JDownloadListener); cdecl;
    procedure setFindListener(listener: JWebView_FindListener); cdecl;
    procedure setHorizontalScrollbarOverlay(overlay: Boolean); cdecl;//Deprecated
    procedure setHttpAuthUsernamePassword(host: JString; realm: JString; username: JString; password: JString); cdecl;
    procedure setInitialScale(scaleInPercent: Integer); cdecl;
    procedure setLayerType(layerType: Integer; paint: JPaint); cdecl;
    procedure setLayoutParams(params: JViewGroup_LayoutParams); cdecl;
    procedure setMapTrackballToArrowKeys(setMap: Boolean); cdecl;//Deprecated
    procedure setNetworkAvailable(networkUp: Boolean); cdecl;
    procedure setOverScrollMode(mode: Integer); cdecl;
    procedure setPictureListener(listener: JWebView_PictureListener); cdecl;//Deprecated
    procedure setScrollBarStyle(style: Integer); cdecl;
    procedure setVerticalScrollbarOverlay(overlay: Boolean); cdecl;//Deprecated
    procedure setWebChromeClient(client: JWebChromeClient); cdecl;
    procedure setWebViewClient(client: JWebViewClient); cdecl;
    function shouldDelayChildPressedState: Boolean; cdecl;//Deprecated
    function showFindDialog(text: JString; showIme: Boolean): Boolean; cdecl;//Deprecated
    procedure stopLoading; cdecl;
    procedure zoomBy(zoomFactor: Single); cdecl;
    function zoomIn: Boolean; cdecl;
    function zoomOut: Boolean; cdecl;
  end;
  TJWebView = class(TJavaGenericImport<JWebViewClass, JWebView>) end;

  JWebView_FindListenerClass = interface(IJavaClass)
    ['{41A75C2A-7028-4424-B3FD-A06BECE9A089}']
  end;

  [JavaSignature('android/webkit/WebView$FindListener')]
  JWebView_FindListener = interface(IJavaInstance)
    ['{4DFED237-9B2D-41ED-8DBB-A5EBF5B36A6C}']
    procedure onFindResultReceived(activeMatchOrdinal: Integer; numberOfMatches: Integer; isDoneCounting: Boolean); cdecl;
  end;
  TJWebView_FindListener = class(TJavaGenericImport<JWebView_FindListenerClass, JWebView_FindListener>) end;

  JWebView_HitTestResultClass = interface(JObjectClass)
    ['{5AE29C91-64C1-4694-B2E3-A5C4077ABBA5}']
    {class} function _GetANCHOR_TYPE: Integer; cdecl;
    {class} function _GetEDIT_TEXT_TYPE: Integer; cdecl;
    {class} function _GetEMAIL_TYPE: Integer; cdecl;
    {class} function _GetGEO_TYPE: Integer; cdecl;
    {class} function _GetIMAGE_ANCHOR_TYPE: Integer; cdecl;
    {class} function _GetIMAGE_TYPE: Integer; cdecl;
    {class} function _GetPHONE_TYPE: Integer; cdecl;
    {class} function _GetSRC_ANCHOR_TYPE: Integer; cdecl;
    {class} function _GetSRC_IMAGE_ANCHOR_TYPE: Integer; cdecl;
    {class} function _GetUNKNOWN_TYPE: Integer; cdecl;
    {class} property ANCHOR_TYPE: Integer read _GetANCHOR_TYPE;
    {class} property EDIT_TEXT_TYPE: Integer read _GetEDIT_TEXT_TYPE;
    {class} property EMAIL_TYPE: Integer read _GetEMAIL_TYPE;
    {class} property GEO_TYPE: Integer read _GetGEO_TYPE;
    {class} property IMAGE_ANCHOR_TYPE: Integer read _GetIMAGE_ANCHOR_TYPE;
    {class} property IMAGE_TYPE: Integer read _GetIMAGE_TYPE;
    {class} property PHONE_TYPE: Integer read _GetPHONE_TYPE;
    {class} property SRC_ANCHOR_TYPE: Integer read _GetSRC_ANCHOR_TYPE;
    {class} property SRC_IMAGE_ANCHOR_TYPE: Integer read _GetSRC_IMAGE_ANCHOR_TYPE;
    {class} property UNKNOWN_TYPE: Integer read _GetUNKNOWN_TYPE;
  end;

  [JavaSignature('android/webkit/WebView$HitTestResult')]
  JWebView_HitTestResult = interface(JObject)
    ['{5350D51E-FE08-48D8-A771-CA8ABEC70D95}']
    function getExtra: JString; cdecl;
    function getType: Integer; cdecl;
  end;
  TJWebView_HitTestResult = class(TJavaGenericImport<JWebView_HitTestResultClass, JWebView_HitTestResult>) end;

  JWebView_PictureListenerClass = interface(IJavaClass)
    ['{126AE669-1AF8-4472-9CA6-67D139C407BD}']
  end;

  [JavaSignature('android/webkit/WebView$PictureListener')]
  JWebView_PictureListener = interface(IJavaInstance)
    ['{C19F2468-28E4-4DE6-818D-BFCEFD4716E8}']
    procedure onNewPicture(view: JWebView; picture: JPicture); cdecl;//Deprecated
  end;
  TJWebView_PictureListener = class(TJavaGenericImport<JWebView_PictureListenerClass, JWebView_PictureListener>) end;

  JWebView_VisualStateCallbackClass = interface(JObjectClass)
    ['{CCD72A26-11BC-4810-AA6B-E11AFC713AD3}']
    {class} function init: JWebView_VisualStateCallback; cdecl;
  end;

  [JavaSignature('android/webkit/WebView$VisualStateCallback')]
  JWebView_VisualStateCallback = interface(JObject)
    ['{29FF2F0D-EC40-48CC-9CDC-348B61A96CF5}']
    procedure onComplete(requestId: Int64); cdecl;
  end;
  TJWebView_VisualStateCallback = class(TJavaGenericImport<JWebView_VisualStateCallbackClass, JWebView_VisualStateCallback>) end;

  JWebView_WebViewTransportClass = interface(JObjectClass)
    ['{8CFEE3EF-625F-4465-8EF9-2ED5CEF3FBCB}']
    {class} function init: JWebView_WebViewTransport; cdecl;
  end;

  [JavaSignature('android/webkit/WebView$WebViewTransport')]
  JWebView_WebViewTransport = interface(JObject)
    ['{4AA5F44F-DDEE-4DDB-8FAD-58C0C20F0A9B}']
    function getWebView: JWebView; cdecl;
    procedure setWebView(webview: JWebView); cdecl;
  end;
  TJWebView_WebViewTransport = class(TJavaGenericImport<JWebView_WebViewTransportClass, JWebView_WebViewTransport>) end;

  JWebViewClientClass = interface(JObjectClass)
    ['{A5B717AB-A760-4941-A8D5-5BBBB610EE9C}']
    {class} function _GetERROR_AUTHENTICATION: Integer; cdecl;
    {class} function _GetERROR_BAD_URL: Integer; cdecl;
    {class} function _GetERROR_CONNECT: Integer; cdecl;
    {class} function _GetERROR_FAILED_SSL_HANDSHAKE: Integer; cdecl;
    {class} function _GetERROR_FILE: Integer; cdecl;
    {class} function _GetERROR_FILE_NOT_FOUND: Integer; cdecl;
    {class} function _GetERROR_HOST_LOOKUP: Integer; cdecl;
    {class} function _GetERROR_IO: Integer; cdecl;
    {class} function _GetERROR_PROXY_AUTHENTICATION: Integer; cdecl;
    {class} function _GetERROR_REDIRECT_LOOP: Integer; cdecl;
    {class} function _GetERROR_TIMEOUT: Integer; cdecl;
    {class} function _GetERROR_TOO_MANY_REQUESTS: Integer; cdecl;
    {class} function _GetERROR_UNKNOWN: Integer; cdecl;
    {class} function _GetERROR_UNSUPPORTED_AUTH_SCHEME: Integer; cdecl;
    {class} function _GetERROR_UNSUPPORTED_SCHEME: Integer; cdecl;
    {class} function init: JWebViewClient; cdecl;
    {class} property ERROR_AUTHENTICATION: Integer read _GetERROR_AUTHENTICATION;
    {class} property ERROR_BAD_URL: Integer read _GetERROR_BAD_URL;
    {class} property ERROR_CONNECT: Integer read _GetERROR_CONNECT;
    {class} property ERROR_FAILED_SSL_HANDSHAKE: Integer read _GetERROR_FAILED_SSL_HANDSHAKE;
    {class} property ERROR_FILE: Integer read _GetERROR_FILE;
    {class} property ERROR_FILE_NOT_FOUND: Integer read _GetERROR_FILE_NOT_FOUND;
    {class} property ERROR_HOST_LOOKUP: Integer read _GetERROR_HOST_LOOKUP;
    {class} property ERROR_IO: Integer read _GetERROR_IO;
    {class} property ERROR_PROXY_AUTHENTICATION: Integer read _GetERROR_PROXY_AUTHENTICATION;
    {class} property ERROR_REDIRECT_LOOP: Integer read _GetERROR_REDIRECT_LOOP;
    {class} property ERROR_TIMEOUT: Integer read _GetERROR_TIMEOUT;
    {class} property ERROR_TOO_MANY_REQUESTS: Integer read _GetERROR_TOO_MANY_REQUESTS;
    {class} property ERROR_UNKNOWN: Integer read _GetERROR_UNKNOWN;
    {class} property ERROR_UNSUPPORTED_AUTH_SCHEME: Integer read _GetERROR_UNSUPPORTED_AUTH_SCHEME;
    {class} property ERROR_UNSUPPORTED_SCHEME: Integer read _GetERROR_UNSUPPORTED_SCHEME;
  end;

  [JavaSignature('android/webkit/WebViewClient')]
  JWebViewClient = interface(JObject)
    ['{04427D5F-0978-486C-9ABC-14621B34FB9D}']
    procedure doUpdateVisitedHistory(view: JWebView; url: JString; isReload: Boolean); cdecl;
    procedure onFormResubmission(view: JWebView; dontResend: JMessage; resend: JMessage); cdecl;
    procedure onLoadResource(view: JWebView; url: JString); cdecl;
    procedure onPageCommitVisible(view: JWebView; url: JString); cdecl;
    procedure onPageFinished(view: JWebView; url: JString); cdecl;
    procedure onPageStarted(view: JWebView; url: JString; favicon: JBitmap); cdecl;
    procedure onReceivedClientCertRequest(view: JWebView; request: JClientCertRequest); cdecl;
    procedure onReceivedError(view: JWebView; errorCode: Integer; description: JString; failingUrl: JString); cdecl; overload;//Deprecated
    procedure onReceivedError(view: JWebView; request: JWebResourceRequest; error: JWebResourceError); cdecl; overload;
    procedure onReceivedHttpAuthRequest(view: JWebView; handler: JHttpAuthHandler; host: JString; realm: JString); cdecl;
    procedure onReceivedHttpError(view: JWebView; request: JWebResourceRequest; errorResponse: JWebResourceResponse); cdecl;
    procedure onReceivedLoginRequest(view: JWebView; realm: JString; account: JString; args: JString); cdecl;
    procedure onReceivedSslError(view: JWebView; handler: JSslErrorHandler; error: JSslError); cdecl;
    procedure onScaleChanged(view: JWebView; oldScale: Single; newScale: Single); cdecl;
    procedure onTooManyRedirects(view: JWebView; cancelMsg: JMessage; continueMsg: JMessage); cdecl;//Deprecated
    procedure onUnhandledInputEvent(view: JWebView; event: JInputEvent); cdecl;
    procedure onUnhandledKeyEvent(view: JWebView; event: JKeyEvent); cdecl;//Deprecated
    function shouldInterceptRequest(view: JWebView; url: JString): JWebResourceResponse; cdecl; overload;//Deprecated
    function shouldInterceptRequest(view: JWebView; request: JWebResourceRequest): JWebResourceResponse; cdecl; overload;
    function shouldOverrideKeyEvent(view: JWebView; event: JKeyEvent): Boolean; cdecl;
    function shouldOverrideUrlLoading(view: JWebView; url: JString): Boolean; cdecl;
  end;
  TJWebViewClient = class(TJavaGenericImport<JWebViewClientClass, JWebViewClient>) end;

  JWebViewDatabaseClass = interface(JObjectClass)
    ['{DEA27CB2-E5C8-497E-9A3E-D9491479FFD9}']
    {class} function init: JWebViewDatabase; cdecl;
    {class} function getInstance(context: JContext): JWebViewDatabase; cdecl;
  end;

  [JavaSignature('android/webkit/WebViewDatabase')]
  JWebViewDatabase = interface(JObject)
    ['{CDF3B654-354D-4CA9-A8ED-C6295AAABC7C}']
    procedure clearFormData; cdecl;
    procedure clearHttpAuthUsernamePassword; cdecl;
    procedure clearUsernamePassword; cdecl;//Deprecated
    function hasFormData: Boolean; cdecl;
    function hasHttpAuthUsernamePassword: Boolean; cdecl;
    function hasUsernamePassword: Boolean; cdecl;//Deprecated
  end;
  TJWebViewDatabase = class(TJavaGenericImport<JWebViewDatabaseClass, JWebViewDatabase>) end;

  JWebViewFragmentClass = interface(JFragmentClass)
    ['{75DB2D86-E8B2-40D6-94D0-253CDADCD376}']
    {class} function init: JWebViewFragment; cdecl;
  end;

  [JavaSignature('android/webkit/WebViewFragment')]
  JWebViewFragment = interface(JFragment)
    ['{65D4F5A5-7470-429E-8544-CE88856852D8}']
    function getWebView: JWebView; cdecl;
    function onCreateView(inflater: JLayoutInflater; container: JViewGroup; savedInstanceState: JBundle): JView; cdecl;
    procedure onDestroy; cdecl;
    procedure onDestroyView; cdecl;
    procedure onPause; cdecl;
    procedure onResume; cdecl;
  end;
  TJWebViewFragment = class(TJavaGenericImport<JWebViewFragmentClass, JWebViewFragment>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JClientCertRequest', TypeInfo(Androidapi.JNI.Webkit.JClientCertRequest));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JConsoleMessage', TypeInfo(Androidapi.JNI.Webkit.JConsoleMessage));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JConsoleMessage_MessageLevel', TypeInfo(Androidapi.JNI.Webkit.JConsoleMessage_MessageLevel));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JCookieManager', TypeInfo(Androidapi.JNI.Webkit.JCookieManager));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JCookieSyncManager', TypeInfo(Androidapi.JNI.Webkit.JCookieSyncManager));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JDateSorter', TypeInfo(Androidapi.JNI.Webkit.JDateSorter));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JDownloadListener', TypeInfo(Androidapi.JNI.Webkit.JDownloadListener));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JGeolocationPermissions', TypeInfo(Androidapi.JNI.Webkit.JGeolocationPermissions));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JGeolocationPermissions_Callback', TypeInfo(Androidapi.JNI.Webkit.JGeolocationPermissions_Callback));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JHttpAuthHandler', TypeInfo(Androidapi.JNI.Webkit.JHttpAuthHandler));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JJavascriptInterface', TypeInfo(Androidapi.JNI.Webkit.JJavascriptInterface));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JJsResult', TypeInfo(Androidapi.JNI.Webkit.JJsResult));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JJsPromptResult', TypeInfo(Androidapi.JNI.Webkit.JJsPromptResult));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JMimeTypeMap', TypeInfo(Androidapi.JNI.Webkit.JMimeTypeMap));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JPermissionRequest', TypeInfo(Androidapi.JNI.Webkit.JPermissionRequest));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JPluginStub', TypeInfo(Androidapi.JNI.Webkit.JPluginStub));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JSslErrorHandler', TypeInfo(Androidapi.JNI.Webkit.JSslErrorHandler));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JURLUtil', TypeInfo(Androidapi.JNI.Webkit.JURLUtil));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JValueCallback', TypeInfo(Androidapi.JNI.Webkit.JValueCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebBackForwardList', TypeInfo(Androidapi.JNI.Webkit.JWebBackForwardList));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebChromeClient', TypeInfo(Androidapi.JNI.Webkit.JWebChromeClient));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebChromeClient_CustomViewCallback', TypeInfo(Androidapi.JNI.Webkit.JWebChromeClient_CustomViewCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebChromeClient_FileChooserParams', TypeInfo(Androidapi.JNI.Webkit.JWebChromeClient_FileChooserParams));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebHistoryItem', TypeInfo(Androidapi.JNI.Webkit.JWebHistoryItem));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebIconDatabase', TypeInfo(Androidapi.JNI.Webkit.JWebIconDatabase));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebIconDatabase_IconListener', TypeInfo(Androidapi.JNI.Webkit.JWebIconDatabase_IconListener));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebMessage', TypeInfo(Androidapi.JNI.Webkit.JWebMessage));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebMessagePort', TypeInfo(Androidapi.JNI.Webkit.JWebMessagePort));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebMessagePort_WebMessageCallback', TypeInfo(Androidapi.JNI.Webkit.JWebMessagePort_WebMessageCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebResourceError', TypeInfo(Androidapi.JNI.Webkit.JWebResourceError));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebResourceRequest', TypeInfo(Androidapi.JNI.Webkit.JWebResourceRequest));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebResourceResponse', TypeInfo(Androidapi.JNI.Webkit.JWebResourceResponse));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebSettings', TypeInfo(Androidapi.JNI.Webkit.JWebSettings));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebSettings_LayoutAlgorithm', TypeInfo(Androidapi.JNI.Webkit.JWebSettings_LayoutAlgorithm));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebSettings_PluginState', TypeInfo(Androidapi.JNI.Webkit.JWebSettings_PluginState));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebSettings_RenderPriority', TypeInfo(Androidapi.JNI.Webkit.JWebSettings_RenderPriority));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebSettings_TextSize', TypeInfo(Androidapi.JNI.Webkit.JWebSettings_TextSize));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebSettings_ZoomDensity', TypeInfo(Androidapi.JNI.Webkit.JWebSettings_ZoomDensity));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebStorage', TypeInfo(Androidapi.JNI.Webkit.JWebStorage));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebStorage_Origin', TypeInfo(Androidapi.JNI.Webkit.JWebStorage_Origin));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebStorage_QuotaUpdater', TypeInfo(Androidapi.JNI.Webkit.JWebStorage_QuotaUpdater));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebView', TypeInfo(Androidapi.JNI.Webkit.JWebView));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebView_FindListener', TypeInfo(Androidapi.JNI.Webkit.JWebView_FindListener));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebView_HitTestResult', TypeInfo(Androidapi.JNI.Webkit.JWebView_HitTestResult));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebView_PictureListener', TypeInfo(Androidapi.JNI.Webkit.JWebView_PictureListener));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebView_VisualStateCallback', TypeInfo(Androidapi.JNI.Webkit.JWebView_VisualStateCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebView_WebViewTransport', TypeInfo(Androidapi.JNI.Webkit.JWebView_WebViewTransport));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebViewClient', TypeInfo(Androidapi.JNI.Webkit.JWebViewClient));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebViewDatabase', TypeInfo(Androidapi.JNI.Webkit.JWebViewDatabase));
  TRegTypes.RegisterType('Androidapi.JNI.Webkit.JWebViewFragment', TypeInfo(Androidapi.JNI.Webkit.JWebViewFragment));
end;

initialization
  RegisterTypes;
end.


