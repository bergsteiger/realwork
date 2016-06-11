{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Management;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.ApplicationModel,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.Storage,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Management Class Names
  // Windows.Management.Deployment.PackageManager
  // WinRT Only
  // WhiteListed
  SDeployment_PackageManager = 'Windows.Management.Deployment.PackageManager';
  // Windows.Management.Deployment.Preview.InstalledClassicAppInfo
  // DualAPI
  SDeployment_Preview_InstalledClassicAppInfo = 'Windows.Management.Deployment.Preview.InstalledClassicAppInfo';
  // Windows.Management.Deployment.Preview.ClassicAppManager
  // DualAPI
  SDeployment_Preview_ClassicAppManager = 'Windows.Management.Deployment.Preview.ClassicAppManager';


type
  // Forward declare interfaces
  // Windows.Management.Deployment.IDeploymentResult
  Deployment_IDeploymentResult = interface;
  PDeployment_IDeploymentResult = ^Deployment_IDeploymentResult;

  // Windows.Management.Deployment.IPackageUserInformation
  Deployment_IPackageUserInformation = interface;
  PDeployment_IPackageUserInformation = ^Deployment_IPackageUserInformation;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Management.Deployment.IDeploymentResult,Windows.Management.Deployment.DeploymentProgress>
  AsyncOperationProgressHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress = interface;
  PAsyncOperationProgressHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress = ^AsyncOperationProgressHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Management.Deployment.IDeploymentResult,Windows.Management.Deployment.DeploymentProgress>
  AsyncOperationWithProgressCompletedHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress = interface;
  PAsyncOperationWithProgressCompletedHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress = ^AsyncOperationWithProgressCompletedHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Management.Deployment.IDeploymentResult,Windows.Management.Deployment.DeploymentProgress>
  IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress = interface;
  PIAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress = ^IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress;

  // Windows.Foundation.Collections.IIterator`1<Windows.Management.Deployment.IPackageUserInformation>
  IIterator_1__Deployment_IPackageUserInformation = interface;
  PIIterator_1__Deployment_IPackageUserInformation = ^IIterator_1__Deployment_IPackageUserInformation;

  // Windows.Foundation.Collections.IIterable`1<Windows.Management.Deployment.IPackageUserInformation>
  IIterable_1__Deployment_IPackageUserInformation = interface;
  PIIterable_1__Deployment_IPackageUserInformation = ^IIterable_1__Deployment_IPackageUserInformation;

  // Windows.Management.Deployment.IPackageManager
  Deployment_IPackageManager = interface;
  PDeployment_IPackageManager = ^Deployment_IPackageManager;

  // Windows.Management.Deployment.IPackageManager2
  Deployment_IPackageManager2 = interface;
  PDeployment_IPackageManager2 = ^Deployment_IPackageManager2;

  // Windows.Management.Deployment.IPackageVolume
  Deployment_IPackageVolume = interface;
  PDeployment_IPackageVolume = ^Deployment_IPackageVolume;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Management.Deployment.IPackageVolume>
  AsyncOperationCompletedHandler_1__Deployment_IPackageVolume = interface;
  PAsyncOperationCompletedHandler_1__Deployment_IPackageVolume = ^AsyncOperationCompletedHandler_1__Deployment_IPackageVolume;

  // Windows.Foundation.IAsyncOperation`1<Windows.Management.Deployment.IPackageVolume>
  IAsyncOperation_1__Deployment_IPackageVolume = interface;
  PIAsyncOperation_1__Deployment_IPackageVolume = ^IAsyncOperation_1__Deployment_IPackageVolume;

  // Windows.Foundation.Collections.IIterator`1<Windows.Management.Deployment.IPackageVolume>
  IIterator_1__Deployment_IPackageVolume = interface;
  PIIterator_1__Deployment_IPackageVolume = ^IIterator_1__Deployment_IPackageVolume;

  // Windows.Foundation.Collections.IIterable`1<Windows.Management.Deployment.IPackageVolume>
  IIterable_1__Deployment_IPackageVolume = interface;
  PIIterable_1__Deployment_IPackageVolume = ^IIterable_1__Deployment_IPackageVolume;

  // Windows.Management.Deployment.IPackageManager3
  Deployment_IPackageManager3 = interface;
  PDeployment_IPackageManager3 = ^Deployment_IPackageManager3;

  // Windows.Management.Deployment.Preview.IInstalledClassicAppInfo
  Deployment_Preview_IInstalledClassicAppInfo = interface;
  PDeployment_Preview_IInstalledClassicAppInfo = ^Deployment_Preview_IInstalledClassicAppInfo;

  // Windows.Management.Deployment.Preview.IClassicAppManagerStatics
  Deployment_Preview_IClassicAppManagerStatics = interface;
  PDeployment_Preview_IClassicAppManagerStatics = ^Deployment_Preview_IClassicAppManagerStatics;


  // Emit Forwarded interfaces
  // Windows.Management Interfaces
  // Windows.Management.Deployment.IDeploymentResult
  Deployment_IDeploymentResult = interface(IInspectable)
  ['{2563B9AE-B77D-4C1F-8A7B-20E6AD515EF3}']
    function get_ErrorText: HSTRING; safecall;
    function get_ActivityId: TGuid; safecall;
    function get_ExtendedErrorCode: HRESULT; safecall;
    property ActivityId: TGuid read get_ActivityId;
    property ErrorText: HSTRING read get_ErrorText;
    property ExtendedErrorCode: HRESULT read get_ExtendedErrorCode;
  end;

  // Windows.Management.Deployment.IPackageUserInformation
  Deployment_IPackageUserInformation = interface(IInspectable)
  ['{F6383423-FA09-4CBC-9055-15CA275E2E7E}']
    function get_UserSecurityId: HSTRING; safecall;
    function get_InstallState: Deployment_PackageInstallState; safecall;
    property InstallState: Deployment_PackageInstallState read get_InstallState;
    property UserSecurityId: HSTRING read get_UserSecurityId;
  end;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Management.Deployment.IDeploymentResult,Windows.Management.Deployment.DeploymentProgress>
  AsyncOperationProgressHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress = interface(IUnknown)
  ['{861AC421-B865-5686-86C4-4917F24750BB}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; progressInfo: Deployment_DeploymentProgress); safecall;
  end;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Management.Deployment.IDeploymentResult,Windows.Management.Deployment.DeploymentProgress>
  AsyncOperationWithProgressCompletedHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress = interface(IUnknown)
  ['{2ABB4ED1-2F62-5ED0-8D86-755BEEBBB430}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Management.Deployment.IDeploymentResult,Windows.Management.Deployment.DeploymentProgress>
  IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress = interface(IInspectable)
  ['{7AF23842-29E8-5C37-BB0B-6561C00ADB92}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function GetResults: Deployment_IDeploymentResult; safecall;
    property Progress: AsyncOperationProgressHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Management.Deployment.IPackageUserInformation>
  IIterator_1__Deployment_IPackageUserInformation = interface(IInspectable)
  ['{BA4EB7C5-E98F-56CE-965B-8E26E0FF88DC}']
    function get_Current: Deployment_IPackageUserInformation; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PDeployment_IPackageUserInformation): Cardinal; safecall;
    property Current: Deployment_IPackageUserInformation read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Management.Deployment.IPackageUserInformation>
  IIterable_1__Deployment_IPackageUserInformation_Base = interface(IInspectable)
  ['{341348B9-52C8-5B57-9E91-F19F2A05B188}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Management.Deployment.IPackageUserInformation>
  IIterable_1__Deployment_IPackageUserInformation = interface(IIterable_1__Deployment_IPackageUserInformation_Base)
  ['{1CD8D83B-9210-50C2-A324-5A8E16954951}']
    function First: IIterator_1__Deployment_IPackageUserInformation; safecall;
  end;

  // DualAPI Interface
  // Windows.Management.Deployment.IPackageManager
  [WinRTClassNameAttribute(SDeployment_PackageManager)]
  Deployment_IPackageManager = interface(IInspectable)
  ['{9A7D4B65-5E8F-4FC7-A2E5-7F6925CB8B53}']
    function AddPackageAsync(packageUri: IUriRuntimeClass; dependencyPackageUris: IIterable_1__IUriRuntimeClass; deploymentOptions: Deployment_DeploymentOptions): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function UpdatePackageAsync(packageUri: IUriRuntimeClass; dependencyPackageUris: IIterable_1__IUriRuntimeClass; deploymentOptions: Deployment_DeploymentOptions): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function RemovePackageAsync(packageFullName: HSTRING): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function StagePackageAsync(packageUri: IUriRuntimeClass; dependencyPackageUris: IIterable_1__IUriRuntimeClass): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function RegisterPackageAsync(manifestUri: IUriRuntimeClass; dependencyPackageUris: IIterable_1__IUriRuntimeClass; deploymentOptions: Deployment_DeploymentOptions): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function FindPackages: IIterable_1__IPackage; overload; safecall;
    function FindPackagesForUser(userSecurityId: HSTRING): IIterable_1__IPackage; overload; safecall;
    function FindPackages(packageName: HSTRING; packagePublisher: HSTRING): IIterable_1__IPackage; overload; safecall;
    function FindPackagesForUser(userSecurityId: HSTRING; packageName: HSTRING; packagePublisher: HSTRING): IIterable_1__IPackage; overload; safecall;
    function FindUsers(packageFullName: HSTRING): IIterable_1__Deployment_IPackageUserInformation; safecall;
    procedure SetPackageState(packageFullName: HSTRING; packageState: Deployment_PackageState); safecall;
    function FindPackage(packageFullName: HSTRING): IPackage; safecall;
    function CleanupPackageForUserAsync(packageName: HSTRING; userSecurityId: HSTRING): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function FindPackages(packageFamilyName: HSTRING): IIterable_1__IPackage; overload; safecall;
    function FindPackagesForUser(userSecurityId: HSTRING; packageFamilyName: HSTRING): IIterable_1__IPackage; overload; safecall;
    function FindPackageForUser(userSecurityId: HSTRING; packageFullName: HSTRING): IPackage; safecall;
  end;

  // DualAPI Interface
  // Windows.Management.Deployment.IPackageManager2
  Deployment_IPackageManager2 = interface(IInspectable)
  ['{F7AAD08D-0840-46F2-B5D8-CAD47693A095}']
    function RemovePackageAsync(packageFullName: HSTRING; removalOptions: Deployment_RemovalOptions): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function StagePackageAsync(packageUri: IUriRuntimeClass; dependencyPackageUris: IIterable_1__IUriRuntimeClass; deploymentOptions: Deployment_DeploymentOptions): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function RegisterPackageByFullNameAsync(mainPackageFullName: HSTRING; dependencyPackageFullNames: IIterable_1__HSTRING; deploymentOptions: Deployment_DeploymentOptions): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function FindPackagesWithPackageTypes(packageTypes: Deployment_PackageTypes): IIterable_1__IPackage; overload; safecall;
    function FindPackagesForUserWithPackageTypes(userSecurityId: HSTRING; packageTypes: Deployment_PackageTypes): IIterable_1__IPackage; overload; safecall;
    function FindPackagesWithPackageTypes(packageName: HSTRING; packagePublisher: HSTRING; packageTypes: Deployment_PackageTypes): IIterable_1__IPackage; overload; safecall;
    function FindPackagesForUserWithPackageTypes(userSecurityId: HSTRING; packageName: HSTRING; packagePublisher: HSTRING; packageTypes: Deployment_PackageTypes): IIterable_1__IPackage; overload; safecall;
    function FindPackagesWithPackageTypes(packageFamilyName: HSTRING; packageTypes: Deployment_PackageTypes): IIterable_1__IPackage; overload; safecall;
    function FindPackagesForUserWithPackageTypes(userSecurityId: HSTRING; packageFamilyName: HSTRING; packageTypes: Deployment_PackageTypes): IIterable_1__IPackage; overload; safecall;
    function StageUserDataAsync(packageFullName: HSTRING): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
  end;

  // Windows.Management.Deployment.IPackageVolume
  Deployment_IPackageVolume = interface(IInspectable)
  ['{CF2672C3-1A40-4450-9739-2ACE2E898853}']
    function get_IsOffline: Boolean; safecall;
    function get_IsSystemVolume: Boolean; safecall;
    function get_MountPoint: HSTRING; safecall;
    function get_Name: HSTRING; safecall;
    function get_PackageStorePath: HSTRING; safecall;
    function get_SupportsHardLinks: Boolean; safecall;
    function FindPackages: IVector_1__IPackage; overload; safecall;
    function FindPackages(packageName: HSTRING; packagePublisher: HSTRING): IVector_1__IPackage; overload; safecall;
    function FindPackages(packageFamilyName: HSTRING): IVector_1__IPackage; overload; safecall;
    function FindPackagesWithPackageTypes(packageTypes: Deployment_PackageTypes): IVector_1__IPackage; overload; safecall;
    function FindPackagesWithPackageTypes(packageTypes: Deployment_PackageTypes; packageName: HSTRING; packagePublisher: HSTRING): IVector_1__IPackage; overload; safecall;
    function FindPackagesWithPackageTypes(packageTypes: Deployment_PackageTypes; packageFamilyName: HSTRING): IVector_1__IPackage; overload; safecall;
    function FindPackage(packageFullName: HSTRING): IVector_1__IPackage; safecall;
    function FindPackagesForUser(userSecurityId: HSTRING): IVector_1__IPackage; overload; safecall;
    function FindPackagesForUser(userSecurityId: HSTRING; packageName: HSTRING; packagePublisher: HSTRING): IVector_1__IPackage; overload; safecall;
    function FindPackagesForUser(userSecurityId: HSTRING; packageFamilyName: HSTRING): IVector_1__IPackage; overload; safecall;
    function FindPackagesForUserWithPackageTypes(userSecurityId: HSTRING; packageTypes: Deployment_PackageTypes): IVector_1__IPackage; overload; safecall;
    function FindPackagesForUserWithPackageTypes(userSecurityId: HSTRING; packageTypes: Deployment_PackageTypes; packageName: HSTRING; packagePublisher: HSTRING): IVector_1__IPackage; overload; safecall;
    function FindPackagesForUserWithPackageTypes(userSecurityId: HSTRING; packageTypes: Deployment_PackageTypes; packageFamilyName: HSTRING): IVector_1__IPackage; overload; safecall;
    function FindPackageForUser(userSecurityId: HSTRING; packageFullName: HSTRING): IVector_1__IPackage; safecall;
    property IsOffline: Boolean read get_IsOffline;
    property IsSystemVolume: Boolean read get_IsSystemVolume;
    property MountPoint: HSTRING read get_MountPoint;
    property Name: HSTRING read get_Name;
    property PackageStorePath: HSTRING read get_PackageStorePath;
    property SupportsHardLinks: Boolean read get_SupportsHardLinks;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Management.Deployment.IPackageVolume>
  AsyncOperationCompletedHandler_1__Deployment_IPackageVolume_Delegate_Base = interface(IUnknown)
  ['{35FEE361-6CEA-5E5C-8EDA-34B3F22DF4E7}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Management.Deployment.IPackageVolume>
  AsyncOperationCompletedHandler_1__Deployment_IPackageVolume = interface(AsyncOperationCompletedHandler_1__Deployment_IPackageVolume_Delegate_Base)
  ['{6FE7A673-8668-57D3-B7F0-4B020D7ACA77}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Deployment_IPackageVolume; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Management.Deployment.IPackageVolume>
  IAsyncOperation_1__Deployment_IPackageVolume_Base = interface(IInspectable)
  ['{0315EDB6-DC58-51CC-A519-44901AD2CF15}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Management.Deployment.IPackageVolume>
  IAsyncOperation_1__Deployment_IPackageVolume = interface(IAsyncOperation_1__Deployment_IPackageVolume_Base)
  ['{EEED3F8D-7911-534D-99E8-F5C0D3968F23}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Deployment_IPackageVolume); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Deployment_IPackageVolume; safecall;
    function GetResults: Deployment_IPackageVolume; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Deployment_IPackageVolume read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Management.Deployment.IPackageVolume>
  IIterator_1__Deployment_IPackageVolume = interface(IInspectable)
  ['{6502657F-39D1-51CB-8EFC-A5C8E5249C0F}']
    function get_Current: Deployment_IPackageVolume; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PDeployment_IPackageVolume): Cardinal; safecall;
    property Current: Deployment_IPackageVolume read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Management.Deployment.IPackageVolume>
  IIterable_1__Deployment_IPackageVolume_Base = interface(IInspectable)
  ['{A6199162-B163-56A1-9980-DB0C3F4E9284}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Management.Deployment.IPackageVolume>
  IIterable_1__Deployment_IPackageVolume = interface(IIterable_1__Deployment_IPackageVolume_Base)
  ['{FF5F02E2-4F72-50FC-B792-22550539B8A0}']
    function First: IIterator_1__Deployment_IPackageVolume; safecall;
  end;

  // DualAPI Interface
  // Windows.Management.Deployment.IPackageManager3
  Deployment_IPackageManager3 = interface(IInspectable)
  ['{DAAD9948-36F1-41A7-9188-BC263E0DCB72}']
    function AddPackageVolumeAsync(packageStorePath: HSTRING): IAsyncOperation_1__Deployment_IPackageVolume; safecall;
    function AddPackageAsync(packageUri: IUriRuntimeClass; dependencyPackageUris: IIterable_1__IUriRuntimeClass; deploymentOptions: Deployment_DeploymentOptions; targetVolume: Deployment_IPackageVolume): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    procedure ClearPackageStatus(packageFullName: HSTRING; status: Deployment_PackageStatus); safecall;
    function RegisterPackageAsync(manifestUri: IUriRuntimeClass; dependencyPackageUris: IIterable_1__IUriRuntimeClass; deploymentOptions: Deployment_DeploymentOptions; appDataVolume: Deployment_IPackageVolume): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function FindPackageVolume(volumeName: HSTRING): Deployment_IPackageVolume; safecall;
    function FindPackageVolumes: IIterable_1__Deployment_IPackageVolume; safecall;
    function GetDefaultPackageVolume: Deployment_IPackageVolume; safecall;
    function MovePackageToVolumeAsync(packageFullName: HSTRING; deploymentOptions: Deployment_DeploymentOptions; targetVolume: Deployment_IPackageVolume): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function RemovePackageVolumeAsync(volume: Deployment_IPackageVolume): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    procedure SetDefaultPackageVolume(volume: Deployment_IPackageVolume); safecall;
    procedure SetPackageStatus(packageFullName: HSTRING; status: Deployment_PackageStatus); safecall;
    function SetPackageVolumeOfflineAsync(packageVolume: Deployment_IPackageVolume): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function SetPackageVolumeOnlineAsync(packageVolume: Deployment_IPackageVolume): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function StagePackageAsync(packageUri: IUriRuntimeClass; dependencyPackageUris: IIterable_1__IUriRuntimeClass; deploymentOptions: Deployment_DeploymentOptions; targetVolume: Deployment_IPackageVolume): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
    function StageUserDataAsync(packageFullName: HSTRING; deploymentOptions: Deployment_DeploymentOptions): IAsyncOperationWithProgress_2__Deployment_IDeploymentResult__Deployment_DeploymentProgress; safecall;
  end;

  // DualAPI Interface
  // Windows.Management.Deployment.Preview.IInstalledClassicAppInfo
  [WinRTClassNameAttribute(SDeployment_Preview_InstalledClassicAppInfo)]
  Deployment_Preview_IInstalledClassicAppInfo = interface(IInspectable)
  ['{0A7D3DA3-65D0-4086-80D6-0610D760207D}']
    function get_DisplayName: HSTRING; safecall;
    function get_DisplayVersion: HSTRING; safecall;
    property DisplayName: HSTRING read get_DisplayName;
    property DisplayVersion: HSTRING read get_DisplayVersion;
  end;

  // DualAPI Interface
  // Windows.Management.Deployment.Preview.IClassicAppManagerStatics
  [WinRTClassNameAttribute(SDeployment_Preview_ClassicAppManager)]
  Deployment_Preview_IClassicAppManagerStatics = interface(IInspectable)
  ['{E2FAD668-882C-4F33-B035-0DF7B90D67E6}']
    function FindInstalledApp(appUninstallKey: HSTRING): Deployment_Preview_IInstalledClassicAppInfo; safecall;
  end;


  // Emit Forwarded classes
  // Windows.Management.Deployment.PackageManager
  // WinRT Only
  // WhiteListed
  TDeployment_PackageManager = class(TWinRTGenericImportI<Deployment_IPackageManager>) end;

  // Windows.Management.Deployment.Preview.InstalledClassicAppInfo
  // DualAPI

  // Windows.Management.Deployment.Preview.ClassicAppManager
  // DualAPI
  TDeployment_Preview_ClassicAppManager = class(TWinRTGenericImportS<Deployment_Preview_IClassicAppManagerStatics>)
  public
    // -> Deployment_Preview_IClassicAppManagerStatics
    class function FindInstalledApp(appUninstallKey: HSTRING): Deployment_Preview_IInstalledClassicAppInfo; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TDeployment_PackageManager }

 { TDeployment_Preview_ClassicAppManager }

class function TDeployment_Preview_ClassicAppManager.FindInstalledApp(appUninstallKey: HSTRING): Deployment_Preview_IInstalledClassicAppInfo;
begin
  Result := Statics.FindInstalledApp(appUninstallKey);
end;



end.
