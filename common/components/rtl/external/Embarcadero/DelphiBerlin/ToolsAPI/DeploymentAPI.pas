{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DeploymentAPI;

interface

uses System.SysUtils, System.Classes, ToolsAPI, PlatformAPI, System.Generics.Collections, System.Types;

type

  // IDE Service
  IOTADeploymentService = interface
    ['{658EBC6E-E96F-45FA-934B-505D158852C7}']
    procedure DeployManagerProject(const Project: IOTAProject);
  end;

  // Personality Trait
  IProjectSupportsDeploymentTrait230 = interface
    ['{45F5E6B4-CFAE-4C8A-A6CE-D6513E12BE17}']
    function ProjectSupportsDeployment: Boolean;
  end;

  IProjectSupportsDeploymentTrait = interface(IProjectSupportsDeploymentTrait230)
    ['{E58E526C-3D36-4D3D-A2FF-F8D153569F29}']
    function ProjectSupportsDeployment: Boolean; overload; deprecated 'Use the overloaded version with IOTAProject parameter';
    function ProjectSupportsDeployment(const Project: IOTAProject): Boolean; overload;
  end;


  // Project module interface.  Projects that support deployment may implement.

//  IDeployAssemblyReferences = interface;
  
  IDeployableProject = interface
  ['{F775F090-1966-4C65-B778-DF4CD2F7F9E6}']
//    function GetHasAssemblyReferences: Boolean;
//    function GetAssemblyReferences: IDeployAssemblyReferences;
//    property HasAssemblyReferences: Boolean read GetHasAssemblyReferences;
//    property AssemblyReferences: IDeployAssemblyReferences read GetAssemblyReferences;
  end;

//  IDeployAssemblyReferences = interface
//  ['{68E7820D-5249-4E86-9024-E97A6BDC4176}']
//    procedure Refresh;
//    function GetCount: Integer;
//    function GetFileName(I: Integer): string;
//    property Count: Integer read GetCount;
//    property FileNames[I: Integer]: string read GetFileName;
//  end;

const
  feDeployProj = '.deployproj';
  sDeviceId = 'DeviceId';
  dcFile = 'File';
  dcProfectFile = 'ProjectFile';
  dcProjectOutput = 'ProjectOutput';
  dcDebugSymbols = 'DebugSymbols';
  dcAdditionalDebugSymbols = 'AdditionalDebugSymbols';
  dcDependencyPackage = 'DependencyPackage';
  dcDependencyPackageResource = 'DependencyPackageResource';
  dcDependencyPackageDebugSymbols = 'DependencyPackageDebugSymbols';
  dcDependencyModule = 'DependencyModule';
  dcDependencyFramework = 'DependencyFramework';

  //OSX32
  dcProjectMainIcns = 'Icns_MainIcns';
  dcProjectOSXResource = 'ProjectOSXResource';
  dcProjectOSXInfoPList = 'ProjectOSXInfoPList';
  dcProjectEntitlements = 'ProjectOSXEntitlements';


  //iOS
  dcProjectiOSResource = 'ProjectiOSResource';
  dcProjectOutput_iOS32 = 'ProjectOutput_iOS32';

  dcIPhone_AppIcon57 = 'iPhone_AppIcon57';
  dcIPhone_AppIcon60 = 'iPhone_AppIcon60';
  dcIPhone_AppIcon87 = 'iPhone_AppIcon87';
  dcIPhone_AppIcon114 = 'iPhone_AppIcon114';
  dcIPhone_AppIcon120 = 'iPhone_AppIcon120';
  dcIPhone_AppIcon180 = 'iPhone_AppIcon180';
  dcIPhone_Spotlight29 = 'iPhone_Spotlight29';
  dcIPhone_Spotlight40 = 'iPhone_Spotlight40';
  dcIPhone_Spotlight58 = 'iPhone_Spotlight58';
  dcIPhone_Spotlight80 = 'iPhone_Spotlight80';
  dcIOS_AppStore512 = 'iOS_AppStore512';
  dcIOS_AppStore1024 = 'iOS_AppStore1024';
  dcIPad_AppIcon72 = 'iPad_AppIcon72';
  dcIPad_AppIcon76 = 'iPad_AppIcon76';
  dcIPad_AppIcon144 = 'iPad_AppIcon144';
  dcIPad_AppIcon152 = 'iPad_AppIcon152';
  dcIPad_SpotLight40 = 'iPad_SpotLight40';
  dcIPad_SpotLight50 = 'iPad_SpotLight50';
  dcIPad_SpotLight80 = 'iPad_SpotLight80';
  dcIPad_SpotLight100 = 'iPad_SpotLight100';
  dcIPad_Setting29 = 'iPad_Setting29';
  dcIPad_Setting58 = 'iPad_Setting58';

  dcIPhone_Launch320 = 'iPhone_Launch320';
  dcIPhone_Launch640 = 'iPhone_Launch640';
  dcIPhone_Launch640x1136 = 'iPhone_Launch640x1136';
  dcIPhone_Launch750 = 'iPhone_Launch750';
  dcIPhone_Launch1242 = 'iPhone_Launch1242';
  dcIPhone_Launch2208 = 'iPhone_Launch2208';
  dcIPad_Launch768 = 'iPad_Launch768';
  dcIPad_Launch768x1024 = 'iPad_Launch768x1024';
  dcIPad_Launch1024 = 'iPad_Launch1024';
  dcIPad_Launch1024x768 = 'iPad_Launch1024x768';
  dcIPad_Launch1536 = 'iPad_Launch1536';
  dcIPad_Launch1536x2048 = 'iPad_Launch1536x2048';
  dcIPad_Launch2048 = 'iPad_Launch2048';
  dcIPad_Launch2048x1536 = 'iPad_Launch2048x1536';
  dcProjectiOSInfoPList = 'ProjectiOSInfoPList';
  dcProjectiOSDeviceResourceRules = 'ProjectiOSDeviceResourceRules';
  dcProjectiOSDeviceDebug = 'ProjectiOSDeviceDebug';
  dcProjectiOSEntitlements = 'ProjectiOSEntitlements';

  //Android
  dcAndroidDefaultAppIcon = 'Android_DefaultAppIcon';
  dcProjectAndroidManifest = 'ProjectAndroidManifest';
  dcAndroidLauncherIcon36 = 'Android_LauncherIcon36';
  dcAndroidLauncherIcon48 = 'Android_LauncherIcon48';
  dcAndroidLauncherIcon72 = 'Android_LauncherIcon72';
  dcAndroidLauncherIcon96 = 'Android_LauncherIcon96';
  dcAndroidLauncherIcon144 = 'Android_LauncherIcon144';
  dcAndroidSplashImage426 = 'Android_SplashImage426';
  dcAndroidSplashImage470 = 'Android_SplashImage470';
  dcAndroidSplashImage640 = 'Android_SplashImage640';
  dcAndroidSplashImage960 = 'Android_SplashImage960';
  dcAndroidGDBServer = 'AndroidGDBServer';
  dcAndroidClassesDexFile = 'AndroidClassesDexFile';
  dcAndroidLibnativeArmeabiFile = 'AndroidLibnativeArmeabiFile';
  dcAndroidLibnativeMipsFile = 'AndroidLibnativeMipsFile';
  dcAndroidSplashImageDef = 'AndroidSplashImageDef';
  dcAndroidSplashStyles = 'AndroidSplashStyles';
  dcAndroidServiceOutput = 'AndroidServiceOutput';

type
  { Make sure the ordinal values of TDeployOperation match the corresponding
    "put" arguments for the remote agent. Make sure doNotSpecified is always
    the highest ordinal value }
  TDeployOperation = (doCopyOnly, doSetExecBit, doUnArchive, doRun, doUnused, doExecuteScript, doNotSpecified);
  TDeploymentItemAction = (daAdded, daChanged, daRemoved, daReconciled);

  IProjectDeploymentItem = interface
  ['{9D9FC05C-49BD-4FD8-8425-833D16FA55E3}']
    { Condition is an MSBuild condition statement which will be evaluated in the
      context of the deployment's project when the Deploy target is run, so that
      delivery can be conditionalized based on project settings.
      e.g., "'$(DynamicRTL)'=='true'" on the file libcgrtl.dylib will cause it
      to be deployed only when the project has linked with the dynamic rtl. Look
      in $(TP)\app\design\*Strs.pas for a list of most project setting property names }
    function GetCondition: string;
    function GetLocalCommands(const PlatformName: string): TList<string>;
    function GetOperation(const PlatformName: string): TDeployOperation;
    function GetPlatforms: TArray<string>;
    function GetRemoteCommands(const PlatformName: string): TList<string>;
    function GetRemoteDir(const PlatformName: string): string;
    function GetRequired: Boolean;
    procedure RemovePlatform(const PlatformName: string);
    procedure SetCondition(const Value: string);
    procedure SetOperation(const PlatformName: string; const Value: TDeployOperation);
    procedure SetRemoteDir(const PlatformName, Value: string);
    procedure SetRequired(Value: Boolean);

    property Condition: string read GetCondition write SetCondition;
    property LocalCommands[const PlatformName: string]: TList<string> read GetLocalCommands;
    property Operation[const PlatformName: string]: TDeployOperation read GetOperation write SetOperation;
    property RemoteCommands[const PlatformName: string]: TList<string> read GetRemoteCommands;
    property RemoteDir[const PlatformName: string]: string read GetRemoteDir write SetRemoteDir;
    property Required: Boolean read GetRequired write SetRequired;
    property Platforms: TArray<string> read GetPlatforms;
  end;

  IProjectDeploymentFile170 = interface(IProjectDeploymentItem)
    ['{184728B4-5713-4D50-A042-CD027A7802BA}']
    function GetConfiguration: string;
    function GetDeploymentClass: string;
    function GetEnabled(const PlatformName: string): Boolean;
    function GetLocalName: string;
    function GetRemoteName(const PlatformName: string): string;
    procedure SetConfiguration(const Value: string);
    procedure SetDeploymentClass(const Value: string);
    procedure SetEnabled(const PlatformName: string; const Value: Boolean);
    procedure SetLocalName(const Value: string);
    procedure SetRemoteName(const PlatformName, Value: string);

    property Configuration: string read GetConfiguration write SetConfiguration;
    property DeploymentClass: string read GetDeploymentClass write SetDeploymentClass;
    property Enabled[const PlatformName: string]: Boolean read GetEnabled write SetEnabled;
    property LocalName: string read GetLocalName write SetLocalName;
    property RemoteName[const PlatformName: string]: string read GetRemoteName write SetRemoteName;
  end;

  IProjectDeploymentFile190 = interface(IProjectDeploymentFile170)
    ['{51CC1C02-BB0F-4CF1-8F48-68ABAEE511C2}']
    { Methods to specify the platform for each file in order to avoid duplicates when the same file
      that is located in a unique directory is required for many platforms. }
    function GetFilePlatform: string;
    procedure SetFilePlatform(const Value: string);
    property FilePlatform: string read GetFilePlatform write SetFilePlatform;
  end;

  IProjectDeploymentFile = interface(IProjectDeploymentFile190)
    ['{F8032C03-731C-4A4D-A493-8F119129B07D}']
    { Methods to specify when the remote file should be overwritten in case of the local file
      is newer than the remote file. }
    function GetOverwrite(const PlatformName: string): Boolean;
    procedure SetOverwrite (const PlatformName: string; Value: Boolean);
    property Overwrite[const PlatformName: string]: Boolean read GetOverwrite write SetOverwrite;
  end;

  IProjectDeploymentClass = interface(IProjectDeploymentItem)
    ['{C1FA0FD1-A0B0-4465-BE24-6C37C75B6D28}']
    function GetClassId: string;
    function GetDescription: string;
    procedure SetClassId(const Value: string);
    procedure SetDescription(const Value: string);
    function ValidFor(const Filename, PlatformName: string): Boolean;

    property ClassId: string read GetClassId write SetClassId;
    property Description: string read GetDescription write SetDescription;
  end;

  IProjectDeploymentNotifier = interface
    ['{E3BBD079-75B6-46F6-AC61-AD4B3B793111}']
    procedure Destroyed;
    procedure ItemChanged(const Item: IProjectDeploymentItem; Action: TDeploymentItemAction);
    procedure Loaded(const ClassId: string);
  end;

  TDeploymentFileArray = array of IProjectDeploymentFile;
  TDeploymentClassArray = array of IProjectDeploymentClass;

const
  cAllPlatforms = 'All';

type
  TReconcileResult = (rrSuccess, rrNotUpToDate, rrCompileRequired, rrFailed, rrNotSupported);

  IProjectDeployment170 = interface
    ['{FF8F9951-52D1-40F1-8A34-A72969BEE0D6}']
    { Register for notifications when project deployment data changes }
    function AddNotifier(const Notifier: IProjectDeploymentNotifier): Integer;
    procedure AddClass(const AClass: IProjectDeploymentClass);
    procedure AddFile(const AFile: IProjectDeploymentFile);
    procedure Clear;
    function CreateClass(const ClassId: string): IProjectDeploymentClass;
    function CreateFile(const LocalName: string): IProjectDeploymentFile;
    function FindFiles(const LocalName, Configuration, PlatformName, ClassName: string): TDeploymentFileArray;
    function GetClasses: TDictionary<string, IProjectDeploymentClass>.TValueCollection;
    function GetClass(const ClassId: string): IProjectDeploymentClass;
    { Returns which classes, if any, can be used with a particular file based on it's extension }
    function GetDefaultClasses(const Filename, PlatformName: string): TDeploymentClassArray;
    function GetFile(const LocalName: string): IProjectDeploymentFile;
    function GetFiles: TDictionary<string, IProjectDeploymentFile>.TValueCollection;
    { Return an array of all items with ClassId }
    function GetFilesOfClass(const ClassId: string): TDeploymentFileArray;
    { The project binary output's remote filename, relative to the remote project directory }
    function GetProjectOutputFile(const PlatformName: string = ''; const ConfigurationName: string = ''): string;
    { The root directory on the remote machine, relative to the agent's "scratch" directory,
      or a fully qualified path }
    function GetRemoteProjectDir(PlatformName: string): string;
    { Does the deployment have any data in it, or has ever been reconciled }
    function IsEmpty: Boolean;
    { Updates deployment to reflect current project state }
    function Reconcile(Configuration: string = ''; PlatformName: string = ''): TReconcileResult;
    { Remove a deployment class }
    procedure RemoveClass(const ClassId: string);
    { Remove all deployment data associated with a local file }
    procedure RemoveFile(const LocalName: string);
    { Remove all files with ClassId }
    procedure RemoveFilesOfClass(const ClassId: string);
    { Remove previously registered notifier }
    procedure RemoveNotifier(const NotifierIndex: Integer);
    { Remove all deployment data, reset to default }
    procedure Reset;
    { Write MSBuild script used by the Deployment MSBuild target }
    procedure SaveToMSBuild;
    { Set remote project root directory }
    procedure SetRemoteProjectDir(PlatformName: string; const Value: string);

    property Classes: TDictionary<string, IProjectDeploymentClass>.TValueCollection read GetClasses;
    property Files: TDictionary<string, IProjectDeploymentFile>.TValueCollection read GetFiles;
    property RemoteProjectDir[PlatformName: string]: string read GetRemoteProjectDir
      write SetRemoteProjectDir;
  end;

  IProjectDeployment180 = interface(IProjectDeployment170)
  ['{76A88D6C-8E6B-460E-8178-C21659E3D3CB}']
    { Overloaded methods to manage files for many platforms. This is necessary in order to avoid duplicates
      when the same file that is located in a unique directory is required for many platforms. }
    procedure AddFile(const AFile: IProjectDeploymentFile); overload;
    procedure AddFile(const PlatformName: string; const AFile: IProjectDeploymentFile); overload;
    function CreateFile(const LocalName: string): IProjectDeploymentFile; overload; deprecated;
    function CreateFile(const PlatformName: string; const LocalName: string): IProjectDeploymentFile; overload;
    function GetFile(const LocalName: string): IProjectDeploymentFile; overload;
    function GetFile(const PlatformName: string; const LocalName: string): IProjectDeploymentFile; overload;
    procedure RemoveFile(const LocalName: string); overload;
    procedure RemoveFile(const PlatformName: string; const LocalName: string); overload;
  end;

  IProjectDeployment190 = interface(IProjectDeployment180)
    ['{34139979-F793-4B85-8C25-058545542407}']
    { Overloaded methods to perform a selective clearing for all platforms or for a specified platform  }
    procedure Clear; overload;
    procedure Clear(const PlatformName: string); overload;
    { Method to get the number of deploy classes by platform }
    function GetClassCount(const PlatformName: string): Integer;
    { Method to know if there are default deployment classes for the specified platform }
    function RequiresDeployClasses(const PlatformName: string): Boolean;
  end;

  IProjectDeployment200 = interface(IProjectDeployment190)
    ['{5EDEAD6D-538B-47F6-B3D6-65405FAEEE1C}']
    { Overloaded methods to perform a selective clearing by removing or not the added files  }
    procedure Clear(const KeepUserFiles: Boolean); overload;
    procedure Clear(const PlatformName: string; const KeepUserFiles: Boolean); overload;
  end;

  IProjectDeployment220 = interface(IProjectDeployment200)
    ['{5D1B3896-962A-417B-A7B5-EE5FAA36BBB7}']
    { Overloaded methods to handle files for multiple configurations and platforms.}
    procedure AddFile(const AFile: IProjectDeploymentFile); overload; deprecated 'Use overloaded version of this method with config and platform parameters';
    procedure AddFile(const PlatformName: string; const AFile: IProjectDeploymentFile); overload; deprecated 'Use overloaded version of this method with config and platform parameters';
    function CreateFile(const LocalName: string): IProjectDeploymentFile; overload; deprecated;
    function CreateFile(const PlatformName: string; const LocalName: string): IProjectDeploymentFile; overload; deprecated 'Use overloaded version of this method with config and platform parameters';
    function GetFile(const LocalName: string): IProjectDeploymentFile; overload; deprecated;
    function GetFile(const PlatformName: string; const LocalName: string): IProjectDeploymentFile; overload; deprecated 'Use overloaded version of this method with config and platform parameters';
    procedure RemoveFile(const LocalName: string); overload; deprecated 'Use overloaded version of this method with config and platform parameters';
    procedure RemoveFile(const PlatformName: string; const LocalName: string); overload; deprecated 'Use overloaded version of this method with config and platform parameters';

    procedure AddFile(const Configuration, PlatformName: string; const AFile: IProjectDeploymentFile); overload;
    function CreateFile(const Configuration, PlatformName: string; const LocalName: string): IProjectDeploymentFile; overload;
    function GetFile(const Configuration, PlatformName: string; const LocalName: string): IProjectDeploymentFile; overload;
    procedure RemoveFile(const Configuration, PlatformName: string; const LocalName: string); overload;

    { Updates the deployment file list to reflect the current project state.
      Added new parameter ReconcileInternally to don't reconcile packages when we want to update the project state internally }
    function Reconcile(Configuration: string = ''; PlatformName: string = ''; const ReconcileInternally: Boolean = False): TReconcileResult; overload;
  end;

  IProjectDeployment = interface(IProjectDeployment220)
    ['{55D3B5B8-AE66-48BC-8357-2767E0121F03}']
    procedure SetBlockNotifications(const Value: Boolean);
    function GetBlockNotifications: Boolean;
    property BlockNotifications: Boolean read GetBlockNotifications write SetBlockNotifications;
  end;


{ Helper functions to resolve unspecified IProjectDeploymentFile fields through the
  underlying Deployment Class }
function GetDeploymentRemoteDir(const AFile: IProjectDeploymentFile;
  const PlatformName: string; const Deployment: IProjectDeployment): string;
function GetDeploymentOperation(const AFile: IProjectDeploymentFile;
  const PlatformName: string; const Deployment: IProjectDeployment): TDeployOperation;
function GetDeploymentClass(const AFile: IProjectDeploymentFile): string;
function GetDeploymentRequired(const AFile: IProjectDeploymentFile;
  const PlatformName: string; const Deployment: IProjectDeployment): Boolean;

implementation

function GetDeploymentRemoteDir(const AFile: IProjectDeploymentFile;
  const PlatformName: string; const Deployment: IProjectDeployment): string;
begin
  Result := AFile.RemoteDir[PlatformName];
  if (Result = '') and (AFile.DeploymentClass <> '')
  and (Deployment.GetClass(AFile.DeploymentClass) <> nil) then
  begin
    Result := Deployment.GetClass(AFile.DeploymentClass).RemoteDir[PlatformName];
    if Result <> '' then
      Result := IncludeTrailingPathDelimiter(Result);
  end;
end;

function GetDeploymentOperation(const AFile: IProjectDeploymentFile;
  const PlatformName: string; const Deployment: IProjectDeployment): TDeployOperation;
begin
  Result := AFile.Operation[PlatformName];
  if (Result = doNotSpecified) and (AFile.DeploymentClass <> '')
  and (Deployment.GetClass(AFile.DeploymentClass) <> nil) then
    Result := Deployment.GetClass(AFile.DeploymentClass).Operation[PlatformName];
  if Result = doNotSpecified then
    Result := doCopyOnly;
end;

function GetDeploymentClass(const AFile: IProjectDeploymentFile): string;
begin
  Result := AFile.DeploymentClass;
  if Result = '' then
    Result := dcFile;
end;

function GetDeploymentRequired(const AFile: IProjectDeploymentFile;
  const PlatformName: string; const Deployment: IProjectDeployment): Boolean;
begin
  Result := AFile.Required;
  if not Result and (AFile.DeploymentClass <> '')
  and (Deployment.GetClass(AFile.DeploymentClass) <> nil) then
    Result := Deployment.GetClass(AFile.DeploymentClass).Required;
end;

end.
