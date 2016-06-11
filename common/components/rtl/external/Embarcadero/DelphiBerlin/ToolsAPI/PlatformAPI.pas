{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit PlatformAPI;

interface

uses
  System.SysUtils, System.Classes, System.Types, ToolsAPI, PlatformConst,
  Vcl.Graphics, Vcl.Forms;

(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform160,0xBD2EAB7F,0x7FB5,0x464A,0x9C,0x97,0x88,0xDA,0x4D,0xC3,0xD1,0xF7);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform170,0xAD0481FA,0x4660,0x48CA,0x87,0x5A,0x57,0xB9,0x05,0x42,0x5E,0xA9);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform180,0xD5033082,0xDC1A,0x45DB,0xA3,0xD6,0xE1,0x26,0x6C,0x76,0xF2,0xCD);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform190,0x48C2471B,0x92E4,0x4728,0xAE,0xE2,0x6B,0xBE,0xA2,0xCA,0x08,0x60);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform200,0xB3E9C246,0x61E8,0x41B9,0x85,0x05,0x56,0x2F,0x54,0x91,0x4B,0x76);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform210,0x266CD60A,0x11EC,0x4DEF,0xB8,0xFB,0x34,0xE5,0x75,0xBB,0xDC,0x99);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform220,0x0D4CE3AB,0xF2D9,0x4AD6,0x90,0xF9,0xE6,0x7D,0x51,0x84,0x41,0x2D);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform230,0x2215945A,0x3D09,0x4750,0x9B,0x95,0xDD,0xE1,0xC5,0xA3,0xE0,0x55);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatform,0x5BF6C6CE,0x0475,0x4B66,0x8A,0xE4,0x5E,0x17,0x5F,0x72,0xB1,0xE6);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformServices160,0x8F20CD96,0x6702,0x43B8,0x87,0x6C,0xC9,0x85,0xC5,0x4C,0x9A,0xFF);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformServices220,0xDD80D595,0xFCCC,0x4764,0x9E,0xF9,0x7C,0x36,0xBA,0x5B,0x11,0xCE);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformServices230,0x775658AD,0x6A87,0x40C9,0x95,0xF0,0x6C,0xDF,0x8A,0x5A,0x83,0xC8);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformServices,0x7144C21F,0xD550,0x451E,0xB6,0x84,0x91,0x89,0xBD,0x21,0xB5,0x3E);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAMobileDevice,0xC1EAA414,0xE8ED,0x4ECB,0xBA,0x30,0x69,0x1F,0xBD,0xEF,0xB6,0x90);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAExternalDevice,0xE45C3DF7,0x2C42,0x4985,0x98,0xB4,0x0E,0xF9,0x8A,0x91,0x56,0x88);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTADesignerOSEntry190,0x5A4CA4AE,0x19BD,0x4F75,0x9A,0x0A,0x83,0xE5,0x64,0x98,0x56,0x4E);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTADesignerOSEntry,0xBBCED617,0x6FE0,0x4EFD,0x82,0x0A,0xC5,0x9B,0x42,0x25,0x88,0xA0);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTADesignerDevice190,0x652602C6,0x8AC6,0x4D1F,0xBB,0x70,0xE3,0x45,0xCE,0x5F,0x05,0x55);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTADesignerDevice220,0xCF55BDDE,0xEBC3,0x48A1,0xB7,0xFF,0xB8,0x43,0xC3,0x92,0x37,0x7B};'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTADesignerDevice,0xE5BED0BD,0x9908,0x47A4,0x80,0x26,0x96,0x86,0xCB,0xA8,0xDD,0x33};'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAMobileDeviceNotifier,0xF9CE8EFC,0xA3A2,0x4BE2,0xB8,0xF2,0x13,0xCD,0x5F,0x58,0xFF,0x41);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAMobileDeviceServices,0x3DAA5A1D,0x5C3B,0x4EA8,0xB4,0xBA,0xA7,0x90,0xE7,0x0D,0x07,0x68);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTADesignerDeviceServices,0x6DB988CC,0xAFEB,0x47CF,0xA3,0x1D,0xE6,0x9D,0xDF,0x6B,0xE0,0x68);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAExternalDeviceNotifier,0x6B4A238B,0x8F43,0x469A,0x98,0x1A,0xAA,0x2E,0x39,0x79,0x80,0x66);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAExternalDeviceServices,0x59CFCEEE,0xF977,0x4303,0x98,0x29,0x54,0xDE,0x3A,0x31,0xFA,0xA5);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAProjectPlatforms160,0xE1C62726,0xBD51,0x4D4E,0xA2,0xF2,0x9A,0x8A,0x59,0xF2,0x72,0xAE);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAProjectPlatforms,0x4A03546D,0x37DD,0x4BDB,0xA5,0x0E,0x8B,0x5A,0xAF,0xB6,0x21,0x2F);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IProjectPlatformInitialize,0x4618AD84,0xCF6D,0x40A7,0x8C,0x2B,0xB0,0x4F,0x35,0x54,0xAD,0x78);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAConnectionCallback,0x7DF7A249,0x4C27,0x4147,0xBF,0xC3,0xCA,0x99,0x59,0x16,0x50,0x43);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfile170,0x328380FA,0x2AB5,0x4F25,0xBC,0xCB,0x7A,0x3F,0x84,0x69,0x1D,0x43);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfile210,0x717C625E,0x8911,0x42A7,0x86,0xA9,0xAC,0xCB,0x57,0xE0,0x07,0xE5);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfile,0x5AB018C2,0x691A,0x4364,0x96,0x1B,0x8B,0x4D,0xBA,0xA7,0xD4,0x88);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileNotifier170,0x84AD7E51,0xE0D0,0x4732,0x87,0x4B,0x05,0xA7,0x0E,0x2B,0xF5,0x34);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileNotifier,0x145453C0,0xAAFE,0x487B,0x86,0xC7,0x7D,0x21,0x71,0xFA,0xF6,0x8F);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileServices160,0xBC86D71D,0x8A31,0x4921,0xA2,0x7F,0x5D,0x32,0xDC,0x3A,0x9A,0x4F);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileServices170,0x5C996765,0x9F24,0x47B1,0xAF,0x80,0x36,0x39,0x4F,0x30,0x69,0xF9);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileServices180,0x6B9557F7,0x32B2,0x4706,0x81,0xFF,0x99,0x5E,0xDA,0x2F,0x31,0x1F);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileServices190,0xC00C8D83,0x2990,0x458A,0x8F,0xA0,0xCD,0x36,0x10,0x91,0xF9,0x24);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTARemoteProfileServices,0x9BF5A1F9,0xCE88,0x4C92,0x89,0x06,0xF1,0x23,0x07,0xD5,0x6F,0xC1);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IPlatformProvisionInformation180,0xA0C2A411,0x2F5E,0x4E97,0xA5,0x8B,0x81,0x0D,0xF6,0x32,0x53,0x62);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IPlatformProvisionInformation220,0x65D61296,0xE20F,0x4F22,0x87,0x9B,0xC5,0xAC,0xB0,0xAA,0x30,0x60);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IPlatformProvisionInformation,0x4AE2C2FA,0x4A38,0x4686,0xB5,0xD4,0x88,0x63,0x5E,0xCD,0xD2,0x92);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IiOSPlatformProvisionAction,0x12EED930,0xE88F,0x44B4,0x8B,0xAB,0xE7,0xF6,0xBC,0xE9,0xEA,0x2E);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDK180,0xDC2B0ADB,0x18BD,0x45D8,0xA6,0x48,0xDC,0x87,0x22,0xEB,0x7C,0x5C);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDK,0x62374BAA,0x7A95,0x4AE1,0xA5,0xE7,0xB6,0xCC,0x35,0x15,0x4E,0xF6);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDKAndroid210,0x4CC4CFFE,0xAF97,0x45C3,0x87,0x4D,0xB1,0xA6,0x13,0xA0,0xED,0x50);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDKAndroid,0x61978519,0xB00A,0x4C41,0xAE,0x9A,0x58,0x9A,0xEC,0x60,0x92,0x18);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDKNotifier,0x3AD83D48,0xBC8B,0x4A6A,0xAA,0x5D,0x53,0x7C,0xC3,0xB7,0x51,0x8B);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDKServices180,0xA41933CA,0x8F86,0x46F3,0x83,0x5B,0x63,0xEF,0x1C,0xAD,0x97,0x83);'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDKServices190,0xDEEC6CA6,0x7027,0x4962,0xA2,0x36,0xA2,0xDF,0x22,0x2F,0x21,0x63};'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDKServices210,0x9A083C9D,0x8CE3,0x43E6,0xB0,0xAB,0xB7,0x0C,0x3F,0xFB,0x83,0x08};'*)
(*$HPPEMIT 'DEFINE_GUID(IID_IOTAPlatformSDKServices,0x6C659F7B,0xFD36,0x478C,0x85,0xC5,0xF2,0x94,0x2C,0x22,0x4F,0xD9};'*)


