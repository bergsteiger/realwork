{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ File: userenv.h                                       }
{                                                       }
{         Copyright (C) Microsoft Corporation.          }
{         All Rights Reserved.                          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{      Win32 User Environment API Interface Unit        }
{*******************************************************}
unit Winapi.UserEnv;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses
  Winapi.Windows,
  Winapi.Wbem,
  Winapi.ActiveX;

(*$HPPEMIT '#include "userenv.h"'*)
(*$HPPEMIT '#ifndef _WIN64'*)
(*$HPPEMIT '#pragma link "userenv.lib"'*)
(*$HPPEMIT '#endif'*)

{ Translated from 'userenv.h' }

// Translation of #defines
const
  PI_NOUI        = $00000001;  // Prevents displaying of messages
  {$EXTERNALSYM PI_NOUI}
  PI_APPLYPOLICY = $00000002;  // Apply NT4 style policy
  {$EXTERNALSYM PI_APPLYPOLICY}

//
// Flags that can be set in the dwFlags field
//
  PT_TEMPORARY    = $00000001;      // A profile has been allocated that will be deleted at logoff.
  {$EXTERNALSYM PT_TEMPORARY}
  PT_ROAMING      = $00000002;      // The loaded profile is a roaming profile.
  {$EXTERNALSYM PT_ROAMING}
  PT_MANDATORY    = $00000004;      // The loaded profile is mandatory.
  {$EXTERNALSYM PT_MANDATORY}

//
// RefreshPolicy Flags
//
  RP_FORCE        = 1;      // Refresh policies without any optimisations.
  {$EXTERNALSYM RP_FORCE}
  RP_SYNC         = 2;      // Refresh Policy sync; the call does not return till the time policy processing is completed
  {$EXTERNALSYM RP_SYNC}

//
// GPOptions flags
//
  GPC_BLOCK_POLICY = $00000001;  // Block all non-forced policy from above
  {$EXTERNALSYM GPC_BLOCK_POLICY}

//
// Options for a GPO link
//
  GPO_FLAG_DISABLE = $00000001;  // This GPO is disabled
  {$EXTERNALSYM GPO_FLAG_DISABLE}
  GPO_FLAG_FORCE   = $00000002;  // Don't override the settings in this GPO with settings from a GPO below it.
  {$EXTERNALSYM GPO_FLAG_FORCE}

//
// dwFlags for GetGPOList()
//
  GPO_LIST_FLAG_MACHINE            = $00000001;  // Return machine policy information
  {$EXTERNALSYM GPO_LIST_FLAG_MACHINE}
  GPO_LIST_FLAG_SITEONLY           = $00000002;  // Return site policy information only
  {$EXTERNALSYM GPO_LIST_FLAG_SITEONLY}
  GPO_LIST_FLAG_NO_WMIFILTERS      = $00000004;  // Ignore WMI filters when filtering GPO's
  {$EXTERNALSYM GPO_LIST_FLAG_NO_WMIFILTERS}
  GPO_LIST_FLAG_NO_SECURITYFILTERS = $00000008; // Ignore security filters
  {$EXTERNALSYM GPO_LIST_FLAG_NO_SECURITYFILTERS}

//
// Some String constants
//
  GP_DLLNAME                       =  'DllName';
  {$EXTERNALSYM GP_DLLNAME}
  GP_ENABLEASYNCHRONOUSPROCESSING  =  'EnableAsynchronousProcessing';
  {$EXTERNALSYM GP_ENABLEASYNCHRONOUSPROCESSING}
  GP_MAXNOGPOLISTCHANGESINTERVAL   =  'MaxNoGPOListChangesInterval';
  {$EXTERNALSYM GP_MAXNOGPOLISTCHANGESINTERVAL}
  GP_NOBACKGROUNDPOLICY            =  'NoBackgroundPolicy';
  {$EXTERNALSYM GP_NOBACKGROUNDPOLICY}
  GP_NOGPOLISTCHANGES              =  'NoGPOListChanges';
  {$EXTERNALSYM GP_NOGPOLISTCHANGES}
  GP_NOMACHINEPOLICY               =  'NoMachinePolicy';
  {$EXTERNALSYM GP_NOMACHINEPOLICY}
  GP_NOSLOWLINK                    =  'NoSlowLink';
  {$EXTERNALSYM GP_NOSLOWLINK}
  GP_NOTIFYLINKTRANSITION          =  'NotifyLinkTransition';
  {$EXTERNALSYM GP_NOTIFYLINKTRANSITION}
  GP_NOUSERPOLICY                  =  'NoUserPolicy';
  {$EXTERNALSYM GP_NOUSERPOLICY}
  GP_PERUSERLOCALSETTINGS          =  'PerUserLocalSettings';
  {$EXTERNALSYM GP_PERUSERLOCALSETTINGS}
  GP_PROCESSGROUPPOLICY            =  'ProcessGroupPolicy';
  {$EXTERNALSYM GP_PROCESSGROUPPOLICY}
  GP_REQUIRESSUCCESSFULREGISTRY    =  'RequiresSuccessfulRegistry';
  {$EXTERNALSYM GP_REQUIRESSUCCESSFULREGISTRY}

//
// GPO_INFO_FLAGS
//
  GPO_INFO_FLAG_MACHINE            = $00000001;  // Apply machine policy rather than user policy
  {$EXTERNALSYM GPO_INFO_FLAG_MACHINE}
  GPO_INFO_FLAG_BACKGROUND         = $00000010;  // Background refresh of policy (ok to do slow stuff)
  {$EXTERNALSYM GPO_INFO_FLAG_BACKGROUND}
  GPO_INFO_FLAG_SLOWLINK           = $00000020;  // Policy is being applied across a slow link
  {$EXTERNALSYM GPO_INFO_FLAG_SLOWLINK}
  GPO_INFO_FLAG_VERBOSE            = $00000040;  // Verbose output to the eventlog
  {$EXTERNALSYM GPO_INFO_FLAG_VERBOSE}
  GPO_INFO_FLAG_NOCHANGES          = $00000080;  // No changes were detected to the Group Policy Objects
  {$EXTERNALSYM GPO_INFO_FLAG_NOCHANGES}
  GPO_INFO_FLAG_LINKTRANSITION     = $00000100;  // A change in link speed was detected between previous policy
                                                 // application and current policy application
  {$EXTERNALSYM GPO_INFO_FLAG_LINKTRANSITION}
  GPO_INFO_FLAG_LOGRSOP_TRANSITION = $00000200;  // A Change in Rsop Logging was detected between previous policy
                                                 // application and current policy application, (new intf only)
  {$EXTERNALSYM GPO_INFO_FLAG_LOGRSOP_TRANSITION}
  GPO_INFO_FLAG_FORCED_REFRESH     = $00000400;  // Forced Refresh is being applied. redo policies.
  {$EXTERNALSYM GPO_INFO_FLAG_FORCED_REFRESH}
  GPO_INFO_FLAG_SAFEMODE_BOOT      = $00000800;  // windows safe mode boot flag
  {$EXTERNALSYM GPO_INFO_FLAG_SAFEMODE_BOOT}
  GPO_INFO_FLAG_ASYNC_FOREGROUND   = $00001000;  // Asynchronous foreground refresh of policy
  {$EXTERNALSYM GPO_INFO_FLAG_ASYNC_FOREGROUND}


//
// Translation of types and structues
//
type
  _PROFILEINFOA = record
    dwSize: DWORD;
    dwFlags: DWORD;
    lpUserName: LPSTR;
    lpProfilePath: LPSTR;
    lpDefaultPath: LPSTR;
    lpServerName: LPSTR;
    lpPolicyPath: LPSTR;
    hProfile: THandle;
  end;
  {$EXTERNALSYM _PROFILEINFOA}

  _PROFILEINFOW = record
    dwSize: DWORD;
    dwFlags: DWORD;
    lpUserName: LPWSTR;
    lpProfilePath: LPWSTR;
    lpDefaultPath: LPWSTR;
    lpServerName: LPWSTR;
    lpPolicyPath: LPWSTR;
    hProfile: THandle;
  end;
  {$EXTERNALSYM _PROFILEINFOW}

  _PROFILEINFO = _PROFILEINFOW;
  PROFILEINFOA = _PROFILEINFOA;
  {$EXTERNALSYM PROFILEINFOA}
  PROFILEINFOW = _PROFILEINFOW;
  {$EXTERNALSYM PROFILEINFOW}
  PROFILEINFO = PROFILEINFOW;

  LPPROFILEINFOA = ^_PROFILEINFOA;
  {$EXTERNALSYM LPPROFILEINFOA}
  LPPROFILEINFOW = ^_PROFILEINFOW;
  {$EXTERNALSYM LPPROFILEINFOW}
  LPPROFILEINFO = LPPROFILEINFOW;

  PProfileInfoA = ^PROFILEINFOA;
  PProfileInfoW = ^PROFILEINFOW;
  PProfileInfo = PProfileInfoW;

  TProfileInfoA = PROFILEINFOA;
  TProfileInfoW = PROFILEINFOW;
  TProfileInfo = TProfileInfoW;

//
// Each Group Policy Object is associated (linked) with a site, domain,
// organizational unit, or machine.
//
type
  _GPO_LINK = (
    GPLinkUnknown = 0,                     // No link information available
    GPLinkMachine,                         // GPO linked to a machine (local or remote)
    GPLinkSite,                            // GPO linked to a site
    GPLinkDomain,                          // GPO linked to a domain
    GPLinkOrganizationalUnit               // GPO linked to a organizational unit
  );
  {$EXTERNALSYM _GPO_LINK}

  GPO_LINK = _GPO_LINK;
  {$EXTERNALSYM GPO_LINK}
  PGPO_LINK = ^_GPO_LINK;
  {$EXTERNALSYM PGPO_LINK}

  TGPOLink = GPO_LINK;
  PGPOLink = ^GPO_LINK;

  PGROUP_POLICY_OBJECTA = ^_GROUP_POLICY_OBJECTA;
  {$EXTERNALSYM PGROUP_POLICY_OBJECTA}
  PGROUP_POLICY_OBJECTW = ^_GROUP_POLICY_OBJECTW;
  {$EXTERNALSYM PGROUP_POLICY_OBJECTW}
  PGROUP_POLICY_OBJECT = PGROUP_POLICY_OBJECTW;

  _GROUP_POLICY_OBJECTA = record
    dwOptions: DWORD;                 // See GPLink option flags above
    dwVersion: DWORD;                 // Revision number of the GPO
    lpDSPath: LPSTR;                 // Path to the Active Directory portion of the GPO
    lpFileSysPath: LPSTR;            // Path to the file system portion of the GPO
    lpDisplayName: LPSTR;            // Friendly display name
    szGPOName: array [0..49] of AnsiChar;// Unique name
    GPOLink: GPO_LINK;                // Link information
    lParam: LPARAM;                   // Free space for the caller to store GPO specific information
    pNext: PGROUP_POLICY_OBJECTA;   // Next GPO in the list
    pPrev: PGROUP_POLICY_OBJECTA;   // Previous GPO in the list
    lpExtensions: LPSTR;             // Extensions that are relevant for this GPO
    lParam2: LPARAM;                  // Free space for the caller to store GPO specific information
    lpLink: LPSTR;                   // Path to the Active Directory site, domain, or organizational unit this GPO is linked to
                                      // If this is the local GPO, this points to the word "Local"
  end;
  {$EXTERNALSYM _GROUP_POLICY_OBJECTA}

  _GROUP_POLICY_OBJECTW = record
    dwOptions: DWORD;                 // See GPLink option flags above
    dwVersion: DWORD;                 // Revision number of the GPO
    lpDSPath: LPWSTR;                 // Path to the Active Directory portion of the GPO
    lpFileSysPath: LPWSTR;            // Path to the file system portion of the GPO
    lpDisplayName: LPWSTR;            // Friendly display name
    szGPOName: array [0..49] of WideChar;// Unique name
    GPOLink: GPO_LINK;                // Link information
    lParam: LPARAM;                   // Free space for the caller to store GPO specific information
    pNext: PGROUP_POLICY_OBJECTW;   // Next GPO in the list
    pPrev: PGROUP_POLICY_OBJECTW;   // Previous GPO in the list
    lpExtensions: LPWSTR;             // Extensions that are relevant for this GPO
    lParam2: LPARAM;                  // Free space for the caller to store GPO specific information
    lpLink: LPWSTR;                   // Path to the Active Directory site, domain, or organizational unit this GPO is linked to
                                      // If this is the local GPO, this points to the word "Local"
  end;
  {$EXTERNALSYM _GROUP_POLICY_OBJECTW}

  _GROUP_POLICY_OBJECT = _GROUP_POLICY_OBJECTW;

  GROUP_POLICY_OBJECTA = _GROUP_POLICY_OBJECTA;
  {$EXTERNALSYM GROUP_POLICY_OBJECTA}
  GROUP_POLICY_OBJECTW = _GROUP_POLICY_OBJECTW;
  {$EXTERNALSYM GROUP_POLICY_OBJECTW}
  GROUP_POLICY_OBJECT = GROUP_POLICY_OBJECTW;

  TGroupPolicyObjectA = GROUP_POLICY_OBJECTA;
  TGroupPolicyObjectW = GROUP_POLICY_OBJECTW;
  TGroupPolicyObject = TGroupPolicyObjectW;

  PGroupPolicyObjectA = PGROUP_POLICY_OBJECTA;
  PGroupPolicyObjectW = PGROUP_POLICY_OBJECTW;
  PGroupPolicyObject = PGroupPolicyObjectW;

//
// Translation of functions.
//
function LoadUserProfile(hToken: THandle; var lpProfileInfo: TProfileInfo): BOOL; stdcall;
{$EXTERNALSYM LoadUserProfile}
function LoadUserProfileA(hToken: THandle; var lpProfileInfo: TProfileInfoA): BOOL; stdcall;
{$EXTERNALSYM LoadUserProfileA}
function LoadUserProfileW(hToken: THandle; var lpProfileInfo: TProfileInfoW): BOOL; stdcall;
{$EXTERNALSYM LoadUserProfileW}

function GetProfilesDirectory(out lpProfilesDir: LPWSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetProfilesDirectory}
function GetProfilesDirectoryA(out lpProfilesDir: LPSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetProfilesDirectoryA}
function GetProfilesDirectoryW(out lpProfilesDir: LPWSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetProfilesDirectoryW}

function GetProfileType(out dwFlags: DWORD):BOOL; stdcall;
{$EXTERNALSYM GetProfileType}

function DeleteProfile(lpSidString: LPWSTR; lpProfilePath: LPWSTR; lpComputerName: LPWSTR):BOOL; stdcall;
{$EXTERNALSYM DeleteProfile}
function DeleteProfileA(lpSidString: LPSTR; lpProfilePath: LPSTR; lpComputerName: LPSTR):BOOL; stdcall;
{$EXTERNALSYM DeleteProfileA}
function DeleteProfileW(lpSidString: LPWSTR; lpProfilePath: LPWSTR; lpComputerName: LPWSTR):BOOL; stdcall;
{$EXTERNALSYM DeleteProfileW}

function CreateProfile(pszUserSid: LPWSTR; pszUserName: LPWSTR; out pszProfilePath: LPWSTR; cchProfilePath: DWORD): HRESULT; stdcall;
{$EXTERNALSYM CreateProfile}
function CreateProfileA(pszUserSid: LPSTR; pszUserName: LPSTR; out pszProfilePath: LPSTR; cchProfilePath: DWORD): HRESULT; stdcall;
{$EXTERNALSYM CreateProfileA}
function CreateProfileW(pszUserSid: LPWSTR; pszUserName: LPWSTR; out pszProfilePath: LPWSTR; cchProfilePath: DWORD): HRESULT; stdcall;
{$EXTERNALSYM CreateProfileW}

function GetDefaultUserProfileDirectory(out lpProfileDir: LPWSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetDefaultUserProfileDirectory}
function GetDefaultUserProfileDirectoryA(out lpProfileDir: LPSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetDefaultUserProfileDirectoryA}
function GetDefaultUserProfileDirectoryW(out lpProfileDir: LPWSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetDefaultUserProfileDirectoryW}

function GetAllUsersProfileDirectory(out lpProfileDir: LPWSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetAllUsersProfileDirectory}
function GetAllUsersProfileDirectoryA(out lpProfileDir: LPSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetAllUsersProfileDirectoryA}
function GetAllUsersProfileDirectoryW(out lpProfileDir: LPWSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetAllUsersProfileDirectoryW}

function GetUserProfileDirectory(hToken: THandle; lpProfileDir: LPWSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetUserProfileDirectory}
function GetUserProfileDirectoryA(hToken: THandle; lpProfileDir: LPSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetUserProfileDirectoryA}
function GetUserProfileDirectoryW(hToken: THandle; lpProfileDir: LPWSTR; var lpcchSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetUserProfileDirectoryW}

function CreateEnvironmentBlock(out lpEnvironment: LPVOID; hToken: THANDLE; bInherit:BOOL): BOOL; stdcall;
{$EXTERNALSYM CreateEnvironmentBlock}

function DestroyEnvironmentBlock(lpEnvironment: LPVOID): BOOL; stdcall;
{$EXTERNALSYM DestroyEnvironmentBlock}

function ExpandEnvironmentStringsForUser(hToken: THandle; lpSrc: LPWSTR; out lpDest: LPWSTR; dwSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM ExpandEnvironmentStringsForUser}
function ExpandEnvironmentStringsForUserA(hToken: THandle; lpSrc: LPSTR; out lpDest: LPSTR; dwSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM ExpandEnvironmentStringsForUserA}
function ExpandEnvironmentStringsForUserW(hToken: THandle; lpSrc: LPWSTR; out lpDest: LPWSTR; dwSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM ExpandEnvironmentStringsForUserW}

function RefreshPolicy(bMachine: BOOL): BOOL; stdcall;
{$EXTERNALSYM RefreshPolicy}

function RefreshPolicyEx(bMachine: BOOL; dwOptions: DWORD): BOOL; stdcall;
{$EXTERNALSYM RefreshPolicyEx}

function EnterCriticalPolicySection(bMachine: BOOL): THandle; stdcall;
{$EXTERNALSYM EnterCriticalPolicySection}

function LeaveCriticalPolicySection(hSection: THandle): BOOL; stdcall;
{$EXTERNALSYM LeaveCriticalPolicySection}

function RegisterGPNotification(hEvent: THandle; bMachine: BOOL): BOOL; stdcall;
{$EXTERNALSYM RegisterGPNotification}

function UnregisterGPNotification(hEvent: THandle): BOOL; stdcall;
{$EXTERNALSYM UnregisterGPNotification}

function GetGPOList(hToken: THandle; lpName, lpHostName, lpComputerName: LPWSTR;
    dwFlags: DWORD; out pGPOList: TGroupPolicyObject): BOOL; stdcall;
{$EXTERNALSYM GetGPOList}
function GetGPOListA(hToken: THandle; lpName, lpHostName, lpComputerName: LPSTR;
    dwFlags: DWORD; out pGPOList: TGroupPolicyObjectA): BOOL; stdcall;
{$EXTERNALSYM GetGPOListA}
function GetGPOListW(hToken: THandle; lpName, lpHostName, lpComputerName: LPWSTR;
    dwFlags: DWORD; out pGPOList: TGroupPolicyObjectW): BOOL; stdcall;
{$EXTERNALSYM GetGPOListW}

function FreeGPOList(const pGPOList: TGroupPolicyObject): BOOL; stdcall;
{$EXTERNALSYM FreeGPOList}
function FreeGPOListA(const pGPOList: TGroupPolicyObjectA): BOOL; stdcall;
{$EXTERNALSYM FreeGPOListA}
function FreeGPOListW(const pGPOList: TGroupPolicyObjectW): BOOL; stdcall;
{$EXTERNALSYM FreeGPOListW}

function GetAppliedGPOList(dwFlags: DWORD; pMachineName: LPWSTR; pSidUser: PSID;
    const pGuidExtension: TGUID; out ppGPOList: PGroupPolicyObject): DWORD;
{$EXTERNALSYM GetAppliedGPOList}
function GetAppliedGPOListA(dwFlags: DWORD; pMachineName: LPSTR; pSidUser: PSID;
    const pGuidExtension: TGUID; out ppGPOList: PGroupPolicyObjectA): DWORD;
{$EXTERNALSYM GetAppliedGPOListA}
function GetAppliedGPOListW(dwFlags: DWORD; pMachineName: LPWSTR; pSidUser: PSID;
    const pGuidExtension: TGUID; out ppGPOList: PGroupPolicyObjectW): DWORD;
{$EXTERNALSYM GetAppliedGPOListW}

function UnloadUserProfile(hToken: THandle; hProfile: THandle): BOOL; stdcall;
{$EXTERNALSYM UnloadUserProfile}

// ============================================================================
type
  ASYNCCOMPLETIONHANDLE = UINT_PTR;
  {$EXTERNALSYM ASYNCCOMPLETIONHANDLE}

  PFNSTATUSMESSAGECALLBACK  = function(bVerbose: BOOL; lpMessage:LPWSTR): DWORD;
  {$EXTERNALSYM PFNSTATUSMESSAGECALLBACK}

  PFNPROCESSGROUPPOLICY = function(
        dwFlags: DWORD;                             // GPO_INFO_FLAGS
        hToken: THandle;                            // User or machine token
        hKeyRoot: HKEY;                             // Root of registry
        pDeletedGPOList: PGROUP_POLICY_OBJECT;      // Linked list of deleted GPOs
        pChangedGPOList: PGROUP_POLICY_OBJECT;      // Linked list of changed GPOs
        pHandle: ASYNCCOMPLETIONHANDLE;             // For asynchronous completion
        var pbAbort: BOOL;                          // If true, then abort GPO processing
        pStatusCallback: PFNSTATUSMESSAGECALLBACK): DWORD;  // Callback function for displaying status messages
                                                    // Note, this can be NULL
  {$EXTERNALSYM PFNPROCESSGROUPPOLICY}

  PFNPROCESSGROUPPOLICYEX = function(
        dwFlags: DWORD;                             // GPO_INFO_FLAGS
        hToken: THandle;                            // User or machine token
        hKeyRoot: HKEY;                             // Root of registry
        pDeletedGPOList: PGROUP_POLICY_OBJECT;      // Linked list of deleted GPOs
        pChangedGPOList: PGROUP_POLICY_OBJECT;      // Linked list of changed GPOs
        pHandle: ASYNCCOMPLETIONHANDLE;             // For asynchronous completion
        var pbAbort: BOOL;                          // If true, then abort GPO processing
        pStatusCallback: PFNSTATUSMESSAGECALLBACK;  // Callback function for displaying status messages
                                                    // Note, this can be NULL
        pWbemServices: IWbemServices;               // Pointer to namespace to log diagnostic mode data
                                                    // Note, this will be NULL when Rsop logging is disabled
        out pRsopStatus: HRESULT): DWORD;           // RSOP Logging succeeded or not.
  {$EXTERNALSYM PFNPROCESSGROUPPOLICYEX}

  PRSOPTOKEN = PVOID;
  {$EXTERNALSYM PRSOPTOKEN}

  _RSOP_TARGET = record
    pwszAccountName: PWCHAR;                 // Account name
    pwszNewSOM: PWCHAR;                      // New domain or OU location for account
    psaSecurityGroups: PSAFEARRAY;           // New security groups
    pRsopToken: PRSOPTOKEN;                  // Rsop token for use with Rsop security Api's
    pGPOList: PGROUP_POLICY_OBJECT;          // Linked list of GPOs
    pWbemServices: IWbemServices;            // Pointer to namespace to log planning mode data
  end;
  {$EXTERNALSYM _RSOP_TARGET}
  RSOP_TARGET  = _RSOP_TARGET;
  {$EXTERNALSYM RSOP_TARGET}
  PRSOP_TARGET = ^_RSOP_TARGET;
  {$EXTERNALSYM PRSOP_TARGET}

  TRSOPTarget = RSOP_TARGET;
  PRSOPTarget = ^RSOP_TARGET;

  PFNGENERATEGROUPPOLICY = function(
    dwFlags: DWORD;                        // GPO_INFO_FLAGS
    var pbAbort: BOOL;                     // If true, then abort GPO processing
    pwszSite: PWCHAR;                      // Site the target computer is in
    pComputerTarget: PRSOP_TARGET;         // Computer target info, can be null
    pUserTarget: PRSOP_TARGET):DWORD;      // User target info, can be null
  {$EXTERNALSYM PFNGENERATEGROUPPOLICY}

  REFGPEXTENSIONID = PGUID;
  {$EXTERNALSYM REFGPEXTENSIONID}

//
// GUID that identifies the registry extension
//
const
  REGISTRY_EXTENSION_GUID: TGUID = (
    D1:$35378EAC; D2:$683F; D3:$11D2; D4:($A8, $9A, $00, $C0, $4F, $BB, $CF, $A2));
  {$EXTERNALSYM REGISTRY_EXTENSION_GUID}

//
// UBPM trigger provider and event GUIDs
//
  GROUP_POLICY_TRIGGER_EVENT_PROVIDER_GUID: TGUID = (
    D1:$BD2F4252; D2:$5E1E; D3:$49FC; D4:($9A, $30, $F3, $97, $8A, $D8, $9E, $E2));
  {$EXTERNALSYM GROUP_POLICY_TRIGGER_EVENT_PROVIDER_GUID}
  MACHINE_POLICY_PRESENT_TRIGGER_GUID: TGUID = (
    D1:$659FCAE6; D2:$5BDB; D3:$4DA9; D4:($B1, $FF, $CA, $2A, $17, $8D, $46, $E0));
  {$EXTERNALSYM MACHINE_POLICY_PRESENT_TRIGGER_GUID}
  USER_POLICY_PRESENT_TRIGGER_GUID: TGUID = (
    D1:$54FB46C8; D2:$F089; D3:$464C; D4:($B1, $FD, $59, $D1, $B6, $2C, $3B, $50));
  {$EXTERNALSYM USER_POLICY_PRESENT_TRIGGER_GUID}

//
// GPO Functions
//
function ProcessGroupPolicyCompleted(extensionId: REFGPEXTENSIONID; pAsyncHandle: ASYNCCOMPLETIONHANDLE; dwStatus: DWORD): DWORD; stdcall;
{$EXTERNALSYM ProcessGroupPolicyCompleted}

function ProcessGroupPolicyCompletedEx(extensionId: REFGPEXTENSIONID; pAsyncHandle: ASYNCCOMPLETIONHANDLE; dwStatus: DWORD;
    RsopStatus: HRESULT): DWORD; stdcall;
{$EXTERNALSYM ProcessGroupPolicyCompletedEx}

function RsopAccessCheckByType(pSecurityDescriptor: PSECURITY_DESCRIPTOR; pPrincipalSelfSid: PSID;
    pRsopToken: PRSOPTOKEN; dwDesiredAccessMask: DWORD; const pObjectTypeList: TObjectTypeList;
    ObjectTypeListLength: DWORD; const pGenericMapping: TGenericMapping; const pPrivilegeSet: TPrivilegeSet;
    pdwPrivilegeSetLength: LPDWORD; var pdwGrantedAccessMask: DWORD; var pbAccessStatus: BOOL): HRESULT; stdcall;
{$EXTERNALSYM RsopAccessCheckByType}

function RsopFileAccessCheck(pszFileName: LPWSTR; pRsopToken: PRSOPTOKEN; dwDesiredAccessMask: DWORD;
    var pdwGrantedAccessMask: DWORD; var pbAccessStatus: BOOL): HRESULT; stdcall;
{$EXTERNALSYM RsopFileAccessCheck}

type
  _SETTINGSTATUS = (RSOPUnspecified = 0, RSOPApplied, RSOPIgnored, RSOPFailed, RSOPSubsettingFailed);
  SETTINGSTATUS = _SETTINGSTATUS;
  {$EXTERNALSYM SETTINGSTATUS}
  TSettingStatus = _SETTINGSTATUS;
  PSettingStatus = ^_SETTINGSTATUS;

  _POLICYSETTINGSTATUSINFO = record
    szKey: LPWSTR;
    szEventSource: LPWSTR;
    szEventLogName: LPWSTR;
    dwEventID: DWORD;
    dwErrorCode: DWORD;
    status: SETTINGSTATUS;
    timeLogged: SYSTEMTIME;
  end;
  {$EXTERNALSYM _POLICYSETTINGSTATUSINFO}
  POLICYSETTINGSTATUSINFO = _POLICYSETTINGSTATUSINFO;
  {$EXTERNALSYM POLICYSETTINGSTATUSINFO}
  LPPOLICYSETTINGSTATUSINFO = ^_POLICYSETTINGSTATUSINFO;
  {$EXTERNALSYM LPPOLICYSETTINGSTATUSINFO}
  TPolicySettingStatusInfo = _POLICYSETTINGSTATUSINFO;
  PPolicySettingStatusInfo = ^_POLICYSETTINGSTATUSINFO;

function RsopSetPolicySettingStatus(dwFlags: DWORD; const pServices: IWbemServices;
    const pSettingInstance: IWbemClassObject; nInfo: DWORD; const pStatus: TPolicySettingStatusInfo): HRESULT;

function RsopResetPolicySettingStatus(dwFlags: DWORD; const pServices: IWbemServices;
    const pSettingInstance: IWbemClassObject): HRESULT;

//=============================================================================
//
// Flags for RSoP WMI providers
//
//=============================================================================
const
  // planning mode provider flags
  FLAG_NO_GPO_FILTER     = $80000000;  // GPOs are not filtered, implies FLAG_NO_CSE_INVOKE
  {$EXTERNALSYM FLAG_NO_GPO_FILTER}
  FLAG_NO_CSE_INVOKE     = $40000000;  // only GP processing done for planning mode
  {$EXTERNALSYM FLAG_NO_CSE_INVOKE}
  FLAG_ASSUME_SLOW_LINK  = $20000000;  // planning mode RSoP assumes slow link
  {$EXTERNALSYM FLAG_ASSUME_SLOW_LINK}
  FLAG_LOOPBACK_MERGE    = $10000000;  // planning mode RSoP assumes merge loop back
  {$EXTERNALSYM FLAG_LOOPBACK_MERGE}
  FLAG_LOOPBACK_REPLACE  = $08000000;  // planning mode RSoP assumes replace loop back
  {$EXTERNALSYM FLAG_LOOPBACK_REPLACE}

  FLAG_ASSUME_USER_WQLFILTER_TRUE  = $04000000;  // planning mode RSoP assumes all comp filters to be true
  {$EXTERNALSYM FLAG_ASSUME_USER_WQLFILTER_TRUE}
  FLAG_ASSUME_COMP_WQLFILTER_TRUE  = $02000000;  // planning mode RSoP assumes all user filters to be true
  {$EXTERNALSYM FLAG_ASSUME_COMP_WQLFILTER_TRUE}

  FLAG_PLANNING_MODE               = $01000000;  // flag that indicates that a given namespace was created
  {$EXTERNALSYM FLAG_PLANNING_MODE}
                                                      // for planning mode. This flag cannot be passed in but the
                                                      // relevant subnamespace will be marked with this flag

  // diagnostic mode provider flags
  FLAG_NO_USER                     = $00000001;  // Don't get any user data
  {$EXTERNALSYM FLAG_NO_USER}
  FLAG_NO_COMPUTER                 = $00000002;  // Don't get any machine data
  {$EXTERNALSYM FLAG_NO_COMPUTER}
  FLAG_FORCE_CREATENAMESPACE       = $00000004;  // Delete and recreate the namespace for this snapshot.
  {$EXTERNALSYM FLAG_FORCE_CREATENAMESPACE}

//=============================================================================
//
// Extended Errors returned by RSoP WMI Providers
//
//=============================================================================
// User accessing the rsop provider doesn't have access to user data.
  RSOP_USER_ACCESS_DENIED        = $00000001;
  {$EXTERNALSYM RSOP_USER_ACCESS_DENIED}

// User accessing the rsop provider doesn't have access to computer data.
  RSOP_COMPUTER_ACCESS_DENIED    = $00000002;
  {$EXTERNALSYM RSOP_COMPUTER_ACCESS_DENIED}

// This user is an interactive non admin user, the temp snapshot namespace already exists
// and the FLAG_FORCE_CREATENAMESPACE was not passed in
  RSOP_TEMPNAMESPACE_EXISTS      = $00000004;
  {$EXTERNALSYM RSOP_TEMPNAMESPACE_EXISTS}

// Name of the dll
const
  userenv   = 'userenv.dll';

implementation

{ Translated from 'userenv.h'}

function LoadUserProfile(hToken: THandle; var lpProfileInfo: TProfileInfo):BOOL; external userenv name 'LoadUserProfileW';
function LoadUserProfileA(hToken: THandle; var lpProfileInfo: TProfileInfoA):BOOL; external userenv name 'LoadUserProfileA';
function LoadUserProfileW(hToken: THandle; var lpProfileInfo: TProfileInfoW):BOOL; external userenv name 'LoadUserProfileW';

function GetProfilesDirectory(out lpProfilesDir: LPWSTR; var lpcchSize: DWORD): BOOL; external userenv name 'GetProfilesDirectoryW';
function GetProfilesDirectoryA(out lpProfilesDir: LPSTR; var lpcchSize: DWORD): BOOL; external userenv name 'GetProfilesDirectoryA';
function GetProfilesDirectoryW(out lpProfilesDir: LPWSTR; var lpcchSize: DWORD): BOOL; external userenv name 'GetProfilesDirectoryW';

function GetProfileType(out dwFlags: DWORD):BOOL; external userenv name 'GetProfileType';

function DeleteProfile(lpSidString:LPWSTR; lpProfilePath: LPWSTR; lpComputerName: LPWSTR):BOOL;
  external userenv name 'DeleteProfileW';
function DeleteProfileA(lpSidString:LPSTR; lpProfilePath: LPSTR; lpComputerName: LPSTR):BOOL;
  external userenv name 'DeleteProfileA';
function DeleteProfileW(lpSidString:LPWSTR; lpProfilePath: LPWSTR; lpComputerName: LPWSTR):BOOL;
  external userenv name 'DeleteProfileW';

function CreateProfile(pszUserSid: LPWSTR;pszUserName: LPWSTR; out pszProfilePath: LPWSTR; cchProfilePath: DWORD): HRESULT;
  external userenv name 'CreateProfileW' delayed;
function CreateProfileA(pszUserSid: LPSTR;pszUserName: LPSTR; out pszProfilePath: LPSTR; cchProfilePath: DWORD): HRESULT;
  external userenv name 'CreateProfileA' delayed;
function CreateProfileW(pszUserSid: LPWSTR;pszUserName: LPWSTR; out pszProfilePath: LPWSTR; cchProfilePath: DWORD): HRESULT;
  external userenv name 'CreateProfileW' delayed;

function GetDefaultUserProfileDirectory(out lpProfileDir: LPWSTR; var lpcchSize: DWORD): BOOL;
  external userenv name 'GetDefaultUserProfileDirectoryW';
function GetDefaultUserProfileDirectoryA(out lpProfileDir: LPSTR; var lpcchSize: DWORD): BOOL;
  external userenv name 'GetDefaultUserProfileDirectoryA';
function GetDefaultUserProfileDirectoryW(out lpProfileDir: LPWSTR; var lpcchSize: DWORD): BOOL;
  external userenv name 'GetDefaultUserProfileDirectoryW';

function GetAllUsersProfileDirectory(out lpProfileDir: LPWSTR; var lpcchSize: DWORD): BOOL;
  external userenv name 'GetAllUsersProfileDirectoryW';
function GetAllUsersProfileDirectoryA(out lpProfileDir: LPSTR; var lpcchSize: DWORD): BOOL;
  external userenv name 'GetAllUsersProfileDirectoryA';
function GetAllUsersProfileDirectoryW(out lpProfileDir: LPWSTR; var lpcchSize: DWORD): BOOL;
  external userenv name 'GetAllUsersProfileDirectoryW';

function GetUserProfileDirectory(hToken: THandle; lpProfileDir: LPWSTR; var lpcchSize:DWORD): BOOL;
  external userenv name 'GetUserProfileDirectoryW';
function GetUserProfileDirectoryA(hToken: THandle; lpProfileDir: LPSTR; var lpcchSize:DWORD): BOOL;
  external userenv name 'GetUserProfileDirectoryA';
function GetUserProfileDirectoryW(hToken: THandle; lpProfileDir: LPWSTR; var lpcchSize:DWORD): BOOL;
  external userenv name 'GetUserProfileDirectoryW';

function CreateEnvironmentBlock(out lpEnvironment: LPVOID; hToken: THandle; bInherit:BOOL): BOOL;
  external userenv name 'CreateEnvironmentBlock';
function DestroyEnvironmentBlock(lpEnvironment: LPVOID): BOOL; external userenv name 'DestroyEnvironmentBlock';

function ExpandEnvironmentStringsForUser(hToken: THandle; lpSrc: LPWSTR; out lpDest: LPWSTR; dwSize: DWORD): BOOL;
  external userenv name 'ExpandEnvironmentStringsForUserW';
function ExpandEnvironmentStringsForUserA(hToken: THandle; lpSrc: LPSTR; out lpDest: LPSTR; dwSize: DWORD): BOOL;
  external userenv name 'ExpandEnvironmentStringsForUserA';
function ExpandEnvironmentStringsForUserW(hToken: THandle; lpSrc: LPWSTR; out lpDest: LPWSTR; dwSize: DWORD): BOOL;
  external userenv name 'ExpandEnvironmentStringsForUserW';

function RefreshPolicy(bMachine: BOOL): BOOL; external userenv name 'RefreshPolicy';
function RefreshPolicyEx(bMachine: BOOL; dwOptions: DWORD): BOOL; external userenv name 'RefreshPolicyEx' delayed; // WinXP

function EnterCriticalPolicySection(bMachine: BOOL): THandle; external userenv name 'EnterCriticalPolicySection';
function LeaveCriticalPolicySection(hSection: THandle): BOOL; external userenv name 'LeaveCriticalPolicySection';

function RegisterGPNotification(hEvent: THandle; bMachine: BOOL): BOOL; external userenv name 'RegisterGPNotification';
function UnregisterGPNotification(hEvent: THandle): BOOL; external userenv name 'UnregisterGPNotification';

function GetGPOList(hToken: THandle; lpName, lpHostName, lpComputerName: LPWSTR;
    dwFlags: DWORD; out pGPOList:TGroupPolicyObject): BOOL; external userenv name 'GetGPOListW';
function GetGPOListA(hToken: THandle; lpName, lpHostName, lpComputerName: LPSTR;
    dwFlags: DWORD; out pGPOList:TGroupPolicyObjectA): BOOL; external userenv name 'GetGPOListA';
function GetGPOListW(hToken: THandle; lpName, lpHostName, lpComputerName: LPWSTR;
    dwFlags: DWORD; out pGPOList:TGroupPolicyObjectW): BOOL; external userenv name 'GetGPOListW';

function FreeGPOList(const pGPOList: TGroupPolicyObject): BOOL; external userenv name 'FreeGPOListW';
function FreeGPOListA(const pGPOList: TGroupPolicyObjectA): BOOL; external userenv name 'FreeGPOListA';
function FreeGPOListW(const pGPOList: TGroupPolicyObjectW): BOOL; external userenv name 'FreeGPOListW';

function GetAppliedGPOList(dwFlags: DWORD; pMachineName: LPWSTR; pSidUser: PSID;
    const pGuidExtension: TGUID; out ppGPOList: PGroupPolicyObject): DWORD; external userenv name 'GetAppliedGPOListW';
function GetAppliedGPOListA(dwFlags: DWORD; pMachineName: LPSTR; pSidUser: PSID;
    const pGuidExtension: TGUID; out ppGPOList: PGroupPolicyObjectA): DWORD; external userenv name 'GetAppliedGPOListA';
function GetAppliedGPOListW(dwFlags: DWORD; pMachineName: LPWSTR; pSidUser: PSID;
    const pGuidExtension: TGUID; out ppGPOList: PGroupPolicyObjectW): DWORD; external userenv name 'GetAppliedGPOListW';

function UnloadUserProfile(hToken: THandle; hProfile: THandle):BOOL; external userenv name 'UnloadUserProfile';

function ProcessGroupPolicyCompleted(extensionId: REFGPEXTENSIONID;
    pAsyncHandle: ASYNCCOMPLETIONHANDLE; dwStatus: DWORD): DWORD; external userenv name 'ProcessGroupPolicyCompleted';

function ProcessGroupPolicyCompletedEx(extensionId: REFGPEXTENSIONID; pAsyncHandle: ASYNCCOMPLETIONHANDLE; dwStatus: DWORD;
    RsopStatus: HRESULT): DWORD; external userenv name 'ProcessGroupPolicyCompletedEx' delayed; // WinXP

function RsopAccessCheckByType(pSecurityDescriptor: PSECURITY_DESCRIPTOR; pPrincipalSelfSid: PSID;
    pRsopToken: PRSOPTOKEN; dwDesiredAccessMask: DWORD; const pObjectTypeList: TObjectTypeList;
    ObjectTypeListLength: DWORD; const pGenericMapping: TGenericMapping; const pPrivilegeSet: TPrivilegeSet;
    pdwPrivilegeSetLength: LPDWORD; var pdwGrantedAccessMask: DWORD; var pbAccessStatus: BOOL): HRESULT;
    external userenv name 'RsopAccessCheckByType' delayed; // WinXP

function RsopFileAccessCheck(pszFileName: LPWSTR; pRsopToken: PRSOPTOKEN; dwDesiredAccessMask: DWORD;
    var pdwGrantedAccessMask: DWORD; var pbAccessStatus: BOOL): HRESULT; external userenv name 'RsopFileAccessCheck' delayed; // WinXP

function RsopSetPolicySettingStatus(dwFlags: DWORD; const pServices: IWbemServices;
    const pSettingInstance: IWbemClassObject; nInfo: DWORD; const pStatus: TPolicySettingStatusInfo): HRESULT;
    external userenv name 'RsopSetPolicySettingStatus' delayed; // WinXP

function RsopResetPolicySettingStatus(dwFlags: DWORD; const pServices: IWbemServices;
    const pSettingInstance: IWbemClassObject): HRESULT; external userenv name 'RsopResetPolicySettingStatus' delayed; // WinXP

end.
