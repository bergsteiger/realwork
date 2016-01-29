{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit PlatformAPI;

interface

uses System.SysUtils, System.Classes, System.Types, ToolsAPI;

(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform160,0xBD2EAB7F,0x7FB5,0x464A,0x9C,0x97,0x88,0xDA,0x4D,0xC3,0xD1,0xF7);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform170,0xAD0481FA,0x4660,0x48CA,0x87,0x5A,0x57,0xB9,0x05,0x42,0x5E,0xA9);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform,0xD5033082,0xDC1A,0x45DB,0xA3,0xD6,0xE1,0x26,0x6C,0x76,0xF2,0xCD);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformServices160,0x8F20CD96,0x6702,0x43B8,0x87,0x6C,0xC9,0x85,0xC5,0x4C,0x9A,0xFF);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformServices,0xDD80D595,0xFCCC,0x4764,0x9E,0xF9,0x7C,0x36,0xBA,0x5B,0x11,0xCE);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAMobileDevice,0xC1EAA414,0xE8ED,0x4ECB,0xBA,0x30,0x69,0x1F,0xBD,0xEF,0xB6,0x90);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAMobileDeviceNotifier,0xF9CE8EFC,0xA3A2,0x4BE2,0xB8,0xF2,0x13,0xCD,0x5F,0x58,0xFF,0x41);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAMobileDeviceServices,0x3DAA5A1D,0x5C3B,0x4EA8,0xB4,0xBA,0xA7,0x90,0xE7,0x0D,0x07,0x68);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAProjectPlatforms160,0xE1C62726,0xBD51,0x4D4E,0xA2,0xF2,0x9A,0x8A,0x59,0xF2,0x72,0xAE);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAProjectPlatforms,0x4A03546D,0x37DD,0x4BDB,0xA5,0x0E,0x8B,0x5A,0xAF,0xB6,0x21,0x2F);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IProjectPlatformInitialize,0x4618AD84,0xCF6D,0x40A7,0x8C,0x2B,0xB0,0x4F,0x35,0x54,0xAD,0x78);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAConnectionCallback,0x7DF7A249,0x4C27,0x4147,0xBF,0xC3,0xCA,0x99,0x59,0x16,0x50,0x43);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfile170,0x328380FA,0x2AB5,0x4F25,0xBC,0xCB,0x7A,0x3F,0x84,0x69,0x1D,0x43);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfile,0x717C625E,0x8911,0x42A7,0x86,0xA9,0xAC,0xCB,0x57,0xE0,0x07,0xE5);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileNotifier170,0x84AD7E51,0xE0D0,0x4732,0x87,0x4B,0x05,0xA7,0x0E,0x2B,0xF5,0x34);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileNotifier,0x145453C0,0xAAFE,0x487B,0x86,0xC7,0x7D,0x21,0x71,0xFA,0xF6,0x8F);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileServices160,0xBC86D71D,0x8A31,0x4921,0xA2,0x7F,0x5D,0x32,0xDC,0x3A,0x9A,0x4F);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileServices170,0x5C996765,0x9F24,0x47B1,0xAF,0x80,0x36,0x39,0x4F,0x30,0x69,0xF9);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileServices,0x6B9557F7,0x32B2,0x4706,0x81,0xFF,0x99,0x5E,0xDA,0x2F,0x31,0x1F);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IPlatformProvisionInformation,0xA0C2A411,0x2F5E,0x4E97,0xA5,0x8B,0x81,0x0D,0xF6,0x32,0x53,0x62);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDK,0xDC2B0ADB,0x18BD,0x45D8,0xA6,0x48,0xDC,0x87,0x22,0xEB,0x7C,0x5C);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDKNotifier,0x3AD83D48,0xBC8B,0x4A6A,0xAA,0x5D,0x53,0x7C,0xC3,0xB7,0x51,0x8B);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDKServices,0xA41933CA,0x8F86,0x46F3,0x83,0x5B,0x63,0xEF,0x1C,0xAD,0x97,0x83);'*)

const
  { Universal platform ids }
  cWin32Platform = 'Win32';
  cWinNX32Platform = 'WinNX32';
  cOSX32Platform = 'OSX32';
  cWin64Platform = 'Win64';
  cLinux32Platform = 'Linux32';
  cAndroidPlatform = 'Android';
  ciOSSimulatorPlatform = 'iOSSimulator';
  ciOSDevicePlatform = 'iOSDevice';

  AllPlatforms = pidWin32 or pidWin64 or pidOSX32 or pidAndroid or pidiOSSimulator or pidLinux32 or pidiOSDevice; // numerical ids from System.Classes

  { File types that have well known platform-dependent extensions }
  fetUnknownType = 0;
  fetExe = 1;
  fetPackage = 2;
  fetDll = 3;
  fetStaticLibrary = 4;
  fetPackageImportLibrary = 5;
  fetCUnitBinary = 6;
  fetDelphiUnitBinary = 7;
  fetImportLibrary = 8;
  fetLast = fetImportLibrary;

  { build types}
  btDebug = 0;
  btAdHoc = 1;
  btAppStore = 2;
  btNormal = 3;
  piBTDebug = btDebug + 30;
  piBTAdHoc = btAdHoc + 30;
  piBTAppStore = btAppStore + 30;
  piBTNormal = btNormal + 30;

