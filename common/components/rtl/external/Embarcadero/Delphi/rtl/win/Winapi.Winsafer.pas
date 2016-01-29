{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{    File: winsafer.h                                   }
{    Copyright (C) Microsoft Corporation, 1997-2001.    }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.Winsafer;

interface

{$ALIGN ON}
{$MINENUMSIZE 4}

uses Winapi.Windows;

// 
// Constants to represent scope with SaferCreateLevel and others.
// 

const
  SAFER_SCOPEID_MACHINE = 1; 
  {$EXTERNALSYM SAFER_SCOPEID_MACHINE}
  SAFER_SCOPEID_USER = 2;
  {$EXTERNALSYM SAFER_SCOPEID_USER}

// 
// Pre-defined levels that can be used with SaferCreateLevel
// 

  SAFER_LEVELID_FULLYTRUSTED = $40000; 
  {$EXTERNALSYM SAFER_LEVELID_FULLYTRUSTED}
  SAFER_LEVELID_NORMALUSER = $20000; 
  {$EXTERNALSYM SAFER_LEVELID_NORMALUSER}
  SAFER_LEVELID_CONSTRAINED = $10000; 
  {$EXTERNALSYM SAFER_LEVELID_CONSTRAINED}
  SAFER_LEVELID_UNTRUSTED = $01000; 
  {$EXTERNALSYM SAFER_LEVELID_UNTRUSTED}
  SAFER_LEVELID_DISALLOWED = $00000; 
  {$EXTERNALSYM SAFER_LEVELID_DISALLOWED}

// 
// Flags to use when creating/opening a Level with SaferCreateLevel
// 

  SAFER_LEVEL_OPEN = 1; 
  {$EXTERNALSYM SAFER_LEVEL_OPEN}

// 
// Maximum string size.
// 

  SAFER_MAX_FRIENDLYNAME_SIZE = 256; 
  {$EXTERNALSYM SAFER_MAX_FRIENDLYNAME_SIZE}
  SAFER_MAX_DESCRIPTION_SIZE = 256; 
  {$EXTERNALSYM SAFER_MAX_DESCRIPTION_SIZE}
  SAFER_MAX_HASH_SIZE = 64; 
  {$EXTERNALSYM SAFER_MAX_HASH_SIZE}

// 
// Flags to use with SaferComputeTokenFromLevel.
// 

  SAFER_TOKEN_NULL_IF_EQUAL = $00000001; 
  {$EXTERNALSYM SAFER_TOKEN_NULL_IF_EQUAL}
  SAFER_TOKEN_COMPARE_ONLY = $00000002; 
  {$EXTERNALSYM SAFER_TOKEN_COMPARE_ONLY}
  SAFER_TOKEN_MAKE_INERT = $00000004; 
  {$EXTERNALSYM SAFER_TOKEN_MAKE_INERT}
  SAFER_TOKEN_WANT_FLAGS = $00000008; 
  {$EXTERNALSYM SAFER_TOKEN_WANT_FLAGS}

// 
// Flags for specifying what criteria within SAFER_CODE_PROPERTIES to evaluate
// when finding code identity with SaferIdentifyLevel.
// 

  SAFER_CRITERIA_IMAGEPATH = $00001; 
  {$EXTERNALSYM SAFER_CRITERIA_IMAGEPATH}
  SAFER_CRITERIA_NOSIGNEDHASH = $00002; 
  {$EXTERNALSYM SAFER_CRITERIA_NOSIGNEDHASH}
  SAFER_CRITERIA_IMAGEHASH = $00004; 
  {$EXTERNALSYM SAFER_CRITERIA_IMAGEHASH}
  SAFER_CRITERIA_AUTHENTICODE = $00008; 
  {$EXTERNALSYM SAFER_CRITERIA_AUTHENTICODE}
  SAFER_CRITERIA_URLZONE = $00010; 
  {$EXTERNALSYM SAFER_CRITERIA_URLZONE}
  SAFER_CRITERIA_IMAGEPATH_NT = $01000; 
  {$EXTERNALSYM SAFER_CRITERIA_IMAGEPATH_NT}

// 
// Code image information structure passed to SaferIdentifyLevel.
// 

type
  PSaferCodeProperties = ^TSaferCodeProperties;
  {$EXTERNALSYM PSaferCodeProperties}
  _SAFER_CODE_PROPERTIES = record // 
    // Must be initialized to be the size of this structure,
    // for the purposes of future/backwards compatibility.
    // 

    cbSize: DWORD;

    // 
    // Must be initialized to the types of criteria that should
    // be considered when evaluating this structure.  This can be
    // a combination of the SAFER_CRITERIA_xxxx flags.  If not enough
    // of the structure elements needed to evaluate the criteria
    // types indicated were supplied, then some of those criteria
    // flags may be silently ignored.  Specifying 0 for this value
    // will cause the entire structure's contents to be ignored.
    // 

    dwCheckFlags: DWORD;

    // 
    // Optionally specifies the fully-qualified path and filename
    // to be used for discrimination checks based on the path.
    // The ImagePath will additionally be used to open and read the
    // file to identify any other discrimination criteria that was
    // unsupplied in this structure.
    // 

    ImagePath: LPCWSTR;

    // 
    // Optionally specifies a file handle that has been opened to
    // code image with at least GENERIC_READ access.  The handle will
    // be used instead of explicitly opening the file again to compute
    // other discrimination criteria that was unsupplied in this structure.
    // 

    hImageFileHandle: THandle;

    // 
    // Optionally specifies the pre-determined Internet Explorer
    // security zone.  These enums are defined within urlmon.h
    // For example: URLZONE_LOCAL_MACHINE, URLZONE_INTRANET,
    //   URLZONE_TRUSTED, URLZONE_INTERNET, or URLZONE_UNTRUSTED.
    // 

    UrlZoneId: DWORD;

    // 
    // Optionally specifies the pre-computed hash of the image.
    // The supplied hash is interpreted as being valid if ImageSize
    // is non-zero and dwImageHashSize is non-zero and HashAlgorithm
    // represents a valid hashing algorithm from wincrypt.h
    // 
    // If the supplied hash fails to meet the conditions above, then
    // the hash will be automatically computed against:
    //      1) by using ImageSize and pByteBlock if both are non-zero.
    //      2) by using hImageFileHandle if it is non-null.
    //      3) by attempting to open ImagePath if it is non-null.
    // 

    ImageHash: packed array[0..SAFER_MAX_HASH_SIZE-1] of Byte;
    dwImageHashSize: DWORD;
    ImageSize: LARGE_INTEGER;
    HashAlgorithm: UINT;

    // 
    // Optionally specifies a memory block of memory representing
    // the image for which the trust is being requested for.  When
    // this member is specified, ImageSize must also be supplied.
    // 

    pByteBlock: PByte;

    // 
    // Optionally gives the arguments used for Authenticode signer
    // certificate verification.  These arguments are supplied to the
    // WinVerifyTrust() API and control the user-interface prompting
    // to accept untrusted certificates.
    // 

    hWndParent: HWND;
    dwWVTUIChoice: DWORD;

  end;
  {$EXTERNALSYM _SAFER_CODE_PROPERTIES}
  TSaferCodeProperties = _SAFER_CODE_PROPERTIES;
  {$EXTERNALSYM TSaferCodeProperties}
  SAFER_CODE_PROPERTIES = _SAFER_CODE_PROPERTIES;
  {$EXTERNALSYM SAFER_CODE_PROPERTIES}

// 
// Masks for the per-identity WinSafer flags
// 

const
  SAFER_POLICY_JOBID_MASK = $FF000000; 
  {$EXTERNALSYM SAFER_POLICY_JOBID_MASK}
  SAFER_POLICY_JOBID_CONSTRAINED = $04000000; 
  {$EXTERNALSYM SAFER_POLICY_JOBID_CONSTRAINED}
  SAFER_POLICY_JOBID_UNTRUSTED = $03000000; 
  {$EXTERNALSYM SAFER_POLICY_JOBID_UNTRUSTED}
  SAFER_POLICY_ONLY_EXES = $00010000; 
  {$EXTERNALSYM SAFER_POLICY_ONLY_EXES}
  SAFER_POLICY_SANDBOX_INERT = $00020000; 
  {$EXTERNALSYM SAFER_POLICY_SANDBOX_INERT}
  SAFER_POLICY_HASH_DUPLICATE = $00040000; 
  {$EXTERNALSYM SAFER_POLICY_HASH_DUPLICATE}
  SAFER_POLICY_ONLY_AUDIT = $00001000; 
  {$EXTERNALSYM SAFER_POLICY_ONLY_AUDIT}
  SAFER_POLICY_BLOCK_CLIENT_UI = $00002000; 
  {$EXTERNALSYM SAFER_POLICY_BLOCK_CLIENT_UI}
  SAFER_POLICY_UIFLAGS_MASK = $000000FF; 
  {$EXTERNALSYM SAFER_POLICY_UIFLAGS_MASK}
  SAFER_POLICY_UIFLAGS_INFORMATION_PROMPT = $00000001; 
  {$EXTERNALSYM SAFER_POLICY_UIFLAGS_INFORMATION_PROMPT}
  SAFER_POLICY_UIFLAGS_OPTION_PROMPT = $00000002; 
  {$EXTERNALSYM SAFER_POLICY_UIFLAGS_OPTION_PROMPT}
  SAFER_POLICY_UIFLAGS_HIDDEN = $00000004; 
  {$EXTERNALSYM SAFER_POLICY_UIFLAGS_HIDDEN}

// 
// Information classes on the overall policy that can be queried
// with SaferSet/GetPolicyInformation and set at different
// policy scopes based on access of the caller.
// 

type
  SAFER_POLICY_INFO_CLASS = type Integer;
  {$EXTERNALSYM SAFER_POLICY_INFO_CLASS}

const
    // Accesses the list of all Levels defined in a policy.
    // The corresponding data element is a buffer that is filled
    // with multiple DWORDs, each representing the LevelIds that
    // are defined within this scope.
    // 

  SaferPolicyLevelList                    = 1; 
  {$EXTERNALSYM SaferPolicyLevelList}

    // 
    // for transparent enforcement of policy in the execution
    // framework -- will be used by native code execution but can
    // be used by any policy enforcement environment.
    // Corresponding data element is a DWORD holding a Boolean value.
    // 

  SaferPolicyEnableTransparentEnforcement = 2; 
  {$EXTERNALSYM SaferPolicyEnableTransparentEnforcement}

    // 
    // Returns the name of the Level that has been designed
    // as the default level within the specified scope.
    // The corresponding data element is a single DWORD buffer
    // representing the LevelId of the default Level.  If no
    // level has been configured to be the default, then the
    // GetInfo API will return FALSE and GetLastError will
    // return ERROR_NOT_FOUND.
    // 

  SaferPolicyDefaultLevel                 = 3; 
  {$EXTERNALSYM SaferPolicyDefaultLevel}

    // 
    // Returns whether Code Identities or Default Level within the
    // user scope can be considered during identification.
    // 

  SaferPolicyEvaluateUserScope            = 4; 
  {$EXTERNALSYM SaferPolicyEvaluateUserScope}

    // 
    // Control Flags for safer policy scope.
    // 

  SaferPolicyScopeFlags                   = 5; 
  {$EXTERNALSYM SaferPolicyScopeFlags}

    // 
    // Flags which indicate "audit" or "block client UI" rules
    // 

  SaferPolicyDefaultLevelFlags            = 6; 
  {$EXTERNALSYM SaferPolicyDefaultLevelFlags}

    // 
    // Flag which indicates if certificate rules are applied in CreateProcess
    // 

  SaferPolicyAuthenticodeEnabled          = 7; 
  {$EXTERNALSYM SaferPolicyAuthenticodeEnabled}

// 
// Enumerations used for retrieving specific information about a
// single authorization Level via SaferGet/SetInformationFromLevel.
// 

type
  SAFER_OBJECT_INFO_CLASS = type Integer;
  {$EXTERNALSYM SAFER_OBJECT_INFO_CLASS}

const
  SaferObjectLevelId                 = 1;
  {$EXTERNALSYM SaferObjectLevelId}
  SaferObjectScopeId                 = 2;
  {$EXTERNALSYM SaferObjectScopeId}
  SaferObjectFriendlyName            = 3;
  {$EXTERNALSYM SaferObjectFriendlyName}
  SaferObjectDescription             = 4;
  {$EXTERNALSYM SaferObjectDescription}
  SaferObjectBuiltin                 = 5;
  {$EXTERNALSYM SaferObjectBuiltin}
  SaferObjectDisallowed              = 6;
  {$EXTERNALSYM SaferObjectDisallowed}
  SaferObjectDisableMaxPrivilege     = 7;
  {$EXTERNALSYM SaferObjectDisableMaxPrivilege}
  SaferObjectInvertDeletedPrivileges = 8;
  {$EXTERNALSYM SaferObjectInvertDeletedPrivileges}
  SaferObjectDeletedPrivileges       = 9;
  {$EXTERNALSYM SaferObjectDeletedPrivileges}
  SaferObjectDefaultOwner            = 10;
  {$EXTERNALSYM SaferObjectDefaultOwner}
  SaferObjectSidsToDisable           = 11;
  {$EXTERNALSYM SaferObjectSidsToDisable}
  SaferObjectRestrictedSidsInverted  = 12;
  {$EXTERNALSYM SaferObjectRestrictedSidsInverted}
  SaferObjectRestrictedSidsAdded     = 13;
  {$EXTERNALSYM SaferObjectRestrictedSidsAdded}

    // 
    // To enumerate all identities, call GetInfo with
    //      SaferObjectAllIdentificationGuids.
    // 

  SaferObjectAllIdentificationGuids  = 14;
  {$EXTERNALSYM SaferObjectAllIdentificationGuids}

    // 
    // To create a new identity, call SetInfo with
    //      SaferObjectSingleIdentification with a new
    //      unique GUID that you have generated.
    // To get details on a single identity, call GetInfo with
    //      SaferObjectSingleIdentification with desired GUID.
    // To modify details of a single identity, call SetInfo with
    //      SaferObjectSingleIdentification with desired info and GUID.
    // To delete an identity, call SetInfo with
    //      SaferObjectSingleIdentification with the
    //      header.dwIdentificationType set to 0.
    // 

  SaferObjectSingleIdentification    = 15;
  {$EXTERNALSYM SaferObjectSingleIdentification}
  SaferObjectExtendedError           = 16;
  {$EXTERNALSYM SaferObjectExtendedError}

// 
// Structures and enums used by the SaferGet/SetLevelInformation APIs.
// 

type
  SAFER_IDENTIFICATION_TYPES = type Integer; 
  {$EXTERNALSYM SAFER_IDENTIFICATION_TYPES}

const
  SaferIdentityDefault         = 0; 
  {$EXTERNALSYM SaferIdentityDefault}
  SaferIdentityTypeImageName   = 1; 
  {$EXTERNALSYM SaferIdentityTypeImageName}
  SaferIdentityTypeImageHash   = 2; 
  {$EXTERNALSYM SaferIdentityTypeImageHash}
  SaferIdentityTypeUrlZone     = 3; 
  {$EXTERNALSYM SaferIdentityTypeUrlZone}
  SaferIdentityTypeCertificate = 4; 
  {$EXTERNALSYM SaferIdentityTypeCertificate}


type
  PSaferIdentificationHeader = ^TSaferIdentificationHeader;
  {$EXTERNALSYM PSaferIdentificationHeader}
  _SAFER_IDENTIFICATION_HEADER = record
    // indicates the type of the structure, one of SaferIdentityType*
    // 

    dwIdentificationType: SAFER_IDENTIFICATION_TYPES;

    // 
    // size of the whole structure, not just the common header.
    // 

    cbStructSize: DWORD;

    // 
    // the unique GUID of the Identity in question.
    // 

    IdentificationGuid: TGUID;

    // 
    // last change of this identification.
    // 

    lastModified: FILETIME;
  end;
  {$EXTERNALSYM _SAFER_IDENTIFICATION_HEADER}
  TSaferIdentificationHeader = _SAFER_IDENTIFICATION_HEADER;
  {$EXTERNALSYM TSaferIdentificationHeader}
  SAFER_IDENTIFICATION_HEADER = _SAFER_IDENTIFICATION_HEADER;
  {$EXTERNALSYM SAFER_IDENTIFICATION_HEADER}

  PSaferPathnameIdentification = ^TSaferPathnameIdentification;
  {$EXTERNALSYM PSaferPathnameIdentification}
  _SAFER_PATHNAME_IDENTIFICATION = record
    // header.dwIdentificationType must be SaferIdentityTypeImageName
    // header.cbStructSize must be sizeof(SAFER_PATHNAME_IDENTIFICATION)
    // 

    header: TSaferIdentificationHeader;

    // 
    // user-entered description
    // 

    Description: packed array[0..SAFER_MAX_DESCRIPTION_SIZE-1] of WCHAR;

    // 
    // filepath or name, possibly with vars
    // 

    ImageName: PWCHAR;

    // 
    // any combo of SAFER_POLICY_* flags
    // 

    dwSaferFlags: DWORD;
  end;
  {$EXTERNALSYM _SAFER_PATHNAME_IDENTIFICATION}
  TSaferPathnameIdentification = _SAFER_PATHNAME_IDENTIFICATION;
  {$EXTERNALSYM TSaferPathnameIdentification}
  SAFER_PATHNAME_IDENTIFICATION = _SAFER_PATHNAME_IDENTIFICATION;
  {$EXTERNALSYM SAFER_PATHNAME_IDENTIFICATION}

  PSaferHashIdentification = ^TSaferHashIdentification;
  {$EXTERNALSYM PSaferHashIdentification}
  _SAFER_HASH_IDENTIFICATION = record
    // header.dwIdentificationType must be SaferIdentityTypeImageHash
    // header.cbStructSize must be sizeof(SAFER_HASH_IDENTIFICATION)
    // 

    header: TSaferIdentificationHeader;

    // 
    // user-entered friendly name, initially from file's resources.
    // 
    Description: packed array[0..SAFER_MAX_DESCRIPTION_SIZE-1] of WCHAR;

    // 
    // user-entered description.
    // 

    FriendlyName: packed array[0..SAFER_MAX_FRIENDLYNAME_SIZE-1] of WCHAR;

    // 
    // amount of ImageHash actually used, in bytes (MD5 is 16 bytes).
    // 

    HashSize: DWORD;

    // 
    // computed hash data itself.
    // 

    ImageHash: packed array[0..SAFER_MAX_HASH_SIZE-1] of Byte;

    // 
    // algorithm in which the hash was computed (CALG_MD5, etc).
    // 

    HashAlgorithm: UINT;

    // 
    // size of the original file in bytes.
    // 

    ImageSize: LARGE_INTEGER;

    // 
    // any combo of SAFER_POLICY_* flags
    // 

    dwSaferFlags: DWORD;
  end;
  {$EXTERNALSYM _SAFER_HASH_IDENTIFICATION}
  TSaferHashIdentification = _SAFER_HASH_IDENTIFICATION;
  {$EXTERNALSYM TSaferHashIdentification}
  SAFER_HASH_IDENTIFICATION = _SAFER_HASH_IDENTIFICATION;
  {$EXTERNALSYM SAFER_HASH_IDENTIFICATION}

  PSaferHashIdentification2 = ^TSaferHashIdentification2;
  {$EXTERNALSYM PSaferHashIdentification2}
  _SAFER_HASH_IDENTIFICATION2 = record
    // Start by including the original structure. It contains number of bytes
    // in this particular structure.
    // 

    hashIdentification: TSaferHashIdentification;

    // 
    // amount of ImageHash actually used, in bytes (SHA256 is 32 bytes).
    // 

    HashSize: DWORD;

    // 
    // computed hash data itself.
    // 

    ImageHash: packed array[0..SAFER_MAX_HASH_SIZE-1] of Byte;

    // 
    // algorithm in which the hash was computed (CALG_SHA256).
    // 

    HashAlgorithm: UINT;
  end;
  {$EXTERNALSYM _SAFER_HASH_IDENTIFICATION2}
  TSaferHashIdentification2 = _SAFER_HASH_IDENTIFICATION2;
  {$EXTERNALSYM TSaferHashIdentification2}
  SAFER_HASH_IDENTIFICATION2 = _SAFER_HASH_IDENTIFICATION2;
  {$EXTERNALSYM SAFER_HASH_IDENTIFICATION2}

  PSaferURLZoneIdentification = ^TSaferURLZoneIdentification;
  {$EXTERNALSYM PSaferURLZoneIdentification}
  _SAFER_URLZONE_IDENTIFICATION = record
    // header.dwIdentificationType must be SaferIdentityTypeUrlZone
    // header.cbStructSize must be sizeof(SAFER_URLZONE_IDENTIFICATION)
    // 

    header: TSaferIdentificationHeader;

    // 
    // any single URLZONE_* from urlmon.h
    // 

    UrlZoneId: DWORD;

    // 
    // any combo of SAFER_POLICY_* flags
    // 

    dwSaferFlags: DWORD;
  end;
  {$EXTERNALSYM _SAFER_URLZONE_IDENTIFICATION}
  TSaferUrlzoneIdentification = _SAFER_URLZONE_IDENTIFICATION;
  {$EXTERNALSYM TSaferUrlzoneIdentification}
  SAFER_URLZONE_IDENTIFICATION = _SAFER_URLZONE_IDENTIFICATION;
  {$EXTERNALSYM SAFER_URLZONE_IDENTIFICATION}

// 
// Functions related to querying and setting the global policy
// controls to disable transparent enforcement, and perform level
// enumeration operations.
// 

function SaferGetPolicyInformation(dwScopeId: DWORD;
  SaferPolicyInfoClass: SAFER_POLICY_INFO_CLASS; InfoBufferSize: DWORD;
  InfoBuffer2: Pointer; InfoBufferRetSize: PDWORD; lpReserved: Pointer): BOOL; stdcall;
{$EXTERNALSYM SaferGetPolicyInformation}

function SaferSetPolicyInformation(dwScopeId: DWORD;
  SaferPolicyInfoClass: SAFER_POLICY_INFO_CLASS; InfoBufferSize: DWORD;
  InfoBuffer: Pointer; lpReserved: Pointer): BOOL; stdcall;
{$EXTERNALSYM SaferSetPolicyInformation}

// 
// Functions to open or close a handle to a Safer Level.
// 

function SaferCreateLevel(dwScopeId: DWORD; dwLevelId: DWORD; OpenFlags: DWORD;
  var pLevelHandle: THandle; lpReserved: Pointer): BOOL; stdcall;
{$EXTERNALSYM SaferCreateLevel}

function SaferCloseLevel(hLevelHandle: THandle): BOOL; stdcall;
{$EXTERNALSYM SaferCloseLevel}

function SaferIdentifyLevel(dwNumProperties: DWORD;
  pCodeProperties: PSaferCodeProperties; var pLevelHandle: THandle;
  lpReserved: Pointer): BOOL; stdcall;
{$EXTERNALSYM SaferIdentifyLevel}

function SaferComputeTokenFromLevel(LevelHandle:THandle;
  InAccessToken: THandle; OutAccessToken: PHANDLE; dwFlags: DWORD;
  lpReserved: Pointer): BOOL; stdcall;
{$EXTERNALSYM SaferComputeTokenFromLevel}

function SaferGetLevelInformation(LevelHandle: THandle;
  dwInfoType: SAFER_OBJECT_INFO_CLASS; dwInBufferSize: DWORD;
  var lpdwOutBufferSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM SaferGetLevelInformation}

function SaferSetLevelInformation(LevelHandle: THandle;
  dwInfoType: SAFER_OBJECT_INFO_CLASS; lpQueryBuffer: Pointer;
  dwInBufferSize: DWORD): BOOL; stdcall;
{$EXTERNALSYM SaferSetLevelInformation}

//
// This function performs logging of messages to the Application
// event log.  This is called by the hooks within CreateProcess,
// ShellExecute and cmd when a lower trust evaluation result occurs.
//

function SaferRecordEventLogEntry(hLevel: THandle;
  szTargetPath: LPCWSTR; lpReserved: Pointer): BOOL; stdcall;
{$EXTERNALSYM SaferRecordEventLogEntry}

function SaferiIsExecutableFileType(szFullPathname: LPCWSTR;
  bFromShellExecute: BOOLEAN): BOOL; stdcall;
{$EXTERNALSYM SaferiIsExecutableFileType}

implementation

function SaferGetPolicyInformation; external advapi32 name 'SaferGetPolicyInformation';
function SaferSetPolicyInformation; external advapi32 name 'SaferSetPolicyInformation';
function SaferCreateLevel; external advapi32 name 'SaferCreateLevel';
function SaferCloseLevel; external advapi32 name 'SaferCloseLevel';
function SaferIdentifyLevel; external advapi32 name 'SaferIdentifyLevel';
function SaferComputeTokenFromLevel; external advapi32 name 'SaferComputeTokenFromLevel';
function SaferGetLevelInformation; external advapi32 name 'SaferGetLevelInformation';
function SaferSetLevelInformation; external advapi32 name 'SaferSetLevelInformation';
function SaferRecordEventLogEntry; external advapi32 name 'SaferRecordEventLogEntry';
function SaferiIsExecutableFileType; external advapi32 name 'SaferiIsExecutableFileType';

end.
