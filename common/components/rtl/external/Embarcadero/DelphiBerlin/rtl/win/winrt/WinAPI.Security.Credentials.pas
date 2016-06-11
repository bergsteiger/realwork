{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Security.Credentials;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Foundation.Collections,
  Winapi.Storage.Streams,
  Winapi.Foundation,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Security.Credentials Class Names
  // Windows.Security.Credentials.WebAccountProvider
  // DualAPI
  SWebAccountProvider = 'Windows.Security.Credentials.WebAccountProvider';
  // Windows.Security.Credentials.WebAccount
  // DualAPI
  SWebAccount = 'Windows.Security.Credentials.WebAccount';
  // Windows.Security.Credentials.KeyCredentialRetrievalResult
  // DualAPI
  SKeyCredentialRetrievalResult = 'Windows.Security.Credentials.KeyCredentialRetrievalResult';
  // Windows.Security.Credentials.KeyCredentialOperationResult
  // DualAPI
  SKeyCredentialOperationResult = 'Windows.Security.Credentials.KeyCredentialOperationResult';
  // Windows.Security.Credentials.KeyCredentialAttestationResult
  // DualAPI
  SKeyCredentialAttestationResult = 'Windows.Security.Credentials.KeyCredentialAttestationResult';
  // Windows.Security.Credentials.KeyCredential
  // DualAPI
  SKeyCredential = 'Windows.Security.Credentials.KeyCredential';
  // Windows.Security.Credentials.KeyCredentialManager
  // DualAPI
  SKeyCredentialManager = 'Windows.Security.Credentials.KeyCredentialManager';
  // Windows.Security.Credentials.PasswordCredential
  // DualAPI
  SPasswordCredential = 'Windows.Security.Credentials.PasswordCredential';
  // Windows.Security.Credentials.PasswordVault
  // DualAPI
  SPasswordVault = 'Windows.Security.Credentials.PasswordVault';
  // Windows.Security.Credentials.PasswordCredentialPropertyStore
  // DualAPI
  SPasswordCredentialPropertyStore = 'Windows.Security.Credentials.PasswordCredentialPropertyStore';


type
  // Forward declare interfaces
  // Windows.Security.Credentials.IPasswordCredential
  IPasswordCredential = interface;
  PIPasswordCredential = ^IPasswordCredential;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.UI.UserConsentVerifierAvailability>
  AsyncOperationCompletedHandler_1__UI_UserConsentVerifierAvailability = interface;
  PAsyncOperationCompletedHandler_1__UI_UserConsentVerifierAvailability = ^AsyncOperationCompletedHandler_1__UI_UserConsentVerifierAvailability;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.UI.UserConsentVerifierAvailability>
  IAsyncOperation_1__UI_UserConsentVerifierAvailability = interface;
  PIAsyncOperation_1__UI_UserConsentVerifierAvailability = ^IAsyncOperation_1__UI_UserConsentVerifierAvailability;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.UI.UserConsentVerificationResult>
  AsyncOperationCompletedHandler_1__UI_UserConsentVerificationResult = interface;
  PAsyncOperationCompletedHandler_1__UI_UserConsentVerificationResult = ^AsyncOperationCompletedHandler_1__UI_UserConsentVerificationResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.UI.UserConsentVerificationResult>
  IAsyncOperation_1__UI_UserConsentVerificationResult = interface;
  PIAsyncOperation_1__UI_UserConsentVerificationResult = ^IAsyncOperation_1__UI_UserConsentVerificationResult;

  // Windows.Security.Credentials.IWebAccountProvider
  IWebAccountProvider = interface;
  PIWebAccountProvider = ^IWebAccountProvider;

  // Windows.Security.Credentials.IWebAccount
  IWebAccount = interface;
  PIWebAccount = ^IWebAccount;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IWebAccount>
  AsyncOperationCompletedHandler_1__IWebAccount = interface;
  PAsyncOperationCompletedHandler_1__IWebAccount = ^AsyncOperationCompletedHandler_1__IWebAccount;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IWebAccount>
  IAsyncOperation_1__IWebAccount = interface;
  PIAsyncOperation_1__IWebAccount = ^IAsyncOperation_1__IWebAccount;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IWebAccountProvider>
  AsyncOperationCompletedHandler_1__IWebAccountProvider = interface;
  PAsyncOperationCompletedHandler_1__IWebAccountProvider = ^AsyncOperationCompletedHandler_1__IWebAccountProvider;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IWebAccountProvider>
  IAsyncOperation_1__IWebAccountProvider = interface;
  PIAsyncOperation_1__IWebAccountProvider = ^IAsyncOperation_1__IWebAccountProvider;

  // Windows.Foundation.Collections.IIterator`1<Windows.Security.Credentials.IWebAccount>
  IIterator_1__IWebAccount = interface;
  PIIterator_1__IWebAccount = ^IIterator_1__IWebAccount;

  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Credentials.IWebAccount>
  IIterable_1__IWebAccount = interface;
  PIIterable_1__IWebAccount = ^IIterable_1__IWebAccount;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Security.Credentials.IWebAccount>
  IVectorView_1__IWebAccount = interface;
  PIVectorView_1__IWebAccount = ^IVectorView_1__IWebAccount;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Credentials.IWebAccount>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IWebAccount = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IWebAccount = ^AsyncOperationCompletedHandler_1__IVectorView_1__IWebAccount;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Credentials.IWebAccount>>
  IAsyncOperation_1__IVectorView_1__IWebAccount = interface;
  PIAsyncOperation_1__IVectorView_1__IWebAccount = ^IAsyncOperation_1__IVectorView_1__IWebAccount;

  // Windows.Security.Credentials.IWebAccountFactory
  IWebAccountFactory = interface;
  PIWebAccountFactory = ^IWebAccountFactory;

  // Windows.Security.Credentials.IWebAccount2
  IWebAccount2 = interface;
  PIWebAccount2 = ^IWebAccount2;

  // Windows.Security.Credentials.IWebAccountProviderFactory
  IWebAccountProviderFactory = interface;
  PIWebAccountProviderFactory = ^IWebAccountProviderFactory;

  // Windows.Security.Credentials.IWebAccountProvider2
  IWebAccountProvider2 = interface;
  PIWebAccountProvider2 = ^IWebAccountProvider2;

  // Windows.Security.Credentials.IWebAccountProvider3
  IWebAccountProvider3 = interface;
  PIWebAccountProvider3 = ^IWebAccountProvider3;

  // Windows.Security.Credentials.IKeyCredentialOperationResult
  IKeyCredentialOperationResult = interface;
  PIKeyCredentialOperationResult = ^IKeyCredentialOperationResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IKeyCredentialOperationResult>
  AsyncOperationCompletedHandler_1__IKeyCredentialOperationResult = interface;
  PAsyncOperationCompletedHandler_1__IKeyCredentialOperationResult = ^AsyncOperationCompletedHandler_1__IKeyCredentialOperationResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IKeyCredentialOperationResult>
  IAsyncOperation_1__IKeyCredentialOperationResult = interface;
  PIAsyncOperation_1__IKeyCredentialOperationResult = ^IAsyncOperation_1__IKeyCredentialOperationResult;

  // Windows.Security.Credentials.IKeyCredentialAttestationResult
  IKeyCredentialAttestationResult = interface;
  PIKeyCredentialAttestationResult = ^IKeyCredentialAttestationResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IKeyCredentialAttestationResult>
  AsyncOperationCompletedHandler_1__IKeyCredentialAttestationResult = interface;
  PAsyncOperationCompletedHandler_1__IKeyCredentialAttestationResult = ^AsyncOperationCompletedHandler_1__IKeyCredentialAttestationResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IKeyCredentialAttestationResult>
  IAsyncOperation_1__IKeyCredentialAttestationResult = interface;
  PIAsyncOperation_1__IKeyCredentialAttestationResult = ^IAsyncOperation_1__IKeyCredentialAttestationResult;

  // Windows.Security.Credentials.IKeyCredential
  IKeyCredential = interface;
  PIKeyCredential = ^IKeyCredential;

  // Windows.Security.Credentials.IKeyCredentialRetrievalResult
  IKeyCredentialRetrievalResult = interface;
  PIKeyCredentialRetrievalResult = ^IKeyCredentialRetrievalResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IKeyCredentialRetrievalResult>
  AsyncOperationCompletedHandler_1__IKeyCredentialRetrievalResult = interface;
  PAsyncOperationCompletedHandler_1__IKeyCredentialRetrievalResult = ^AsyncOperationCompletedHandler_1__IKeyCredentialRetrievalResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IKeyCredentialRetrievalResult>
  IAsyncOperation_1__IKeyCredentialRetrievalResult = interface;
  PIAsyncOperation_1__IKeyCredentialRetrievalResult = ^IAsyncOperation_1__IKeyCredentialRetrievalResult;

  // Windows.Security.Credentials.IKeyCredentialManagerStatics
  IKeyCredentialManagerStatics = interface;
  PIKeyCredentialManagerStatics = ^IKeyCredentialManagerStatics;

  // Windows.Security.Credentials.ICredentialFactory
  ICredentialFactory = interface;
  PICredentialFactory = ^ICredentialFactory;

  // Windows.Foundation.Collections.IIterator`1<Windows.Security.Credentials.IPasswordCredential>
  IIterator_1__IPasswordCredential = interface;
  PIIterator_1__IPasswordCredential = ^IIterator_1__IPasswordCredential;

  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Credentials.IPasswordCredential>
  IIterable_1__IPasswordCredential = interface;
  PIIterable_1__IPasswordCredential = ^IIterable_1__IPasswordCredential;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Security.Credentials.IPasswordCredential>
  IVectorView_1__IPasswordCredential = interface;
  PIVectorView_1__IPasswordCredential = ^IVectorView_1__IPasswordCredential;

  // Windows.Security.Credentials.IPasswordVault
  IPasswordVault = interface;
  PIPasswordVault = ^IPasswordVault;


  // Emit Forwarded interfaces
  // Windows.Security.Credentials Interfaces
  // DualAPI Interface
  // Windows.Security.Credentials.IPasswordCredential
  [WinRTClassNameAttribute(SPasswordCredential)]
  IPasswordCredential = interface(IInspectable)
  ['{6AB18989-C720-41A7-A6C1-FEADB36329A0}']
    function get_Resource: HSTRING; safecall;
    procedure put_Resource(resource: HSTRING); safecall;
    function get_UserName: HSTRING; safecall;
    procedure put_UserName(userName: HSTRING); safecall;
    function get_Password: HSTRING; safecall;
    procedure put_Password(password: HSTRING); safecall;
    procedure RetrievePassword; safecall;
    function get_Properties: IPropertySet; safecall;
    property Password: HSTRING read get_Password write put_Password;
    property Properties: IPropertySet read get_Properties;
    property Resource: HSTRING read get_Resource write put_Resource;
    property UserName: HSTRING read get_UserName write put_UserName;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.UI.UserConsentVerifierAvailability>
  AsyncOperationCompletedHandler_1__UI_UserConsentVerifierAvailability_Delegate_Base = interface(IUnknown)
  ['{28988174-ACE2-5C15-A0DF-580A26D94294}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.UI.UserConsentVerifierAvailability>
  AsyncOperationCompletedHandler_1__UI_UserConsentVerifierAvailability = interface(AsyncOperationCompletedHandler_1__UI_UserConsentVerifierAvailability_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__UI_UserConsentVerifierAvailability; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.UI.UserConsentVerifierAvailability>
  IAsyncOperation_1__UI_UserConsentVerifierAvailability_Base = interface(IInspectable)
  ['{DDD384F3-D818-5D83-AB4B-32119C28587C}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.UI.UserConsentVerifierAvailability>
  IAsyncOperation_1__UI_UserConsentVerifierAvailability = interface(IAsyncOperation_1__UI_UserConsentVerifierAvailability_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__UI_UserConsentVerifierAvailability); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__UI_UserConsentVerifierAvailability; safecall;
    function GetResults: UI_UserConsentVerifierAvailability; safecall;
    property Completed: AsyncOperationCompletedHandler_1__UI_UserConsentVerifierAvailability read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.UI.UserConsentVerificationResult>
  AsyncOperationCompletedHandler_1__UI_UserConsentVerificationResult_Delegate_Base = interface(IUnknown)
  ['{0CFFC6C9-4C2B-5CD4-B38C-7B8DF3FF5AFB}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.UI.UserConsentVerificationResult>
  AsyncOperationCompletedHandler_1__UI_UserConsentVerificationResult = interface(AsyncOperationCompletedHandler_1__UI_UserConsentVerificationResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__UI_UserConsentVerificationResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.UI.UserConsentVerificationResult>
  IAsyncOperation_1__UI_UserConsentVerificationResult_Base = interface(IInspectable)
  ['{FD596FFD-2318-558F-9DBE-D21DF43764A5}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.UI.UserConsentVerificationResult>
  IAsyncOperation_1__UI_UserConsentVerificationResult = interface(IAsyncOperation_1__UI_UserConsentVerificationResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__UI_UserConsentVerificationResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__UI_UserConsentVerificationResult; safecall;
    function GetResults: UI_UserConsentVerificationResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__UI_UserConsentVerificationResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IWebAccountProvider
  [WinRTClassNameAttribute(SWebAccountProvider)]
  IWebAccountProvider = interface(IInspectable)
  ['{29DCC8C3-7AB9-4A7C-A336-B942F9DBF7C7}']
    function get_Id: HSTRING; safecall;
    function get_DisplayName: HSTRING; safecall;
    function get_IconUri: IUriRuntimeClass; safecall;
    property DisplayName: HSTRING read get_DisplayName;
    property IconUri: IUriRuntimeClass read get_IconUri;
    property Id: HSTRING read get_Id;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IWebAccount
  [WinRTClassNameAttribute(SWebAccount)]
  IWebAccount = interface(IInspectable)
  ['{69473EB2-8031-49BE-80BB-96CB46D99ABA}']
    function get_WebAccountProvider: IWebAccountProvider; safecall;
    function get_UserName: HSTRING; safecall;
    function get_State: WebAccountState; safecall;
    property State: WebAccountState read get_State;
    property UserName: HSTRING read get_UserName;
    property WebAccountProvider: IWebAccountProvider read get_WebAccountProvider;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IWebAccount>
  AsyncOperationCompletedHandler_1__IWebAccount_Delegate_Base = interface(IUnknown)
  ['{4BD6F1E5-CA89-5240-8F3D-7F1B54AE90A7}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IWebAccount>
  AsyncOperationCompletedHandler_1__IWebAccount = interface(AsyncOperationCompletedHandler_1__IWebAccount_Delegate_Base)
  ['{B10C69CC-B076-5988-B147-09363CA35D01}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IWebAccount; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IWebAccount>
  IAsyncOperation_1__IWebAccount_Base = interface(IInspectable)
  ['{ACD76B54-297F-5A18-9143-20A309E2DFD3}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IWebAccount>
  IAsyncOperation_1__IWebAccount = interface(IAsyncOperation_1__IWebAccount_Base)
  ['{691C50CC-BB04-5825-805C-A80108E1F539}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IWebAccount); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IWebAccount; safecall;
    function GetResults: IWebAccount; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IWebAccount read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IWebAccountProvider>
  AsyncOperationCompletedHandler_1__IWebAccountProvider_Delegate_Base = interface(IUnknown)
  ['{9477622B-1340-5574-81FC-5013581F57C9}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IWebAccountProvider>
  AsyncOperationCompletedHandler_1__IWebAccountProvider = interface(AsyncOperationCompletedHandler_1__IWebAccountProvider_Delegate_Base)
  ['{C39FF379-8E7D-54D3-A6A2-30732DBECB20}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IWebAccountProvider; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IWebAccountProvider>
  IAsyncOperation_1__IWebAccountProvider_Base = interface(IInspectable)
  ['{88C66009-12F7-58E2-8DBE-6EFC620C85BA}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IWebAccountProvider>
  IAsyncOperation_1__IWebAccountProvider = interface(IAsyncOperation_1__IWebAccountProvider_Base)
  ['{5DF2D5A2-29BE-588D-A865-2D532F0CFEB4}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IWebAccountProvider); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IWebAccountProvider; safecall;
    function GetResults: IWebAccountProvider; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IWebAccountProvider read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Security.Credentials.IWebAccount>
  IIterator_1__IWebAccount = interface(IInspectable)
  ['{7B1BB16E-3EAB-508A-9EB6-4F170A834193}']
    function get_Current: IWebAccount; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIWebAccount): Cardinal; safecall;
    property Current: IWebAccount read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Credentials.IWebAccount>
  IIterable_1__IWebAccount_Base = interface(IInspectable)
  ['{CB15D439-A910-542A-89ED-7CFE67848A83}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Credentials.IWebAccount>
  IIterable_1__IWebAccount = interface(IIterable_1__IWebAccount_Base)
  ['{4EA35D15-AA11-5236-9708-C8030DCA63DC}']
    function First: IIterator_1__IWebAccount; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Security.Credentials.IWebAccount>
  IVectorView_1__IWebAccount = interface(IInspectable)
  ['{4C618663-2E68-5686-9058-F0A1B557EF74}']
    function GetAt(index: Cardinal): IWebAccount; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IWebAccount; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIWebAccount): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Credentials.IWebAccount>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IWebAccount_Delegate_Base = interface(IUnknown)
  ['{C2090D8C-37D8-5C47-9581-0F17B91A0CD3}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Credentials.IWebAccount>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IWebAccount = interface(AsyncOperationCompletedHandler_1__IVectorView_1__IWebAccount_Delegate_Base)
  ['{D7DC33D6-EF58-5AD6-823F-F907097A8CBB}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IWebAccount; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Credentials.IWebAccount>>
  IAsyncOperation_1__IVectorView_1__IWebAccount_Base = interface(IInspectable)
  ['{66B59040-7C93-5F96-B52F-2C098D1557D0}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Security.Credentials.IWebAccount>>
  IAsyncOperation_1__IVectorView_1__IWebAccount = interface(IAsyncOperation_1__IVectorView_1__IWebAccount_Base)
  ['{5D82779F-56CD-593C-BCF2-64A212D2DD67}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IWebAccount); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IWebAccount; safecall;
    function GetResults: IVectorView_1__IWebAccount; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IWebAccount read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IWebAccountFactory
  [WinRTClassNameAttribute(SWebAccount)]
  IWebAccountFactory = interface(IInspectable)
  ['{AC9AFB39-1DE9-4E92-B78F-0581A87F6E5C}']
    function CreateWebAccount(webAccountProvider: IWebAccountProvider; userName: HSTRING; state: WebAccountState): IWebAccount; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IWebAccount2
  IWebAccount2 = interface(IInspectable)
  ['{7B56D6F8-990B-4EB5-94A7-5621F3A8B824}']
    function get_Id: HSTRING; safecall;
    function get_Properties: IMapView_2__HSTRING__HSTRING; safecall;
    function GetPictureAsync(desizedSize: WebAccountPictureSize): IAsyncOperation_1__IRandomAccessStream; safecall;
    function SignOutAsync: IAsyncAction; overload; safecall;
    function SignOutAsync(clientId: HSTRING): IAsyncAction; overload; safecall;
    property Id: HSTRING read get_Id;
    property Properties: IMapView_2__HSTRING__HSTRING read get_Properties;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IWebAccountProviderFactory
  [WinRTClassNameAttribute(SWebAccountProvider)]
  IWebAccountProviderFactory = interface(IInspectable)
  ['{1D767DF1-E1E1-4B9A-A774-5C7C7E3BF371}']
    function CreateWebAccountProvider(id: HSTRING; displayName: HSTRING; iconUri: IUriRuntimeClass): IWebAccountProvider; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IWebAccountProvider2
  IWebAccountProvider2 = interface(IInspectable)
  ['{4A01EB05-4E42-41D4-B518-E008A5163614}']
    function get_DisplayPurpose: HSTRING; safecall;
    function get_Authority: HSTRING; safecall;
    property Authority: HSTRING read get_Authority;
    property DisplayPurpose: HSTRING read get_DisplayPurpose;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IWebAccountProvider3
  IWebAccountProvider3 = interface(IInspectable)
  ['{DA1C518B-970D-4D49-825C-F2706F8CA7FE}']
    function get_User: IInspectable{IUser}; safecall;
    property User: IInspectable{IUser} read get_User;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IKeyCredentialOperationResult
  [WinRTClassNameAttribute(SKeyCredentialOperationResult)]
  IKeyCredentialOperationResult = interface(IInspectable)
  ['{F53786C1-5261-4CDD-976D-CC909AC71620}']
    function get_Result: IBuffer; safecall;
    function get_Status: KeyCredentialStatus; safecall;
    property Result: IBuffer read get_Result;
    property Status: KeyCredentialStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IKeyCredentialOperationResult>
  AsyncOperationCompletedHandler_1__IKeyCredentialOperationResult_Delegate_Base = interface(IUnknown)
  ['{39B4609A-0202-55FA-8005-6F83709E20F3}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IKeyCredentialOperationResult>
  AsyncOperationCompletedHandler_1__IKeyCredentialOperationResult = interface(AsyncOperationCompletedHandler_1__IKeyCredentialOperationResult_Delegate_Base)
  ['{F6D2BE52-9016-57D4-8CC1-06F861215406}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IKeyCredentialOperationResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IKeyCredentialOperationResult>
  IAsyncOperation_1__IKeyCredentialOperationResult_Base = interface(IInspectable)
  ['{6576E5B3-9535-50D6-98F6-C67D6AACA2C5}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IKeyCredentialOperationResult>
  IAsyncOperation_1__IKeyCredentialOperationResult = interface(IAsyncOperation_1__IKeyCredentialOperationResult_Base)
  ['{2B1CF200-85BE-58C2-8380-15F6F437E5B7}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IKeyCredentialOperationResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IKeyCredentialOperationResult; safecall;
    function GetResults: IKeyCredentialOperationResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IKeyCredentialOperationResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IKeyCredentialAttestationResult
  [WinRTClassNameAttribute(SKeyCredentialAttestationResult)]
  IKeyCredentialAttestationResult = interface(IInspectable)
  ['{78AAB3A1-A3C1-4103-B6CC-472C44171CBB}']
    function get_CertificateChainBuffer: IBuffer; safecall;
    function get_AttestationBuffer: IBuffer; safecall;
    function get_Status: KeyCredentialAttestationStatus; safecall;
    property AttestationBuffer: IBuffer read get_AttestationBuffer;
    property CertificateChainBuffer: IBuffer read get_CertificateChainBuffer;
    property Status: KeyCredentialAttestationStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IKeyCredentialAttestationResult>
  AsyncOperationCompletedHandler_1__IKeyCredentialAttestationResult_Delegate_Base = interface(IUnknown)
  ['{2C16E103-F783-5DD9-A5F3-3362BCBDAABD}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IKeyCredentialAttestationResult>
  AsyncOperationCompletedHandler_1__IKeyCredentialAttestationResult = interface(AsyncOperationCompletedHandler_1__IKeyCredentialAttestationResult_Delegate_Base)
  ['{019B23FA-0731-54AF-9B44-5E7A9E2D2160}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IKeyCredentialAttestationResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IKeyCredentialAttestationResult>
  IAsyncOperation_1__IKeyCredentialAttestationResult_Base = interface(IInspectable)
  ['{B83D29E9-F4E4-5AA4-92D5-B262CB40C622}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IKeyCredentialAttestationResult>
  IAsyncOperation_1__IKeyCredentialAttestationResult = interface(IAsyncOperation_1__IKeyCredentialAttestationResult_Base)
  ['{67AD516F-C0D7-5C2C-8A02-64EC5361E1AA}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IKeyCredentialAttestationResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IKeyCredentialAttestationResult; safecall;
    function GetResults: IKeyCredentialAttestationResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IKeyCredentialAttestationResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IKeyCredential
  [WinRTClassNameAttribute(SKeyCredential)]
  IKeyCredential = interface(IInspectable)
  ['{9585EF8D-457B-4847-B11A-FA960BBDB138}']
    function get_Name: HSTRING; safecall;
    function RetrievePublicKey: IBuffer; safecall;
    function RequestSignAsync(data: IBuffer): IAsyncOperation_1__IKeyCredentialOperationResult; safecall;
    function GetAttestationAsync: IAsyncOperation_1__IKeyCredentialAttestationResult; safecall;
    property Name: HSTRING read get_Name;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IKeyCredentialRetrievalResult
  [WinRTClassNameAttribute(SKeyCredentialRetrievalResult)]
  IKeyCredentialRetrievalResult = interface(IInspectable)
  ['{58CD7703-8D87-4249-9B58-F6598CC9644E}']
    function get_Credential: IKeyCredential; safecall;
    function get_Status: KeyCredentialStatus; safecall;
    property Credential: IKeyCredential read get_Credential;
    property Status: KeyCredentialStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IKeyCredentialRetrievalResult>
  AsyncOperationCompletedHandler_1__IKeyCredentialRetrievalResult_Delegate_Base = interface(IUnknown)
  ['{03EA60B1-A874-58CE-8E8E-FFF448B6733E}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Security.Credentials.IKeyCredentialRetrievalResult>
  AsyncOperationCompletedHandler_1__IKeyCredentialRetrievalResult = interface(AsyncOperationCompletedHandler_1__IKeyCredentialRetrievalResult_Delegate_Base)
  ['{1BC39F2F-E816-5800-BF7F-19BB52D9352A}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IKeyCredentialRetrievalResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IKeyCredentialRetrievalResult>
  IAsyncOperation_1__IKeyCredentialRetrievalResult_Base = interface(IInspectable)
  ['{89D0AD1E-BD4C-55B4-810E-BDDD4CEC7A2A}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Security.Credentials.IKeyCredentialRetrievalResult>
  IAsyncOperation_1__IKeyCredentialRetrievalResult = interface(IAsyncOperation_1__IKeyCredentialRetrievalResult_Base)
  ['{FDE031B9-B951-5F3B-ADEA-C0C87D793496}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IKeyCredentialRetrievalResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IKeyCredentialRetrievalResult; safecall;
    function GetResults: IKeyCredentialRetrievalResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IKeyCredentialRetrievalResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IKeyCredentialManagerStatics
  [WinRTClassNameAttribute(SKeyCredentialManager)]
  IKeyCredentialManagerStatics = interface(IInspectable)
  ['{6AAC468B-0EF1-4CE0-8290-4106DA6A63B5}']
    function IsSupportedAsync: IAsyncOperation_1__Boolean; safecall;
    function RenewAttestationAsync: IAsyncAction; safecall;
    function RequestCreateAsync(name: HSTRING; option: KeyCredentialCreationOption): IAsyncOperation_1__IKeyCredentialRetrievalResult; safecall;
    function OpenAsync(name: HSTRING): IAsyncOperation_1__IKeyCredentialRetrievalResult; safecall;
    function DeleteAsync(name: HSTRING): IAsyncAction; safecall;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.ICredentialFactory
  [WinRTClassNameAttribute(SPasswordCredential)]
  ICredentialFactory = interface(IInspectable)
  ['{54EF13A1-BF26-47B5-97DD-DE779B7CAD58}']
    function CreatePasswordCredential(resource: HSTRING; userName: HSTRING; password: HSTRING): IPasswordCredential; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Security.Credentials.IPasswordCredential>
  IIterator_1__IPasswordCredential = interface(IInspectable)
  ['{C3C5D889-E8E7-591B-BAB3-6F1E4C8B74B2}']
    function get_Current: IPasswordCredential; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIPasswordCredential): Cardinal; safecall;
    property Current: IPasswordCredential read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Credentials.IPasswordCredential>
  IIterable_1__IPasswordCredential_Base = interface(IInspectable)
  ['{0D224A66-BAD5-5AD5-9ADE-1E9F5A60FE73}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Security.Credentials.IPasswordCredential>
  IIterable_1__IPasswordCredential = interface(IIterable_1__IPasswordCredential_Base)
  ['{B86DD1B0-F6AB-5DEE-926A-B8F623D76255}']
    function First: IIterator_1__IPasswordCredential; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Security.Credentials.IPasswordCredential>
  IVectorView_1__IPasswordCredential = interface(IInspectable)
  ['{A1AC5012-3C00-5B22-ADC1-095F7E86CA11}']
    function GetAt(index: Cardinal): IPasswordCredential; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IPasswordCredential; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIPasswordCredential): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Security.Credentials.IPasswordVault
  [WinRTClassNameAttribute(SPasswordVault)]
  IPasswordVault = interface(IInspectable)
  ['{61FD2C0B-C8D4-48C1-A54F-BC5A64205AF2}']
    procedure Add(credential: IPasswordCredential); safecall;
    procedure Remove(credential: IPasswordCredential); safecall;
    function Retrieve(resource: HSTRING; userName: HSTRING): IPasswordCredential; safecall;
    function FindAllByResource(resource: HSTRING): IVectorView_1__IPasswordCredential; safecall;
    function FindAllByUserName(userName: HSTRING): IVectorView_1__IPasswordCredential; safecall;
    function RetrieveAll: IVectorView_1__IPasswordCredential; safecall;
  end;


  // Emit Forwarded classes
  // Windows.Security.Credentials.WebAccountProvider
  // DualAPI
  TWebAccountProvider = class(TWinRTGenericImportF<IWebAccountProviderFactory>)
  public
    // -> IWebAccountProviderFactory
    class function CreateWebAccountProvider(id: HSTRING; displayName: HSTRING; iconUri: IUriRuntimeClass): IWebAccountProvider; static; inline;
  end;

  // Windows.Security.Credentials.WebAccount
  // DualAPI
  TWebAccount = class(TWinRTGenericImportF<IWebAccountFactory>)
  public
    // -> IWebAccountFactory
    class function CreateWebAccount(webAccountProvider: IWebAccountProvider; userName: HSTRING; state: WebAccountState): IWebAccount; static; inline;
  end;

  // Windows.Security.Credentials.KeyCredentialRetrievalResult
  // DualAPI

  // Windows.Security.Credentials.KeyCredentialOperationResult
  // DualAPI

  // Windows.Security.Credentials.KeyCredentialAttestationResult
  // DualAPI

  // Windows.Security.Credentials.KeyCredential
  // DualAPI

  // Windows.Security.Credentials.KeyCredentialManager
  // DualAPI
  TKeyCredentialManager = class(TWinRTGenericImportS<IKeyCredentialManagerStatics>)
  public
    // -> IKeyCredentialManagerStatics
    class function IsSupportedAsync: IAsyncOperation_1__Boolean; static; inline;
    class function RenewAttestationAsync: IAsyncAction; static; inline;
    class function RequestCreateAsync(name: HSTRING; option: KeyCredentialCreationOption): IAsyncOperation_1__IKeyCredentialRetrievalResult; static; inline;
    class function OpenAsync(name: HSTRING): IAsyncOperation_1__IKeyCredentialRetrievalResult; static; inline;
    class function DeleteAsync(name: HSTRING): IAsyncAction; static; inline;
  end;

  // Windows.Security.Credentials.PasswordCredential
  // DualAPI
  TPasswordCredential = class(TWinRTGenericImportFI<ICredentialFactory, IPasswordCredential>)
  public
    // -> ICredentialFactory
    class function CreatePasswordCredential(resource: HSTRING; userName: HSTRING; password: HSTRING): IPasswordCredential; static; inline;
  end;

  // Windows.Security.Credentials.PasswordVault
  // DualAPI
  TPasswordVault = class(TWinRTGenericImportI<IPasswordVault>) end;

  // Windows.Security.Credentials.PasswordCredentialPropertyStore
  // DualAPI
  TPasswordCredentialPropertyStore = class(TWinRTGenericImportI<IPropertySet>) end;


implementation

  // Emit Classes Implementation
 { TWebAccountProvider }
// Factories for : "WebAccountProvider"
// Factory: "Windows.Security.Credentials.IWebAccountProviderFactory"
// -> IWebAccountProviderFactory

class function TWebAccountProvider.CreateWebAccountProvider(id: HSTRING; displayName: HSTRING; iconUri: IUriRuntimeClass): IWebAccountProvider;
begin
  Result := Factory.CreateWebAccountProvider(id, displayName, iconUri);
end;


 { TWebAccount }
// Factories for : "WebAccount"
// Factory: "Windows.Security.Credentials.IWebAccountFactory"
// -> IWebAccountFactory

class function TWebAccount.CreateWebAccount(webAccountProvider: IWebAccountProvider; userName: HSTRING; state: WebAccountState): IWebAccount;
begin
  Result := Factory.CreateWebAccount(webAccountProvider, userName, state);
end;


 { TKeyCredentialManager }

class function TKeyCredentialManager.IsSupportedAsync: IAsyncOperation_1__Boolean;
begin
  Result := Statics.IsSupportedAsync;
end;

class function TKeyCredentialManager.RenewAttestationAsync: IAsyncAction;
begin
  Result := Statics.RenewAttestationAsync;
end;

class function TKeyCredentialManager.RequestCreateAsync(name: HSTRING; option: KeyCredentialCreationOption): IAsyncOperation_1__IKeyCredentialRetrievalResult;
begin
  Result := Statics.RequestCreateAsync(name, option);
end;

class function TKeyCredentialManager.OpenAsync(name: HSTRING): IAsyncOperation_1__IKeyCredentialRetrievalResult;
begin
  Result := Statics.OpenAsync(name);
end;

class function TKeyCredentialManager.DeleteAsync(name: HSTRING): IAsyncAction;
begin
  Result := Statics.DeleteAsync(name);
end;


 { TPasswordCredential }
// Factories for : "PasswordCredential"
// Factory: "Windows.Security.Credentials.ICredentialFactory"
// -> ICredentialFactory

class function TPasswordCredential.CreatePasswordCredential(resource: HSTRING; userName: HSTRING; password: HSTRING): IPasswordCredential;
begin
  Result := Factory.CreatePasswordCredential(resource, userName, password);
end;


 { TPasswordVault }

 { TPasswordCredentialPropertyStore }


end.