type
  TPlatformSupportsOperation = (psVFSPreProcessor, psMobile, psWindows, psFrameworkCopy);
  IOTAPlatform160 = interface
    ['{BD2EAB7F-7FB5-464A-9C97-88DA4DC3D1F7}']
    { Check a project to see if it's capable of supporting this platform as-is.
      Note this is not a strict check, because there's no way to know completely
      the nature of a project and the intended platform. Returns True if no
      reason could be found to prevent support, False if there is a known reason.
      Reasons parameter contains an array of strings indicating why the project
      won't work on this platform }
    function CheckProject(const AProject: IOTAProject; var Reasons: TArray<string>): Boolean;
    { Returns the translated display name for the platform }
    function GetDisplayName: string;
    { Returns the enumeration member for this platform, defined in System.Classes }
    function GetId: System.Classes.TPlatformIds;
    { Returns the invariant internal name for the platform }
    function GetName: string;
    { Returns the path delimiter for the platform }
    function GetPathDelim: string;
    { Return the appropriate file extension for various file types for this platform.
      Use "fet" constants above }
    function GetFileExtension(const FileExtType: Integer): string;
    { Return the file type associated with a a filename for this platform }
    function GetFileType(const Filename: string): Integer;
    { Relative index into the IDE's image list }
    function GetImageIndex: Integer;
    { Platform-specific namespace search paths, e.g., Win;System.Win }
    function GetNamespaceSearchPaths: string;
    { Return the appropriate output extension for this platform given
      the project type string (e.g., 'Library', 'CppConsoleApplication' as
      defined in this file }
    function GetOutputExtension(const ApplicationType: string): string;
    { Return the application type based on it's output filename }
    function GetOutputType(const Filename: string): string;
    { Is this platform available for the given personality in this IDE? }
    function IsAvailable(const Personality: string): Boolean;
    { Does this platform require a remote profile in order to compile/make/build? }
    function IsRemoteProfileRequiredToCompile(const Personality: string): Boolean;
    { Does this platform require a remote profile in order to run an application? }
    function IsRemoteProfileRequiredToRun(const Personality: string): Boolean;

    property DisplayName: string read GetDisplayName;
    property FileExtensions[const FileExtType: Integer]: string read GetFileExtension;
    property FileType[const Filename: string]: Integer read GetFileType;
    property Name: string read GetName;
    property PathDelim: string read GetPathDelim;
    property OutputExtension[const ApplicationType: string]: string
      read GetOutputExtension;
    property OutputType[const Filename: string]: string read GetOutputType;
  end;

  IOTAPlatform170 = interface(IOTAPlatform160)
    ['{AD0481FA-4660-48CA-875A-57B905425EA9}']
    function PlatformSupports(AOperation: TPlatformSupportsOperation): Boolean;
    { Determines if the project manager must show the platform node when it's the only one available }
    function ForceShowWhenUnique: Boolean;
  end;

  IOTAPlatform = interface(IOTAPlatform170)
    ['{D5033082-DC1A-45DB-A3D6-E1266C76F2CD}']
    { Does this platform require a SDK in order to compile/make/build? }
    function IsSDKRequiredToCompile(const Personality: string): Boolean;
    { Does this platform require a SDK in order to run an application? }
    function IsSDKRequiredToRun(const Personality: string): Boolean;
  end;

  TOTAPlatforms = array of IOTAPlatform;

  IOTAPlatformServices160 = interface(IInterface)
    ['{8F20CD96-6702-43B8-876C-C985C54C9AFF}']
    { Returns an array of all known platform names }
    function AllPlatforms: TArray<string>;
    { Returns an array of names of all platforms available (enabled) for the
      given personality in this IDE }
    function AvailablePlatforms(const Personality: string): TArray<string>;
    { Return the appropriate file extension for various file types for this platform.
      Use "fet" constants above }
    function GetFileExtension(const APlatform: string; const FileExtType: Integer): string;
    { Given a platform name, returns the IOTAPlatform instance for that platform }
    function GetPlatform(const Name: string): IOTAPlatform;
    { Given a filename, return which platforms have specific knowledge of that file.
      Essentially a reverse lookup of GetFileExtension }
    function GetPlatformsFromFilename(const Filename: string): TArray<string>;
    { Return the platforms that define a particular namespace, if any. }
    function GetPlatformsFromNamespace(const Namespace: string): TArray<string>;
    { Returns whether or not the platform with PlatformName is available (enabled)
      for the given personality in this IDE }
    function PlatformAvailable(const PlatformName, Personality: string): Boolean;
    { Returns whether or not the platform with the specified key exists and
      is registered }
    function PlatformExists(const PlatformName: string): Boolean;

    property FileExtension[const APlatform: string; const FileExtType: Integer]: string read GetFileExtension;
    property Platforms[const Name: string]: IOTAPlatform read GetPlatform; default;
  end;

  IOTAPlatformServices = interface(IOTAPlatformServices160)
    ['{DD80D595-FCCC-4764-9EF9-7C36BA5B11CE}']
    function PlatformSupports(APlatform: string; AOperation: TPlatformSupportsOperation): Boolean;
  end;

  TOTADeviceOrientation = (doPortrait, doUpsideDown, doLandscapeLeft, doLandscapeRight);

  TOTADeviceLayout = record
  public
    Enabled: Boolean;
    Artwork: string;
    Left: Integer;
    Top: Integer;
    Width: Integer;
    Height: Integer;
    StatusbarHeight: Integer;
    procedure Init;
  end;

  IOTAMobileDevice = interface
    ['{C1EAA414-E8ED-4ECB-BA30-691FBDEFB690}']
     { Assigns the new values for this mobile device }
    procedure Assign(const AMobileDevice: IOTAMobileDevice);
    { Returns the Active value for this mobile device }
    function IsActive: Boolean;
    { Is this mobile device available for the given platform in this IDE? }
    function IsAvailable(const APlatform: string): Boolean;
    { Returns the translated display name for the mobile device }
    function GetDisplayName: string;
    { Relative index into the IDE's image list }
    function GetImageIndex: Integer;
    { Returns the internal name for the mobile device }
    function GetName: string;
    { Returns the platform availabe for this mobile device }
    function GetPlatform: string;
    { Sets when the active mobile device is available }
    procedure SetActive(aValue: Boolean);
    { Returns the Simulator ID }
    function GetSimulatorID: string;
    { Gets the device's screen width }
    function GetWidth: Integer;
    { Gets the device's screen height }
    function GetHeight: Integer;
    { Gets the screen's top coordinate in the artwork }
    function GetTop: Integer;
    { Gets the screen's left coordinate in the artwork }
    function GetLeft: Integer;
    { Gets the screen's left coordinate in the artwork }
    function GetDPI: Integer;
    { Gets the device artwork }
    function GetArtwork: string;
    { Determines if the entry can be modified by the user }
    function GetUserData: Boolean;
    { Gets a orientation of the device }
    function GetDeviceLayout(Orientation: TOTADeviceOrientation): TOTADeviceLayout;

    procedure SetDisplayName(Value: string);
    procedure SetPlatform(Value: string);
    procedure SetSimulatorID(Value: string);
    procedure SetWidth(Value: Integer);
    procedure SetHeight(Value: Integer);
    procedure SetLeft(Value: Integer);
    procedure SetTop(Value: Integer);
    procedure SetDPI(Value: Integer);
    procedure SetArtwork(Value: string);
    procedure SetUserData(Value: Boolean);
    procedure SetDeviceLayout(Orientation: TOTADeviceOrientation; const Value: TOTADeviceLayout);

    property Active: Boolean read IsActive write SetActive;
    property DisplayName: string read GetDisplayName write SetDisplayName;
    property Name: string read GetName;
    property Platform: string read GetPlatform write SetPlatform;
    property SimulatorID: string read GetSimulatorID write SetSimulatorID;
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
    property Top: Integer read GetTop write SetTop;
    property Left: Integer read GetLeft write SetLeft;
    property DPI: Integer read GetDPI write SetDPI;
    property Artwork: string read GetArtwork write SetArtwork;
    property UserData: Boolean read GetUserData write SetUserData;
    property Layouts[Orientation: TOTADeviceOrientation]: TOTADeviceLayout read GetDeviceLayout write SetDeviceLayout;
  end;

  TOTAMobileDevices = array of IOTAMobileDevice;

  TOTAMobileDeviceChangeAction = (mdcaModified, mdcaDeleted);

  IOTAMobileDeviceNotifier = interface(IOTANotifier)
    ['{F9CE8EFC-A3A2-4BE2-B8F2-13CD5F58FF41}']
    { Called when a mobile device is modified }
    procedure MobileDeviceChanged(const aDeviceInternalName: string; aAction: TOTAMobileDeviceChangeAction);
  end;

  IOTAMobileDeviceServices = interface(IInterface)
    ['{3DAA5A1D-5C3B-4EA8-B4BA-A790E70D0768}']
    { Add a mobile device to the local repository }
    procedure AddMobileDevice(const AMobileDevice: IOTAMobileDevice);
    function CreateMobileDevice(const AInternalName: string): IOTAMobileDevice;
    { Returns an array of all known mobile devices names }
    function AllMobileDevices: TArray<string>;
    { Given a mobile device name, returns the IOTAMobileDevice instance for that mobile device }
    function GetMobileDevice(const Name: string): IOTAMobileDevice;
    { Gets the default device }
    function GetDefaultDevice: IOTAMobileDevice;
    { Sets the default device }
    procedure SetDefaultDevice(const Name: string);
    { Returns whether or not the mobile device with the specified key exists }
    function MobileDeviceExists(const MobileDeviceName: string): Boolean;
    { Remove a mobile device from the local repository }
    procedure RemoveMobileDevice(const MobileDeviceName: string);
    { Update a mobile device from the local repository }
    procedure UpdateMobileDevice(const AMobileDevice: IOTAMobileDevice);
    { Call this to register an IOTANotifier. The result is the index to be
      used when calling RemoveNotifier. If <0 then an error occurred. }
    function AddMobileDeviceNotifier(const ANotifier: IOTANotifier): Integer;
    { Call with the index obtained from AddNotifier }
    procedure RemoveMobileDeviceNotifier(Index: Integer);
    { Gets the SimulatorID for the named Device }
    function GetSimulatorID(const Name: string): string;

    property MobileDevices[const Name: string]: IOTAMobileDevice read GetMobileDevice; default;
  end;


  { Provides information on platform-specific information held by a project }
  IOTAProjectPlatforms160 = interface(IInterface)
    ['{E1C62726-BD51-4D4E-A2F2-9A8A59F272AE}']
    { Add an available platform to the project }
    procedure AddPlatform(const PlatformName: string);
    { Return the currently active platform key }
    function CurrentPlatform: string;
    { Return enabled state of the requested platform }
    function GetEnabled(const PlatformName: string): Boolean;
    { Return an array of strings representing the enabled platforms for a project }
    function GetEnabledPlatforms: TArray<string>;
    { Return the profile name associated with the specified platform }
    function GetProfile(const PlatformName: string): string;
    { Does the project support platform specified by PlatformName? }
    function GetSupported(const PlatformName: string): Boolean;
    { Return an array of strings representing the valid platforms for a project }
    function GetSupportedPlatforms: TArray<string>;
    { Set a platform as disabled for this project (cannot be made active) }
    procedure SetEnabled(const PlatformName: string; Value: Boolean);
    { Set the profile name for the specified platform. Pass an empty string to
      clear the profile }
    procedure SetProfile(const PlatformName, ProfileName: string);
    { Indicate the specified platform is supported or not }
    procedure SetSupported(const PlatformName: string; Value: Boolean);
    { Return whether or not the profile associated with PlatformName is the default profile
      for that platform }
    function UsingDefaultProfile(const PlatformName: string): Boolean;

    property EnabledPlatforms: TArray<string> read GetEnabledPlatforms;
    property Enabled[const PlatformName: string]: Boolean read GetEnabled write SetEnabled;
    property Profile[const PlatformName: string]: string read GetProfile write SetProfile;
    property Supported[const PlatformName: string]: Boolean read GetSupported write SetSupported;
    property SupportedPlatforms: TArray<string> read GetSupportedPlatforms;
  end;

  IOTAProjectPlatforms = interface(IOTAProjectPlatforms160)
    ['{4A03546D-37DD-4BDB-A50E-8B5AAFB6212F}']
    { Return the SDK name associated with the specified platform }
    function GetSDKVersion(const PlatformName: string): string;
    { Set the SDK name for the specified platform. }
    procedure SetSDKVersion(const PlatformName, SDKVersionName: string);
    { Return the currently active platform key }
    function CurrentMobileDevice: string;

    property PlatformSDK[const PlatformName: string]: string read GetSDKVersion write SetSDKVersion;
  end;

  IProjectPlatformInitialize = interface
    ['{4618AD84-CF6D-40A7-8C2B-B04F3554AD78}']
    procedure InitializeProject(const AProject: IOTAProject);
  end;

  { orptInclude -- path will be passed in the C++ compiler's Include path
    orptLibrary -- path will be passed in the C++ linker's Library path
    orptFramework -- path will be passed in the C++ compiler and linker's
                     framework path. The MaskOrFramework field indicates the
                     framework name, and it will be passed in the C++ compiler
                     and linker's framework option.
    orptOther -- path will not be passed to the compiler or linker }
  TOTARemotePathType = (orptInclude, orptLibrary, orptFramework, orptOther);

  { Profile Path item expressed as a path, filemask, and a flag indicating
    whether or not to recurse into subdirectories.  All path items will be
    processed on the remote machine and cached on the local machine.
    PathItems with a PathType other than orptOther will also be passed to
    the C++ compiler and linker.  For orptFramework PathTypes, all headers
    and symbolic information for the framework will always be cached.  If
    IncludeSubDir is True for frameworks, then all other files under the
    framework directory will also be cached locally. }
  TOTARemoteProfilePathItem = record
    Path: string;
    MaskOrFramework: string;
    IncludeSubDir: Boolean;
    PathType: TOTARemotePathType;
  end;

  { Dynamic array of profile path items }
  TOTARemoteProfilePathArray = array of TOTARemoteProfilePathItem;

  { Profile Credential expressed as a password or passfile, and a flag indicating which.
    IsEncrypted flag is used to indicate whether the password has been encrypted. }
  TOTARemoteProfileCredential = record
    PasswordOrPassFile: string;
    IsPassword: Boolean;
    IsEncrypted: Boolean;
  end;

  TOTASDKInfo = record
    PlatformID: string;
    Path: string;
    Version: string;
    Name: string;
    DisplayName: string;
    BuildVersion: string;
    XCodeBuildVersion: string;
  end;

  TOTASDKInfoArray = array of TOTASDKInfo;

  IOTAConnectionCallback = interface(IInterface)
    ['{7DF7A249-4C27-4147-BFC3-CA9959165043}']
    { Returns True to retry the current failed or timed out connection }
    function Retry: Boolean;
    { Returns True to abort the current pending connection }
    function Abort: Boolean;
  end;

  IOTARemoteProfile170 = interface(IInterface)
    ['{328380FA-2AB5-4F25-BCCB-7A3F84691D43}']
    { Returns the name of the profile }
    function GetName: string;
    { Returns the name of the platform for this profile }
    function GetPlatformName: string;
    { Returns the name of the host machine for this profile }
    function GetHostName: string;
    { Returns the port number for this profile }
    function GetPortNumber: Integer;
    { Returns the credential for this profile }
    function GetCredential: TOTARemoteProfileCredential;
    { Returns the system root directory for this profile }
    function GetSystemRoot: string;
    { Returns the array of remote paths for this profile }
    function GetPaths: TOTARemoteProfilePathArray;
    { Sets the name of the profile }
    procedure SetName(const Value: string);
    { Sets the name of the platform for this profile }
    procedure SetPlatformName(const Value: string);
    { Sets the name of the host machine for this profile }
    procedure SetHostName(const Value: string);
    { Sets the port number for this profile }
    procedure SetPortNumber(const Value: Integer);
    { Sets the credential for this profile }
    procedure SetCredential(const Value: TOTARemoteProfileCredential);
    { Sets the system root directory for this profile }
    procedure SetSystemRoot(const Value: string);
    { Sets the array of remote paths for this profile }
    procedure SetPaths(const Value: TOTARemoteProfilePathArray);
    { BeginUpdate/EndUpdate allow the caller to set multiple properties of the
      profile, without sending a IOTARemoteProfileNotifier for each individual
      change.  Call BeginUpdate before setting any properties, and then a single
      notification will be sent after EndUpdate is called. }
    procedure BeginUpdate;
    procedure EndUpdate;

    property Name: string read GetName write SetName;
    property PlatformName: string read GetPlatformName write SetPlatformName;
    property HostName: string read GetHostName write SetHostName;
    property PortNumber: Integer read GetPortNumber write SetPortNumber;
    property Credential: TOTARemoteProfileCredential read GetCredential write SetCredential;
    property SystemRoot: string read GetSystemRoot write SetSystemRoot;
    property Paths: TOTARemoteProfilePathArray read GetPaths write SetPaths;
  end;

  IOTARemoteProfile = interface(IOTARemoteProfile170)
    ['{717C625E-8911-42A7-86A9-ACCB57E007E5}']
    { Gets the array of the SDK's info }
    function GetSDKs(const PlatformName: string; out ErrorMessage: string): TOTASDKInfoArray;
    { Gets the Developer program ID from remote machine }
    function GetDeveloperTeamID(const MobileProvisionFile: string; out Errormessage: string): string;
  end;

  TOTARemoteProfileStatus = (orpsOk, orpsNotFound, orpsNotAssigned);

  { optStart  -- show progress dialog at start of process; StatusMessage is the dialog caption
    optUpdate -- update progress dialog
    optError  -- an error occurred; StatusMessage is the error message
    optFinish -- process is done, close Progress dialog
    optCancel   -- process is cancelled }
  TOTAProgressType = (optStart, optUpdate, optError, optFinish, optCancel);

  TOTAGetProfileFilesProgressCallback = function(ProgressType: TOTAProgressType;
    CurPathItem: Integer;           // -1 indicates no update of count
    TotalPathItemCount: Integer;    // -1 indicates no update of count
    const StatusMessage: string;    // status message for progress dialog
    const Path: string;             // path to file being copied
    const FileName: string;         // file being copied
    FileCurrentPercent: Integer     // percent complete of file being copied: -1 indicates not a file
    ): Boolean of object;

  TOTAFileOverwriteControl = (ofocAlwaysOverwrite, ofocNeverOverwrite, ofocPromptUserToOverwrite);

  TOTAPutFileFlags = set of (opffRunnable, opffArchive, opffScript);

  { An item to copy from the local machine to the remote machine.
    LocalSourceFileName is the fully-qualified name of the local file to copy to
    the remote machine.  RemoteDestinationPath is the location on the remote
    machine (relative to the machine's scratch directory) where the file will be
    copied.  RemoteDestinationFile is the name of the file to use on the remote
    machine.  If RemoteDestinationFile and RemoteDestinationPath are blank, then
    the remote file will be created at a location determined by the path of
    LocalSourceFileName.  For instance, if the LocalSourceFileName is
    "c:\foo\bar\test.txt", then the remote file created will be:
    "<SCRATCHDIR>\<USER>-<PROFILENAME>\c__drive\foo\bar\test.txt" where
    <SCRATCHDIR> is determined by the remote server.  Flags indicates how to
    handle the file after it is copied.  opffRunnable will cause the file to
    get the executable bit set (for remote systems where this matters).
    opffArchive will cause the file to be unzipped on the remote machine.
    opffScript indicates that the file is a shell script file, that should be
    executed after it is transferred (opffScript implies opffRunnable) }
  TOTAPutFileItem = record
    LocalSourceFileName: string;
    RemoteDestinationPath: string;
    RemoteDestinationFile: string;
    Flags: TOTAPutFileFlags;
  end;
  { Dynamic array of files to copy to the remote machine }
  TOTAPutFileArray = array of TOTAPutFileItem;

  { An item representing a file on the remote machine.  Name is the file or
    directory name.  Attributes indicates the attributes for the remote file --
    these correspond to the "fa..." constants defined in the "File attribute
    constants" section in SysUtils.pas.  TimeStamp may indicate the timestamp
    of the remote file (see comment for BrowseRemoteFileSystem below).  Size
    indicates the size of the remote file }
  TOTARemoteFileInfo = record
    Name: string;
    Attributes: Integer;
    TimeStamp: TDateTime;
    Size: Int64;
  end;
  TOTARemoteFileInfoArray = array of TOTARemoteFileInfo;

  { A notifier for changes to remote profiles }
  IOTARemoteProfileNotifier170 = interface
    ['{84AD7E51-E0D0-4732-874B-05A70E2BF534}']
    { Called after the name of the remote profile is changed }
    procedure RemoteProfileRenamed(const RemoteProfile: IOTARemoteProfile;
      const OldName: string);
    { Called after any properties (other than name) of the remote profile are
      changed }
    procedure RemoteProfileChanged(const RemoteProfile: IOTARemoteProfile);
    { Called after a new remote profile is added }
    procedure RemoteProfileAdded(const RemoteProfile: IOTARemoteProfile);
    { Called right before a remote profile is removed.  Release any references
      to the profile, so that it can be properly cleaned up }
    procedure RemoteProfileRemoved(const RemoteProfile: IOTARemoteProfile);
  end;

  IOTARemoteProfileNotifier = interface(IOTARemoteProfileNotifier170)
    ['{145453C0-AAFE-487B-86C7-7D2171FAF68F}']
   { This procedure is called immediately following a deploy.  Succeeded
      will be true if the deploy was successful }
    procedure AfterDeploy(const Succeeded: Boolean; const RemoteProfile: IOTARemoteProfile);
   { This procedure is called immediately following a run.  Succeeded
      will be true if the run was successful }
    procedure AfterRun(const Succeeded: Boolean; const RemoteProfile: IOTARemoteProfile);
  end;

  IOTARemoteProfileServices160 = interface(IInterface)
    ['{BC86D71D-8A31-4921-A27F-5D32DC3A9A4F}']
    { Returns the number of available profiles for the specified platform }
    function GetProfileCount(const PlatformName: string): Integer;
    { Returns the index'd profile for the specified platform }
    function GetProfile(const PlatformName: string; Index: Integer): IOTARemoteProfile; overload;
    { Returns the specified profile.  Returns nil if the profile does not exist }
    function GetProfile(const ProfileName: string): IOTARemoteProfile; overload;
    { Adds a new profile }
    function AddProfile(const Name: string; const PlatformName: string;
      const HostName: string; PortNumber: Integer; const Credential: TOTARemoteProfileCredential;
      const SystemRoot: string; const Paths: TOTARemoteProfilePathArray;
      IsDefault: Boolean): IOTARemoteProfile;
    { Opens up the Options dialog, selects the "Connection Profile Manager" options page,
      and focuses the specified profile, allowing the user to edit it }
    procedure EditProfile(const Name: string);
    { Removes the specified profile }
    procedure RemoveProfile(const Profile: IOTARemoteProfile);
    { Returns the default profile for the specified platform.  Returns nil if
      there is no default profile for the specified platform.  The Windows
      platform will never have a default -- thus this method will always return
      nil for the Windows platform }
    function GetDefaultForPlatform(const PlatformName: string): IOTARemoteProfile;
    { Sets the specified profile as the default for its platform }
    procedure SetAsDefaultForPlatform(const Profile: IOTARemoteProfile);
    { BeginOperation and EndOperation should be used to increase performance
      when multiple calls to the following methods will be made in succession:
      GetProfileFiles, GetProfileFilesWithProgress, PutFiles, GetRemoteFileInfo,
      PutFilesWithProgress, RemoveRemoteFilesWithProgress, BrowseRemoteFileSystem,
      RemoteDirectoryExists, GetRemoteBaseDirectory, ExpandPath, ExpandAllPaths,
      CreateSymLink, Run, StartRemoteDebugger, GetEnvironmentVariables.
      Wrapping the multiple calls inside of a BeginOperation/EndOperation pair
      will allow a single connection to the remote machine to be used. Otherwise
      each individual call will create and destroy its own connection. }
    procedure BeginOperation(const Profile: IOTARemoteProfile);
    procedure EndOperation(const Profile: IOTARemoteProfile);
    { Attempts to connect to the host defined in the specifed IOTARemoteProfile.
      The return value indicates if the connection succeeded or not. If False
      is returned, ErrorMessage may contain extra information about the failure.
      ConnectionCallback is an optional interface that is called when the connection
      fails or when to abort the pending connection }
    function TestConnection(const Profile: IOTARemoteProfile;
      out ErrorMessage: string;
      ConnectionCallBack: IOTAConnectionCallback = nil): Boolean; overload;
    { Attempts to connect to the host machine and process the remote files
      specified in Profile.Paths.  The symbolic information and files will be
      cached on the local machine directory specified in Profile.SystemRoot }
    function GetProfileFiles(const Profile: IOTARemoteProfile;
      OverwriteControl: TOTAFileOverwriteControl = ofocPromptUserToOverwrite;
      ConnectionCallback: IOTAConnectionCallback = nil;
      ProgressCallback: TOTAGetProfileFilesProgressCallback = nil): Boolean;
    { Gets the size and date of a local file and returns False if the file does not exist }
    function GetFileInfo(const Profile: IOTARemoteProfile; const Path: string; out LastWriteTime: TDateTime;
      out Size: Int64) : Boolean;
    { Attempts to connect to the host machine and returns the size and date of a remote file.
      Return False if the file does not exist }
    function GetRemoteFileInfo(const Profile: IOTARemoteProfile; const Path: string; out LastWriteTime: TDateTime;
      out Size: Int64; ConnectionCallBack: IOTAConnectionCallback = nil): Boolean;
    { A simplified version of GetProfileFiles that uses the defaults for
      OverwriteControl and ConnectionCallback and uses the IDE's built-in progress
      dialog }
    function GetProfileFilesWithProgress(const Profile: IOTARemoteProfile): Boolean;
    { Attempts to connect to the host machine and push the specified Files from
      the local machine to the remote machine }
    function PutFiles(const Profile: IOTARemoteProfile; const Files: TOTAPutFileArray;
      OverwriteControl: TOTAFileOverwriteControl = ofocAlwaysOverwrite;
      ConnectionCallback: IOTAConnectionCallback = nil;
      ProgressCallback: TOTAGetProfileFilesProgressCallback = nil): Boolean;
    { A simplified version of PutFiles that uses the defaults for
      OverwriteControl and ConnectionCallback and uses the IDE's built-in progress
      dialog }
    function PutFilesWithProgress(const Profile: IOTARemoteProfile;
      const Files: TOTAPutFileArray): Boolean;
    { Attempts to connect to the host machine and delete the files specfied in
      the Files array.  The Files array should contain fully qualified file
      names as they are seen on the remote machine }
    function RemoveRemoteFiles(const Profile: IOTARemoteProfile;
      const Files: TStringDynArray;
      ConnectionCallback: IOTAConnectionCallback = nil;
      ProgressCallback: TOTAGetProfileFilesProgressCallback = nil): Boolean;
    { A simplified version of PutFiles that uses the default for
      ConnectionCallback and uses the IDE's built-in progress dialog }
    function RemoveRemoteFilesWithProgress(const Profile: IOTARemoteProfile;
      const Files: TStringDynArray): Boolean;
    { Attempts to connect to the host machine and browse the remote file system.
      Path is the directory you want to browse.  Attributes are the file types
      that you want included in the result -- these correspond to the "fa..."
      constants defined in the "File attribute constants" section in
      SysUtils.pas. IncludeTimeStamp is a flag indicating whether or not you
      want the result to include file timestamps.  If IncludeTimeStamp is false,
      all items in the result array will have a zero TimeStamp. Item zero in the
      returned array is the name of the Path passed in.  Actual items on the
      remote machine start at item one in the returned array }
    function BrowseRemoteFileSystem(const Profile: IOTARemoteProfile;
      const Path: string; Attributes: Integer; IncludeTimeStamp: Boolean;
      ConnectionCallBack: IOTAConnectionCallback = nil): TOTARemoteFileInfoArray;
    { Attempts to connect to the host machine and returns True if the directory
      exists in the remote file system }
    function RemoteDirectoryExists(const Profile: IOTARemoteProfile;
      const Directory: string; ConnectionCallBack: IOTAConnectionCallback = nil): Boolean;
    { Attempts to connect to the host machine and asks the remote machine for
      the name of the scratch directory used on the remote machine for the
      specified profile }
    function GetRemoteBaseDirectory(const Profile: IOTARemoteProfile;
      ConnectionCallBack: IOTAConnectionCallback = nil): string;
    { Attempts to connect to the host machine and returns the fully qualified path
      of the given path. If the path is a relative path, it is made full path
      by resolving it against the scratch directory used on the remote machine for
      the specified profile }
    function ExpandPath(const Profile: IOTARemoteProfile; const Path: string;
      ConnectionCallBack: IOTAConnectionCallback = nil): string;
    { Attempts to connect to the host machine and returns the fully qualified paths
      of the given paths. If the path is a relative path, it is made full path
      by resolving it against the scratch directory used on the remote machine for
      the specified profile }
    function ExpandAllPaths(const Profile: IOTARemoteProfile; const Paths: string;
      ConnectionCallBack: IOTAConnectionCallback = nil): string;
    { Attempts to connect to the host machine and returns True if the symbolic link
      is successfully created for the TargetPath.  If False is returned, ErrorMessage
      may contain extra information about the failure }
    function CreateSymLink(const Profile: IOTARemoteProfile; const LinkPath: string;
      const TargetPath: string; ConnectionCallBack: IOTAConnectionCallback = nil): Boolean;
    { Attempts to connect to a remote machine using the specified profile and
      Runs (without debugging) the specified process on that machine.
      PathUnderScratchDir is the path under the remote machine's "scratch directory"
      where the process lives.  ExeName is the name of the executable to run.
      Params are parameters to pass to the executable.  Launcher is an optional
      application to use to launch the ExeName.  If it contains the string "%debuggee%",
      then the ExeName will be used in place of %debuggee%.   The most common
      use of a Launcher is a shell that can be used so that the running app has
      a dedicated place for stdin/stdout/stderr/etc.   WorkingDir is the directory
      to use as the current directory when launching the process.  EnvList is
      a list of environment variables for the process.  UserName is the user
      account to use when running the process.  The return value indicates whether
      or not the process was launched successfully.  If False is returned, ErrorMessage
      may contain extra information about the failure }
    function Run(const Profile: IOTARemoteProfile;
      const PathUnderScratchDir: string; const ExeName: string;
      const Params: string; const Launcher: string; const WorkingDir: string;
      const EnvList: TStrings; const UserName: string;
      out ErrorMessage: string;
      ConnectionCallback: IOTAConnectionCallback = nil): Boolean; overload;
    { Attempts to connect to a remote machine using the specified profile and
      starts the remote debugger on that machine.  UserName is the user account
      to use when running the remote debugger process. The return value indicates
      whether or not the remote debugger was launched successfully. If False is
      returned, ErrorMessage may contain extra information about the failure }
    function StartRemoteDebugger(const Profile: IOTARemoteProfile;
      const UserName: string; const ProcessType: TOTAProcessType; out DebuggerId: Integer;
      out DebuggerPort: Integer; out ErrorMessage: string; ConnectionCallback: IOTAConnectionCallback = nil): Boolean;
    { Executes the "Create a Connection Profile" wizard and returns the newly-added
      IOTARemoteProfile.  Returns nil if the user cancels out of the wizard.
      InitialPlatform is the platform that will be pre-selected in the wizard
      If InitialPlatform is the empty string, the initial platform will be
      the first one listed in the Platform combo box. If RestrictToInitialPlatform
      is true, the user will not be able to select any platform other than the
      InitialPlatform }
    function ExecuteNewProfileWizard(const InitialPlatform: string = '';
      RestrictToInitialPlatform: Boolean = False): IOTARemoteProfile;
    { Shows a dialog with all available Profiles for the specified platform.  If
      PlatformName is blank, all Profiles for all platforms will be included in
      the dialog.  The return value indicates which Platform the user selected.
      The return value will be nil if the user cancels out of the dialog }
    function ShowSelectProfileDialog(const PlatformName: string = ''): IOTARemoteProfile;
    { Can the project currently be deployed using the specified profile? }
    function CanDeployProject(const Project: IOTAProject; const Profile: IOTARemoteProfile): Boolean;
    { Run the "Deploy" target using the specified profile and project }
    function DeployProject(const Project: IOTAProject; const Profile: IOTARemoteProfile;
      Configuration: string = ''; PlatformName: string = ''; ClearMessages: Boolean = True): Boolean;
    { Check profile requirement(s) in order to compile the given project for
      the specified platform. Return true if requirements are met, false if
      they cannot be met or are not met after prompting the user }
    function EnsureProfileForCompile(const Project: IOTAProject;
      const PlatformName: string; var ErrorMessage: string): TOTARemoteProfileStatus;
    { Check profile requirement(s) in order to run the given project. Return
      true if requirements are met, false if they cannot be met or are not
      met after prompting the user }
    function EnsureProfileForRun(const Project: IOTAProject;
      var ErrorMessage: string): TOTARemoteProfileStatus;
    { Call this to register an IOTARemoteProfileNotifier. The result is the
      index to be used when calling RemoveNotifier. If <0 then an error occurred. }
    function AddNotifier(const Notifier: IOTARemoteProfileNotifier): Integer;
    { Call with the index obtained from AddNotifier }
    procedure RemoveNotifier(Index: Integer);
    { Attempts to connect to the host machine and returns environment variables
      on that meachine. Returns empty array if no environment variable is found,
      otherwise returns array of 'name=value' string }
    function GetEnvironmentVariables(const Profile: IOTARemoteProfile;
      ConnectionCallBack: IOTAConnectionCallback = nil): TStringDynArray;
  end;

  IOTARemoteProfileServices170 = interface(IOTARemoteProfileServices160)
    ['{5C996765-9F24-47B1-AF80-36394F3069F9}']
    { Attempts to connect to a remote machine using the specified profile and
      Runs (without debugging) the specified process on that machine.
      PathUnderScratchDir is the path under the remote machine's "scratch directory"
      where the process lives.  ExeName is the name of the executable to run.
      Params are parameters to pass to the executable.  Launcher is an optional
      application to use to launch the ExeName.  If it contains the string "%debuggee%",
      then the ExeName will be used in place of %debuggee%.   The most common
      use of a Launcher is a shell that can be used so that the running app has
      a dedicated place for stdin/stdout/stderr/etc.   WorkingDir is the directory
      to use as the current directory when launching the process.  EnvList is
      a list of environment variables for the process.  UserName is the user
      account to use when running the process.  The return value indicates whether
      or not the process was launched successfully.  If False is returned, ErrorMessage
      may contain extra information about the failure. If True is returned, Pid contains
      the actual process id }
    function Run(const Profile: IOTARemoteProfile;
      const PathUnderScratchDir: string; const ExeName: string;
      const Params: string; const Launcher: string; const WorkingDir: string;
      const EnvList: TStrings; const UserName: string;
      out ErrorMessage: string; out Pid: Integer;
      ConnectionCallback: IOTAConnectionCallback = nil): Boolean; overload;
    { Attempts to connect to a remote machine using the specified profile and
      returns iOS application launcher. Returns device launcher if DeviceFamily
      is blank, otherwise returns simulator launcher. Set Debug to True if you
      want launcher to run the app in debug mode }
    function GetIOSLauncher(const Profile: IOTARemoteProfile; const DeviceFamily: string = '';
      Debug: Boolean = False; ConnectionCallBack: IOTAConnectionCallback = nil): string;
  end;

  IOTARemoteProfileServices = interface(IOTARemoteProfileServices170)
    ['{6B9557F7-32B2-4706-81FF-995EDA2F311F}']
    { Adds a new profile, saves it in the registry and creates the profile file.
      If the profile specified exists this function updates the profile's values. }
    procedure MergeRemoteProfile(const Profile: IOTARemoteProfile);
  end;

  EPlatformNotSupported = class(Exception)
  public
    constructor Create(const PlatformName: string);
  end;

  TOTABuildType = record
    Name: string;
    DisplayName: string;
    ImageIndex: Integer;
  end;

  TOTABuildTypeConfig = record
    ProvisioningKey: string;
    DeveloperKey: string;
    DevTeamIdKey: string;
    Platform: string;
    BuildType: string;
    BuildTypeKey: string;
    BuildTypeDisplay: string;
  end;

  IPlatformProvisionInformation = interface
    ['{A0C2A411-2F5E-4E97-A58B-810DF6325362}']
    function GetBuildTypes: TArray<TOTABuildTypeConfig>;
    {Returns a detailed list of BuildType items by platform}
  end;

  TOTAPlatformSDKStatus = (opssOk, opssNotFound, opssNotAssigned, opssNoFiles, opssOutOfDate);

  IOTAPlatformSDK = interface
    ['{DC2B0ADB-18BD-45D8-A648-DC8722EB7C5C}']
    { Returns the internal name of the SDK }
    function GetName: string;
    { Returns the display name of the SDK }
    function GetDisplayName: string;
    { Returns the version of the SDK }
    function GetVersion: string;
    { Returns the build version of the SDK }
    function GetBuildVersion: string;
    { Returns the XCode build version of the SDK }
    function GetXCodeBuildVersion: string;
    { Returns the name of the platform for this SDK }
    function GetPlatformName: string;
    { Returns the system root directory for this SDK }
    function GetSystemRoot: string;
    { Returns the framework root directories for this SDK }
    function GetFrameworkRoot: string;
    { Returns the array of remote paths for this SDK }
    function GetPaths: TOTARemoteProfilePathArray;
    { Returns the remote path for this SDK }
    function GetRemotePath: string;
    { Returns the default SDK }
    function GetIsDefault: Boolean;
    { Sets the internal name of the SDK }
    procedure SetName(const Value: string);
    { Sets the display name of the SDK }
    procedure SetDisplayName(const Value: string);
    { Sets the version of the SDK }
    procedure SetVersion(const Value: string);
    { Sets the build version of the SDK }
    procedure SetBuildVersion(const Value: string);
    { Sets the XCode build version of the SDK }
    procedure SetXCodeBuildVersion(const Value: string);
    { Sets the name of the platform for this SDK }
    procedure SetPlatformName(const Value: string);
    { Sets the system root directory for this SDK }
    procedure SetSystemRoot(const Value: string);
    { Sets the framework root directories for this SDK }
    procedure SetFrameworkRoot(const Value: string);
    { Sets the array of remote paths for this SDK }
    procedure SetPaths(const Value: TOTARemoteProfilePathArray);
    { Sets the remote path for this SDK }
    procedure SetRemotePath(const Value: string);
    { Sets the default SDK }
    procedure SetIsDefault(const Value: Boolean);
    { BeginUpdate/EndUpdate allow the caller to set multiple properties of the
      SDK, without sending a IOTAPlatformSDKNotifier for each individual
      change.  Call BeginUpdate before setting any properties, and then a single
      notification will be sent after EndUpdate is called. }
    procedure BeginUpdate;
    procedure EndUpdate;

    property Name: string read GetName write SetName;
    property DisplayName: string read GetDisplayName write SetDisplayName;
    property Version: string read GetVersion write SetVersion;
    property BuildVersion: string read GetBuildVersion write SetBuildVersion;
    property XCodeBuildVersion: string read GetXCodeBuildVersion write SetXCodeBuildVersion;
    property PlatformName: string read GetPlatformName write SetPlatformName;
    property SystemRoot: string read GetSystemRoot write SetSystemRoot;
    property FrameworkRoot: string read GetFrameworkRoot write SetFrameworkRoot;
    property Paths: TOTARemoteProfilePathArray read GetPaths write SetPaths;
    property RemotePath: string read GetRemotePath write SetRemotePath;
    property IsDefault: Boolean read GetIsDefault write SetIsDefault;
  end;

  IOTAPlatformSDKNotifier = interface
    ['{3AD83D48-BC8B-4A6A-AA5D-537CC3B7518B}']
    { Called after any properties (other than name) of the SDK are
      changed }
    procedure PlatformSDKChanged(const PlatformSDK: IOTAPlatformSDK);
    { Called after a new SDK is added }
    procedure PlatformSDKAdded(const PlatformSDK: IOTAPlatformSDK);
    { Called right before a SDK is removed.  Release any references
      to the SDK, so that it can be properly cleaned up }
    procedure PlatformSDKRemoved(const PlatformSDK: IOTAPlatformSDK);
  end;

  IOTAPlatformSDKServices = interface(IInterface)
    ['{A41933CA-8F86-46F3-835B-63EF1CAD9783}']
    { Returns the number of available SDK for the specified platform }
    function GetPlatformSDKCount(const PlatformName: string): Integer;
    { Returns the index'd SDK for the specified platform }
    function GetPlatformSDK(const PlatformName: string; Index: Integer): IOTAPlatformSDK; overload;
    { Returns the specified SDK.  Returns nil if the SDK does not exist }
    function GetPlatformSDK(const SDKName: string): IOTAPlatformSDK; overload;
    { Returns the specified SDK for the specified platform and version.  Returns nil if the SDK does not exist }
    function GetPlatformSDK(const PlatformName: string; const Version: string): IOTAPlatformSDK; overload;
    { Returns the default SDK for the specified platform.  Returns nil if
      there is no default SDK for the specified platform.  The Windows
      platform will never have a default -- thus this method will always return
      nil for the Windows platform }
    function GetDefaultForPlatform(const PlatformName: string): IOTAPlatformSDK;
    { Sets the specified SDK as the default for its platform }
    procedure SetAsDefaultForPlatform(const PlatformSDK: IOTAPlatformSDK);
    { Sets the paths of the specified SDK as default }
    procedure SetDefaultPaths(const PlatformSDK: IOTAPlatformSDK);
    { Returns the default paths for the specified SDK }
    function GetDefaultPaths(const PlatformSDK: IOTAPlatformSDK): TOTARemoteProfilePathArray;
    { Returns the default SDK paths file }
    function GetDefaultFileName(const PlatformSDKName: string; const SDKVersion: string; const PlatformName: string): string; overload;
    { Returns the default SDK paths file }
    function GetDefaultFileName(const PlatformSDKName: string): string; overload;
    { Adds a new SDK }
    function AddPlatformSDK(const Name: string; const DisplayName: string; const Version: string;
      const BuildVersion: string; const XCodeBuildVersion: string; const PlatformName: string;
      const SystemRoot: string; const FrameworkRoot: string; const Paths: TOTARemoteProfilePathArray;
      const RemotePath: string; const IsDefault: Boolean): IOTAPlatformSDK;
    { Opens up the Options dialog, selects the "SDK Manager" options page,
      and focuses the specified SDK, allowing the user to edit it }
    procedure EditPlatformSDK(const Name: string);
    { Removes the specified SDK }
    procedure RemovePlatformSDK(const PlatformSDK: IOTAPlatformSDK);
    { Executes the "Add a New SDK" wizard and returns the newly-added
      IOTAPlatformSDK.  Returns nil if the user cancels out of the wizard. }
    function ExecuteNewSDKWizard(const SelectedSDKActive: Boolean; const InitialPlatform: string = ''): IOTAPlatformSDK;
    { Shows a dialog to select the platform, the remote profile to connect and the SDK version.
      The return value indicates which PlatformSDK the user selected and the remote profile to connect.
      The return value will be nil if the user cancels out of the dialog. }
    function SelectProfilePlatformDialog(const SelectedSDKActive: Boolean;
      out ProfileToConnect: IOTARemoteProfile; const InitialPlatform: string = ''): IOTAPlatformSDK;
    { Shows a dialog with the platform and the SDK version to select the remote profile to
      attempt to connect to the host machine and process the remote files. }
    function SelectProfileToPullRemoteFiles(const PlatformSDKToPullRemoteFiles: IOTAPlatformSDK): Boolean;
    { Call this to register an IOTAPlatformSDKNotifier. The result is the
      index to be used when calling RemoveNotifier. If <0 then an error occurred. }
    function AddNotifier(const Notifier: IOTAPlatformSDKNotifier): Integer;
    { Show the platform properties dialog }
    function ShowPlatformPropertiesDialog(const AProject: IOTAProject;
      const PlatformName: string; var PlatformSDK: string; var Profile: IOTARemoteProfile): Boolean;
    { Check platform SDK requirement(s) in order to compile the given project for
      the specified platform using SDKs. Return true if requirements are met,
      false if they cannot be met or are not met after prompting the user }
    function EnsurePlatformSDK(const Project: IOTAProject;
      const PlatformName: string; ForCompile: Boolean; var ErrorMessage: string): TOTAPlatformSDKStatus;
    { Returns the Remote profile manager }
    function GetProfileMgr: IOTARemoteProfileServices;
    { Sets the Remote profile manager }
    procedure SetProfileMgr(const Value: IOTARemoteProfileServices);

    property ProfileMgr: IOTARemoteProfileServices read GetProfileMgr write SetProfileMgr;
  end;



function ConfigurationDisplayTitle(const BC: IOTABuildConfiguration; Abbreviate: Boolean): string;

implementation

uses DesignConst;

resourcestring
  sPlatformNotSupported = 'Platform "%s" not supported.';

function ConfigurationDisplayTitle(const BC: IOTABuildConfiguration; Abbreviate: Boolean): string;
var
  S: string;
begin
  if BC.Name = sBaseConfigurationKey then
    Result := sAllConfigurations
  else
    Result := BC.Name + sConfiguration;

  if (BC.Platform = '') and Abbreviate then Exit;

  if BC.Platform = '' then
    S := sAllPlatforms
  else if (BorlandIDEServices as IOTAPlatformServices).PlatformExists(BC.Platform) then
    S := (BorlandIDEServices as IOTAPlatformServices).Platforms[BC.Platform].DisplayName + sPlatform
  else
    S := BC.Platform + sPlatform;

  if (BC.Platform <> '') and Abbreviate then
  begin
    Result := S;
    Exit;
  end;
  Result := Format('%s - %s', [Result, S]);
end;

{ EPlatformNotSupported }

constructor EPlatformNotSupported.Create(const PlatformName: string);
begin
  inherited CreateFmt(sPlatformNotSupported, [PlatformName]);
end;

{ TDeviceLayout }

procedure TOTADeviceLayout.Init;
begin
  Enabled := False;
  Artwork := '';
  Left := 0;
  Top := 0;
  Width := 0;
  Height := 0;
  StatusbarHeight := 0;
end;

end.
