{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Accounts;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.JavaUtil,
  Androidapi.JNI.Os;

type
// ===== Forward declarations =====

  JAccount = interface;//android.accounts.Account
  JAccountManager = interface;//android.accounts.AccountManager
  JAccountManagerCallback = interface;//android.accounts.AccountManagerCallback
  JAccountManagerFuture = interface;//android.accounts.AccountManagerFuture
  JAuthenticatorDescription = interface;//android.accounts.AuthenticatorDescription
  JOnAccountsUpdateListener = interface;//android.accounts.OnAccountsUpdateListener

// ===== Interface declarations =====

  JAccountClass = interface(JObjectClass)
    ['{94EE6861-F326-489F-8919-E20B39E3D9C1}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(name: JString; type_: JString): JAccount; cdecl; overload;
    {class} function init(in_: JParcel): JAccount; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/accounts/Account')]
  JAccount = interface(JObject)
    ['{71476381-8B6E-471F-9189-9857ECD7508C}']
    function _Getname: JString; cdecl;
    function _Gettype: JString; cdecl;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property name: JString read _Getname;
    property &type: JString read _Gettype;
  end;
  TJAccount = class(TJavaGenericImport<JAccountClass, JAccount>) end;

  JAccountManagerClass = interface(JObjectClass)
    ['{96273844-2D84-47F0-BFD5-14B73402F843}']
    {class} function _GetACTION_AUTHENTICATOR_INTENT: JString; cdecl;
    {class} function _GetAUTHENTICATOR_ATTRIBUTES_NAME: JString; cdecl;
    {class} function _GetAUTHENTICATOR_META_DATA_NAME: JString; cdecl;
    {class} function _GetERROR_CODE_BAD_ARGUMENTS: Integer; cdecl;
    {class} function _GetERROR_CODE_BAD_AUTHENTICATION: Integer; cdecl;
    {class} function _GetERROR_CODE_BAD_REQUEST: Integer; cdecl;
    {class} function _GetERROR_CODE_CANCELED: Integer; cdecl;
    {class} function _GetERROR_CODE_INVALID_RESPONSE: Integer; cdecl;
    {class} function _GetERROR_CODE_NETWORK_ERROR: Integer; cdecl;
    {class} function _GetERROR_CODE_REMOTE_EXCEPTION: Integer; cdecl;
    {class} function _GetERROR_CODE_UNSUPPORTED_OPERATION: Integer; cdecl;
    {class} function _GetKEY_ACCOUNTS: JString; cdecl;
    {class} function _GetKEY_ACCOUNT_AUTHENTICATOR_RESPONSE: JString; cdecl;
    {class} function _GetKEY_ACCOUNT_MANAGER_RESPONSE: JString; cdecl;
    {class} function _GetKEY_ACCOUNT_NAME: JString; cdecl;
    {class} function _GetKEY_ACCOUNT_TYPE: JString; cdecl;
    {class} function _GetKEY_ANDROID_PACKAGE_NAME: JString; cdecl;
    {class} function _GetKEY_AUTHENTICATOR_TYPES: JString; cdecl;
    {class} function _GetKEY_AUTHTOKEN: JString; cdecl;
    {class} function _GetKEY_AUTH_FAILED_MESSAGE: JString; cdecl;
    {class} function _GetKEY_AUTH_TOKEN_LABEL: JString; cdecl;
    {class} function _GetKEY_BOOLEAN_RESULT: JString; cdecl;
    {class} function _GetKEY_CALLER_PID: JString; cdecl;
    {class} function _GetKEY_CALLER_UID: JString; cdecl;
    {class} function _GetKEY_ERROR_CODE: JString; cdecl;
    {class} function _GetKEY_ERROR_MESSAGE: JString; cdecl;
    {class} function _GetKEY_INTENT: JString; cdecl;
    {class} function _GetKEY_LAST_AUTHENTICATED_TIME: JString; cdecl;
    {class} function _GetKEY_PASSWORD: JString; cdecl;
    {class} function _GetKEY_USERDATA: JString; cdecl;
    {class} function _GetLOGIN_ACCOUNTS_CHANGED_ACTION: JString; cdecl;
    {class} function &get(context: JContext): JAccountManager; cdecl;
    {class} function newChooseAccountIntent(selectedAccount: JAccount; allowableAccounts: JArrayList; allowableAccountTypes: TJavaObjectArray<JString>; alwaysPromptForAccount: Boolean; descriptionOverrideText: JString; addAccountAuthTokenType: JString; addAccountRequiredFeatures: TJavaObjectArray<JString>; addAccountOptions: JBundle): JIntent; cdecl; overload;//Deprecated
    {class} function newChooseAccountIntent(selectedAccount: JAccount; allowableAccounts: JList; allowableAccountTypes: TJavaObjectArray<JString>; descriptionOverrideText: JString; addAccountAuthTokenType: JString; addAccountRequiredFeatures: TJavaObjectArray<JString>; addAccountOptions: JBundle): JIntent; cdecl; overload;
    {class} property ACTION_AUTHENTICATOR_INTENT: JString read _GetACTION_AUTHENTICATOR_INTENT;
    {class} property AUTHENTICATOR_ATTRIBUTES_NAME: JString read _GetAUTHENTICATOR_ATTRIBUTES_NAME;
    {class} property AUTHENTICATOR_META_DATA_NAME: JString read _GetAUTHENTICATOR_META_DATA_NAME;
    {class} property ERROR_CODE_BAD_ARGUMENTS: Integer read _GetERROR_CODE_BAD_ARGUMENTS;
    {class} property ERROR_CODE_BAD_AUTHENTICATION: Integer read _GetERROR_CODE_BAD_AUTHENTICATION;
    {class} property ERROR_CODE_BAD_REQUEST: Integer read _GetERROR_CODE_BAD_REQUEST;
    {class} property ERROR_CODE_CANCELED: Integer read _GetERROR_CODE_CANCELED;
    {class} property ERROR_CODE_INVALID_RESPONSE: Integer read _GetERROR_CODE_INVALID_RESPONSE;
    {class} property ERROR_CODE_NETWORK_ERROR: Integer read _GetERROR_CODE_NETWORK_ERROR;
    {class} property ERROR_CODE_REMOTE_EXCEPTION: Integer read _GetERROR_CODE_REMOTE_EXCEPTION;
    {class} property ERROR_CODE_UNSUPPORTED_OPERATION: Integer read _GetERROR_CODE_UNSUPPORTED_OPERATION;
    {class} property KEY_ACCOUNTS: JString read _GetKEY_ACCOUNTS;
    {class} property KEY_ACCOUNT_AUTHENTICATOR_RESPONSE: JString read _GetKEY_ACCOUNT_AUTHENTICATOR_RESPONSE;
    {class} property KEY_ACCOUNT_MANAGER_RESPONSE: JString read _GetKEY_ACCOUNT_MANAGER_RESPONSE;
    {class} property KEY_ACCOUNT_NAME: JString read _GetKEY_ACCOUNT_NAME;
    {class} property KEY_ACCOUNT_TYPE: JString read _GetKEY_ACCOUNT_TYPE;
    {class} property KEY_ANDROID_PACKAGE_NAME: JString read _GetKEY_ANDROID_PACKAGE_NAME;
    {class} property KEY_AUTHENTICATOR_TYPES: JString read _GetKEY_AUTHENTICATOR_TYPES;
    {class} property KEY_AUTHTOKEN: JString read _GetKEY_AUTHTOKEN;
    {class} property KEY_AUTH_FAILED_MESSAGE: JString read _GetKEY_AUTH_FAILED_MESSAGE;
    {class} property KEY_AUTH_TOKEN_LABEL: JString read _GetKEY_AUTH_TOKEN_LABEL;
    {class} property KEY_BOOLEAN_RESULT: JString read _GetKEY_BOOLEAN_RESULT;
    {class} property KEY_CALLER_PID: JString read _GetKEY_CALLER_PID;
    {class} property KEY_CALLER_UID: JString read _GetKEY_CALLER_UID;
    {class} property KEY_ERROR_CODE: JString read _GetKEY_ERROR_CODE;
    {class} property KEY_ERROR_MESSAGE: JString read _GetKEY_ERROR_MESSAGE;
    {class} property KEY_INTENT: JString read _GetKEY_INTENT;
    {class} property KEY_LAST_AUTHENTICATED_TIME: JString read _GetKEY_LAST_AUTHENTICATED_TIME;
    {class} property KEY_PASSWORD: JString read _GetKEY_PASSWORD;
    {class} property KEY_USERDATA: JString read _GetKEY_USERDATA;
    {class} property LOGIN_ACCOUNTS_CHANGED_ACTION: JString read _GetLOGIN_ACCOUNTS_CHANGED_ACTION;
  end;

  [JavaSignature('android/accounts/AccountManager')]
  JAccountManager = interface(JObject)
    ['{9FA4077B-4628-433C-BAFC-9EB299DA9C98}']
    function addAccount(accountType: JString; authTokenType: JString; requiredFeatures: TJavaObjectArray<JString>; addAccountOptions: JBundle; activity: JActivity; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl;
    function addAccountExplicitly(account: JAccount; password: JString; userdata: JBundle): Boolean; cdecl;
    procedure addOnAccountsUpdatedListener(listener: JOnAccountsUpdateListener; handler: JHandler; updateImmediately: Boolean); cdecl;
    function blockingGetAuthToken(account: JAccount; authTokenType: JString; notifyAuthFailure: Boolean): JString; cdecl;
    procedure clearPassword(account: JAccount); cdecl;
    function confirmCredentials(account: JAccount; options: JBundle; activity: JActivity; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl;
    function editProperties(accountType: JString; activity: JActivity; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl;
    function getAccounts: TJavaObjectArray<JAccount>; cdecl;
    function getAccountsByType(type_: JString): TJavaObjectArray<JAccount>; cdecl;
    function getAccountsByTypeAndFeatures(type_: JString; features: TJavaObjectArray<JString>; callback: TJavaObjectArray<JAccountManagerCallback>; handler: JHandler): TJavaObjectArray<JAccountManagerFuture>; cdecl;
    function getAccountsByTypeForPackage(type_: JString; packageName: JString): TJavaObjectArray<JAccount>; cdecl;
    function getAuthToken(account: JAccount; authTokenType: JString; options: JBundle; activity: JActivity; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl; overload;
    function getAuthToken(account: JAccount; authTokenType: JString; notifyAuthFailure: Boolean; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl; overload;//Deprecated
    function getAuthToken(account: JAccount; authTokenType: JString; options: JBundle; notifyAuthFailure: Boolean; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl; overload;
    function getAuthTokenByFeatures(accountType: JString; authTokenType: JString; features: TJavaObjectArray<JString>; activity: JActivity; addAccountOptions: JBundle; getAuthTokenOptions: JBundle; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl;
    function getAuthenticatorTypes: TJavaObjectArray<JAuthenticatorDescription>; cdecl;
    function getPassword(account: JAccount): JString; cdecl;
    function getPreviousName(account: JAccount): JString; cdecl;
    function getUserData(account: JAccount; key: JString): JString; cdecl;
    function hasFeatures(account: JAccount; features: TJavaObjectArray<JString>; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl;
    procedure invalidateAuthToken(accountType: JString; authToken: JString); cdecl;
    function notifyAccountAuthenticated(account: JAccount): Boolean; cdecl;
    function peekAuthToken(account: JAccount; authTokenType: JString): JString; cdecl;
    function removeAccount(account: JAccount; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl; overload;//Deprecated
    function removeAccount(account: JAccount; activity: JActivity; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl; overload;
    function removeAccountExplicitly(account: JAccount): Boolean; cdecl;
    procedure removeOnAccountsUpdatedListener(listener: JOnAccountsUpdateListener); cdecl;
    function renameAccount(account: JAccount; newName: JString; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl;
    procedure setAuthToken(account: JAccount; authTokenType: JString; authToken: JString); cdecl;
    procedure setPassword(account: JAccount; password: JString); cdecl;
    procedure setUserData(account: JAccount; key: JString; value: JString); cdecl;
    function updateCredentials(account: JAccount; authTokenType: JString; options: JBundle; activity: JActivity; callback: JAccountManagerCallback; handler: JHandler): JAccountManagerFuture; cdecl;
  end;
  TJAccountManager = class(TJavaGenericImport<JAccountManagerClass, JAccountManager>) end;

  JAccountManagerCallbackClass = interface(IJavaClass)
    ['{2BB75752-63FB-452C-9774-7731FF54106C}']
  end;

  [JavaSignature('android/accounts/AccountManagerCallback')]
  JAccountManagerCallback = interface(IJavaInstance)
    ['{BAAAB7C0-D823-4787-AD18-053B44CBBADD}']
    procedure run(future: JAccountManagerFuture); cdecl;
  end;
  TJAccountManagerCallback = class(TJavaGenericImport<JAccountManagerCallbackClass, JAccountManagerCallback>) end;

  JAccountManagerFutureClass = interface(IJavaClass)
    ['{B87CF21F-E69E-409A-AA91-204D152A7183}']
  end;

  [JavaSignature('android/accounts/AccountManagerFuture')]
  JAccountManagerFuture = interface(IJavaInstance)
    ['{608D5C94-7A70-44B3-8F29-7F84F825A2D2}']
    function cancel(mayInterruptIfRunning: Boolean): Boolean; cdecl;
    function getResult: JObject; cdecl; overload;
    function getResult(timeout: Int64; unit_: JTimeUnit): JObject; cdecl; overload;
    function isCancelled: Boolean; cdecl;
    function isDone: Boolean; cdecl;
  end;
  TJAccountManagerFuture = class(TJavaGenericImport<JAccountManagerFutureClass, JAccountManagerFuture>) end;

  JAuthenticatorDescriptionClass = interface(JObjectClass)
    ['{6FDEA3E2-7412-4415-A32F-FD7689B911B4}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(type_: JString; packageName: JString; labelId: Integer; iconId: Integer; smallIconId: Integer; prefId: Integer; customTokens: Boolean): JAuthenticatorDescription; cdecl; overload;
    {class} function init(type_: JString; packageName: JString; labelId: Integer; iconId: Integer; smallIconId: Integer; prefId: Integer): JAuthenticatorDescription; cdecl; overload;
    {class} function newKey(type_: JString): JAuthenticatorDescription; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/accounts/AuthenticatorDescription')]
  JAuthenticatorDescription = interface(JObject)
    ['{9F482564-61EE-4E96-B6F0-B1673A7E4620}']
    function _GetaccountPreferencesId: Integer; cdecl;
    function _GetcustomTokens: Boolean; cdecl;
    function _GeticonId: Integer; cdecl;
    function _GetlabelId: Integer; cdecl;
    function _GetpackageName: JString; cdecl;
    function _GetsmallIconId: Integer; cdecl;
    function _Gettype: JString; cdecl;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property accountPreferencesId: Integer read _GetaccountPreferencesId;
    property customTokens: Boolean read _GetcustomTokens;
    property iconId: Integer read _GeticonId;
    property labelId: Integer read _GetlabelId;
    property packageName: JString read _GetpackageName;
    property smallIconId: Integer read _GetsmallIconId;
    property &type: JString read _Gettype;
  end;
  TJAuthenticatorDescription = class(TJavaGenericImport<JAuthenticatorDescriptionClass, JAuthenticatorDescription>) end;

  JOnAccountsUpdateListenerClass = interface(IJavaClass)
    ['{3C07CAD3-934F-4DC2-A61F-2A7401AEC9DE}']
  end;

  [JavaSignature('android/accounts/OnAccountsUpdateListener')]
  JOnAccountsUpdateListener = interface(IJavaInstance)
    ['{AC1ECF5C-E922-4AC1-95B1-345E995C36E7}']
    procedure onAccountsUpdated(accounts: TJavaObjectArray<JAccount>); cdecl;
  end;
  TJOnAccountsUpdateListener = class(TJavaGenericImport<JOnAccountsUpdateListenerClass, JOnAccountsUpdateListener>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Accounts.JAccount', TypeInfo(Androidapi.JNI.Accounts.JAccount));
  TRegTypes.RegisterType('Androidapi.JNI.Accounts.JAccountManager', TypeInfo(Androidapi.JNI.Accounts.JAccountManager));
  TRegTypes.RegisterType('Androidapi.JNI.Accounts.JAccountManagerCallback', TypeInfo(Androidapi.JNI.Accounts.JAccountManagerCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Accounts.JAccountManagerFuture', TypeInfo(Androidapi.JNI.Accounts.JAccountManagerFuture));
  TRegTypes.RegisterType('Androidapi.JNI.Accounts.JAuthenticatorDescription', TypeInfo(Androidapi.JNI.Accounts.JAuthenticatorDescription));
  TRegTypes.RegisterType('Androidapi.JNI.Accounts.JOnAccountsUpdateListener', TypeInfo(Androidapi.JNI.Accounts.JOnAccountsUpdateListener));
end;

initialization
  RegisterTypes;
end.