const
  { Universal platform ids, deprecated }
  cWin32Platform        = PlatformConst.cWin32Platform;
  cWinNX32Platform      = PlatformConst.cWinNX32Platform;
  cWinIoT32Platform     = PlatformConst.cWinIoT32Platform;
  cWinARMPlatform       = PlatformConst.cWinARMPlatform;
  cOSX32Platform        = PlatformConst.cOSX32Platform;
  cWin64Platform        = PlatformConst.cWin64Platform;
  cLinux32Platform      = PlatformConst.cLinux32Platform;
  cLinux64Platform      = PlatformConst.cLinux64Platform;
  cAndroidPlatform      = PlatformConst.cAndroidPlatform;
  ciOSSimulatorPlatform = PlatformConst.ciOSSimulatorPlatform;
  ciOSDevice32Platform  = PlatformConst.ciOSDevice32Platform;
  ciOSDevice64Platform  = PlatformConst.ciOSDevice64Platform;
  ciOSDevicePlatform    = PlatformConst.ciOSDevice32Platform;

  cUndefinedFamilyName = 'Unknown';
  cWindowsFamilyName = 'Windows';
  cOSXFamilyName = 'OSX';
  ciOSFamilyName = 'iOS';
  cAndroidFamilyName = 'Android';
  cLinuxFamilyName = 'Linux';

  AllPlatforms = pidWin32 or pidWin64 or pidOSX32 or pidAndroid or pidiOSSimulator or pidLinux32 or pidiOSDevice32 or pidiOSDevice64 or pidWinARM; // numerical ids from System.Classes

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
  fetDelphiRemoteDebug = 9;
  fetCBuilderRemoteDebug = 10;
  fetDelphiLibraryRemoteDebug = 11;

  { build types}
  btDebug = 0;
  btAdHoc = 1;
  btAppStore = 2;
  btNormal = 3;
  piBTDebug = btDebug + 30;
  piBTAdHoc = btAdHoc + 30;
  piBTAppStore = btAppStore + 30;
  piBTNormal = btNormal + 30;


  cAndroidServiceType = 'AndroidServiceType';
  cSrvTypeLocal = 'Local';
  cSrvTypeRemote = 'Remote';
  cSrvTypeIntentLocal = 'IntentLocal';
  cSrvTypeIntentRemote = 'IntentRemote';

type
  TPlatformSupportsOperation = (
      psVFSPreProcessor,
      psMobile,
      psWindows,
      psFrameworkCopy,
      psiOS,
      psUSBcatch,
      psOSX,
      psAndroid,
      psLinux,
      psRemoteDebugger,
      psClangPCHSupport,
      psRun,
      psDeployment
  );


  TOTAOSFamily = (
    osfWindows,
    osfOSX,
    osfiOS,
    osfAndroid,
    osfLinux,
    osfUndefined
  );

  TOTAOSFamilies = set of TOTAOSFamily;

const
  cOSFamilyDisplayNames: array[Low(TOTAOSFamily)..High(TOTAOSFamily)] of string =
    (cWindowsFamilyName, cOSXFamilyName, ciOSFamilyName, cAndroidFamilyName, cLinuxFamilyName, cUndefinedFamilyName);

