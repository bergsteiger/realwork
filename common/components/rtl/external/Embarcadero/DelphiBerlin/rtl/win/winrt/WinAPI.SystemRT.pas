{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.SystemRT;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Foundation.Collections,
  Winapi.Foundation,
  Winapi.Storage.Streams,
  Winapi.Storage,
  Winapi.Globalization,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.System Class Names
  // Windows.System.UserProfile.UserProfilePersonalizationSettings
  // DualAPI
  SUserProfile_UserProfilePersonalizationSettings = 'Windows.System.UserProfile.UserProfilePersonalizationSettings';
  // Windows.System.UserProfile.GlobalizationPreferences
  // DualAPI
  SUserProfile_GlobalizationPreferences = 'Windows.System.UserProfile.GlobalizationPreferences';
  // Windows.System.UserWatcher
  // DualAPI
  SUserWatcher = 'Windows.System.UserWatcher';
  // Windows.System.User
  // DualAPI
  SUser = 'Windows.System.User';
  // Windows.System.UserChangedEventArgs
  // DualAPI
  SUserChangedEventArgs = 'Windows.System.UserChangedEventArgs';
  // Windows.System.UserAuthenticationStatusChangingEventArgs
  // DualAPI
  SUserAuthenticationStatusChangingEventArgs = 'Windows.System.UserAuthenticationStatusChangingEventArgs';
  // Windows.System.UserAuthenticationStatusChangeDeferral
  // DualAPI
  SUserAuthenticationStatusChangeDeferral = 'Windows.System.UserAuthenticationStatusChangeDeferral';
  // Windows.System.KnownUserProperties
  // DualAPI
  SKnownUserProperties = 'Windows.System.KnownUserProperties';
  // Windows.System.UserProfile.FirstSignInSettings
  // DualAPI
  SUserProfile_FirstSignInSettings = 'Windows.System.UserProfile.FirstSignInSettings';
  // Windows.System.UserProfile.LockScreen
  // DualAPI
  SUserProfile_LockScreen = 'Windows.System.UserProfile.LockScreen';
  // Windows.System.UserProfile.UserInformation
  // DualAPI
  SUserProfile_UserInformation = 'Windows.System.UserProfile.UserInformation';


type
  // Forward declare interfaces
  // Windows.System.IUser
  IUser = interface;
  PIUser = ^IUser;

  // Windows.System.IUserChangedEventArgs
  IUserChangedEventArgs = interface;
  PIUserChangedEventArgs = ^IUserChangedEventArgs;

  // Windows.System.Threading.WorkItemHandler
  Threading_WorkItemHandler = interface;
  PThreading_WorkItemHandler = ^Threading_WorkItemHandler;

  // Windows.System.UserProfile.IUserProfilePersonalizationSettings
  UserProfile_IUserProfilePersonalizationSettings = interface;
  PUserProfile_IUserProfilePersonalizationSettings = ^UserProfile_IUserProfilePersonalizationSettings;

  // Windows.System.UserProfile.IUserProfilePersonalizationSettingsStatics
  UserProfile_IUserProfilePersonalizationSettingsStatics = interface;
  PUserProfile_IUserProfilePersonalizationSettingsStatics = ^UserProfile_IUserProfilePersonalizationSettingsStatics;

  // Windows.System.UserProfile.IGlobalizationPreferencesStatics
  UserProfile_IGlobalizationPreferencesStatics = interface;
  PUserProfile_IGlobalizationPreferencesStatics = ^UserProfile_IGlobalizationPreferencesStatics;

  // Windows.Foundation.TypedEventHandler`2<Windows.System.IUserWatcher,Windows.System.IUserChangedEventArgs>
  TypedEventHandler_2__IUserWatcher__IUserChangedEventArgs = interface;
  PTypedEventHandler_2__IUserWatcher__IUserChangedEventArgs = ^TypedEventHandler_2__IUserWatcher__IUserChangedEventArgs;

  // Windows.System.IUserAuthenticationStatusChangeDeferral
  IUserAuthenticationStatusChangeDeferral = interface;
  PIUserAuthenticationStatusChangeDeferral = ^IUserAuthenticationStatusChangeDeferral;

  // Windows.System.IUserAuthenticationStatusChangingEventArgs
  IUserAuthenticationStatusChangingEventArgs = interface;
  PIUserAuthenticationStatusChangingEventArgs = ^IUserAuthenticationStatusChangingEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.System.IUserWatcher,Windows.System.IUserAuthenticationStatusChangingEventArgs>
  TypedEventHandler_2__IUserWatcher__IUserAuthenticationStatusChangingEventArgs = interface;
  PTypedEventHandler_2__IUserWatcher__IUserAuthenticationStatusChangingEventArgs = ^TypedEventHandler_2__IUserWatcher__IUserAuthenticationStatusChangingEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.System.IUserWatcher,Object>
  TypedEventHandler_2__IUserWatcher__IInspectable = interface;
  PTypedEventHandler_2__IUserWatcher__IInspectable = ^TypedEventHandler_2__IUserWatcher__IInspectable;

  // Windows.System.IUserWatcher
  IUserWatcher = interface;
  PIUserWatcher = ^IUserWatcher;

  // Windows.Foundation.Collections.IIterator`1<Windows.System.IUser>
  IIterator_1__IUser = interface;
  PIIterator_1__IUser = ^IIterator_1__IUser;

  // Windows.Foundation.Collections.IIterable`1<Windows.System.IUser>
  IIterable_1__IUser = interface;
  PIIterable_1__IUser = ^IIterable_1__IUser;

  // Windows.Foundation.Collections.IVectorView`1<Windows.System.IUser>
  IVectorView_1__IUser = interface;
  PIVectorView_1__IUser = ^IVectorView_1__IUser;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.System.IUser>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IUser = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IUser = ^AsyncOperationCompletedHandler_1__IVectorView_1__IUser;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.System.IUser>>
  IAsyncOperation_1__IVectorView_1__IUser = interface;
  PIAsyncOperation_1__IVectorView_1__IUser = ^IAsyncOperation_1__IVectorView_1__IUser;

  // Windows.System.IUserStatics
  IUserStatics = interface;
  PIUserStatics = ^IUserStatics;

  // Windows.System.IKnownUserPropertiesStatics
  IKnownUserPropertiesStatics = interface;
  PIKnownUserPropertiesStatics = ^IKnownUserPropertiesStatics;

  // Windows.System.UserProfile.IFirstSignInSettings
  UserProfile_IFirstSignInSettings = interface;
  PUserProfile_IFirstSignInSettings = ^UserProfile_IFirstSignInSettings;

  // Windows.System.UserProfile.IFirstSignInSettingsStatics
  UserProfile_IFirstSignInSettingsStatics = interface;
  PUserProfile_IFirstSignInSettingsStatics = ^UserProfile_IFirstSignInSettingsStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.System.LaunchQuerySupportStatus>
  AsyncOperationCompletedHandler_1__LaunchQuerySupportStatus = interface;
  PAsyncOperationCompletedHandler_1__LaunchQuerySupportStatus = ^AsyncOperationCompletedHandler_1__LaunchQuerySupportStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.System.LaunchQuerySupportStatus>
  IAsyncOperation_1__LaunchQuerySupportStatus = interface;
  PIAsyncOperation_1__LaunchQuerySupportStatus = ^IAsyncOperation_1__LaunchQuerySupportStatus;

  // Windows.System.UserProfile.ILockScreenStatics
  UserProfile_ILockScreenStatics = interface;
  PUserProfile_ILockScreenStatics = ^UserProfile_ILockScreenStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.System.UserProfile.SetImageFeedResult>
  AsyncOperationCompletedHandler_1__UserProfile_SetImageFeedResult = interface;
  PAsyncOperationCompletedHandler_1__UserProfile_SetImageFeedResult = ^AsyncOperationCompletedHandler_1__UserProfile_SetImageFeedResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.System.UserProfile.SetImageFeedResult>
  IAsyncOperation_1__UserProfile_SetImageFeedResult = interface;
  PIAsyncOperation_1__UserProfile_SetImageFeedResult = ^IAsyncOperation_1__UserProfile_SetImageFeedResult;

  // Windows.System.UserProfile.ILockScreenImageFeedStatics
  UserProfile_ILockScreenImageFeedStatics = interface;
  PUserProfile_ILockScreenImageFeedStatics = ^UserProfile_ILockScreenImageFeedStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.System.UserProfile.SetAccountPictureResult>
  AsyncOperationCompletedHandler_1__UserProfile_SetAccountPictureResult = interface;
  PAsyncOperationCompletedHandler_1__UserProfile_SetAccountPictureResult = ^AsyncOperationCompletedHandler_1__UserProfile_SetAccountPictureResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.System.UserProfile.SetAccountPictureResult>
  IAsyncOperation_1__UserProfile_SetAccountPictureResult = interface;
  PIAsyncOperation_1__UserProfile_SetAccountPictureResult = ^IAsyncOperation_1__UserProfile_SetAccountPictureResult;

  // Windows.System.UserProfile.IUserInformationStatics
  UserProfile_IUserInformationStatics = interface;
  PUserProfile_IUserInformationStatics = ^UserProfile_IUserInformationStatics;


  // Emit Forwarded interfaces
  // Windows.System Interfaces
  // DualAPI Interface
  // Windows.System.IUser
  [WinRTClassNameAttribute(SUser)]
  IUser = interface(IInspectable)
  ['{DF9A26C6-E746-4BCD-B5D4-120103C4209B}']
    function get_NonRoamableId: HSTRING; safecall;
    function get_AuthenticationStatus: UserAuthenticationStatus; safecall;
    function get_Type: UserType; safecall;
    function GetPropertyAsync(value: HSTRING): IAsyncOperation_1__IInspectable; safecall;
    function GetPropertiesAsync(values: IVectorView_1__HSTRING): IAsyncOperation_1__IPropertySet; safecall;
    function GetPictureAsync(desiredSize: UserPictureSize): IAsyncOperation_1__IRandomAccessStreamReference; safecall;
    property AuthenticationStatus: UserAuthenticationStatus read get_AuthenticationStatus;
    property NonRoamableId: HSTRING read get_NonRoamableId;
    property &Type: UserType read get_Type;
  end;

  // DualAPI Interface
  // Windows.System.IUserChangedEventArgs
  [WinRTClassNameAttribute(SUserChangedEventArgs)]
  IUserChangedEventArgs = interface(IInspectable)
  ['{086459DC-18C6-48DB-BC99-724FB9203CCC}']
    function get_User: IUser; safecall;
    property User: IUser read get_User;
  end;

  // Windows.System.Threading.WorkItemHandler
  Threading_WorkItemHandler = interface(IUnknown)
  ['{1D1A8B8B-FA66-414F-9CBD-B65FC99D17FA}']
    procedure Invoke(operation: IAsyncAction); safecall;
  end;

  // DualAPI Interface
  // Windows.System.UserProfile.IUserProfilePersonalizationSettings
  [WinRTClassNameAttribute(SUserProfile_UserProfilePersonalizationSettings)]
  UserProfile_IUserProfilePersonalizationSettings = interface(IInspectable)
  ['{8CEDDAB4-7998-46D5-8DD3-184F1C5F9AB9}']
    function TrySetLockScreenImageAsync(imageFile: IStorageFile): IAsyncOperation_1__Boolean; safecall;
    function TrySetWallpaperImageAsync(imageFile: IStorageFile): IAsyncOperation_1__Boolean; safecall;
  end;

  // DualAPI Interface
  // Windows.System.UserProfile.IUserProfilePersonalizationSettingsStatics
  [WinRTClassNameAttribute(SUserProfile_UserProfilePersonalizationSettings)]
  UserProfile_IUserProfilePersonalizationSettingsStatics = interface(IInspectable)
  ['{91ACB841-5037-454B-9883-BB772D08DD16}']
    function get_Current: UserProfile_IUserProfilePersonalizationSettings; safecall;
    function IsSupported: Boolean; safecall;
    property Current: UserProfile_IUserProfilePersonalizationSettings read get_Current;
  end;

  // DualAPI Interface
  // Windows.System.UserProfile.IGlobalizationPreferencesStatics
  [WinRTClassNameAttribute(SUserProfile_GlobalizationPreferences)]
  UserProfile_IGlobalizationPreferencesStatics = interface(IInspectable)
  ['{01BF4326-ED37-4E96-B0E9-C1340D1EA158}']
    function get_Calendars: IVectorView_1__HSTRING; safecall;
    function get_Clocks: IVectorView_1__HSTRING; safecall;
    function get_Currencies: IVectorView_1__HSTRING; safecall;
    function get_Languages: IVectorView_1__HSTRING; safecall;
    function get_HomeGeographicRegion: HSTRING; safecall;
    function get_WeekStartsOn: DayOfWeek; safecall;
    property Calendars: IVectorView_1__HSTRING read get_Calendars;
    property Clocks: IVectorView_1__HSTRING read get_Clocks;
    property Currencies: IVectorView_1__HSTRING read get_Currencies;
    property HomeGeographicRegion: HSTRING read get_HomeGeographicRegion;
    property Languages: IVectorView_1__HSTRING read get_Languages;
    property WeekStartsOn: DayOfWeek read get_WeekStartsOn;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.System.IUserWatcher,Windows.System.IUserChangedEventArgs>
  TypedEventHandler_2__IUserWatcher__IUserChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{EB9D0454-25DB-5620-98B8-BE4C5D0DBC67}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.System.IUserWatcher,Windows.System.IUserChangedEventArgs>
  TypedEventHandler_2__IUserWatcher__IUserChangedEventArgs = interface(TypedEventHandler_2__IUserWatcher__IUserChangedEventArgs_Delegate_Base)
  ['{86D02F04-FE8D-56E3-BF34-02086CE023C3}']
    procedure Invoke(sender: IUserWatcher; args: IUserChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.System.IUserAuthenticationStatusChangeDeferral
  [WinRTClassNameAttribute(SUserAuthenticationStatusChangeDeferral)]
  IUserAuthenticationStatusChangeDeferral = interface(IInspectable)
  ['{88B59568-BB30-42FB-A270-E9902E40EFA7}']
    procedure Complete; safecall;
  end;

  // DualAPI Interface
  // Windows.System.IUserAuthenticationStatusChangingEventArgs
  [WinRTClassNameAttribute(SUserAuthenticationStatusChangingEventArgs)]
  IUserAuthenticationStatusChangingEventArgs = interface(IInspectable)
  ['{8C030F28-A711-4C1E-AB48-04179C15938F}']
    function GetDeferral: IUserAuthenticationStatusChangeDeferral; safecall;
    function get_User: IUser; safecall;
    function get_NewStatus: UserAuthenticationStatus; safecall;
    function get_CurrentStatus: UserAuthenticationStatus; safecall;
    property CurrentStatus: UserAuthenticationStatus read get_CurrentStatus;
    property NewStatus: UserAuthenticationStatus read get_NewStatus;
    property User: IUser read get_User;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.System.IUserWatcher,Windows.System.IUserAuthenticationStatusChangingEventArgs>
  TypedEventHandler_2__IUserWatcher__IUserAuthenticationStatusChangingEventArgs_Delegate_Base = interface(IUnknown)
  ['{9EC3D9D5-B413-51DF-8C64-640E3356E351}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.System.IUserWatcher,Windows.System.IUserAuthenticationStatusChangingEventArgs>
  TypedEventHandler_2__IUserWatcher__IUserAuthenticationStatusChangingEventArgs = interface(TypedEventHandler_2__IUserWatcher__IUserAuthenticationStatusChangingEventArgs_Delegate_Base)
  ['{8E52A522-D252-5C66-981D-5C4669CAA182}']
    procedure Invoke(sender: IUserWatcher; args: IUserAuthenticationStatusChangingEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.System.IUserWatcher,Object>
  TypedEventHandler_2__IUserWatcher__IInspectable_Delegate_Base = interface(IUnknown)
  ['{F155E0FF-DBB5-5C34-AC0C-7E291E3300AB}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.System.IUserWatcher,Object>
  TypedEventHandler_2__IUserWatcher__IInspectable = interface(TypedEventHandler_2__IUserWatcher__IInspectable_Delegate_Base)
  ['{84CEB98E-C67B-5F00-9D4D-BAE9724A3F2C}']
    procedure Invoke(sender: IUserWatcher; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.System.IUserWatcher
  [WinRTClassNameAttribute(SUserWatcher)]
  IUserWatcher = interface(IInspectable)
  ['{155EB23B-242A-45E0-A2E9-3171FC6A7FBB}']
    function get_Status: UserWatcherStatus; safecall;
    procedure Start; safecall;
    procedure Stop; safecall;
    function add_Added(handler: TypedEventHandler_2__IUserWatcher__IUserChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_Added(token: EventRegistrationToken); safecall;
    function add_Removed(handler: TypedEventHandler_2__IUserWatcher__IUserChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_Removed(token: EventRegistrationToken); safecall;
    function add_Updated(handler: TypedEventHandler_2__IUserWatcher__IUserChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_Updated(token: EventRegistrationToken); safecall;
    function add_AuthenticationStatusChanged(handler: TypedEventHandler_2__IUserWatcher__IUserChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_AuthenticationStatusChanged(token: EventRegistrationToken); safecall;
    function add_AuthenticationStatusChanging(handler: TypedEventHandler_2__IUserWatcher__IUserAuthenticationStatusChangingEventArgs): EventRegistrationToken; safecall;
    procedure remove_AuthenticationStatusChanging(token: EventRegistrationToken); safecall;
    function add_EnumerationCompleted(handler: TypedEventHandler_2__IUserWatcher__IInspectable): EventRegistrationToken; safecall;
    procedure remove_EnumerationCompleted(token: EventRegistrationToken); safecall;
    function add_Stopped(handler: TypedEventHandler_2__IUserWatcher__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Stopped(token: EventRegistrationToken); safecall;
    property Status: UserWatcherStatus read get_Status;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.System.IUser>
  IIterator_1__IUser = interface(IInspectable)
  ['{7CA609B7-BB87-5F99-93CE-9F66837F18B2}']
    function get_Current: IUser; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIUser): Cardinal; safecall;
    property Current: IUser read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.System.IUser>
  IIterable_1__IUser_Base = interface(IInspectable)
  ['{D1BACD1F-0376-5823-8C29-1D45B9F4C191}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.System.IUser>
  IIterable_1__IUser = interface(IIterable_1__IUser_Base)
  ['{31EAD71A-B0E3-523D-ADC3-A3C6C4E566CD}']
    function First: IIterator_1__IUser; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.System.IUser>
  IVectorView_1__IUser = interface(IInspectable)
  ['{5B679876-AAF7-5044-99B1-64E9A66CAD79}']
    function GetAt(index: Cardinal): IUser; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IUser; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIUser): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.System.IUser>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IUser_Delegate_Base = interface(IUnknown)
  ['{09870533-F7CB-569C-B797-DCB48DEBD709}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.System.IUser>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IUser = interface(AsyncOperationCompletedHandler_1__IVectorView_1__IUser_Delegate_Base)
  ['{5F64D434-639D-57F4-A6E7-351B8BBF48B3}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IUser; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.System.IUser>>
  IAsyncOperation_1__IVectorView_1__IUser_Base = interface(IInspectable)
  ['{E44EA1DF-BB85-5A8C-BDDC-C8E960C355C9}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.System.IUser>>
  IAsyncOperation_1__IVectorView_1__IUser = interface(IAsyncOperation_1__IVectorView_1__IUser_Base)
  ['{A2CB77C4-6586-5D0A-B451-72EA90169873}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IUser); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IUser; safecall;
    function GetResults: IVectorView_1__IUser; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IUser read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.System.IUserStatics
  [WinRTClassNameAttribute(SUser)]
  IUserStatics = interface(IInspectable)
  ['{155EB23B-242A-45E0-A2E9-3171FC6A7FDD}']
    function CreateWatcher: IUserWatcher; safecall;
    function FindAllAsync: IAsyncOperation_1__IVectorView_1__IUser; overload; safecall;
    function FindAllAsync(&type: UserType): IAsyncOperation_1__IVectorView_1__IUser; overload; safecall;
    function FindAllAsync(&type: UserType; status: UserAuthenticationStatus): IAsyncOperation_1__IVectorView_1__IUser; overload; safecall;
    function GetFromId(nonRoamableId: HSTRING): IUser; safecall;
  end;

  // DualAPI Interface
  // Windows.System.IKnownUserPropertiesStatics
  [WinRTClassNameAttribute(SKnownUserProperties)]
  IKnownUserPropertiesStatics = interface(IInspectable)
  ['{7755911A-70C5-48E5-B637-5BA3441E4EE4}']
    function get_DisplayName: HSTRING; safecall;
    function get_FirstName: HSTRING; safecall;
    function get_LastName: HSTRING; safecall;
    function get_ProviderName: HSTRING; safecall;
    function get_AccountName: HSTRING; safecall;
    function get_GuestHost: HSTRING; safecall;
    function get_PrincipalName: HSTRING; safecall;
    function get_DomainName: HSTRING; safecall;
    function get_SessionInitiationProtocolUri: HSTRING; safecall;
    property AccountName: HSTRING read get_AccountName;
    property DisplayName: HSTRING read get_DisplayName;
    property DomainName: HSTRING read get_DomainName;
    property FirstName: HSTRING read get_FirstName;
    property GuestHost: HSTRING read get_GuestHost;
    property LastName: HSTRING read get_LastName;
    property PrincipalName: HSTRING read get_PrincipalName;
    property ProviderName: HSTRING read get_ProviderName;
    property SessionInitiationProtocolUri: HSTRING read get_SessionInitiationProtocolUri;
  end;

  // DualAPI Interface
  // Windows.System.UserProfile.IFirstSignInSettings
  [WinRTClassNameAttribute(SUserProfile_FirstSignInSettings)]
  UserProfile_IFirstSignInSettings = interface(IInspectable)
  ['{3E945153-3A5E-452E-A601-F5BAAD2A4870}']
  end;

  // DualAPI Interface
  // Windows.System.UserProfile.IFirstSignInSettingsStatics
  [WinRTClassNameAttribute(SUserProfile_FirstSignInSettings)]
  UserProfile_IFirstSignInSettingsStatics = interface(IInspectable)
  ['{1CE18F0F-1C41-4EA0-B7A2-6F0C1C7E8438}']
    function GetDefault: UserProfile_IFirstSignInSettings; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.System.LaunchQuerySupportStatus>
  AsyncOperationCompletedHandler_1__LaunchQuerySupportStatus_Delegate_Base = interface(IUnknown)
  ['{198CAC52-ABCD-5529-933F-071CC93FD635}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.System.LaunchQuerySupportStatus>
  AsyncOperationCompletedHandler_1__LaunchQuerySupportStatus = interface(AsyncOperationCompletedHandler_1__LaunchQuerySupportStatus_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__LaunchQuerySupportStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.System.LaunchQuerySupportStatus>
  IAsyncOperation_1__LaunchQuerySupportStatus_Base = interface(IInspectable)
  ['{E7539992-2220-5D2D-82C4-3D44F8750D91}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.System.LaunchQuerySupportStatus>
  IAsyncOperation_1__LaunchQuerySupportStatus = interface(IAsyncOperation_1__LaunchQuerySupportStatus_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__LaunchQuerySupportStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__LaunchQuerySupportStatus; safecall;
    function GetResults: LaunchQuerySupportStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__LaunchQuerySupportStatus read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.System.UserProfile.ILockScreenStatics
  [WinRTClassNameAttribute(SUserProfile_LockScreen)]
  UserProfile_ILockScreenStatics = interface(IInspectable)
  ['{3EE9D3AD-B607-40AE-B426-7631D9821269}']
    function get_OriginalImageFile: IUriRuntimeClass; safecall;
    function GetImageStream: IRandomAccessStream; safecall;
    function SetImageFileAsync(value: IStorageFile): IAsyncAction; safecall;
    function SetImageStreamAsync(value: IRandomAccessStream): IAsyncAction; safecall;
    property OriginalImageFile: IUriRuntimeClass read get_OriginalImageFile;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.System.UserProfile.SetImageFeedResult>
  AsyncOperationCompletedHandler_1__UserProfile_SetImageFeedResult_Delegate_Base = interface(IUnknown)
  ['{F214731A-1305-5B44-932C-AF9A1E4D78C9}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.System.UserProfile.SetImageFeedResult>
  AsyncOperationCompletedHandler_1__UserProfile_SetImageFeedResult = interface(AsyncOperationCompletedHandler_1__UserProfile_SetImageFeedResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__UserProfile_SetImageFeedResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.System.UserProfile.SetImageFeedResult>
  IAsyncOperation_1__UserProfile_SetImageFeedResult_Base = interface(IInspectable)
  ['{5361BFC9-0740-544A-9797-1FFE5E73C54E}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.System.UserProfile.SetImageFeedResult>
  IAsyncOperation_1__UserProfile_SetImageFeedResult = interface(IAsyncOperation_1__UserProfile_SetImageFeedResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__UserProfile_SetImageFeedResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__UserProfile_SetImageFeedResult; safecall;
    function GetResults: UserProfile_SetImageFeedResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__UserProfile_SetImageFeedResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.System.UserProfile.ILockScreenImageFeedStatics
  [WinRTClassNameAttribute(SUserProfile_LockScreen)]
  UserProfile_ILockScreenImageFeedStatics = interface(IInspectable)
  ['{2C0D73F6-03A9-41A6-9B01-495251FF51D5}']
    function RequestSetImageFeedAsync(syndicationFeedUri: IUriRuntimeClass): IAsyncOperation_1__UserProfile_SetImageFeedResult; safecall;
    function TryRemoveImageFeed: Boolean; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.System.UserProfile.SetAccountPictureResult>
  AsyncOperationCompletedHandler_1__UserProfile_SetAccountPictureResult_Delegate_Base = interface(IUnknown)
  ['{603F3E31-7A51-518C-9280-C188EA4213D8}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.System.UserProfile.SetAccountPictureResult>
  AsyncOperationCompletedHandler_1__UserProfile_SetAccountPictureResult = interface(AsyncOperationCompletedHandler_1__UserProfile_SetAccountPictureResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__UserProfile_SetAccountPictureResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.System.UserProfile.SetAccountPictureResult>
  IAsyncOperation_1__UserProfile_SetAccountPictureResult_Base = interface(IInspectable)
  ['{6809E406-6D3B-5164-8F32-B845B0781405}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.System.UserProfile.SetAccountPictureResult>
  IAsyncOperation_1__UserProfile_SetAccountPictureResult = interface(IAsyncOperation_1__UserProfile_SetAccountPictureResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__UserProfile_SetAccountPictureResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__UserProfile_SetAccountPictureResult; safecall;
    function GetResults: UserProfile_SetAccountPictureResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__UserProfile_SetAccountPictureResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.System.UserProfile.IUserInformationStatics
  [WinRTClassNameAttribute(SUserProfile_UserInformation)]
  UserProfile_IUserInformationStatics = interface(IInspectable)
  ['{77F3A910-48FA-489C-934E-2AE85BA8F772}']
    function get_AccountPictureChangeEnabled: Boolean; safecall;
    function get_NameAccessAllowed: Boolean; safecall;
    function GetAccountPicture(kind: UserProfile_AccountPictureKind): IStorageFile; safecall;
    function SetAccountPictureAsync(image: IStorageFile): IAsyncOperation_1__UserProfile_SetAccountPictureResult; safecall;
    function SetAccountPicturesAsync(smallImage: IStorageFile; largeImage: IStorageFile; video: IStorageFile): IAsyncOperation_1__UserProfile_SetAccountPictureResult; safecall;
    function SetAccountPictureFromStreamAsync(image: IRandomAccessStream): IAsyncOperation_1__UserProfile_SetAccountPictureResult; safecall;
    function SetAccountPicturesFromStreamsAsync(smallImage: IRandomAccessStream; largeImage: IRandomAccessStream; video: IRandomAccessStream): IAsyncOperation_1__UserProfile_SetAccountPictureResult; safecall;
    function add_AccountPictureChanged(changeHandler: EventHandler_1__IInspectable): EventRegistrationToken; safecall;
    procedure remove_AccountPictureChanged(token: EventRegistrationToken); safecall;
    function GetDisplayNameAsync: IAsyncOperation_1__HSTRING; safecall;
    function GetFirstNameAsync: IAsyncOperation_1__HSTRING; safecall;
    function GetLastNameAsync: IAsyncOperation_1__HSTRING; safecall;
    function GetPrincipalNameAsync: IAsyncOperation_1__HSTRING; safecall;
    function GetSessionInitiationProtocolUriAsync: IAsyncOperation_1__IUriRuntimeClass; safecall;
    function GetDomainNameAsync: IAsyncOperation_1__HSTRING; safecall;
    property AccountPictureChangeEnabled: Boolean read get_AccountPictureChangeEnabled;
    property NameAccessAllowed: Boolean read get_NameAccessAllowed;
  end;


  // Emit Forwarded classes
  // Windows.System.UserProfile.UserProfilePersonalizationSettings
  // DualAPI
  TUserProfile_UserProfilePersonalizationSettings = class(TWinRTGenericImportS<UserProfile_IUserProfilePersonalizationSettingsStatics>)
  public
    // -> UserProfile_IUserProfilePersonalizationSettingsStatics
    class function get_Current: UserProfile_IUserProfilePersonalizationSettings; static; inline;
    class function IsSupported: Boolean; static; inline;
    class property Current: UserProfile_IUserProfilePersonalizationSettings read get_Current;
  end;

  // Windows.System.UserProfile.GlobalizationPreferences
  // DualAPI
  TUserProfile_GlobalizationPreferences = class(TWinRTGenericImportS<UserProfile_IGlobalizationPreferencesStatics>)
  public
    // -> UserProfile_IGlobalizationPreferencesStatics
    class function get_Calendars: IVectorView_1__HSTRING; static; inline;
    class function get_Clocks: IVectorView_1__HSTRING; static; inline;
    class function get_Currencies: IVectorView_1__HSTRING; static; inline;
    class function get_Languages: IVectorView_1__HSTRING; static; inline;
    class function get_HomeGeographicRegion: HSTRING; static; inline;
    class function get_WeekStartsOn: DayOfWeek; static; inline;
    class property Calendars: IVectorView_1__HSTRING read get_Calendars;
    class property Clocks: IVectorView_1__HSTRING read get_Clocks;
    class property Currencies: IVectorView_1__HSTRING read get_Currencies;
    class property HomeGeographicRegion: HSTRING read get_HomeGeographicRegion;
    class property Languages: IVectorView_1__HSTRING read get_Languages;
    class property WeekStartsOn: DayOfWeek read get_WeekStartsOn;
  end;

  // Windows.System.UserWatcher
  // DualAPI

  // Windows.System.User
  // DualAPI
  TUser = class(TWinRTGenericImportS<IUserStatics>)
  public
    // -> IUserStatics
    class function CreateWatcher: IUserWatcher; static; inline;
    class function FindAllAsync: IAsyncOperation_1__IVectorView_1__IUser; overload; static; inline;
    class function FindAllAsync(&type: UserType): IAsyncOperation_1__IVectorView_1__IUser; overload; static; inline;
    class function FindAllAsync(&type: UserType; status: UserAuthenticationStatus): IAsyncOperation_1__IVectorView_1__IUser; overload; static; inline;
    class function GetFromId(nonRoamableId: HSTRING): IUser; static; inline;
  end;

  // Windows.System.UserChangedEventArgs
  // DualAPI

  // Windows.System.UserAuthenticationStatusChangingEventArgs
  // DualAPI

  // Windows.System.UserAuthenticationStatusChangeDeferral
  // DualAPI

  // Windows.System.KnownUserProperties
  // DualAPI
  TKnownUserProperties = class(TWinRTGenericImportS<IKnownUserPropertiesStatics>)
  public
    // -> IKnownUserPropertiesStatics
    class function get_DisplayName: HSTRING; static; inline;
    class function get_FirstName: HSTRING; static; inline;
    class function get_LastName: HSTRING; static; inline;
    class function get_ProviderName: HSTRING; static; inline;
    class function get_AccountName: HSTRING; static; inline;
    class function get_GuestHost: HSTRING; static; inline;
    class function get_PrincipalName: HSTRING; static; inline;
    class function get_DomainName: HSTRING; static; inline;
    class function get_SessionInitiationProtocolUri: HSTRING; static; inline;
    class property AccountName: HSTRING read get_AccountName;
    class property DisplayName: HSTRING read get_DisplayName;
    class property DomainName: HSTRING read get_DomainName;
    class property FirstName: HSTRING read get_FirstName;
    class property GuestHost: HSTRING read get_GuestHost;
    class property LastName: HSTRING read get_LastName;
    class property PrincipalName: HSTRING read get_PrincipalName;
    class property ProviderName: HSTRING read get_ProviderName;
    class property SessionInitiationProtocolUri: HSTRING read get_SessionInitiationProtocolUri;
  end;

  // Windows.System.UserProfile.FirstSignInSettings
  // DualAPI
  TUserProfile_FirstSignInSettings = class(TWinRTGenericImportS<UserProfile_IFirstSignInSettingsStatics>)
  public
    // -> UserProfile_IFirstSignInSettingsStatics
    class function GetDefault: UserProfile_IFirstSignInSettings; static; inline;
  end;

  // Windows.System.UserProfile.LockScreen
  // DualAPI
  TUserProfile_LockScreen = class(TWinRTGenericImportS2<UserProfile_ILockScreenImageFeedStatics, UserProfile_ILockScreenStatics>)
  public
    // -> UserProfile_ILockScreenImageFeedStatics
    class function RequestSetImageFeedAsync(syndicationFeedUri: IUriRuntimeClass): IAsyncOperation_1__UserProfile_SetImageFeedResult; static; inline;
    class function TryRemoveImageFeed: Boolean; static; inline;

    // -> UserProfile_ILockScreenStatics
    class function get_OriginalImageFile: IUriRuntimeClass; static; inline;
    class function GetImageStream: IRandomAccessStream; static; inline;
    class function SetImageFileAsync(value: IStorageFile): IAsyncAction; static; inline;
    class function SetImageStreamAsync(value: IRandomAccessStream): IAsyncAction; static; inline;
    class property OriginalImageFile: IUriRuntimeClass read get_OriginalImageFile;
  end;

  // Windows.System.UserProfile.UserInformation
  // DualAPI
  TUserProfile_UserInformation = class(TWinRTGenericImportS<UserProfile_IUserInformationStatics>)
  public
    // -> UserProfile_IUserInformationStatics
    class function get_AccountPictureChangeEnabled: Boolean; static; inline;
    class function get_NameAccessAllowed: Boolean; static; inline;
    class function GetAccountPicture(kind: UserProfile_AccountPictureKind): IStorageFile; static; inline;
    class function SetAccountPictureAsync(image: IStorageFile): IAsyncOperation_1__UserProfile_SetAccountPictureResult; static; inline;
    class function SetAccountPicturesAsync(smallImage: IStorageFile; largeImage: IStorageFile; video: IStorageFile): IAsyncOperation_1__UserProfile_SetAccountPictureResult; static; inline;
    class function SetAccountPictureFromStreamAsync(image: IRandomAccessStream): IAsyncOperation_1__UserProfile_SetAccountPictureResult; static; inline;
    class function SetAccountPicturesFromStreamsAsync(smallImage: IRandomAccessStream; largeImage: IRandomAccessStream; video: IRandomAccessStream): IAsyncOperation_1__UserProfile_SetAccountPictureResult; static; inline;
    class function add_AccountPictureChanged(changeHandler: EventHandler_1__IInspectable): EventRegistrationToken; static; inline;
    class procedure remove_AccountPictureChanged(token: EventRegistrationToken); static; inline;
    class function GetDisplayNameAsync: IAsyncOperation_1__HSTRING; static; inline;
    class function GetFirstNameAsync: IAsyncOperation_1__HSTRING; static; inline;
    class function GetLastNameAsync: IAsyncOperation_1__HSTRING; static; inline;
    class function GetPrincipalNameAsync: IAsyncOperation_1__HSTRING; static; inline;
    class function GetSessionInitiationProtocolUriAsync: IAsyncOperation_1__IUriRuntimeClass; static; inline;
    class function GetDomainNameAsync: IAsyncOperation_1__HSTRING; static; inline;
    class property AccountPictureChangeEnabled: Boolean read get_AccountPictureChangeEnabled;
    class property NameAccessAllowed: Boolean read get_NameAccessAllowed;
  end;


implementation

  // Emit Classes Implementation
 { TUserProfile_UserProfilePersonalizationSettings }

class function TUserProfile_UserProfilePersonalizationSettings.get_Current: UserProfile_IUserProfilePersonalizationSettings;
begin
  Result := Statics.get_Current;
end;

class function TUserProfile_UserProfilePersonalizationSettings.IsSupported: Boolean;
begin
  Result := Statics.IsSupported;
end;


 { TUserProfile_GlobalizationPreferences }

class function TUserProfile_GlobalizationPreferences.get_Calendars: IVectorView_1__HSTRING;
begin
  Result := Statics.get_Calendars;
end;

class function TUserProfile_GlobalizationPreferences.get_Clocks: IVectorView_1__HSTRING;
begin
  Result := Statics.get_Clocks;
end;

class function TUserProfile_GlobalizationPreferences.get_Currencies: IVectorView_1__HSTRING;
begin
  Result := Statics.get_Currencies;
end;

class function TUserProfile_GlobalizationPreferences.get_Languages: IVectorView_1__HSTRING;
begin
  Result := Statics.get_Languages;
end;

class function TUserProfile_GlobalizationPreferences.get_HomeGeographicRegion: HSTRING;
begin
  Result := Statics.get_HomeGeographicRegion;
end;

class function TUserProfile_GlobalizationPreferences.get_WeekStartsOn: DayOfWeek;
begin
  Result := Statics.get_WeekStartsOn;
end;


 { TUser }

class function TUser.CreateWatcher: IUserWatcher;
begin
  Result := Statics.CreateWatcher;
end;

class function TUser.FindAllAsync: IAsyncOperation_1__IVectorView_1__IUser;
begin
  Result := Statics.FindAllAsync;
end;

class function TUser.FindAllAsync(&type: UserType): IAsyncOperation_1__IVectorView_1__IUser;
begin
  Result := Statics.FindAllAsync(&type);
end;

class function TUser.FindAllAsync(&type: UserType; status: UserAuthenticationStatus): IAsyncOperation_1__IVectorView_1__IUser;
begin
  Result := Statics.FindAllAsync(&type, status);
end;

class function TUser.GetFromId(nonRoamableId: HSTRING): IUser;
begin
  Result := Statics.GetFromId(nonRoamableId);
end;


 { TKnownUserProperties }

class function TKnownUserProperties.get_DisplayName: HSTRING;
begin
  Result := Statics.get_DisplayName;
end;

class function TKnownUserProperties.get_FirstName: HSTRING;
begin
  Result := Statics.get_FirstName;
end;

class function TKnownUserProperties.get_LastName: HSTRING;
begin
  Result := Statics.get_LastName;
end;

class function TKnownUserProperties.get_ProviderName: HSTRING;
begin
  Result := Statics.get_ProviderName;
end;

class function TKnownUserProperties.get_AccountName: HSTRING;
begin
  Result := Statics.get_AccountName;
end;

class function TKnownUserProperties.get_GuestHost: HSTRING;
begin
  Result := Statics.get_GuestHost;
end;

class function TKnownUserProperties.get_PrincipalName: HSTRING;
begin
  Result := Statics.get_PrincipalName;
end;

class function TKnownUserProperties.get_DomainName: HSTRING;
begin
  Result := Statics.get_DomainName;
end;

class function TKnownUserProperties.get_SessionInitiationProtocolUri: HSTRING;
begin
  Result := Statics.get_SessionInitiationProtocolUri;
end;


 { TUserProfile_FirstSignInSettings }

class function TUserProfile_FirstSignInSettings.GetDefault: UserProfile_IFirstSignInSettings;
begin
  Result := Statics.GetDefault;
end;


 { TUserProfile_LockScreen }

class function TUserProfile_LockScreen.RequestSetImageFeedAsync(syndicationFeedUri: IUriRuntimeClass): IAsyncOperation_1__UserProfile_SetImageFeedResult;
begin
  Result := Statics.RequestSetImageFeedAsync(syndicationFeedUri);
end;

class function TUserProfile_LockScreen.TryRemoveImageFeed: Boolean;
begin
  Result := Statics.TryRemoveImageFeed;
end;


class function TUserProfile_LockScreen.get_OriginalImageFile: IUriRuntimeClass;
begin
  Result := Statics2.get_OriginalImageFile;
end;

class function TUserProfile_LockScreen.GetImageStream: IRandomAccessStream;
begin
  Result := Statics2.GetImageStream;
end;

class function TUserProfile_LockScreen.SetImageFileAsync(value: IStorageFile): IAsyncAction;
begin
  Result := Statics2.SetImageFileAsync(value);
end;

class function TUserProfile_LockScreen.SetImageStreamAsync(value: IRandomAccessStream): IAsyncAction;
begin
  Result := Statics2.SetImageStreamAsync(value);
end;


 { TUserProfile_UserInformation }

class function TUserProfile_UserInformation.get_AccountPictureChangeEnabled: Boolean;
begin
  Result := Statics.get_AccountPictureChangeEnabled;
end;

class function TUserProfile_UserInformation.get_NameAccessAllowed: Boolean;
begin
  Result := Statics.get_NameAccessAllowed;
end;

class function TUserProfile_UserInformation.GetAccountPicture(kind: UserProfile_AccountPictureKind): IStorageFile;
begin
  Result := Statics.GetAccountPicture(kind);
end;

class function TUserProfile_UserInformation.SetAccountPictureAsync(image: IStorageFile): IAsyncOperation_1__UserProfile_SetAccountPictureResult;
begin
  Result := Statics.SetAccountPictureAsync(image);
end;

class function TUserProfile_UserInformation.SetAccountPicturesAsync(smallImage: IStorageFile; largeImage: IStorageFile; video: IStorageFile): IAsyncOperation_1__UserProfile_SetAccountPictureResult;
begin
  Result := Statics.SetAccountPicturesAsync(smallImage, largeImage, video);
end;

class function TUserProfile_UserInformation.SetAccountPictureFromStreamAsync(image: IRandomAccessStream): IAsyncOperation_1__UserProfile_SetAccountPictureResult;
begin
  Result := Statics.SetAccountPictureFromStreamAsync(image);
end;

class function TUserProfile_UserInformation.SetAccountPicturesFromStreamsAsync(smallImage: IRandomAccessStream; largeImage: IRandomAccessStream; video: IRandomAccessStream): IAsyncOperation_1__UserProfile_SetAccountPictureResult;
begin
  Result := Statics.SetAccountPicturesFromStreamsAsync(smallImage, largeImage, video);
end;

class function TUserProfile_UserInformation.add_AccountPictureChanged(changeHandler: EventHandler_1__IInspectable): EventRegistrationToken;
begin
  Result := Statics.add_AccountPictureChanged(changeHandler);
end;

class procedure TUserProfile_UserInformation.remove_AccountPictureChanged(token: EventRegistrationToken);
begin
  Statics.remove_AccountPictureChanged(token);
end;

class function TUserProfile_UserInformation.GetDisplayNameAsync: IAsyncOperation_1__HSTRING;
begin
  Result := Statics.GetDisplayNameAsync;
end;

class function TUserProfile_UserInformation.GetFirstNameAsync: IAsyncOperation_1__HSTRING;
begin
  Result := Statics.GetFirstNameAsync;
end;

class function TUserProfile_UserInformation.GetLastNameAsync: IAsyncOperation_1__HSTRING;
begin
  Result := Statics.GetLastNameAsync;
end;

class function TUserProfile_UserInformation.GetPrincipalNameAsync: IAsyncOperation_1__HSTRING;
begin
  Result := Statics.GetPrincipalNameAsync;
end;

class function TUserProfile_UserInformation.GetSessionInitiationProtocolUriAsync: IAsyncOperation_1__IUriRuntimeClass;
begin
  Result := Statics.GetSessionInitiationProtocolUriAsync;
end;

class function TUserProfile_UserInformation.GetDomainNameAsync: IAsyncOperation_1__HSTRING;
begin
  Result := Statics.GetDomainNameAsync;
end;



end.