type
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

  IOTAPlatform180 = interface(IOTAPlatform170)
    ['{D5033082-DC1A-45DB-A3D6-E1266C76F2CD}']
    { Does this platform require a SDK in order to compile/make/build? }
    function IsSDKRequiredToCompile(const Personality: string): Boolean;
    { Does this platform require a SDK in order to run an application? }
    function IsSDKRequiredToRun(const Personality: string): Boolean;
  end;

  IOTAPlatform190 = interface(IOTAPlatform180)
    ['{48C2471B-92E4-4728-AEE2-6BBEA2CA0860}']
    { Returns the appropriate output file prefix for this platform given
    the project type string (e.g., 'Library', 'CppConsoleApplication' as
    defined in this file }
    function GetOutputFilePrefix(const ApplicationType: string): string;

    property OutputFilePrefix[const ApplicationType: string]: string
      read GetOutputFilePrefix;
  end;

  IOTAPlatform200 = interface(IOTAPlatform190)
    ['{B3E9C246-61E8-41B9-8505-562F54914B76}']
    { Returns the Platform's OS family display name }
    function GetOSFamilyDisplayName: string;
    { Returns the Platform's OS family type }
    function GetOSFamily: TOTAOSFamily;

    property OSFamilyDisplayName: string read GetOSFamilyDisplayName;
    property OSFamily: TOTAOSFamily read GetOSFamily;
  end;

  IOTAPlatform210 = interface(IOTAPlatform200)
    ['{266CD60A-11EC-4DEF-B8FB-34E575BBDC99}']
    { Returns the default deployment remote directory }
    function GetPlatformRemoteDir: string;
  end;

  IOTAPlatform220 = interface(IOTAPlatform210)
    ['{0D4CE3AB-F2D9-4AD6-90F9-E67D5184412D}']
    function GetSDKFamilyName: string;

    property SDKFamilyName: string read GetSDKFamilyName;
  end;

  IOTAPlatform230 = interface(IOTAPlatform220)
    ['{2215945A-3D09-4750-9B95-DDE1C5A3E055}']
    function GetCppPreprocessorToolName(const APlatform: string; IsClangBased: Boolean): string;
  end;

  IOTAPlatform = interface(IOTAPlatform230)
    ['{5BF6C6CE-0475-4B66-8AE4-5E175F72B1E6}']
    function GetPlatformProjectType(const AProject: IOTAProject): string;
    function SupportsPlatformProjectType(const APlatformProjectType: string): Boolean;
    function ProjectTypeSupportsOperation(const APlatformProjectType: string; AOperation: TPlatformSupportsOperation): Boolean;
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

  IOTAPlatformServices220 = interface(IOTAPlatformServices160)
    ['{DD80D595-FCCC-4764-9EF9-7C36BA5B11CE}']
    function PlatformSupports(APlatform: string; AOperation: TPlatformSupportsOperation): Boolean;
  end;

  IOTAPlatformServices230 = interface(IOTAPlatformServices220)
    ['{775658AD-6A87-40C9-95F0-6CDF8A5A83C8}']
    function GetCppPreprocessorToolName(const APlatform: string; IsClangBased: Boolean): string;
  end;

  IOTAPlatformServices = interface(IOTAPlatformServices230)
    ['{7144C21F-D550-451E-B684-9189BD21B53E}']
    function GetPlatformProjectType(const APlatform: string; AProject: IOTAProject): string;
    function SupportsPlatformProjectType(const APlatform: string; APlatformProjectType: string): Boolean;
    function ProjectTypeSupportsOperation(const APlatform: string; APlatformProjectType: string; AOperation: TPlatformSupportsOperation): Boolean;
  end;

  TOTADeviceOrientation = (doPortrait, doUpsideDown, doLandscapeLeft, doLandscapeRight);
  TOTAStatusbarPos = (sbpTop, sbpBottom, sbpLeft, sbpRight);

  TOTADevicePlatform = (dpWindows, dpOSX, dpiOS, dpAndroid, dpLinux, dpUndefined) deprecated 'Use TOTAOSFamily instead';
  TOTADeviceFormFactor = (dffDesktop, dffFullScreen, dffPhone, dffTablet, dffMediaPlayer, dffAutomotive, dffIndustrial, dffEmbedded, dffWatch, dffGlasses);

  TOTADevicePlatforms = set of TOTADevicePlatform deprecated 'Use TOTAOSFamilies instead';
  TOTADeviceFormFactors = set of TOTADeviceFormFactor;

const
  dffPlatforms: TOTADevicePlatforms = [dpWindows, dpOSX, dpiOS, dpAndroid]; // Deprecated
  dffFormFactors: TOTADeviceFormFactors = [dffDesktop, dffFullScreen, dffPhone, dffTablet];
  dffPhoneFactors: TOTADeviceFormFactors = [dffPhone, dffTablet];
  dffWearableFactors: TOTADEviceFormFactors = [dffWatch, dffGlasses];
  dffComputerFactors: TOTADeviceFormFactors = [dffDesktop, dffFullScreen];

type
  TOTADeviceLayout = record
  public
    Enabled: Boolean;
    Artwork: string;
    Mask: string;
    Left: Integer;
    Top: Integer;
    Width: Integer;
    Height: Integer;
    StatusbarHeight: Integer;
    StatusbarPos: TOTAStatusbarPos;
    procedure Init;
  end;

  IOTAMobileDevice = interface(IInterface)
    ['{C1EAA414-E8ED-4ECB-BA30-691FBDEFB690}']
    procedure Assign(const AMobileDevice: IOTAMobileDevice);
    function IsActive: Boolean;
    function IsAvailable(const APlatform: string): Boolean;
    function GetDisplayName: string;
    function GetImageIndex: Integer;
    function GetPlatform: string;
    procedure SetActive(aValue: Boolean);
    function GetSimulatorID: string;
    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetTop: Integer;
    function GetLeft: Integer;
    function GetDPI: Integer;
    function GetArtwork: string;
    function GetUserData: Boolean;
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
  end deprecated 'Not used anymore';

  IOTAExternalDevice = interface(IInterface)
    ['{E45C3DF7-2C42-4985-98B4-0EF98A915688}']
    { Returns the Active value for this device }
    function GetActive: Boolean;
    { Returns device's internal name }
    function GetInternalName: string;
    { Returns the translated display name for the device }
    function GetDisplayName: string;
    { Relative index into the IDE's image list }
    function GetImageIndex: Integer;
    { Returns the internal name for the device }
    function GetPlatform: string;
    { Returns the Simulator ID for this device}
    function GetSimulatorID: string;
    { Determines if the entry can be modified by the user }
    function GetUserData: Boolean;
    { Returns the Profile Name associated to this device if it is available}
    function GetProfileName: string;
    { Returns an emulator port when is connected  }
    function GetPort: string;
    { Returns if the device is an emulator }
    function GetEmulator: Boolean;

    procedure SetActive(const Value: Boolean);
    procedure SetDisplayName(const Value: string);
    procedure SetPlatform(const Value: string);
    procedure SetSimulatorID(const Value: string);
    procedure SetUserData(const Value: Boolean);
    procedure SetProfileName(const Value: string);
    procedure SetPort(const Value: string);
    procedure SetEmulator(const Value: Boolean);

    { Assigns new values for this device }
    procedure Assign(const AMobileDevice: IOTAExternalDevice);

    property Active: Boolean read GetActive write SetActive;
    property InternalName: string read GetInternalName;
    property DisplayName: string read GetDisplayName write SetDisplayName;
    property Platform: string read GetPlatform write SetPlatform;
    property SimulatorID: string read GetSimulatorID write SetSimulatorID;
    property UserData: Boolean read GetUserData write SetUserData;
    property ProfileName: string read GetProfileName write SetProfileName;
    property Port: string read GetPort write SetPort;
    property Emulator: Boolean read GetEmulator write SetEmulator;
  end;

  TOTAExternalDevices = array of IOTAExternalDevice;

  IOTADesignerDevice = interface;

  IOTADesignerDevice190 = interface(IInterface)
  ['{652602C6-8AC6-4D1F-BB70-E345CE5F0555}']
    { Returns if the device is the active one }
    function GetActive: Boolean;
    { Returns device's internal name }
    function GetInternalName: string;
    { Returns the translated display name for the device }
    function GetDisplayName: string;
    { Determines if the device is created by the user or is built-in}
    function GetUserData: Boolean;
    { Deprecated }
    function GetListOrder: Integer; deprecated 'not in use anymore';
    { Determines if the device is kept hidden }
    function GetHide: Boolean;
    { Gets a orientation of the device }
    function GetDeviceLayout(Orientation: TOTADeviceOrientation): TOTADeviceLayout;
    { Deprecated }
    function GetDevicePlatform: TOTADevicePlatform; deprecated 'use IOTADesignerDevice.GetOSFamily instead';
    { Determines the form factor of this device }
    function GetFormFactor: TOTADeviceFormFactor;
    { Gets the path to the thumbnail of the device }
    function GetThumbnail: string; deprecated;

    procedure SetActive(aValue: Boolean);
    procedure SetDisplayName(Value: string);
    procedure SetUserData(Value: Boolean);
    procedure SetListOrder(const Value: Integer); deprecated 'not in use anymore';
    procedure SetHide(const Value: Boolean);
    procedure SetDeviceLayout(Orientation: TOTADeviceOrientation; const Value: TOTADeviceLayout);
    procedure SetDevicePlatform(const Value: TOTADevicePlatform); deprecated 'use IOTADesignerDevice.SetOsFamily instead';
    procedure SetFormFactor(const Value: TOTADeviceFormFactor);
    procedure SetThumbnail(const Value: string); deprecated;

    { Assigns new values for this device }
    procedure Assign(const AMobileDevice: IOTADesignerDevice);
    { Generates a thumbnail from the artwork of the device, returns true if successful }
    function GenerateThumbnail(aBitmap: TBitmap): Boolean;
    { Saves the thumbnail in the path specified by the device info}
    procedure UpdateThumbnail(aBitmap: TBitmap);
    { Loads the device's thumbnail or generates a new one if it cannot be loaded
      Returns True if the thumbnail was generated }
    function LoadThumbnail(aBitmap: TBitmap): Boolean; deprecated;

    property Active: Boolean read GetActive write SetActive;
    property InternalName: string read GetInternalName;
    property DisplayName: string read GetDisplayName write SetDisplayName;
    property UserData: Boolean read GetUserData write SetUserData;
    property ListOrder: Integer read GetListOrder write SetListOrder;
    property Hide: Boolean read GetHide write SetHide;
    property Layouts[Orientation: TOTADeviceOrientation]: TOTADeviceLayout read GetDeviceLayout write SetDeviceLayout;
    property DevicePlatform: TOTADevicePlatform read GetDevicePlatform write SetDevicePlatform;
    property FormFactor: TOTADeviceFormFactor read GetFormFactor write SetFormFactor;
    property Thumbnail: string read GetThumbnail write SetThumbnail;
  end;

  IOTADesignerDevice220 = interface(IOTADesignerDevice190)
    ['{CF55BDDE-EBC3-48A1-B7FF-B843C392377B}']
    function GetOSFamily: TOTAOSFamily;
    procedure SetOSFamily(const Value: TOTAOSFamily);

    property OSFamily: TOTAOSFamily read GetOSFamily write SetOSFamily;
  end;

  IOTADesignerDevice = interface(IOTADesignerDevice220)
    ['{E5BED0BD-9908-47A4-8026-9686CBA8DD33}']
    { Returns the first available orientation of the device }
    function FirstAvailableOrientation: TOTADeviceOrientation;
  end;

  TOTADesignerDevices = array of IOTADesignerDevice;

  IOTADesignerOSEntry190 = interface(IInterface)
    ['{5A4CA4AE-19BD-4F75-9A0A-83E56498564E}']
    function GetName: string;
    function GetDisplayName: string;
    function GetVersion: string;
    function GetOSPlatform: TOTADevicePlatform; deprecated 'Use IOTADesignerOSEntry.GetOSFamily instead';
    procedure SetName(const Value: string);
    procedure SetDisplayName(const Value: string);
    procedure SetVersion(const Value: string);
    procedure SetOSPlatform(const Value: TOTADevicePlatform); deprecated 'Use IOTADesignerOSEntry.SetOSFamily instead';

    property Name: string read GetName write SetName;
    property DisplayName: string read GetDisplayName write SetDisplayName;
    property Version: string read GetVersion write SetVersion;
    property OSPlatform: TOTADevicePlatform read GetOSPlatform write SetOSPlatform;
  end;

  IOTADesignerOSEntry = interface(IOTADesignerOSEntry190)
    ['{BBCED617-6FE0-4EFD-820A-C59B422588A0}']
    function GetOSFamily: TOTAOSFamily;
    procedure SetOSFamily(const Value: TOTAOSFamily);

    property OSFamily: TOTAOSFamily read GetOSFamily write SetOSFamily;
  end;

  TOTADesignerOSList = array of IOTADesignerOSEntry;

  TOTAMobileDeviceChangeAction = (mdcaModified, mdcaDeleted, mdcaAdded, mdcaBatchUpdate);

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
  end deprecated 'Not used anymore';

  IOTADesignerDeviceServices190 = interface(IInterface)
    ['{6DB988CC-AFEB-47CF-A31D-E69DDF6BE068}']
    function CreateDesignerDevice(const AInternalName: string): IOTADesignerDevice;
    { Add a mobile device to the local repository }
    procedure AddDesignerDevice(const ADevice: IOTADesignerDevice);
    { Returns an array of all known mobile devices names }
    function DesignerDeviceNameList: TArray<string>;
    { Given a mobile device name, returns the IOTAMobileDevice instance for that mobile device }
    function GetDesignerDevice(const AName: string): IOTADesignerDevice;
    { Gets the default device }
    function GetDesignerDefaultDevice: IOTADesignerDevice;
    { Sets the default device }
    procedure SetDesignerDefaultDevice(const AName: string);
    { Returns whether or not the mobile device with the specified key exists }
    function DesignerDeviceExists(const ADeviceName: string): Boolean;
    { Remove a mobile device from the local repository }
    procedure RemoveDesignerDevice(const ADeviceName: string);
    { Update a mobile device from the local repository }
    procedure UpdateDesignerDevice(const ADevice: IOTADesignerDevice);
    { Call this to register an IOTANotifier. The result is the index to be
      used when calling RemoveNotifier. If <0 then an error occurred. }
    function AddDesignerDeviceNotifier(const ANotifier: IOTANotifier): Integer;
    { Call with the index obtained from AddNotifier }
    procedure RemoveDesignerDeviceNotifier(Index: Integer);

    property DesignerDevices[const Name: string]: IOTADesignerDevice read GetDesignerDevice; default;
    { Clears the device list }
    procedure ClearDesignerDeviceList;
    { Starts a batch modification state that avoids disk updates }
    procedure BeginDesignerDeviceListUpdate;
    { Ends the batch modification state and saves every change to disk }
    procedure EndDesignerDeviceListUpdate;
    { Ends the batch modification state and cancels the changes}
    procedure CancelDesignerDeviceListUpdate;

    { Deprecated }
    function GetOSByPlatform(APlatform: TOTADevicePlatform): TOTADesignerOSList; deprecated 'Use IOTADesignerDeviceServices.GetOSByFamily instead';
    { Deprecated }
    function GetLastOSVersion(APlatform: TOTADevicePlatform): string; deprecated 'Use IOTADesignerDeviceServices.GetLastOSFamilyVersion instead';
    { Deprecated }
    procedure SetLastOSVersion(APlatform: TOTADevicePlatform; aVersion: string); deprecated 'Use IOTADesignerDeviceServices.SetLastOSFamilyVersion instead';
    { Deprecated }
    function ValidateOSVersion(APlatform: TOTADevicePlatform; aVersion: string): Boolean; deprecated 'Use IOTADesignerDeviceServices.ValidateOSFamilyVersion instead';
  end;

  IOTADesignerDeviceServices = interface(IOTADesignerDeviceServices190)
    ['{FFF44A3C-B434-4E84-A58E-E5CF52DAB09A}']
    { Returns a list of registered operating systems for a determined platform }
    function GetOSByFamily(APlatform: TOTAOSFamily): TOTADesignerOSList;
    { Returns the version of the last OS version used for a determined platform }
    function GetLastOSFamilyVersion(APlatform: TOTAOSFamily): string;
    { Sets the version of the last OS version used for a determined platform }
    procedure SetLastOSFamilyVersion(APlatform: TOTAOSFamily; aVersion: string);
    { Returns true if the platform & OS version pair is valid }
    function ValidateOSFamilyVersion(APlatform: TOTAOSFamily; aVersion: string): Boolean;
  end;

  IOTAExternalDeviceNotifier = interface(IOTANotifier)
    ['{6B4A238B-8F43-469A-981A-AA2E39798066}']
    { Called when a group of external devices with same platform and remote profile are reloaded }
    procedure ExternalDevicesChanged(const APlatform: string; const ARemoteProfileName: string; const ASDKName: string);
    { Starting animation feedback }
    procedure StartAnimation(const APlatform: string; const ARemoteProfileName: string; const ASDKName: string);
    { Stopping animation feedback }
    procedure StopAnimation(const APlatform: string; const ARemoteProfileName: string; const ASDKName: string);
  end;


  IOTAExternalDeviceServices = interface(IInterface)
    ['{59CFCEEE-F977-4303-9829-54DE3A31FAA5}']
    { Gets the SimulatorID for the named Device }
    function GetExternalDeviceSimulatorID(const Name: string): string;
    { Gets every device for a given platform }
    function AvailableExternalDevices(const APlatform: string): TArray<string>;
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

  { Profile Path item expressed as a path, filemask, destination dir, and 
    a flag indicating whether or not to recurse into subdirectories.  All path 
    items will be processed on the remote machine and cached on the local machine.
    PathItems with a PathType other than orptOther will also be passed to
    the C++ compiler and linker.  For orptFramework PathTypes, all headers
    and symbolic information for the framework will always be cached.  If
    IncludeSubDir is True for frameworks, then all other files under the
    framework directory will also be cached locally. }
  TOTARemoteProfilePathItem = record
    Path: string;
    MaskOrFramework: string;
    IncludeSubDir: Boolean;
    DestinationDir: string;
    PathType: TOTARemotePathType;
    Reserved: string;        
  end;

  { Dynamic array of profile path items }
  TOTARemoteProfilePathArray = array of TOTARemoteProfilePathItem;

  { Profile Credential expressed as a password or passfile, and a flag indicating which.
    IsEncrypted flag is used to indicate whether the password has been encrypted. }
  TOTARemoteProfileCredential = record
    PasswordOrPassFile: string;
    IsPassword: Boolean;
    IsEncrypted: Boolean;
    procedure Init;
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

  IOTARemoteProfile210 = interface(IOTARemoteProfile170)
    ['{717C625E-8911-42A7-86A9-ACCB57E007E5}']
    { Gets the array of the SDK's info }
    function GetSDKs(const PlatformName: string; out ErrorMessage: string): TOTASDKInfoArray;
    { Gets the Developer program ID from remote machine }
    function GetDeveloperTeamID(const MobileProvisionFile: string; out Errormessage: string): string;
  end;

  TEntitlement = record
    AppIdentifier: string;
    KeychainAccess: TStringDynArray;
    ExtraKeyValues: TStringDynArray;
  end;

  TProvisionProfileInfo = record
    Name: string;
    Path: string;
    TeamID: string;
    TeamName: string;
    UUID: string;
    Devices: TStringDynArray;
    Certificates: TStringDynArray;
    Entitlements: TEntitlement;
  end;
  TProvisionProfileInfoArray = array of TProvisionProfileInfo;

  IOTARemoteProfile = interface(IOTARemoteProfile210)
    ['{5AB018C2-691A-4364-961B-8B4DBAA7D488}']
    { Gets all info relative to provision profiles and certificates}
    function GetProvisionProfiles(DeviceId: string; Kind: integer; out ErrorMessage: string): TProvisionProfileInfoArray;
  end;

  TOTARemoteProfileStatus = (orpsOk, orpsNotFound, orpsNotAssigned);
  TOTADeviceStatus = (odsOk, odsCancel, odsNotAssigned);

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

  IOTARemoteProfileServices180 = interface(IOTARemoteProfileServices170)
    ['{6B9557F7-32B2-4706-81FF-995EDA2F311F}']
    { Adds a new profile, saves it in the registry and creates the profile file.
      If the profile specified exists this function updates the profile's values. }
    procedure MergeRemoteProfile(const Profile: IOTARemoteProfile);
  end;

  IOTARemoteProfileServices190 = interface(IOTARemoteProfileServices180)
    ['{C00C8D83-2990-458A-8FA0-CD361091F924}']
    { Attempts to connect to a remote machine using the specified profile and
      returns Android application launcher. Set Debug to True if you want launcher
      to run the app in debug mode }
    function GetAndroidLauncher(const Profile: IOTARemoteProfile; const DeviceId: string;
      Debug: Boolean = False; ConnectionCallBack: IOTAConnectionCallback = nil): string;
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
      the actual process id, CommandFile may contain extra information about the
      process }
    function Run(const Profile: IOTARemoteProfile;
      const PathUnderScratchDir: string; const ExeName: string;
      const Params: string; const Launcher: string; const WorkingDir: string;
      const EnvList: TStrings; const UserName: string;
      out ErrorMessage: string; out Pid: Integer; out CommandFile: string;
      ConnectionCallback: IOTAConnectionCallback = nil): Boolean; overload;
    procedure Refresh;
  end;

  IOTARemoteProfileServices230 = interface(IOTARemoteProfileServices190)
    ['{9BF5A1F9-CE88-4C92-8906-F12307D56FC1}']
    { Check device requirement(s) in order to run the given project. Return
      odsOk if requirements are met, odsNotAssigned if device does not exist or
      odsCancel if cancel operation selected after prompting the user }
    function EnsureDeviceForRun(const Project: IOTAProject; const PlatformName: string;
      var ErrorMessage: string; var HelpContext: integer): TOTADeviceStatus;
  end;

  IOTARemoteProfileServices = interface(IOTARemoteProfileServices230)
    ['{AF6D9681-143F-48FD-AC78-418DFCF6BAC8}']
    function EnsureProvisioningInformation(const Project: IOTAProject): Boolean;
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

  IPlatformProvisionInformation180 = interface
    ['{A0C2A411-2F5E-4E97-A58B-810DF6325362}']
    function GetBuildTypes: TArray<TOTABuildTypeConfig>; deprecated 'Use IPlatformProvisionInformation.AllBuildTypes instead';
    { Returns a detailed list of BuildType items by platform }
  end;

  IPlatformSpecificBuildAction = interface
    ['{4C87E6BA-E248-40D8-9BDA-E8A1AAFE5B8E}']
    { Launches a specific platform build action }
    procedure DoBuildAction(const AProject: IOTAProject; CompileMode: TOTACompileMode);
  end;

  IPlatformProvisionInformation220 = interface//(IPlatformProvisionInformation180)
    ['{65D61296-E20F-4F22-879B-C5ACB0AA3060}']
    function AllBuildTypes: TArray<string>;
    { Returns a list of BuildType names by Platform }
    function GetBuildTypeDisplayName(const ABuildType: string): string;
    { Returns the localized name of a BuildType }
    function GetBuildTypeImageIndex(const ABuildType: string): Integer;
    { Returns the Image Index of a BuildType }
    function GetBuildTypeKey(const ABuildType: string): string;
    { Returns a key to be used internally for a BuildType names by platform }
    function GetBuildTypeFrame(const ABuildType: string): TCustomFrameClass;
    { Returns a Frame to be used for user options entries }
    function AllBuildTypeProperties(const ABuildType: string): TArray<string>;
    { Returns a list of build types properties by BuildType }
    function GetEnvironmentKey(const ABuildType: string; const ABuildTypeProperty: string): string;
    { Returns a key to be used internally for a BuildType }
    function GetProjectOptionKey(const ABuildType: string; const ABuildTypeProperty: string): string;
    { Returns a key to be used internally for a BuildType }
  end;

  IPlatformProvisionInformation = interface(IPlatformProvisionInformation220)
    ['{4AE2C2FA-4A38-4686-B5D4-88635ECDD292}']
    function GetBuildTypeFinalExtension(const ABuildType: string): string;
    { Returns file extension for a final output file according to the build type }
    function GetBuildTypeAllowRun(const ABuildType: string): Boolean;
    { Returns True if build type passed allows execution in Device }
    property BuildTypeAllowRun[const ABuildType: string]: Boolean read GetBuildTypeAllowRun;
    { Returns True if build type passed allows execution in Device }
    property BuildTypeFinalExtension[const ABuildType: string]: string read GetBuildTypeFinalExtension;
    { Returns file extension for a final output file according to the build type }
  end;

  IiOSPlatformProvisionAction = interface
    ['{12EED930-E88F-44B4-8BAB-E7F6BCE9EA2E}']
    function CheckProvision(const Project: IOTAProject; out ErrMsg: string): Boolean;
    { Checks the current provisioning configuration and prepares the project to be signed and launched.
    This function does not modify the project, but will change if it is necessary the environment-info
    about signing a project before compiling}
  end;


  TOTAPlatformSDKStatus = (opssOk, opssNotFound, opssNotAssigned, opssNoFiles, opssOutOfDate);

  IOTAPlatformSDK180 = interface
    ['{DC2B0ADB-18BD-45D8-A648-DC8722EB7C5C}']
    { Returns the internal name of the SDK }
    function GetName: string;
    { Returns the display name of the SDK }
    function GetDisplayName: string;
    { Returns the version of the SDK }
    function GetVersion: string;
    { Returns the name of the platform for this SDK }
    function GetPlatformName: string;
    { Returns the system root directory for this SDK }
    function GetSystemRoot: string;
    { Returns the default SDK }
    function GetIsDefault: Boolean;
    { Returns the build version of the SDK }
    function GetBuildVersion: string; deprecated 'Use IOTAPlatformSDKOSX.GetBuildVersion instead';
    { Returns the XCode build version of the SDK }
    function GetXCodeBuildVersion: string; deprecated 'Use IOTAPlatformSDKOSX.GetXCodeBuildVersion instead';
    { Returns the framework root directories for this SDK }
    function GetFrameworkRoot: string; deprecated 'Use IOTAPlatformSDKOSX.GetFrameworkRoot instead';
    { Returns the array of remote paths for this SDK }
    function GetPaths: TOTARemoteProfilePathArray; deprecated 'Use IOTAPlatformSDKOSX.GetPaths instead';
    { Returns the remote path for this SDK }
    function GetRemotePath: string; deprecated 'Use IOTAPlatformSDKOSX.GetRemotePath instead';

    { Sets the internal name of the SDK }
    procedure SetName(const Value: string);
    { Sets the display name of the SDK }
    procedure SetDisplayName(const Value: string);
    { Sets the version of the SDK }
    procedure SetVersion(const Value: string);
    { Sets the name of the platform for this SDK }
    procedure SetPlatformName(const Value: string);
    { Sets the system root directory for this SDK }
    procedure SetSystemRoot(const Value: string);
    { Sets the default SDK }
    procedure SetIsDefault(const Value: Boolean);
    { Sets the build version of the SDK }
    procedure SetBuildVersion(const Value: string); deprecated 'Use IOTAPlatformSDKOSX.SetBuildVersion instead';
    { Sets the XCode build version of the SDK }
    procedure SetXCodeBuildVersion(const Value: string); deprecated 'Use IOTAPlatformSDKOSX.SetXCodeBuildVersion instead';
    { Sets the framework root directories for this SDK }
    procedure SetFrameworkRoot(const Value: string); deprecated 'Use IOTAPlatformSDKOSX.SetFrameworkRoot instead';
    { Sets the array of remote paths for this SDK }
    procedure SetPaths(const Value: TOTARemoteProfilePathArray); deprecated 'Use IOTAPlatformSDKOSX.SetPaths instead';
    { Sets the remote path for this SDK }
    procedure SetRemotePath(const Value: string); deprecated 'Use IOTAPlatformSDKOSX.SetRemotePath instead';

    { BeginUpdate/EndUpdate allow the caller to set multiple properties of the
      SDK, without sending a IOTAPlatformSDKNotifier for each individual
      change.  Call BeginUpdate before setting any properties, and then a single
      notification will be sent after EndUpdate is called. }
    procedure BeginUpdate;
    procedure EndUpdate;

    property Name: string read GetName write SetName;
    property DisplayName: string read GetDisplayName write SetDisplayName;
    property Version: string read GetVersion write SetVersion;
    property PlatformName: string read GetPlatformName write SetPlatformName;
    property SystemRoot: string read GetSystemRoot write SetSystemRoot;
    property IsDefault: Boolean read GetIsDefault write SetIsDefault;
    property BuildVersion: string read GetBuildVersion write SetBuildVersion; // Deprecated
    property XCodeBuildVersion: string read GetXCodeBuildVersion write SetXCodeBuildVersion; // Deprecated
    property FrameworkRoot: string read GetFrameworkRoot write SetFrameworkRoot; // Deprecated
    property Paths: TOTARemoteProfilePathArray read GetPaths write SetPaths; // Deprecated
    property RemotePath: string read GetRemotePath write SetRemotePath; // Deprecated
  end;

  IOTAPlatformSDK = interface(IOTAPlatformSDK180)
    ['{62374BAA-7A95-4AE1-A5E7-B6CC35154EF6}']
    { Assigns the new values for this Platform SDK }
    procedure Assign(const PlatformSDK: IOTAPlatformSDK);
  end;

  IOTAPlatformSDKOSX = interface(IOTAPlatformSDK)
    ['{78FB1115-144C-4CC3-ABB5-50AF3A3EF58D}']
    { Returns the build version of the SDK }
    function GetBuildVersion: string;
    { Returns the XCode build version of the SDK }
    function GetXCodeBuildVersion: string;
    { Returns the framework root directories for this SDK }
    function GetFrameworkRoot: string;
    { Returns the array of remote paths for this SDK }
    function GetPaths: TOTARemoteProfilePathArray;
    { Returns the remote path for this SDK }
    function GetRemotePath: string;
    { Sets the build version of the SDK }
    procedure SetBuildVersion(const Value: string);
    { Sets the XCode build version of the SDK }
    procedure SetXCodeBuildVersion(const Value: string);
    { Sets the framework root directories for this SDK }
    procedure SetFrameworkRoot(const Value: string);
    { Sets the array of remote paths for this SDK }
    procedure SetPaths(const Value: TOTARemoteProfilePathArray);
    { Sets the remote path for this SDK }
    procedure SetRemotePath(const Value: string);

    { Assigns the new values for this Platform SDK for OSX }
    procedure Assign(const PlatformSDK: IOTAPlatformSDK);

    property BuildVersion: string read GetBuildVersion write SetBuildVersion;
    property XCodeBuildVersion: string read GetXCodeBuildVersion write SetXCodeBuildVersion;
    property FrameworkRoot: string read GetFrameworkRoot write SetFrameworkRoot;
    property Paths: TOTARemoteProfilePathArray read GetPaths write SetPaths;
    property RemotePath: string read GetRemotePath write SetRemotePath;
  end;

  IOTAPlatformSDKAndroid210 = interface(IOTAPlatformSDK)
    ['{4CC4CFFE-AF97-45C3-874D-B1A613A0ED50}']
    { Returns the NDK base path of the SDK }
    function GetNDKBasePath: string;
    { Returns the arm-linux linker of the SDK }
    function GetNDKArmLinuxAndroidFile: string;
    { Returns the arm-linux strip of the SDK }
    function GetNDKArmLinuxAndroidStripFile: string;
    { Returns the NDK platform API of the SDK }
    function GetNDKApiPath: string;
    { Returns the NDK GdbServer of the SDK }
    function GetNDKGdbServerPath: string;
    { Returns the ZipAlign.exe tool of the SDK }
    function GetSDKZipAlignPath: string;
    { Returns the Android.bat tool of the SDK }
    function GetSDKAndroidPath: string;
    { Returns the Adb.exe tool of the SDK }
    function GetSDKAdbPath: string;
    { Returns the Aapt.exe tool of the SDK }
    function GetSDKAaptPath: string;
    { Returns the API Level of the SDK }
    function GetSDKApiLevel: string;
    { Returns the Java JDK base path of the SDK }
    function GetJDKPath: string;
    { Returns the Jarsigner tool of the SDK }
    function GetJDKJarsignerPath: string;
    { Returns the KeyTool tool of the SDK }
    function GetJDKKeyToolPath: string;
    { Returns the Library path for Delphi of the SDK }
    function GetDelphiNDKLibraryPath: string;
    { Returns the Library path for C++ Builder of the SDK }
    function GetCBuilderNDKLibraryPath: string;
    { Sets the NDK base path of the SDK }
    procedure SetNDKBasePath(const Value: string);
    { Sets the arm-linux linker of the SDK }
    procedure SetNDKArmLinuxAndroidFile(const Value: string);
    { Sets the arm-linux strip of the SDK }
    procedure SetNDKArmLinuxAndroidStripFile(const Value: string);
    { Sets the NDK platform API of the SDK }
    procedure SetNDKApiPath(const Value: string);
    { Sets the NDK GdbServer of the SDK }
    procedure SetNDKGdbServerPath(const Value: string);
    { Sets the ZipAlign.exe tool of the SDK }
    procedure SetSDKZipAlignPath(const Value: string);
    { Sets the Android.bat tool of the SDK }
    procedure SetSDKAndroidPath(const Value: string);
    { Sets the Adb.exe tool of the SDK }
    procedure SetSDKAdbPath(const Value: string);
    { Sets the Aapt.exe tool of the SDK }
    procedure SetSDKAaptPath(const Value: string);
    { Sets the API Level of the SDK }
    procedure SetSDKApiLevel(const Value: string);
    { Sets the Java JDK base path of the SDK }
    procedure SetJDKPath(const Value: string);
    { Sets the Jarsigner tool of the SDK }
    procedure SetJDKJarsignerPath(const Value: string);
    { Sets the KeyTool tool of the SDK }
    procedure SetJDKKeyToolPath(const Value: string);
    { Sets the Library path for Delphi of the SDK }
    procedure SetDelphiNDKLibraryPath(const Value: string);
    { Sets the Library path for C++Builder of the SDK }
    procedure SetCBuilderNDKLibraryPath(const Value: string);
    { Assigns the new values for this Platform SDK for Android }
    procedure Assign(const PlatformSDK: IOTAPlatformSDK);

    property NDKBasePath: string read GetNDKBasePath write SetNDKBasePath;
    property NDKArmLinuxAndroidFile: string read GetNDKArmLinuxAndroidFile write SetNDKArmLinuxAndroidFile;
    property NDKArmLinuxAndroidStripFile: string read GetNDKArmLinuxAndroidStripFile write SetNDKArmLinuxAndroidStripFile;
    property NDKApiPath: string read GetNDKApiPath write SetNDKApiPath;
    property NDKGdbServerPath: string read GetNDKGdbServerPath write SetNDKGdbServerPath;
    property SDKZipAlignPath: string read GetSDKZipAlignPath write SetSDKZipAlignPath;
    property SDKAndroidPath: string read GetSDKAndroidPath write SetSDKAndroidPath;
    property SDKAdbPath: string read GetSDKAdbPath write SetSDKAdbPath;
    property SDKAaptPath: string read GetSDKAaptPath write SetSDKAaptPath;
    property SDKApiLevel: string read GetSDKApiLevel write SetSDKApiLevel;
    property JDKPath: string read GetJDKPath write SetJDKPath;
    property JDKJarsignerPath: string read GetJDKJarsignerPath write SetJDKJarsignerPath;
    property JDKKeyToolPath: string read GetJDKKeyToolPath write SetJDKKeyToolPath;
    property DelphiNDKLibraryPath: string read GetDelphiNDKLibraryPath write SetDelphiNDKLibraryPath;
    property CBuilderNDKLibraryPath: string read GetCBuilderNDKLibraryPath write SetCBuilderNDKLibraryPath;
  end;

  IOTAPlatformSDKAndroid = interface(IOTAPlatformSDKAndroid210)
    ['{61978519-B00A-4C41-AE9A-589AEC609218}']
    { Autodetects the SDK, NDK and JDK paths and their tools from the SysRoot(for SDK), NDKBasePath and JDKPath }
    function AutoDetectPaths: Boolean;
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

  TDeviceType = (dtEmulator = 0, dtDevice = 1, dtSimulator = 2);
  TDeviceRecord = record
    Kind: TDeviceType;
    Id: string;
    Name: string;
    Target: string;
    Connected: Boolean;
    Online: Boolean;
    Platform: string;
    ProfileName: string;
    Height: Integer;
    Width: Integer;
    Density: Integer;
    DiagonalSize: Double;
  end;

  IOTAPlatformSDKServices180 = interface(IInterface)
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
    procedure SetAsDefaultForPlatform(const PlatformSDK: IOTAPlatformSDK); overload;
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
      const RemotePath: string; const IsDefault: Boolean): IOTAPlatformSDK; deprecated;
    { Opens up the Options dialog, selects the "SDK Manager" options page,
      and focuses the specified SDK, allowing the user to edit it }
    procedure EditPlatformSDK(const Name: string);
    { Removes the specified SDK }
    procedure RemovePlatformSDK(const PlatformSDK: IOTAPlatformSDK); overload;
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
    function SelectProfileToPullRemoteFiles(const PlatformSDKToPullRemoteFiles: IOTAPlatformSDK): Boolean; overload;
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
      const PlatformName: string; ForCompile: Boolean; var ErrorMessage: string): TOTAPlatformSDKStatus; deprecated;
    { Returns the Remote profile manager }
    function GetProfileMgr: IOTARemoteProfileServices;
    { Sets the Remote profile manager }
    procedure SetProfileMgr(const Value: IOTARemoteProfileServices);

    property ProfileMgr: IOTARemoteProfileServices read GetProfileMgr write SetProfileMgr;
  end;

  IOTAPlatformSDKServices190 = interface(IOTAPlatformSDKServices180)
    ['{DEEC6CA6-7027-4962-A236-A2DF222F2163}']
    { Adds a new SDK depending on the specified platform type }
    function AddPlatformSDK(const PlatformName: string; const IsDefault: Boolean): IOTAPlatformSDK; overload;
    { Adds a new SDK and assigns the new values from the specified PlatformSDK }
    function AddPlatformSDK(const PlatformSDK: IOTAPlatformSDK): IOTAPlatformSDK; overload;
    { Getting devices from PAClient by Platform, SDK and RemoteProfile }
    function AllDevicesFromPAClient(const APlatform: string ; const ARemoteProfileName: string = ''; const ASDKName: string = ''; const AVerboseMode: Boolean = False): TArray<TDeviceRecord>;
    { Check platform SDK requirement(s) in order to compile the given project for
      the specified platform using SDKs. Return true if requirements are met,
      false if they cannot be met or are not met after prompting the user }
    function EnsurePlatformSDK(const Project: IOTAProject;
      const PlatformName: string; ForCompile: Boolean; var ErrorMessage: string; var HelpContext: integer): TOTAPlatformSDKStatus; overload;
  end;

  IOTAPlatformSDKServices210 = interface(IOTAPlatformSDKServices190)
    ['{9A083C9D-8CE3-43E6-B0AB-B70C3FFB8308}']
    { Function overloaded with the RemotProfileToConnect. It is an output and input
      parameter to set the remote profile before showing the dialog and get it. }
    function ExecuteNewSDKWizard(const SelectedSDKActive: Boolean; var RemoteProfileToConnect: IOTARemoteProfile;
      const InitialPlatform: string = ''): IOTAPlatformSDK; overload;
    { Call with the index obtained from AddNotifier }
    procedure RemoveNotifier(Index: Integer);
  end;

  IOTAPlatformSDKServices = interface(IOTAPlatformSDKServices210)
    ['{6C659F7B-FD36-478C-85C5-F2942C224FD9}']
    { Adds a new SDK depending on the specified platform type and it sets an IOTAPlatformSDK instance instead of creating a new one }
    function AddPlatformSDK(const PlatformName: string; const IsDefault: Boolean;
      const PlatformSDK: IOTAPlatformSDK): IOTAPlatformSDK; overload;
    { Returns the specified SDK depending on the specified platform type. Returns nil if the SDK does not exist }
    function GetPlatformSDK(const PlatformSDK: IOTAPlatformSDK; const PlatformName: string): IOTAPlatformSDK; overload;
    { Sets the specified SDK as the default for its platform depending on the specified platform type }
    procedure SetAsDefaultForPlatform(const PlatformSDK: IOTAPlatformSDK; const PlatformName: string); overload;
    { Removes the specified SDK depending on the specified platform type }
    procedure RemovePlatformSDK(const PlatformSDK: IOTAPlatformSDK; const PlatformName: string); overload;
    { Checks if a PlatformName is in a platform name group. This function is useful when a PlatformSDK is shared for several Platforms.
      Before performing some actions with the SDK, we can ensure that the platform is contained in the specified group. }
    function PlatformNameExists(const PlatformNameGroup: string; const PlatformName: string): Boolean;
    { Shows a dialog by Platform Name with the platform and the SDK version to select the remote profile to
      attempt to connect to the host machine and process the remote files. }
    function SelectProfileToPullRemoteFiles(const PlatformSDKToPullRemoteFiles: IOTAPlatformSDK; const PlatformName: string): Boolean; overload;
    { Updates the changes made by any operation (AddPlatformSDK, RemovePlatformSDK) }
    procedure UpdateChanges;
  end;

  IPlatformContainerCreator = interface
    ['{29EF0235-029D-4994-84B0-081C10F205D8}']
    function GetPlatformContainer(const AModelContainer: IInterface; const AProject: IInterface; const AGraphParent: IInterface): IInterfaceList;
    function GetPlatformContainerId: TArray<string>;
  end;

  IPlatformContainerCategoryCreator = interface
    ['{EEA5DA06-C1CA-4E64-8D25-49B986E80076}']
    function GetPlatformContainerCategories(const AModelContainer: IInterface; const AProject: IInterface; const AGraphParent: IInterface): IInterfaceList;
    function GetPlatformContainerCategoriesId: TArray<string>;
  end;

  IPlatformResources = interface
    ['{E3F87885-E37A-4B98-B5CC-03F4EA7D0C2C}']
    function FindPlatformResource(const AName: string): THandle;
    function LoadPlatformResourceStream(const AName: string): TStream;
  end;

  IOTAAndroidServicesManager = interface(IInterface)
    ['{4C4F6CEE-CA06-46D6-9114-B22FA4F7E771}']
    function ExecuteAddServiceWizard(const AProject: IOTAProject; const ServiceProjectBasePath: string = ''): Boolean;
    function ExecuteRemoveServicesWizard(const AProject: IOTAProject): Boolean;
  end;

function ConfigurationDisplayTitle(const BC: IOTABuildConfiguration; Abbreviate: Boolean): string;

implementation

uses
  DesignConst;

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


{ TOTARemoteProfileCredential }

procedure TOTARemoteProfileCredential.Init;
begin
  IsEncrypted := False;
  IsPassword := True;
  PasswordOrPassFile := '';
end;

{ TDeviceLayout }

procedure TOTADeviceLayout.Init;
begin
  Enabled := False;
  Artwork := string.Empty;
  Mask := string.Empty;
  Left := 0;
  Top := 0;
  Width := 0;
  Height := 0;
  StatusbarHeight := 0;
  StatusbarPos := sbpTop;
end;

end.
