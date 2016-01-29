{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: corerror.h                             }
{          Copyright (c) Microsoft Corporation.         }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

(*********************************************************************
 **                                                                 **
 ** CorError.h - lists the HResults used by the .NET Framework's    **
 **              Common Language Runtime.                           **
 ** Created: September 3, 1999.                                     **
 **                                                                 **
 *********************************************************************)

unit Winapi.CorError;

//#ifndef __COMMON_LANGUAGE_RUNTIME_HRESULTS__
//#pragma option push -b -a8 -pc -A- /*P_O_Push*/
//#define __COMMON_LANGUAGE_RUNTIME_HRESULTS__

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses Winapi.Windows;

(*********************************************************************

These HRESULTs are used for mapping managed exceptions to COM error codes
and vice versa through COM Interop.  For background on COM error codes see
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/com/error_9td2.asp.

FACILITY_URT is defined as 0x13 (0x8013xxxx). The facility range is reserved
for the .NET Framework SDK teams.

Within that range, the following subranges have been allocated for different
feature areas:

0x10yy for Execution Engine
0x11yy for Metadata, TypeLib Export, and CLDB
0x12yy for MetaData Validator
0x13yy for Debugger and Profiler errors
0x14yy for Security
0x15yy for BCL
0x1600 - 0x161F for Reflection
0x1620 - 0x163F for System.IO
0x1640 - 0x165F for Security
0x1660 - 0x16FF for BCL
0x17yy for shim
0x18yy for IL Verifier
0x19yy for .NET Framework
0x1Ayy for .NET Framework
0x1Byy for MetaData Validator
0x1Cyy for more debugger errors
0x1Dyy for PE Format Validation
0x1Eyy for CLR Optimization Service errors
0x1Fyy for NGEN errors
0x30yy for VSA errors

Base class library HRESULTs are copied from this file into many different
files named __HResults.cs under the BCL directory.  Frameworks HRESULTs are
defined in src/main/HResults.cs. If you make any modifications to
the range allocations described above, please make sure the corerror.h file
gets updated.

*********************************************************************)

const
  FACILITY_URT            = $13;
  {$EXTERNALSYM FACILITY_URT}

// ******************
// FACILITY_UTF
// ******************


// ******************
// Metadata errors
// ******************

//**** ICeeFileGen errors.
  CEE_E_ENTRYPOINT                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1000);     // The entry point info is invalid.
  {$EXTERNALSYM CEE_E_ENTRYPOINT}
  CEE_E_CVTRES_NOT_FOUND          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1001);     // cannot find cvtres.exe
  {$EXTERNALSYM CEE_E_CVTRES_NOT_FOUND}

//**** EE errors
  MSEE_E_LOADLIBFAILED            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1010);     // Failed to delay load library %s (Win32 error: %d).
  {$EXTERNALSYM MSEE_E_LOADLIBFAILED}
  MSEE_E_GETPROCFAILED            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1011);     // Failed to get entry point %s (Win32 error: %d).
  {$EXTERNALSYM MSEE_E_GETPROCFAILED}
  MSEE_E_MULTCOPIESLOADED         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1012);     // Multiple copies of MSCOREE.dll have been loaded by the same process.
  {$EXTERNALSYM MSEE_E_MULTCOPIESLOADED}
// the following two are COR to match the name used in the library
  COR_E_APPDOMAINUNLOADED         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1014);     // access unloaded appdomain
  {$EXTERNALSYM COR_E_APPDOMAINUNLOADED}
  COR_E_CANNOTUNLOADAPPDOMAIN     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1015);     // Error while unloading an appdomain
  {$EXTERNALSYM COR_E_CANNOTUNLOADAPPDOMAIN}
  MSEE_E_ASSEMBLYLOADINPROGRESS   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1016);     // Assembly is being currently being loaded
  {$EXTERNALSYM MSEE_E_ASSEMBLYLOADINPROGRESS}
  MSEE_E_CANNOTCREATEAPPDOMAIN    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1017);     // Attempt to create appdomain failed
  {$EXTERNALSYM MSEE_E_CANNOTCREATEAPPDOMAIN}
  COR_E_FIXUPSINEXE               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1019);     // Attempt to load an unverifiable exe with fixups (IAT with more than 2 sections or a TLS section)
  {$EXTERNALSYM COR_E_FIXUPSINEXE}
  COR_E_NO_LOADLIBRARY_ALLOWED    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $101A);     // Attempt to LoadLibrary a managed image in an improper way (only assemblies with EAT's area allowed.)
  {$EXTERNALSYM COR_E_NO_LOADLIBRARY_ALLOWED}
  COR_E_NEWER_RUNTIME             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $101B);     // The assembly is built by a runtime newer than the currently loaded runtime, and cannot be loaded.
  {$EXTERNALSYM COR_E_NEWER_RUNTIME}
  COR_E_CANNOT_SET_POLICY         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $101C);     // Unable to set app domain security policy after non-GAC domain neutral assemblies are loaded
  {$EXTERNALSYM COR_E_CANNOT_SET_POLICY}
  COR_E_CANNOT_SPECIFY_EVIDENCE   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $101D);     // Unable to use assembly evidence after non-GAC domain neutral assemblies are loaded
  {$EXTERNALSYM COR_E_CANNOT_SPECIFY_EVIDENCE}

// The CLR hosting support reserves 0x1020-0x102F.
  HOST_E_DEADLOCK                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1020);             // Host detects deadlock on a blocking operation
  {$EXTERNALSYM HOST_E_DEADLOCK}
  HOST_E_INTERRUPTED              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1021);             // Host interrupts a wait, similar to APC
  {$EXTERNALSYM HOST_E_INTERRUPTED}
  HOST_E_INVALIDOPERATION         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1022);        // The operation is invalid
  {$EXTERNALSYM HOST_E_INVALIDOPERATION}
  HOST_E_CLRNOTAVAILABLE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1023);         // CLR has been disabled due to unrecoverable error
  {$EXTERNALSYM HOST_E_CLRNOTAVAILABLE}
  HOST_E_TIMEOUT                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1024);                 // A wait times out
  {$EXTERNALSYM HOST_E_TIMEOUT}
  HOST_E_NOT_OWNER                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1025);               //
  {$EXTERNALSYM HOST_E_NOT_OWNER}
  HOST_E_ABANDONED                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1026);               // An event is abandoned
  {$EXTERNALSYM HOST_E_ABANDONED}
  HOST_E_EXITPROCESS_THREADABORT  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1027); // ExitProcess due to ThreadAbort escalation
  {$EXTERNALSYM HOST_E_EXITPROCESS_THREADABORT}
  HOST_E_EXITPROCESS_ADUNLOAD     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1028);    // ExitProcess due to AD Unload escalation
  {$EXTERNALSYM HOST_E_EXITPROCESS_ADUNLOAD}
  HOST_E_EXITPROCESS_TIMEOUT      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1029);     // ExitProcess due to Timeout escalation
  {$EXTERNALSYM HOST_E_EXITPROCESS_TIMEOUT}
  HOST_E_EXITPROCESS_OUTOFMEMORY  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $102a); // ExitProcess due to OutOfMemory escalation
  {$EXTERNALSYM HOST_E_EXITPROCESS_OUTOFMEMORY}
  HOST_E_EXITPROCESS_STACKOVERFLOW = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $102b); // ExitProcess due to StackOverflow escalation
  {$EXTERNALSYM HOST_E_EXITPROCESS_STACKOVERFLOW}

//**** Assembly Cache errors
  COR_E_MODULE_HASH_CHECK_FAILED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1039);      // The check of the module's hash failed.
  {$EXTERNALSYM COR_E_MODULE_HASH_CHECK_FAILED}
  FUSION_E_REF_DEF_MISMATCH       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1040);     // The located assembly's manifest definition does not match the assembly reference.
  {$EXTERNALSYM FUSION_E_REF_DEF_MISMATCH}
  FUSION_E_INVALID_PRIVATE_ASM_LOCATION = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1041); // The private assembly was located outside the appbase directory.
  {$EXTERNALSYM FUSION_E_INVALID_PRIVATE_ASM_LOCATION}
  FUSION_E_ASM_MODULE_MISSING     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1042);     // A module specified in the manifest was not found.
  {$EXTERNALSYM FUSION_E_ASM_MODULE_MISSING}
  FUSION_E_UNEXPECTED_MODULE_FOUND = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1043);    // Modules which are not in the manifest were streamed in.
  {$EXTERNALSYM FUSION_E_UNEXPECTED_MODULE_FOUND}
  FUSION_E_PRIVATE_ASM_DISALLOWED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1044);     // A strongly-named assembly is required.
  {$EXTERNALSYM FUSION_E_PRIVATE_ASM_DISALLOWED}
  FUSION_E_SIGNATURE_CHECK_FAILED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1045);     // The check of the signature failed.
  {$EXTERNALSYM FUSION_E_SIGNATURE_CHECK_FAILED}
  FUSION_E_DATABASE_ERROR         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1046);     // An unexpected error was encountered in the Assembly Cache database.
  {$EXTERNALSYM FUSION_E_DATABASE_ERROR}
  FUSION_E_INVALID_NAME           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1047);     // The given assembly name or codebase was invalid.
  {$EXTERNALSYM FUSION_E_INVALID_NAME}
  FUSION_E_CODE_DOWNLOAD_DISABLED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1048);     // HTTP download of assemblies has been disabled for this appdomain.
  {$EXTERNALSYM FUSION_E_CODE_DOWNLOAD_DISABLED}
  FUSION_E_UNINSTALL_DISALLOWED   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1049);     // Uninstall of given assembly is not allowed.
  {$EXTERNALSYM FUSION_E_UNINSTALL_DISALLOWED}
  FUSION_E_HOST_GAC_ASM_MISMATCH  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1050);     // Assembly in host store has a different signature than assembly in GAC
  {$EXTERNALSYM FUSION_E_HOST_GAC_ASM_MISMATCH}
  FUSION_E_LOADFROM_BLOCKED       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1051);     // Hosted environment doesn't permit loading by location
  {$EXTERNALSYM FUSION_E_LOADFROM_BLOCKED}
  FUSION_E_CACHEFILE_FAILED       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1052);     // Failed to add file to AppDomain cache
  {$EXTERNALSYM FUSION_E_CACHEFILE_FAILED}

//=============================================================================
// THE VALIDATOR IS CURRENTLY USING ERROR CODES STARTING WITH 0x1050 ONWARDS.
// LOOK AT ERROR CODES STARTING FROM VLDTR_E_AS_NAMENULL.  JUST A NOTE IN CASE
// THE EE EVER COMES TO THE POINT OF NEEDING THOSE!!!
//=============================================================================

//**** Generic errors.
  CLDB_E_FILE_BADREAD             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1100);     // Error occured during a read.
  {$EXTERNALSYM CLDB_E_FILE_BADREAD}
  CLDB_E_FILE_BADWRITE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1101);     // Error occured during a write.
  {$EXTERNALSYM CLDB_E_FILE_BADWRITE}
  CLDB_E_FILE_READONLY            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1103);     // File is read only.
  {$EXTERNALSYM CLDB_E_FILE_READONLY}
  CLDB_E_NAME_ERROR               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1105);     // An ill-formed name was given.
  {$EXTERNALSYM CLDB_E_NAME_ERROR}
  CLDB_S_TRUNCATION               = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1106);   // STATUS: Data value was truncated.
  {$EXTERNALSYM CLDB_S_TRUNCATION}
  CLDB_E_TRUNCATION               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1106);     // ERROR:  Data value was truncated.
  {$EXTERNALSYM CLDB_E_TRUNCATION}
  CLDB_E_FILE_OLDVER              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1107);     // Old version error.
  {$EXTERNALSYM CLDB_E_FILE_OLDVER}
  CLDB_E_RELOCATED                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1108);     // A shared mem open failed to open at the originally
  {$EXTERNALSYM CLDB_E_RELOCATED}
                                                                                                                                //  assigned memory address.
  CLDB_S_NULL                     = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1109);   // NULL data value.
  {$EXTERNALSYM CLDB_S_NULL}
  CLDB_E_SMDUPLICATE              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $110A);     // Create of shared memory failed.  A memory mapping of the same name already exists.
  {$EXTERNALSYM CLDB_E_SMDUPLICATE}
  CLDB_E_NO_DATA                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $110B);     // There isn't .CLB data in the memory or stream.
  {$EXTERNALSYM CLDB_E_NO_DATA}
  CLDB_E_READONLY                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $110C);     // Database is read only.
  {$EXTERNALSYM CLDB_E_READONLY}
  CLDB_E_INCOMPATIBLE             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $110D);     // The importing scope is not comptabile with the emitting scope
  {$EXTERNALSYM CLDB_E_INCOMPATIBLE}

//**** Schema errors.
  CLDB_E_FILE_CORRUPT             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $110E);     // File is corrupt.
  {$EXTERNALSYM CLDB_E_FILE_CORRUPT}
  CLDB_E_SCHEMA_VERNOTFOUND       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $110F);   // Version %d of schema '%s' not found.
  {$EXTERNALSYM CLDB_E_SCHEMA_VERNOTFOUND}
  CLDB_E_BADUPDATEMODE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1110);     // cannot open a incrementally build scope for full update
  {$EXTERNALSYM CLDB_E_BADUPDATEMODE}

//**** Index errors.
  CLDB_E_INDEX_NONULLKEYS         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1121);     // Null value not allowed in unique index or primary key.
  {$EXTERNALSYM CLDB_E_INDEX_NONULLKEYS}
  CLDB_E_INDEX_DUPLICATE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1122);     // Unique index %s has been violated.
  {$EXTERNALSYM CLDB_E_INDEX_DUPLICATE}
  CLDB_E_INDEX_BADTYPE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1123);     // The columns data type is not allowed in an index.
  {$EXTERNALSYM CLDB_E_INDEX_BADTYPE}
  CLDB_E_INDEX_NOTFOUND           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1124);     // Index %s not found.
  {$EXTERNALSYM CLDB_E_INDEX_NOTFOUND}
  CLDB_S_INDEX_TABLESCANREQUIRED  = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1125);   // Table scan required to run query.
  {$EXTERNALSYM CLDB_S_INDEX_TABLESCANREQUIRED}

//**** Record errors.
  CLDB_E_RECORD_NOTFOUND          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1130);     // Record wasn't found on lookup.
  {$EXTERNALSYM CLDB_E_RECORD_NOTFOUND}
  CLDB_E_RECORD_OVERFLOW          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1131);     // Too many records were returned for criteria.
  {$EXTERNALSYM CLDB_E_RECORD_OVERFLOW}
  CLDB_E_RECORD_DUPLICATE         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1132);     // Record is a duplicate.
  {$EXTERNALSYM CLDB_E_RECORD_DUPLICATE}
  CLDB_E_RECORD_PKREQUIRED        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1133);    // Primary key value is required.
  {$EXTERNALSYM CLDB_E_RECORD_PKREQUIRED}
  CLDB_E_RECORD_DELETED           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1134);     // Record is valid but deleted.
  {$EXTERNALSYM CLDB_E_RECORD_DELETED}
  CLDB_E_RECORD_OUTOFORDER        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1135);    // Record is emitted out of order.
  {$EXTERNALSYM CLDB_E_RECORD_OUTOFORDER}

//**** Column errors.
  CLDB_E_COLUMN_OVERFLOW          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1140);     // Data too large.
  {$EXTERNALSYM CLDB_E_COLUMN_OVERFLOW}
  CLDB_E_COLUMN_READONLY          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1141);     // Column cannot be changed.
  {$EXTERNALSYM CLDB_E_COLUMN_READONLY}
  CLDB_E_COLUMN_SPECIALCOL        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1142);    // Too many RID or primary key columns, 1 is max.
  {$EXTERNALSYM CLDB_E_COLUMN_SPECIALCOL}
  CLDB_E_COLUMN_PKNONULLS         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1143);     // Primary key column %s may not allow the null value.
  {$EXTERNALSYM CLDB_E_COLUMN_PKNONULLS}

//**** Table errors.
  CLDB_E_TABLE_CANTDROP           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1150);     // Can't auto-drop table while open.
  {$EXTERNALSYM CLDB_E_TABLE_CANTDROP}

//**** Object errors.
  CLDB_E_OBJECT_NOTFOUND          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1151);     // Object was not found in the database.
  {$EXTERNALSYM CLDB_E_OBJECT_NOTFOUND}
  CLDB_E_OBJECT_COLNOTFOUND       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1152);   // The column was not found.
  {$EXTERNALSYM CLDB_E_OBJECT_COLNOTFOUND}

//**** Vector errors.
  CLDB_E_VECTOR_BADINDEX          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1153);     // The index given was invalid.
  {$EXTERNALSYM CLDB_E_VECTOR_BADINDEX}

//**** Heap errors;
  CLDB_E_TOO_BIG                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1154);     // A blob or string was too big.
  {$EXTERNALSYM CLDB_E_TOO_BIG}

//**** IMeta* errors.
  META_E_INVALID_TOKEN_TYPE       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $115f); // A token of the wrong type passed to a metadata function.
  {$EXTERNALSYM META_E_INVALID_TOKEN_TYPE}

  TLBX_E_INVALID_TYPEINFO         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1160); // Typelib import: invalid type, not converted.
  {$EXTERNALSYM TLBX_E_INVALID_TYPEINFO}
  TLBX_E_INVALID_TYPEINFO_UNNAMED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1161); // Typelib import: invalid type, not converted -- name unknown.
  {$EXTERNALSYM TLBX_E_INVALID_TYPEINFO_UNNAMED}
  TLBX_E_CTX_NESTED               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1162); // Typelib export: Format string for nested contexts.
  {$EXTERNALSYM TLBX_E_CTX_NESTED}
  TLBX_E_ERROR_MESSAGE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1163); // Typelib export: Error message wrapper.
  {$EXTERNALSYM TLBX_E_ERROR_MESSAGE}
  TLBX_E_CANT_SAVE                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1164); // Typelib export: cant "SaveAllChanges()"
  {$EXTERNALSYM TLBX_E_CANT_SAVE}
  TLBX_W_LIBNOTREGISTERED         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1165); // Typelib export: type library is not registered.
  {$EXTERNALSYM TLBX_W_LIBNOTREGISTERED}
  TLBX_E_CANTLOADLIBRARY          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1166); // Typelib export: type library cannot be loaded.
  {$EXTERNALSYM TLBX_E_CANTLOADLIBRARY}
  TLBX_E_BAD_VT_TYPE              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1167); // Typelib import: invalid VT_*, not converted.
  {$EXTERNALSYM TLBX_E_BAD_VT_TYPE}
  TLBX_E_NO_MSCOREE_TLB           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1168); // Typelib export: can't load mscoree.tlb
  {$EXTERNALSYM TLBX_E_NO_MSCOREE_TLB}
  TLBX_E_BAD_MSCOREE_TLB          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1169); // Typelib export: can't get a required typeinfo from mscoree.tlb.
  {$EXTERNALSYM TLBX_E_BAD_MSCOREE_TLB}
  TLBX_E_TLB_EXCEPTION            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $116a); // Typelib import: fault reading a typelib.
  {$EXTERNALSYM TLBX_E_TLB_EXCEPTION}
  TLBX_E_MULTIPLE_LCIDS           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $116b); // Typelib import: Multiple LCID's parameters on a method.
  {$EXTERNALSYM TLBX_E_MULTIPLE_LCIDS}
  TLBX_I_TYPEINFO_IMPORTED        = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $116c); // Typelib import: progress report.
  {$EXTERNALSYM TLBX_I_TYPEINFO_IMPORTED}
  TLBX_E_AMBIGUOUS_RETURN         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $116d); // Typelib import: duplicate or ambiguous return types.
  {$EXTERNALSYM TLBX_E_AMBIGUOUS_RETURN}
  TLBX_E_DUPLICATE_TYPE_NAME      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $116e); // Typelib import: duplicate name (due to user-defined name).
  {$EXTERNALSYM TLBX_E_DUPLICATE_TYPE_NAME}
  TLBX_I_USEIUNKNOWN              = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $116f); // Typelib export: substituted IUnknown for type.
  {$EXTERNALSYM TLBX_I_USEIUNKNOWN}

  TLBX_I_UNCONVERTABLE_ARGS       = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1170); // Typelib import: signature can't be converted (eg, struct**)
  {$EXTERNALSYM TLBX_I_UNCONVERTABLE_ARGS}
  TLBX_I_UNCONVERTABLE_FIELD      = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1171); // Typelib import: signature can't be converted (eg, struct**)
  {$EXTERNALSYM TLBX_I_UNCONVERTABLE_FIELD}
  TLBX_I_NONSEQUENTIALSTRUCT      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1172); // Typelib export: Can't convert non-sequential structs.
  {$EXTERNALSYM TLBX_I_NONSEQUENTIALSTRUCT}
  TLBX_W_WARNING_MESSAGE          = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1173); // Typelib export: Warning message wrapper.
  {$EXTERNALSYM TLBX_W_WARNING_MESSAGE}
  TLBX_I_RESOLVEREFFAILED         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1174); // Typelib import: The resolve ref call failed.
  {$EXTERNALSYM TLBX_I_RESOLVEREFFAILED}
  TLBX_E_ASANY                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1175); // Typelib export: Encounterd "AsAny" -- ignored.
  {$EXTERNALSYM TLBX_E_ASANY}
  TLBX_E_INVALIDLCIDPARAM         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1176); // Typelib export: Encounterd an LCID attribute set to an invalid param.
  {$EXTERNALSYM TLBX_E_INVALIDLCIDPARAM}
  TLBX_E_LCIDONDISPONLYITF        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1177); // Typelib export: Encounterd an LCID attribute on a disp only interface.
  {$EXTERNALSYM TLBX_E_LCIDONDISPONLYITF}
  TLBX_E_NONPUBLIC_FIELD          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1178); // Typelib export: Non-public field in public struct.
  {$EXTERNALSYM TLBX_E_NONPUBLIC_FIELD}
  TLBX_I_TYPE_EXPORTED            = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1179); // Typelib export: type exported
  {$EXTERNALSYM TLBX_I_TYPE_EXPORTED}
  TLBX_I_DUPLICATE_DISPID         = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $117A); // Typelib export: duplicate dispid -- auto corrected.
  {$EXTERNALSYM TLBX_I_DUPLICATE_DISPID}
  TLBX_E_BAD_NAMES                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $117B); // Typelib export: bad names list.
  {$EXTERNALSYM TLBX_E_BAD_NAMES}
  TLBX_I_REF_TYPE_AS_STRUCT       = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $117C); // Typelib export: referenct tyep had layout, exported as struct.
  {$EXTERNALSYM TLBX_I_REF_TYPE_AS_STRUCT}
  TLBX_E_GENERICINST_SIGNATURE    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $117D); // TypeLib export: generic type instance in signature.
  {$EXTERNALSYM TLBX_E_GENERICINST_SIGNATURE}
  TLBX_E_GENERICPAR_SIGNATURE     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $117E); // TypeLib export: generic type parameter in signature.
  {$EXTERNALSYM TLBX_E_GENERICPAR_SIGNATURE}
  TLBX_I_GENERIC_TYPE             = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $117F); // TypeLib export: generic type definition
  {$EXTERNALSYM TLBX_I_GENERIC_TYPE}

  META_E_DUPLICATE                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1180);     // Attempt to define an object that already exists.
  {$EXTERNALSYM META_E_DUPLICATE}
  META_E_GUID_REQUIRED            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1181);     // A guid was not provided where one was required.
  {$EXTERNALSYM META_E_GUID_REQUIRED}
  META_E_TYPEDEF_MISMATCH         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1182);     // Merge: an import typedef matched ns.name, but not version and guid.
  {$EXTERNALSYM META_E_TYPEDEF_MISMATCH}
  META_E_MERGE_COLLISION          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1183);     // Merge: conflict between import and emit
  {$EXTERNALSYM META_E_MERGE_COLLISION}
  TLBX_W_NON_INTEGRAL_CA_TYPE     = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1184); // TypeLib import: Ignoring IDL custom attribute -- does not have an integral value.
  {$EXTERNALSYM TLBX_W_NON_INTEGRAL_CA_TYPE}
  TLBX_W_IENUM_CA_ON_IUNK         = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1185); // TypeLib import: Ignoring IDL custom attribute -- using IEnum CA on an IUnknown derived interface.
  {$EXTERNALSYM TLBX_W_IENUM_CA_ON_IUNK}
  TLBX_E_NO_SAFEHANDLE_ARRAYS     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1186); // TypeLib export: detected array of SafeHandles
  {$EXTERNALSYM TLBX_E_NO_SAFEHANDLE_ARRAYS}
  META_E_METHD_NOT_FOUND          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1187); // Merge: Class already in emit scope, but member not found
  {$EXTERNALSYM META_E_METHD_NOT_FOUND}
  META_E_FIELD_NOT_FOUND          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1188); // Merge: Class already in emit scope, but member not found
  {$EXTERNALSYM META_E_FIELD_NOT_FOUND}
  META_S_PARAM_MISMATCH           = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1189); // Merge: Parameter information mismatched.
  {$EXTERNALSYM META_S_PARAM_MISMATCH}
  META_E_PARAM_MISMATCH           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1189); // Merge: Parameter information mismatched.
  {$EXTERNALSYM META_E_PARAM_MISMATCH}
  META_E_BADMETADATA              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $118A); // Merge: Inconsistency in meta data import scope
  {$EXTERNALSYM META_E_BADMETADATA}
  META_E_INTFCEIMPL_NOT_FOUND     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $118B); // Merge: Class already in emit scope, but interfaceimpl not found
  {$EXTERNALSYM META_E_INTFCEIMPL_NOT_FOUND}
  TLBX_E_NO_CRITICALHANDLE_ARRAYS = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $118C); // TypeLib export: detected array of CriticalHandles
  {$EXTERNALSYM TLBX_E_NO_CRITICALHANDLE_ARRAYS}
  META_E_CLASS_LAYOUT_INCONSISTENT = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $118D); // Merge: Class is duplicated but class layout information is not consistent
  {$EXTERNALSYM META_E_CLASS_LAYOUT_INCONSISTENT}
  META_E_FIELD_MARSHAL_NOT_FOUND  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $118E); // Merge: Field is duplicated but we cannot find the matching FieldMarshal information
  {$EXTERNALSYM META_E_FIELD_MARSHAL_NOT_FOUND}
  META_E_METHODSEM_NOT_FOUND      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $118F); // Merge:
  {$EXTERNALSYM META_E_METHODSEM_NOT_FOUND}

  META_E_EVENT_NOT_FOUND          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1190); // Merge: Method is duplicated but we cannot find the matching event info.
  {$EXTERNALSYM META_E_EVENT_NOT_FOUND}
  META_E_PROP_NOT_FOUND           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1191); // Merge: Method is duplicated but we cannot find the maching property info.
  {$EXTERNALSYM META_E_PROP_NOT_FOUND}
  META_E_BAD_SIGNATURE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1192); // Bad binary signature
  {$EXTERNALSYM META_E_BAD_SIGNATURE}
  META_E_BAD_INPUT_PARAMETER      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1193); // Bad input parameters
  {$EXTERNALSYM META_E_BAD_INPUT_PARAMETER}
  META_E_METHDIMPL_INCONSISTENT   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1194); // Merge: duplicated methods have inconsistent ImplFlags
  {$EXTERNALSYM META_E_METHDIMPL_INCONSISTENT}
  META_E_MD_INCONSISTENCY         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1195); // Merge: Inconsistency in meta data
  {$EXTERNALSYM META_E_MD_INCONSISTENCY}
  META_E_CANNOTRESOLVETYPEREF     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1196); // Cannot resolve typeref
  {$EXTERNALSYM META_E_CANNOTRESOLVETYPEREF}
  META_S_DUPLICATE                = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1197); // Attempt to define an object that already exists in valid scenerios.
  {$EXTERNALSYM META_S_DUPLICATE}
  META_E_STRINGSPACE_FULL         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1198); // No logical space left to create more user strings.
  {$EXTERNALSYM META_E_STRINGSPACE_FULL}
  META_E_UNEXPECTED_REMAP         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1199); // A TokenRemap occurred which we weren't prepared to handle.
  {$EXTERNALSYM META_E_UNEXPECTED_REMAP}
  META_E_HAS_UNMARKALL            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $119A); // Unmark all has been called already
  {$EXTERNALSYM META_E_HAS_UNMARKALL}
  META_E_MUST_CALL_UNMARKALL      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $119B); // Must call UnmarkAll first before marking.
  {$EXTERNALSYM META_E_MUST_CALL_UNMARKALL}
  META_E_GENERICPARAM_INCONSISTENT = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $119C); // Merge: duplicated types/methods have inconsistent GenericParams
  {$EXTERNALSYM META_E_GENERICPARAM_INCONSISTENT}
  META_E_EVENT_COUNTS             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $119D); // Merge: different event counts in import and emit scopes.
  {$EXTERNALSYM META_E_EVENT_COUNTS}
  META_E_PROPERTY_COUNTS          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $119E); // Merge: different property counts in import and emit scopes.
  {$EXTERNALSYM META_E_PROPERTY_COUNTS}
  META_E_TYPEDEF_MISSING          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $119F); // Merge: An input scope has a TypeRef which should but doesn't have a matching TypeDef.
  {$EXTERNALSYM META_E_TYPEDEF_MISSING}

  TLBX_E_CANT_LOAD_MODULE         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11A0); // TypeLib export: can't open the module to export.
  {$EXTERNALSYM TLBX_E_CANT_LOAD_MODULE}
  TLBX_E_CANT_LOAD_CLASS          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11A1); // TypeLib export: can't load a class.
  {$EXTERNALSYM TLBX_E_CANT_LOAD_CLASS}
  TLBX_E_NULL_MODULE              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11A2); // TypeLib export: the hMod of a loaded class is 0; can't export it.
  {$EXTERNALSYM TLBX_E_NULL_MODULE}
  TLBX_E_NO_CLSID_KEY             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11A3); // TypeLib export: no CLSID or Interface subkey to HKCR.
  {$EXTERNALSYM TLBX_E_NO_CLSID_KEY}
  TLBX_E_CIRCULAR_EXPORT          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11A4); // TypeLib export: attempt to export a CLB imported from a TLB.
  {$EXTERNALSYM TLBX_E_CIRCULAR_EXPORT}
  TLBX_E_CIRCULAR_EXPORT2          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B52); // TypeLib export: attempt to export a CLB imported from a TLB.
  {$EXTERNALSYM TLBX_E_CIRCULAR_EXPORT2}
  TLBX_E_CIRCULAR_IMPORT          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11A5); // TypeLib import: attempt to import a TLB exported from a CLB.
  {$EXTERNALSYM TLBX_E_CIRCULAR_IMPORT}
  TLBX_E_BAD_NATIVETYPE           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11A6); // TypeLib export: bad Native type in method signature.
  {$EXTERNALSYM TLBX_E_BAD_NATIVETYPE}
  TLBX_E_BAD_VTABLE               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11A7); // TypeLib import: non-increasing vtable (duplicate slots).
  {$EXTERNALSYM TLBX_E_BAD_VTABLE}
  TLBX_E_CRM_NON_STATIC           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11A8); // TypeLib export: the COM register method is non static.
  {$EXTERNALSYM TLBX_E_CRM_NON_STATIC}
  TLBX_E_CRM_INVALID_SIG          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11A9); // TypeLib export: the specified COM register method does not have the correct signature.
  {$EXTERNALSYM TLBX_E_CRM_INVALID_SIG}
  TLBX_E_CLASS_LOAD_EXCEPTION     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11AA); // TypeLib export: can't load, have the class load exception.
  {$EXTERNALSYM TLBX_E_CLASS_LOAD_EXCEPTION}
  TLBX_E_UNKNOWN_SIGNATURE        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11AB); // TypeLib export: unknown element in signature.
  {$EXTERNALSYM TLBX_E_UNKNOWN_SIGNATURE}
  TLBX_E_REFERENCED_TYPELIB       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11AC); // TypeLib import: reference to an external typelib.
  {$EXTERNALSYM TLBX_E_REFERENCED_TYPELIB}
  TLBX_S_REFERENCED_TYPELIB       = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $11AC); // TypeLib import: reference to an external typelib.
  {$EXTERNALSYM TLBX_S_REFERENCED_TYPELIB}
  TLBX_E_INVALID_NAMESPACE        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11AD); // TypeLib import: an imported typelib has an invalid namespace name.
  {$EXTERNALSYM TLBX_E_INVALID_NAMESPACE}
  TLBX_E_LAYOUT_ERROR             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11AE); // Typelib export: an error on Layout()
  {$EXTERNALSYM TLBX_E_LAYOUT_ERROR}
  TLBX_E_NOTIUNKNOWN              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11AF); // Typelib import: Interface not derived from IUnknown.
  {$EXTERNALSYM TLBX_E_NOTIUNKNOWN}

  TLBX_E_NONVISIBLEVALUECLASS     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11B0); // Typelib export: Non COM visible value type in method signature.
  {$EXTERNALSYM TLBX_E_NONVISIBLEVALUECLASS}
  TLBX_E_LPTSTR_NOT_ALLOWED       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11B1); // Typelib export: Types which contain the native type NATIVE_TYPE_LPTSTR are not allowed to be exported to COM.
  {$EXTERNALSYM TLBX_E_LPTSTR_NOT_ALLOWED}
  TLBX_E_AUTO_CS_NOT_ALLOWED      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11B2); // Typelib export: Types with a char set of auto are not allowed to be exported to COM.
  {$EXTERNALSYM TLBX_E_AUTO_CS_NOT_ALLOWED}
  TLBX_S_NOSTDINTERFACE           = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $11B3); // Typelib export: Found an interface marked as IID_IDispatch or IID_IUnknown.
  {$EXTERNALSYM TLBX_S_NOSTDINTERFACE}
  TLBX_S_DUPLICATE_DISPID         = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $11B4); // Typelib export: duplicate dispid found; ignored.
  {$EXTERNALSYM TLBX_S_DUPLICATE_DISPID}
  TLBX_E_ENUM_VALUE_INVALID       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11B5); // Typelib export: The enum value is not legal for a typelib.
  {$EXTERNALSYM TLBX_E_ENUM_VALUE_INVALID}
  TLBX_E_DUPLICATE_IID            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11B6); // Typelib export: Duplicate IID
  {$EXTERNALSYM TLBX_E_DUPLICATE_IID}
  TLBX_E_NO_NESTED_ARRAYS         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11B7); // Tyeplib export: detected nested arrays.
  {$EXTERNALSYM TLBX_E_NO_NESTED_ARRAYS}
  TLBX_E_PARAM_ERROR_NAMED        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11B8); // Typelib import: param type couldn't be converted.
  {$EXTERNALSYM TLBX_E_PARAM_ERROR_NAMED}
  TLBX_E_PARAM_ERROR_UNNAMED      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11B9); // Typelib import: param type couldn't be converted -- param name unknown.
  {$EXTERNALSYM TLBX_E_PARAM_ERROR_UNNAMED}
  TLBX_E_AGNOST_SIGNATURE         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11BA); // TypeLib export: size agnostic element in signature.
  {$EXTERNALSYM TLBX_E_AGNOST_SIGNATURE}
  TLBX_E_CONVERT_FAIL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11BB); // TypeLib export: exporter failed.
  {$EXTERNALSYM TLBX_E_CONVERT_FAIL}
  TLBX_W_DUAL_NOT_DISPATCH        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11BC); // Typelib import: [dual] interface not derived from IDispatch.
  {$EXTERNALSYM TLBX_W_DUAL_NOT_DISPATCH}
  TLBX_E_BAD_SIGNATURE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11BD); // Typelib export: unconvertable signature (use specific error for reporting!)
  {$EXTERNALSYM TLBX_E_BAD_SIGNATURE}
  TLBX_E_ARRAY_NEEDS_NT_FIXED     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11BE); // Typelib export: non-fixed/non-safearray array in struct
  {$EXTERNALSYM TLBX_E_ARRAY_NEEDS_NT_FIXED}
  TLBX_E_CLASS_NEEDS_NT_INTF      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11BF); // Typelib export: non-interface class in struct
  {$EXTERNALSYM TLBX_E_CLASS_NEEDS_NT_INTF}

  META_E_CA_INVALID_TARGET        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11C0); // Known custom attribute on invalid target.
  {$EXTERNALSYM META_E_CA_INVALID_TARGET}
  META_E_CA_INVALID_VALUE         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11C1); // Known custom attribute had invalid value.
  {$EXTERNALSYM META_E_CA_INVALID_VALUE}
  META_E_CA_INVALID_BLOB          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11C2); // Known custom attribute blob is bad format.
  {$EXTERNALSYM META_E_CA_INVALID_BLOB}
  META_E_CA_REPEATED_ARG          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11C3); // Known custom attribute blob has repeated named argument.
  {$EXTERNALSYM META_E_CA_REPEATED_ARG}
  META_E_CA_UNKNOWN_ARGUMENT      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11C4); // Known custom attrubte named arg not recognized.
  {$EXTERNALSYM META_E_CA_UNKNOWN_ARGUMENT}
  META_E_CA_VARIANT_NYI           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11C5); // Known attribute named argument doesn't support variant.
  {$EXTERNALSYM META_E_CA_VARIANT_NYI}
  META_E_CA_ARRAY_NYI             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11C6); // Known attribute named argument doesn't support array.
  {$EXTERNALSYM META_E_CA_ARRAY_NYI}
  META_E_CA_UNEXPECTED_TYPE       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11C7); // Known attribute parser found unexpected type.
  {$EXTERNALSYM META_E_CA_UNEXPECTED_TYPE}
  META_E_CA_INVALID_ARGTYPE       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11C8); // Known attribute parser only handles fields -- no properties.
  {$EXTERNALSYM META_E_CA_INVALID_ARGTYPE}
  META_E_CA_INVALID_ARG_FOR_TYPE  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11C9); // Known attribute parser found an argument that is invalid for the object it is applied to.
  {$EXTERNALSYM META_E_CA_INVALID_ARG_FOR_TYPE}
  META_E_CA_INVALID_UUID          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11CA); // The format of the UUID was invalid.
  {$EXTERNALSYM META_E_CA_INVALID_UUID}
  META_E_CA_INVALID_MARSHALAS_FIELDS = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11CB); // The MarshalAs attribute has fields set that are not valid for the specified unmanaged type.
  {$EXTERNALSYM META_E_CA_INVALID_MARSHALAS_FIELDS}
  META_E_CA_NT_FIELDONLY          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11CC); // The specified unmanaged type is only valid on fields.
  {$EXTERNALSYM META_E_CA_NT_FIELDONLY}
  META_E_CA_NEGATIVE_PARAMINDEX   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11CD); // The parameter index cannot be negative.
  {$EXTERNALSYM META_E_CA_NEGATIVE_PARAMINDEX}
  META_E_CA_NEGATIVE_MULTIPLIER   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11CE); // The multiplier cannot be negative.
  {$EXTERNALSYM META_E_CA_NEGATIVE_MULTIPLIER}
  META_E_CA_NEGATIVE_CONSTSIZE    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11CF); // The constant size cannot be negative.
  {$EXTERNALSYM META_E_CA_NEGATIVE_CONSTSIZE}

  META_E_CA_FIXEDSTR_SIZE_REQUIRED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11D0); // A fixed string requires a size.
  {$EXTERNALSYM META_E_CA_FIXEDSTR_SIZE_REQUIRED}
  META_E_CA_CUSTMARSH_TYPE_REQUIRED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11D1); // A custom marshaler requires the custom marshaler type.
  {$EXTERNALSYM META_E_CA_CUSTMARSH_TYPE_REQUIRED}
  META_E_CA_FILENAME_REQUIRED     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11D2); // A DllImport attribute requires a filename.
  {$EXTERNALSYM META_E_CA_FILENAME_REQUIRED}
  TLBX_W_NO_PROPS_IN_EVENTS       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11D3); // TypeLib import: Detected properties in a source dispinterface.
  {$EXTERNALSYM TLBX_W_NO_PROPS_IN_EVENTS}
  META_E_NOT_IN_ENC_MODE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11D4); // SaveDelta was called without being in EnC mode
  {$EXTERNALSYM META_E_NOT_IN_ENC_MODE}
  TLBX_W_ENUM_VALUE_TOOBIG        = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $11D5); // Typelib export: The enum value is not legal for a typelib.
  {$EXTERNALSYM TLBX_W_ENUM_VALUE_TOOBIG}
  META_E_METHOD_COUNTS            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11D6); // Merge: different method counts in import and emit scopes.
  {$EXTERNALSYM META_E_METHOD_COUNTS}
  META_E_FIELD_COUNTS             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11D7); // Merge: different field counts in import and emit scopes.
  {$EXTERNALSYM META_E_FIELD_COUNTS}
  META_E_PARAM_COUNTS             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11D8); // Merge: different param counts in import and emit scopes.
  {$EXTERNALSYM META_E_PARAM_COUNTS}
  TLBX_W_EXPORTING_AUTO_LAYOUT    = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $11D9); // TypeLib export: Exporting an auto-layout type.
  {$EXTERNALSYM TLBX_W_EXPORTING_AUTO_LAYOUT}
  TLBX_E_TYPED_REF                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11DA); // TypeLib export: Exporting a TypedReference.
  {$EXTERNALSYM TLBX_E_TYPED_REF}
  TLBX_W_DEFAULT_INTF_NOT_VISIBLE = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $11DB); // TypeLib export: ComDefaultInterface is not COMVisible.
  {$EXTERNALSYM TLBX_W_DEFAULT_INTF_NOT_VISIBLE}
  TLBX_W_BAD_SAFEARRAYFIELD_NO_ELEMENTVT = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $11DE); // TypeLib export: System.Array SAFEARRAY field without a SafeArraySubType.
  {$EXTERNALSYM TLBX_W_BAD_SAFEARRAYFIELD_NO_ELEMENTVT}
  TLBX_W_LAYOUTCLASS_AS_INTERFACE = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $11DF); // TypeLib export: Class with layout parameter of field marked with UnmanagedType.Interface
  {$EXTERNALSYM TLBX_W_LAYOUTCLASS_AS_INTERFACE}
  TLBX_I_GENERIC_BASE_TYPE        = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $11E0); // TypeLib export: type deriving from a generic type.
  {$EXTERNALSYM TLBX_I_GENERIC_BASE_TYPE}
  TLBX_E_BITNESS_MISMATCH         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11E1); // TypeLib export: bitness of assembly doesn't match bitness of output type library
  {$EXTERNALSYM TLBX_E_BITNESS_MISMATCH}
  TLBX_E_EVENT_WITH_NEWENUM       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11E2); // TypeLib import: source interface with NewEnum member.
  {$EXTERNALSYM TLBX_E_EVENT_WITH_NEWENUM}
  TLBX_E_PROPGET_WITHOUT_RETURN   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11E3); // TypeLib import: propget without return type
  {$EXTERNALSYM TLBX_E_PROPGET_WITHOUT_RETURN}
  META_E_MISMATCHED_VISIBLITY     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11E4); // Merge - Match found for type/method/etc but differs in visiblity
  {$EXTERNALSYM META_E_MISMATCHED_VISIBLITY}
  META_E_CA_BAD_FRIENDS_ARGS      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11E5); // InternalsVisibileTo can't have a version, culture, or processor architecture
  {$EXTERNALSYM META_E_CA_BAD_FRIENDS_ARGS}
  META_E_CA_FRIENDS_SN_REQUIRED   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $11E6); // Strong-name signed assemblies can only grant friend access to strong name-signed assemblies
  {$EXTERNALSYM META_E_CA_FRIENDS_SN_REQUIRED}


// Return values from validator functions.
  VLDTR_S_WRN                     = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1200); // Warnings found in the validator.
  {$EXTERNALSYM VLDTR_S_WRN}
  VLDTR_S_ERR                     = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1201); // Errors found in the validator.
  {$EXTERNALSYM VLDTR_S_ERR}
  VLDTR_S_WRNERR                  = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1202); // Warnings and errors found in the validator.
  {$EXTERNALSYM VLDTR_S_WRNERR}

// Validator structural errors.
  VLDTR_E_RID_OUTOFRANGE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1203); // Rid is out of range.
  {$EXTERNALSYM VLDTR_E_RID_OUTOFRANGE}
  VLDTR_E_CDTKN_OUTOFRANGE        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1204); // Coded token type is out of range.
  {$EXTERNALSYM VLDTR_E_CDTKN_OUTOFRANGE}
  VLDTR_E_CDRID_OUTOFRANGE        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1205); // Coded rid is out of range.
  {$EXTERNALSYM VLDTR_E_CDRID_OUTOFRANGE}
  VLDTR_E_STRING_INVALID          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1206); // String offset is invalid.
  {$EXTERNALSYM VLDTR_E_STRING_INVALID}
  VLDTR_E_GUID_INVALID            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1207); // GUID offset is invalid.
  {$EXTERNALSYM VLDTR_E_GUID_INVALID}
  VLDTR_E_BLOB_INVALID            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1208); // Blob offset if invalid.
  {$EXTERNALSYM VLDTR_E_BLOB_INVALID}

// Validator semantic errors.
  VLDTR_E_MOD_MULTI               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1209); // Multiple module records found.
  {$EXTERNALSYM VLDTR_E_MOD_MULTI}
  VLDTR_E_MOD_NULLMVID            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $120A); // Module has null MVID.
  {$EXTERNALSYM VLDTR_E_MOD_NULLMVID}
  VLDTR_E_TR_NAMENULL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $120B); // TypeRef name is NULL.
  {$EXTERNALSYM VLDTR_E_TR_NAMENULL}
  VLDTR_E_TR_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $120C); // TypeRef has a dup.
  {$EXTERNALSYM VLDTR_E_TR_DUP}
  VLDTR_E_TD_NAMENULL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $120D); // TypeDef name is NULL.
  {$EXTERNALSYM VLDTR_E_TD_NAMENULL}
  VLDTR_E_TD_DUPNAME              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $120E); // TypeDef has a dup based on name+namespace.
  {$EXTERNALSYM VLDTR_E_TD_DUPNAME}
  VLDTR_E_TD_DUPGUID              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $120F); // TypeDef has a dup based on GUID.
  {$EXTERNALSYM VLDTR_E_TD_DUPGUID}
  VLDTR_E_TD_NOTIFACEOBJEXTNULL   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1210); // TypeDef that's not an Interface and not System.Object extends nil parent.
  {$EXTERNALSYM VLDTR_E_TD_NOTIFACEOBJEXTNULL}
  VLDTR_E_TD_OBJEXTENDSNONNULL    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1211); // System.Object extends a non-nil parent.
  {$EXTERNALSYM VLDTR_E_TD_OBJEXTENDSNONNULL}
  VLDTR_E_TD_EXTENDSSEALED        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1212); // TypeDef extends sealed class.
  {$EXTERNALSYM VLDTR_E_TD_EXTENDSSEALED}
  VLDTR_E_TD_DLTNORTSPCL          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1213); // TypeDef is Deleted but not marked with RTSpecialName.
  {$EXTERNALSYM VLDTR_E_TD_DLTNORTSPCL}
  VLDTR_E_TD_RTSPCLNOTDLT         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1214); // TypeDef is marked RTSpecialName, but is not a Deleted record.
  {$EXTERNALSYM VLDTR_E_TD_RTSPCLNOTDLT}
  VLDTR_E_MI_DECLPRIV             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1215); // MethodImpl's Decl is private
  {$EXTERNALSYM VLDTR_E_MI_DECLPRIV}
  VLDTR_E_AS_BADNAME              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1216); // Assembly [Ref] name has path and/or extension.
  {$EXTERNALSYM VLDTR_E_AS_BADNAME}
  VLDTR_E_FILE_SYSNAME            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1217); // File has a system name (con, com, aux, etc.).
  {$EXTERNALSYM VLDTR_E_FILE_SYSNAME}
  VLDTR_E_MI_BODYSTATIC           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1218); // MethodImpl's body is static.
  {$EXTERNALSYM VLDTR_E_MI_BODYSTATIC}
  VLDTR_E_TD_IFACENOTABS          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1219); // TypeDef is marked Interface but not Abstract.
  {$EXTERNALSYM VLDTR_E_TD_IFACENOTABS}
  VLDTR_E_TD_IFACEPARNOTNIL       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $121A); // TypeDef is marked Interface but parent is not Nil.
  {$EXTERNALSYM VLDTR_E_TD_IFACEPARNOTNIL}
  VLDTR_E_TD_IFACEGUIDNULL        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $121B); // TypeDef is marked Interface but GUID is NULL.
  {$EXTERNALSYM VLDTR_E_TD_IFACEGUIDNULL}
  VLDTR_E_MI_DECLFINAL            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $121C); // TMethodImpl's Decl is final.
  {$EXTERNALSYM VLDTR_E_MI_DECLFINAL}
  VLDTR_E_TD_VTNOTSEAL            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $121D); // TypeDef is marked ValueType but not marked Sealed.
  {$EXTERNALSYM VLDTR_E_TD_VTNOTSEAL}
  VLDTR_E_PD_BADFLAGS             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $121E); // Param has extra bits in flags.
  {$EXTERNALSYM VLDTR_E_PD_BADFLAGS}
  VLDTR_E_IFACE_DUP               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $121F); // InterfaceImpl has a dup.
  {$EXTERNALSYM VLDTR_E_IFACE_DUP}
  VLDTR_E_MR_NAMENULL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1220); // MemberRef name is NULL.
  {$EXTERNALSYM VLDTR_E_MR_NAMENULL}
  VLDTR_E_MR_VTBLNAME             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1221); // MemberRef has an invalid name, _VtblGap*.
  {$EXTERNALSYM VLDTR_E_MR_VTBLNAME}
  VLDTR_E_MR_DELNAME              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1222); // MemberRef has an invalid name, _Deleted*.
  {$EXTERNALSYM VLDTR_E_MR_DELNAME}
  VLDTR_E_MR_PARNIL               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1223); // MemberRef parent Nil in a PE file.
  {$EXTERNALSYM VLDTR_E_MR_PARNIL}
  VLDTR_E_MR_BADCALLINGCONV       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1224); // MemberRef has invalid calling convention.
  {$EXTERNALSYM VLDTR_E_MR_BADCALLINGCONV}
  VLDTR_E_MR_NOTVARARG            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1225); // MemberRef has Method parent but calling convention is not VARARG.
  {$EXTERNALSYM VLDTR_E_MR_NOTVARARG}
  VLDTR_E_MR_NAMEDIFF             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1226); // MemberRef name different from parent MethodDef.
  {$EXTERNALSYM VLDTR_E_MR_NAMEDIFF}
  VLDTR_E_MR_SIGDIFF              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1227); // MemberRef signature different from parent MethodDef.
  {$EXTERNALSYM VLDTR_E_MR_SIGDIFF}
  VLDTR_E_MR_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1228); // MemberRef has a dup.
  {$EXTERNALSYM VLDTR_E_MR_DUP}
  VLDTR_E_CL_TDAUTO               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1229); // ClassLayout parent TypeDef is marked AutoLayout.
  {$EXTERNALSYM VLDTR_E_CL_TDAUTO}
  VLDTR_E_CL_BADPCKSZ             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $122A); // ClassLayout has bad PackingSize.
  {$EXTERNALSYM VLDTR_E_CL_BADPCKSZ}
  VLDTR_E_CL_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $122B); // ClassLayout has dup.
  {$EXTERNALSYM VLDTR_E_CL_DUP}
  VLDTR_E_FL_BADOFFSET            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $122C); // FieldLayout2 has bad offset.
  {$EXTERNALSYM VLDTR_E_FL_BADOFFSET}
  VLDTR_E_FL_TDNIL                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $122D); // FieldLayout2 has field with nil parent.
  {$EXTERNALSYM VLDTR_E_FL_TDNIL}
  VLDTR_E_FL_NOCL                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $122E); // FieldLayout2 has no ClassLayout record.
  {$EXTERNALSYM VLDTR_E_FL_NOCL}
  VLDTR_E_FL_TDNOTEXPLCT          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $122F); // FieldLayout2 parent TypeDef is not marked with ExplicitLayout.
  {$EXTERNALSYM VLDTR_E_FL_TDNOTEXPLCT}
  VLDTR_E_FL_FLDSTATIC            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1230); // FieldLayout2 has field marked Static.
  {$EXTERNALSYM VLDTR_E_FL_FLDSTATIC}
  VLDTR_E_FL_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1231); // FieldLayout2 has a dup.
  {$EXTERNALSYM VLDTR_E_FL_DUP}
  VLDTR_E_MODREF_NAMENULL         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1232); // ModuleRef name is NULL.
  {$EXTERNALSYM VLDTR_E_MODREF_NAMENULL}
  VLDTR_E_MODREF_DUP              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1233); // ModuleRef has a dup.
  {$EXTERNALSYM VLDTR_E_MODREF_DUP}
  VLDTR_E_TR_BADSCOPE             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1234); // TypeRef has a bad resolution scope.
  {$EXTERNALSYM VLDTR_E_TR_BADSCOPE}
  VLDTR_E_TD_NESTEDNOENCL         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1235); // TypeDef marked nested has no encloser.
  {$EXTERNALSYM VLDTR_E_TD_NESTEDNOENCL}
  VLDTR_E_TD_EXTTRRES             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1236); // TypeDef extends a TypeRef which resolves to a TypeDef in the same module.
  {$EXTERNALSYM VLDTR_E_TD_EXTTRRES}
  VLDTR_E_SIGNULL                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1237); // Signature specified is zero-sized.
  {$EXTERNALSYM VLDTR_E_SIGNULL}
  VLDTR_E_SIGNODATA               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1238); // Signature does not have enough data at specified byte.
  {$EXTERNALSYM VLDTR_E_SIGNODATA}
  VLDTR_E_MD_BADCALLINGCONV       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1239); // Method signature has invalid calling convention.
  {$EXTERNALSYM VLDTR_E_MD_BADCALLINGCONV}
  VLDTR_E_MD_THISSTATIC           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $123A); // Method is marked static but has HASTHIS/EXPLICITTHIS set on the calling convention.
  {$EXTERNALSYM VLDTR_E_MD_THISSTATIC}
  VLDTR_E_MD_NOTTHISNOTSTATIC     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $123B); // Method is not marked static but is not HASTHIS/EXPLICITTHIS.
  {$EXTERNALSYM VLDTR_E_MD_NOTTHISNOTSTATIC}
  VLDTR_E_MD_NOARGCNT             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $123C); // Method signature is missing the argument count.
  {$EXTERNALSYM VLDTR_E_MD_NOARGCNT}
  VLDTR_E_SIG_MISSELTYPE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $123D); // Signature missing element type.
  {$EXTERNALSYM VLDTR_E_SIG_MISSELTYPE}
  VLDTR_E_SIG_MISSTKN             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $123E); // Signature missing token.
  {$EXTERNALSYM VLDTR_E_SIG_MISSTKN}
  VLDTR_E_SIG_TKNBAD              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $123F); // Signature has bad token.
  {$EXTERNALSYM VLDTR_E_SIG_TKNBAD}
  VLDTR_E_SIG_MISSFPTR            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1240); // Signature is missing function pointer.
  {$EXTERNALSYM VLDTR_E_SIG_MISSFPTR}
  VLDTR_E_SIG_MISSFPTRARGCNT      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1241); // Signature has function pointer missing argument count.
  {$EXTERNALSYM VLDTR_E_SIG_MISSFPTRARGCNT}
  VLDTR_E_SIG_MISSRANK            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1242); // Signature is missing rank specification.
  {$EXTERNALSYM VLDTR_E_SIG_MISSRANK}
  VLDTR_E_SIG_MISSNSIZE           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1243); // Signature is missing count of sized dimensions.
  {$EXTERNALSYM VLDTR_E_SIG_MISSNSIZE}
  VLDTR_E_SIG_MISSSIZE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1244); // Signature is missing size of dimension.
  {$EXTERNALSYM VLDTR_E_SIG_MISSSIZE}
  VLDTR_E_SIG_MISSNLBND           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1245); // Signature is missing count of lower bounds.
  {$EXTERNALSYM VLDTR_E_SIG_MISSNLBND}
  VLDTR_E_SIG_MISSLBND            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1246); // Signature is missing a lower bound.
  {$EXTERNALSYM VLDTR_E_SIG_MISSLBND}
  VLDTR_E_SIG_BADELTYPE           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1247); // Signature has bad element type.
  {$EXTERNALSYM VLDTR_E_SIG_BADELTYPE}
  VLDTR_E_SIG_MISSVASIZE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1248); // Signature has value array missing size.
  {$EXTERNALSYM VLDTR_E_SIG_MISSVASIZE}
  VLDTR_E_FD_BADCALLINGCONV       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1249); // Field signature has invalid calling convention.
  {$EXTERNALSYM VLDTR_E_FD_BADCALLINGCONV}
  VLDTR_E_MD_NAMENULL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $124A); // Method name is NULL.
  {$EXTERNALSYM VLDTR_E_MD_NAMENULL}
  VLDTR_E_MD_PARNIL               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $124B); // Method has parent NIL.
  {$EXTERNALSYM VLDTR_E_MD_PARNIL}
  VLDTR_E_MD_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $124C); // Method has dup.
  {$EXTERNALSYM VLDTR_E_MD_DUP}
  VLDTR_E_FD_NAMENULL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $124D); // Field name is NULL.
  {$EXTERNALSYM VLDTR_E_FD_NAMENULL}
  VLDTR_E_FD_PARNIL               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $124E); // Field parent is Nil.
  {$EXTERNALSYM VLDTR_E_FD_PARNIL}
  VLDTR_E_FD_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $124F); // Field has dup.
  {$EXTERNALSYM VLDTR_E_FD_DUP}
  VLDTR_E_AS_MULTI                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1250); // Multiple Assembly records found.
  {$EXTERNALSYM VLDTR_E_AS_MULTI}
  VLDTR_E_AS_NAMENULL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1251); // Assembly name is NULL.
  {$EXTERNALSYM VLDTR_E_AS_NAMENULL}
  VLDTR_E_SIG_TOKTYPEMISMATCH     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1252); // E_T_VALUETYPE<class token> or E_T_CLASS<vtype token>.
  {$EXTERNALSYM VLDTR_E_SIG_TOKTYPEMISMATCH}
  VLDTR_E_CL_TDINTF               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1253); // Class layout on an Interface.
  {$EXTERNALSYM VLDTR_E_CL_TDINTF}
  VLDTR_E_ASOS_OSPLTFRMIDINVAL    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1254); // AssemblyOS platform ID invalid.
  {$EXTERNALSYM VLDTR_E_ASOS_OSPLTFRMIDINVAL}
  VLDTR_E_AR_NAMENULL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1255); // AssemblyRef name is NULL.
  {$EXTERNALSYM VLDTR_E_AR_NAMENULL}
  VLDTR_E_TD_ENCLNOTNESTED        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1256); // TypeDef not nested has encloser.
  {$EXTERNALSYM VLDTR_E_TD_ENCLNOTNESTED}
  VLDTR_E_AROS_OSPLTFRMIDINVAL    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1257); // AssemblyRefOS has invalid platform ID.
  {$EXTERNALSYM VLDTR_E_AROS_OSPLTFRMIDINVAL}
  VLDTR_E_FILE_NAMENULL           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1258); // File name is NULL.
  {$EXTERNALSYM VLDTR_E_FILE_NAMENULL}
  VLDTR_E_CT_NAMENULL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1259); // ExportedType name is NULL.
  {$EXTERNALSYM VLDTR_E_CT_NAMENULL}
  VLDTR_E_TD_EXTENDSCHILD         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $125A); // TypeDef extends its own child.
  {$EXTERNALSYM VLDTR_E_TD_EXTENDSCHILD}
  VLDTR_E_MAR_NAMENULL            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $125B); // ManifestResource name is NULL.
  {$EXTERNALSYM VLDTR_E_MAR_NAMENULL}
  VLDTR_E_FILE_DUP                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $125C); // File has dup.
  {$EXTERNALSYM VLDTR_E_FILE_DUP}
  VLDTR_E_FILE_NAMEFULLQLFD       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $125D); // File name is fully qualified.
  {$EXTERNALSYM VLDTR_E_FILE_NAMEFULLQLFD}
  VLDTR_E_CT_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $125E); // ExportedType has dup.
  {$EXTERNALSYM VLDTR_E_CT_DUP}
  VLDTR_E_MAR_DUP                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $125F); // ManifestResource has dup.
  {$EXTERNALSYM VLDTR_E_MAR_DUP}
  VLDTR_E_MAR_NOTPUBPRIV          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1260); // ManifestResource is neither Public not Private.
  {$EXTERNALSYM VLDTR_E_MAR_NOTPUBPRIV}
  VLDTR_E_TD_ENUMNOVALUE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1261); // Enum has no "value__" field.
  {$EXTERNALSYM VLDTR_E_TD_ENUMNOVALUE}
  VLDTR_E_TD_ENUMVALSTATIC        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1262); // Enum's "value__" field is static.
  {$EXTERNALSYM VLDTR_E_TD_ENUMVALSTATIC}
  VLDTR_E_TD_ENUMVALNOTSN         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1263); // Enum's "value__" field is not SpecialName.
  {$EXTERNALSYM VLDTR_E_TD_ENUMVALNOTSN}
  VLDTR_E_TD_ENUMFLDNOTST         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1264); // Enum's field is not static.
  {$EXTERNALSYM VLDTR_E_TD_ENUMFLDNOTST}
  VLDTR_E_TD_ENUMFLDNOTLIT        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1265); // Enum's field is not literal.
  {$EXTERNALSYM VLDTR_E_TD_ENUMFLDNOTLIT}
  VLDTR_E_TD_ENUMNOLITFLDS        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1266); // Enum has no literal fields.
  {$EXTERNALSYM VLDTR_E_TD_ENUMNOLITFLDS}
  VLDTR_E_TD_ENUMFLDSIGMISMATCH   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1267); // Enum's field sig does not match value__ sig.
  {$EXTERNALSYM VLDTR_E_TD_ENUMFLDSIGMISMATCH}
  VLDTR_E_TD_ENUMVALNOT1ST        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1268); // Enum's "value__" field is not first.
  {$EXTERNALSYM VLDTR_E_TD_ENUMVALNOT1ST}
  VLDTR_E_FD_NOTVALUERTSN         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1269); // Field is RTSpecialName but name is not "value__".
  {$EXTERNALSYM VLDTR_E_FD_NOTVALUERTSN}
  VLDTR_E_FD_VALUEPARNOTENUM      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $126A); // Field "value__" in not Enum class.
  {$EXTERNALSYM VLDTR_E_FD_VALUEPARNOTENUM}
  VLDTR_E_FD_INSTINIFACE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $126B); // Instance field in interface.
  {$EXTERNALSYM VLDTR_E_FD_INSTINIFACE}
  VLDTR_E_FD_NOTPUBINIFACE        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $126C); // Non-public field in interface.
  {$EXTERNALSYM VLDTR_E_FD_NOTPUBINIFACE}
  VLDTR_E_FMD_GLOBALNOTPUBPRIVSC  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $126D); // Global field/method neither Public nor PrivateScope.
  {$EXTERNALSYM VLDTR_E_FMD_GLOBALNOTPUBPRIVSC}
  VLDTR_E_FMD_GLOBALNOTSTATIC     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $126E); // Global field/method not static.
  {$EXTERNALSYM VLDTR_E_FMD_GLOBALNOTSTATIC}
  VLDTR_E_FD_GLOBALNORVA          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $126F); // Global field has no RVA.
  {$EXTERNALSYM VLDTR_E_FD_GLOBALNORVA}
  VLDTR_E_MD_CTORZERORVA          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1270); // .ctor,.cctor has zero RVA.
  {$EXTERNALSYM VLDTR_E_MD_CTORZERORVA}
  VLDTR_E_FD_MARKEDNOMARSHAL      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1271); // Field is marked marshaled but has no marshaling rec.
  {$EXTERNALSYM VLDTR_E_FD_MARKEDNOMARSHAL}
  VLDTR_E_FD_MARSHALNOTMARKED     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1272); // Field has marshaling rec but is not marked marshaled.
  {$EXTERNALSYM VLDTR_E_FD_MARSHALNOTMARKED}
  VLDTR_E_FD_MARKEDNODEFLT        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1273); // Field is marked HasDefault but has no const value.
  {$EXTERNALSYM VLDTR_E_FD_MARKEDNODEFLT}
  VLDTR_E_FD_DEFLTNOTMARKED       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1274); // Field has const value rec but is not marked HasDefault.
  {$EXTERNALSYM VLDTR_E_FD_DEFLTNOTMARKED}
  VLDTR_E_FMD_MARKEDNOSECUR       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1275); // Field/method is marked HasSecurity but has no security rec.
  {$EXTERNALSYM VLDTR_E_FMD_MARKEDNOSECUR}
  VLDTR_E_FMD_SECURNOTMARKED      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1276); // Field/method has security rec but is not marked HasSecurity.
  {$EXTERNALSYM VLDTR_E_FMD_SECURNOTMARKED}
  VLDTR_E_FMD_PINVOKENOTSTATIC    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1277); // Field/method is PInvoke but is not marked Static.
  {$EXTERNALSYM VLDTR_E_FMD_PINVOKENOTSTATIC}
  VLDTR_E_FMD_MARKEDNOPINVOKE     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1278); // Field/method is marked PInvoke but has no ImplMap.
  {$EXTERNALSYM VLDTR_E_FMD_MARKEDNOPINVOKE}
  VLDTR_E_FMD_PINVOKENOTMARKED    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1279); // Field/method has ImplMap but is not marked PInvoke.
  {$EXTERNALSYM VLDTR_E_FMD_PINVOKENOTMARKED}
  VLDTR_E_FMD_BADIMPLMAP          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $127A); // Field/method has invalid ImplMap
  {$EXTERNALSYM VLDTR_E_FMD_BADIMPLMAP}
  VLDTR_E_IMAP_BADMODREF          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $127B); // ImplMap has invalid ModuleRef
  {$EXTERNALSYM VLDTR_E_IMAP_BADMODREF}
  VLDTR_E_IMAP_BADMEMBER          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $127C); // ImplMap has invalid MemberForwarded
  {$EXTERNALSYM VLDTR_E_IMAP_BADMEMBER}
  VLDTR_E_IMAP_BADIMPORTNAME      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $127D); // ImplMap has invalid ImportName
  {$EXTERNALSYM VLDTR_E_IMAP_BADIMPORTNAME}
  VLDTR_E_IMAP_BADCALLCONV        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $127E); // ImplMap has invalid call conv
  {$EXTERNALSYM VLDTR_E_IMAP_BADCALLCONV}
  VLDTR_E_FMD_BADACCESSFLAG       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $127F); // Field/method has invalid access flag
  {$EXTERNALSYM VLDTR_E_FMD_BADACCESSFLAG}
  VLDTR_E_FD_INITONLYANDLITERAL   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1280); // Field is InitOnly and Literal
  {$EXTERNALSYM VLDTR_E_FD_INITONLYANDLITERAL}
  VLDTR_E_FD_LITERALNOTSTATIC     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1281); // Field is Literal but not Static
  {$EXTERNALSYM VLDTR_E_FD_LITERALNOTSTATIC}
  VLDTR_E_FMD_RTSNNOTSN           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1282); // Field/method is RTSpec.Name but not Spec.Name
  {$EXTERNALSYM VLDTR_E_FMD_RTSNNOTSN}
  VLDTR_E_MD_ABSTPARNOTABST       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1283); // Method is abstract, parent is not
  {$EXTERNALSYM VLDTR_E_MD_ABSTPARNOTABST}
  VLDTR_E_MD_NOTSTATABSTININTF    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1284); // Method not static or abstract in interface
  {$EXTERNALSYM VLDTR_E_MD_NOTSTATABSTININTF}
  VLDTR_E_MD_NOTPUBININTF         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1285); // Method not public in interface
  {$EXTERNALSYM VLDTR_E_MD_NOTPUBININTF}
  VLDTR_E_MD_CTORININTF           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1286); // ctor in interface
  {$EXTERNALSYM VLDTR_E_MD_CTORININTF}
  VLDTR_E_MD_GLOBALCTORCCTOR      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1287); // global ctor or cctor
  {$EXTERNALSYM VLDTR_E_MD_GLOBALCTORCCTOR}
  VLDTR_E_MD_CTORSTATIC           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1288); // static ctor
  {$EXTERNALSYM VLDTR_E_MD_CTORSTATIC}
  VLDTR_E_MD_CTORNOTSNRTSN        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1289); // ctor,cctor not marked SpecialName,RTSpecialName
  {$EXTERNALSYM VLDTR_E_MD_CTORNOTSNRTSN}
  VLDTR_E_MD_CTORVIRT             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $128A); // virtual ctor,cctor
  {$EXTERNALSYM VLDTR_E_MD_CTORVIRT}
  VLDTR_E_MD_CTORABST             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $128B); // abstract ctor,cctor
  {$EXTERNALSYM VLDTR_E_MD_CTORABST}
  VLDTR_E_MD_CCTORNOTSTATIC       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $128C); // instance cctor
  {$EXTERNALSYM VLDTR_E_MD_CCTORNOTSTATIC}
  VLDTR_E_MD_ZERORVA              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $128D); // RVA=0, method not abstract or pinvoke or runtime, or reverse
  {$EXTERNALSYM VLDTR_E_MD_ZERORVA}
  VLDTR_E_MD_FINNOTVIRT           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $128E); // Method is final and not virtual
  {$EXTERNALSYM VLDTR_E_MD_FINNOTVIRT}
  VLDTR_E_MD_STATANDFINORVIRT     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $128F); // Method is static and final or virtual
  {$EXTERNALSYM VLDTR_E_MD_STATANDFINORVIRT}
  VLDTR_E_MD_ABSTANDFINAL         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1290); // Method is abstract and final
  {$EXTERNALSYM VLDTR_E_MD_ABSTANDFINAL}
  VLDTR_E_MD_ABSTANDIMPL          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1291); // Method is abstract and implemented
  {$EXTERNALSYM VLDTR_E_MD_ABSTANDIMPL}
  VLDTR_E_MD_ABSTANDPINVOKE       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1292); // Method is abstract and pinvoke
  {$EXTERNALSYM VLDTR_E_MD_ABSTANDPINVOKE}
  VLDTR_E_MD_ABSTNOTVIRT          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1293); // Method is abstract and not virtual
  {$EXTERNALSYM VLDTR_E_MD_ABSTNOTVIRT}
  VLDTR_E_MD_NOTABSTNOTIMPL       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1294); // Method is not abstract and not implemented
  {$EXTERNALSYM VLDTR_E_MD_NOTABSTNOTIMPL}
  VLDTR_E_MD_NOTABSTBADFLAGSRVA   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1295); // Method is not abstract and not (RVA!=0 or pinvoke or runtime)
  {$EXTERNALSYM VLDTR_E_MD_NOTABSTBADFLAGSRVA}
  VLDTR_E_MD_PRIVSCOPENORVA       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1296); // Method is PrivateScope and has RVA==0
  {$EXTERNALSYM VLDTR_E_MD_PRIVSCOPENORVA}
  VLDTR_E_MD_GLOBALABSTORVIRT     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1297); // Global method is abstract or virtual
  {$EXTERNALSYM VLDTR_E_MD_GLOBALABSTORVIRT}
  VLDTR_E_SIG_LONGFORM            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1298); // Signature uses long form
  {$EXTERNALSYM VLDTR_E_SIG_LONGFORM}
  VLDTR_E_MD_MULTIPLESEMANTICS    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1299); // Method has multiple semantics (warning)
  {$EXTERNALSYM VLDTR_E_MD_MULTIPLESEMANTICS}
  VLDTR_E_MD_INVALIDSEMANTICS     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $129A); // Method has invalid semantics (not event or prop)
  {$EXTERNALSYM VLDTR_E_MD_INVALIDSEMANTICS}
  VLDTR_E_MD_SEMANTICSNOTEXIST    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $129B); // Method has semantics assoc that does not exist
  {$EXTERNALSYM VLDTR_E_MD_SEMANTICSNOTEXIST}
  VLDTR_E_MI_DECLNOTVIRT          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $129C); // MethodImpl's Decl is not virtual
  {$EXTERNALSYM VLDTR_E_MI_DECLNOTVIRT}
  VLDTR_E_FMD_GLOBALITEM          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $129D); // Global field/method (warning,CLS)
  {$EXTERNALSYM VLDTR_E_FMD_GLOBALITEM}
  VLDTR_E_MD_MULTSEMANTICFLAGS    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $129E); // Method has multiple semantic flags set
  {$EXTERNALSYM VLDTR_E_MD_MULTSEMANTICFLAGS}
  VLDTR_E_MD_NOSEMANTICFLAGS      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $129F); // Method has no semantic flags set
  {$EXTERNALSYM VLDTR_E_MD_NOSEMANTICFLAGS}
  VLDTR_E_FD_FLDINIFACE           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12A0); // Field in Interface (warning, CLS)
  {$EXTERNALSYM VLDTR_E_FD_FLDINIFACE}
  VLDTR_E_AS_HASHALGID            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12A1); // Unrecognized Hash Alg ID (warning)
  {$EXTERNALSYM VLDTR_E_AS_HASHALGID}
  VLDTR_E_AS_PROCID               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12A2); // Unrecognized Processor ID in Assembly(warning)
  {$EXTERNALSYM VLDTR_E_AS_PROCID}
  VLDTR_E_AR_PROCID               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12A3); // Unrecognized Processor ID in AssemblyRef(warning)
  {$EXTERNALSYM VLDTR_E_AR_PROCID}
  VLDTR_E_CN_PARENTRANGE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12A4); // Constant: parent token out of range
  {$EXTERNALSYM VLDTR_E_CN_PARENTRANGE}
  VLDTR_E_AS_BADFLAGS             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12A5); // Invalid flags in Assembly
  {$EXTERNALSYM VLDTR_E_AS_BADFLAGS}
  VLDTR_E_TR_HASTYPEDEF           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12A6); // There is TypeDef with same name as TypeRef (warning)
  {$EXTERNALSYM VLDTR_E_TR_HASTYPEDEF}
  VLDTR_E_IFACE_BADIMPL           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12A7); // In InterfaceImpl, the implementing token is not TypeDef
  {$EXTERNALSYM VLDTR_E_IFACE_BADIMPL}
  VLDTR_E_IFACE_BADIFACE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12A8); // In InterfaceImpl, the implemented token is not TypeDef or TypeRef
  {$EXTERNALSYM VLDTR_E_IFACE_BADIFACE}
  VLDTR_E_TD_SECURNOTMARKED       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12A9); // TypeDef has security rec but not marked HasSecurity
  {$EXTERNALSYM VLDTR_E_TD_SECURNOTMARKED}
  VLDTR_E_TD_MARKEDNOSECUR        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12AA); // TypeDef marked HasSecurity but has no security rec
  {$EXTERNALSYM VLDTR_E_TD_MARKEDNOSECUR}
  VLDTR_E_MD_CCTORHASARGS         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12AB); // .cctor has arguments
  {$EXTERNALSYM VLDTR_E_MD_CCTORHASARGS}
  VLDTR_E_CT_BADIMPL              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12AC); // ExportedType has invalid Implementation
  {$EXTERNALSYM VLDTR_E_CT_BADIMPL}
  VLDTR_E_MI_ALIENBODY            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12AD); // MethodImpl has body from other class
  {$EXTERNALSYM VLDTR_E_MI_ALIENBODY}
  VLDTR_E_MD_CCTORCALLCONV        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12AE); // .cctor has invalid calling convention
  {$EXTERNALSYM VLDTR_E_MD_CCTORCALLCONV}
  VLDTR_E_MI_BADCLASS             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12AF); // MethodImpl has invalid Class token
  {$EXTERNALSYM VLDTR_E_MI_BADCLASS}
  VLDTR_E_MI_CLASSISINTF          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12B0); // MethodImpl declared in Interface
  {$EXTERNALSYM VLDTR_E_MI_CLASSISINTF}
  VLDTR_E_MI_BADDECL              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12B1); // MethodImpl has invalid MethodDeclaration token
  {$EXTERNALSYM VLDTR_E_MI_BADDECL}
  VLDTR_E_MI_BADBODY              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12B2); // MethodImpl has invalid MethodBody token
  {$EXTERNALSYM VLDTR_E_MI_BADBODY}
  VLDTR_E_MI_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12B3); // MethodImpl has duplicate
  {$EXTERNALSYM VLDTR_E_MI_DUP}
  VLDTR_E_FD_BADPARENT            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12B4); // Bad field parent
  {$EXTERNALSYM VLDTR_E_FD_BADPARENT}
  VLDTR_E_MD_PARAMOUTOFSEQ        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12B5); // Param out of sequence (warning)
  {$EXTERNALSYM VLDTR_E_MD_PARAMOUTOFSEQ}
  VLDTR_E_MD_PARASEQTOOBIG        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12B6); // Param's sequence num exceeds num of args
  {$EXTERNALSYM VLDTR_E_MD_PARASEQTOOBIG}
  VLDTR_E_MD_PARMMARKEDNOMARSHAL  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12B7); // Param marked HasMarshal, has no marshaling info
  {$EXTERNALSYM VLDTR_E_MD_PARMMARKEDNOMARSHAL}
  VLDTR_E_MD_PARMMARSHALNOTMARKED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12B8); // Param has marshaling info, not marked HasMarshal
  {$EXTERNALSYM VLDTR_E_MD_PARMMARSHALNOTMARKED}
  VLDTR_E_MD_PARMMARKEDNODEFLT    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12BA); // Param marked HasDefault, has no const value
  {$EXTERNALSYM VLDTR_E_MD_PARMMARKEDNODEFLT}
  VLDTR_E_MD_PARMDEFLTNOTMARKED   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12BB); // Param has const value, not marked HasDefault
  {$EXTERNALSYM VLDTR_E_MD_PARMDEFLTNOTMARKED}
  VLDTR_E_PR_BADSCOPE             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12BC); // Prop has invalid scope
  {$EXTERNALSYM VLDTR_E_PR_BADSCOPE}
  VLDTR_E_PR_NONAME               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12BD); // Prop has no name
  {$EXTERNALSYM VLDTR_E_PR_NONAME}
  VLDTR_E_PR_NOSIG                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12BE); // Prop has no signature
  {$EXTERNALSYM VLDTR_E_PR_NOSIG}
  VLDTR_E_PR_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12BF); // Prop has a duplicate
  {$EXTERNALSYM VLDTR_E_PR_DUP}
  VLDTR_E_PR_BADCALLINGCONV       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12C0); // Prop has bad calling convention
  {$EXTERNALSYM VLDTR_E_PR_BADCALLINGCONV}
  VLDTR_E_PR_MARKEDNODEFLT        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12C1); // Prop marked HasDefault, has no const value
  {$EXTERNALSYM VLDTR_E_PR_MARKEDNODEFLT}
  VLDTR_E_PR_DEFLTNOTMARKED       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12C2); // Prop has const value, not marked HasDefault
  {$EXTERNALSYM VLDTR_E_PR_DEFLTNOTMARKED}
  VLDTR_E_PR_BADSEMANTICS         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12C3); // Prop has method not (Setter,Getter, or Other)
  {$EXTERNALSYM VLDTR_E_PR_BADSEMANTICS}
  VLDTR_E_PR_BADMETHOD            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12C4); // Prop has method with invalid token
  {$EXTERNALSYM VLDTR_E_PR_BADMETHOD}
  VLDTR_E_PR_ALIENMETHOD          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12C5); // Prop has method from another class
  {$EXTERNALSYM VLDTR_E_PR_ALIENMETHOD}
  VLDTR_E_CN_BLOBNOTNULL          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12C6); // Const has non-null blob when it should not
  {$EXTERNALSYM VLDTR_E_CN_BLOBNOTNULL}
  VLDTR_E_CN_BLOBNULL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12C7); // Const has null value blob
  {$EXTERNALSYM VLDTR_E_CN_BLOBNULL}
  VLDTR_E_EV_BADSCOPE             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12C8); // Event has invalid scope
  {$EXTERNALSYM VLDTR_E_EV_BADSCOPE}
  VLDTR_E_EV_NONAME               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12CA); // Event has no name
  {$EXTERNALSYM VLDTR_E_EV_NONAME}
  VLDTR_E_EV_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12CB); // Event has a duplicate
  {$EXTERNALSYM VLDTR_E_EV_DUP}
  VLDTR_E_EV_BADEVTYPE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12CC); // Event has invalid EventType
  {$EXTERNALSYM VLDTR_E_EV_BADEVTYPE}
  VLDTR_E_EV_EVTYPENOTCLASS       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12CD); // Event's EventType is not a class
  {$EXTERNALSYM VLDTR_E_EV_EVTYPENOTCLASS}
  VLDTR_E_EV_BADSEMANTICS         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12CE); // Event has method not (AddOn,RemoveOn,Fire,Other)
  {$EXTERNALSYM VLDTR_E_EV_BADSEMANTICS}
  VLDTR_E_EV_BADMETHOD            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12CF); // Event has method with invalid token
  {$EXTERNALSYM VLDTR_E_EV_BADMETHOD}
  VLDTR_E_EV_ALIENMETHOD          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12D0); // Event has method from another class
  {$EXTERNALSYM VLDTR_E_EV_ALIENMETHOD}
  VLDTR_E_EV_NOADDON              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12D1); // Event has no AddOn method
  {$EXTERNALSYM VLDTR_E_EV_NOADDON}
  VLDTR_E_EV_NOREMOVEON           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12D2); // Event has no RemoveOn method
  {$EXTERNALSYM VLDTR_E_EV_NOREMOVEON}
  VLDTR_E_CT_DUPTDNAME            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12D3); // ExportedType has same name as TypeDef
  {$EXTERNALSYM VLDTR_E_CT_DUPTDNAME}
  VLDTR_E_MAR_BADOFFSET           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12D4); // MRes refers to non-PE file with offset !=0
  {$EXTERNALSYM VLDTR_E_MAR_BADOFFSET}
  VLDTR_E_DS_BADOWNER             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12D5); // Decl.security has invalid owner token
  {$EXTERNALSYM VLDTR_E_DS_BADOWNER}
  VLDTR_E_DS_BADFLAGS             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12D6); // Decl.security has invalid action flags
  {$EXTERNALSYM VLDTR_E_DS_BADFLAGS}
  VLDTR_E_DS_NOBLOB               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12D7); // Decl.security has no permission blob
  {$EXTERNALSYM VLDTR_E_DS_NOBLOB}
  VLDTR_E_MAR_BADIMPL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12D8); // Manifest resource has invalid Implementation
  {$EXTERNALSYM VLDTR_E_MAR_BADIMPL}
  VLDTR_E_MR_VARARGCALLINGCONV    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12DA); // MemberRef has VARARG calling conv. (CLS warning)
  {$EXTERNALSYM VLDTR_E_MR_VARARGCALLINGCONV}
  VLDTR_E_MD_CTORNOTVOID          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12DB); // .ctor,.cctor returning not void
  {$EXTERNALSYM VLDTR_E_MD_CTORNOTVOID}
  VLDTR_E_EV_FIRENOTVOID          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12DC); // Fire method returning not void
  {$EXTERNALSYM VLDTR_E_EV_FIRENOTVOID}
  VLDTR_E_AS_BADLOCALE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12DD); // Invalid locale
  {$EXTERNALSYM VLDTR_E_AS_BADLOCALE}
  VLDTR_E_CN_PARENTTYPE           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12DE); // Constant has parent of invalid type
  {$EXTERNALSYM VLDTR_E_CN_PARENTTYPE}
  VLDTR_E_SIG_SENTINMETHODDEF     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12DF); // E_T_SENTINEL in MethodDef signature
  {$EXTERNALSYM VLDTR_E_SIG_SENTINMETHODDEF}
  VLDTR_E_SIG_SENTMUSTVARARG      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12E0); // E_T_SENTINEL <=> VARARG
  {$EXTERNALSYM VLDTR_E_SIG_SENTMUSTVARARG}
  VLDTR_E_SIG_MULTSENTINELS       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12E1); // Multiple E_T_SENTINELs
  {$EXTERNALSYM VLDTR_E_SIG_MULTSENTINELS}
  VLDTR_E_SIG_LASTSENTINEL        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12E2); // E_T_SENTINEL not followed by type
  {$EXTERNALSYM VLDTR_E_SIG_LASTSENTINEL}
  VLDTR_E_SIG_MISSARG             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12E3); // Signature missing argument
  {$EXTERNALSYM VLDTR_E_SIG_MISSARG}
  VLDTR_E_SIG_BYREFINFIELD        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12E4); // Field of ByRef type
  {$EXTERNALSYM VLDTR_E_SIG_BYREFINFIELD}
  VLDTR_E_MD_SYNCMETHODINVTYPE    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12E5); // Synchronized method in value class
  {$EXTERNALSYM VLDTR_E_MD_SYNCMETHODINVTYPE}
  VLDTR_E_TD_NAMETOOLONG          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12E6); // TypeDef name too long
  {$EXTERNALSYM VLDTR_E_TD_NAMETOOLONG}
  VLDTR_E_AS_PROCDUP              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12E7); // Duplicate Assembly Processor
  {$EXTERNALSYM VLDTR_E_AS_PROCDUP}
  VLDTR_E_ASOS_DUP                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12E8); // Duplicate Assembly OS (ID+ver.major+ver.minor)
  {$EXTERNALSYM VLDTR_E_ASOS_DUP}
  VLDTR_E_MAR_BADFLAGS            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12E9); // Manifest Resource has bad flags
  {$EXTERNALSYM VLDTR_E_MAR_BADFLAGS}
  VLDTR_E_CT_NOTYPEDEFID          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12EA); // ExportedType has nil TypeDefId
  {$EXTERNALSYM VLDTR_E_CT_NOTYPEDEFID}
  VLDTR_E_FILE_BADFLAGS           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12EB); // File has bad flags
  {$EXTERNALSYM VLDTR_E_FILE_BADFLAGS}
  VLDTR_E_FILE_NULLHASH           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12EC); // File has no hash blob
  {$EXTERNALSYM VLDTR_E_FILE_NULLHASH}
  VLDTR_E_MOD_NONAME              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12ED); // Module has no name
  {$EXTERNALSYM VLDTR_E_MOD_NONAME}
  VLDTR_E_MOD_NAMEFULLQLFD        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12EE); // Module has fully-qualified name
  {$EXTERNALSYM VLDTR_E_MOD_NAMEFULLQLFD}
  VLDTR_E_TD_RTSPCLNOTSPCL        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12EF); // TypeDef is tdRTSpecialName but not tdSpecialName
  {$EXTERNALSYM VLDTR_E_TD_RTSPCLNOTSPCL}
  VLDTR_E_TD_EXTENDSIFACE         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12F0); // TypeDef extends interface
  {$EXTERNALSYM VLDTR_E_TD_EXTENDSIFACE}
  VLDTR_E_MD_CTORPINVOKE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12F1); // .ctor,.cctor is PInvokeImpl
  {$EXTERNALSYM VLDTR_E_MD_CTORPINVOKE}
  VLDTR_E_TD_SYSENUMNOTCLASS      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12F2); // System.Enum is not a class
  {$EXTERNALSYM VLDTR_E_TD_SYSENUMNOTCLASS}
  VLDTR_E_TD_SYSENUMNOTEXTVTYPE   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12F3); // System.Enum extends not System.ValueType
  {$EXTERNALSYM VLDTR_E_TD_SYSENUMNOTEXTVTYPE}
  VLDTR_E_MI_SIGMISMATCH          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12F4); // MethodImpl's Decl and Body signatures mismatch
  {$EXTERNALSYM VLDTR_E_MI_SIGMISMATCH}
  VLDTR_E_TD_ENUMHASMETHODS       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12F5); // TypeDef extends System.Enum but has methods
  {$EXTERNALSYM VLDTR_E_TD_ENUMHASMETHODS}
  VLDTR_E_TD_ENUMIMPLIFACE        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12F6); // TypeDef extends System.Enum but impls interface(s)
  {$EXTERNALSYM VLDTR_E_TD_ENUMIMPLIFACE}
  VLDTR_E_TD_ENUMHASPROP          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12F7); // TypeDef extends System.Enum but has prop(s)
  {$EXTERNALSYM VLDTR_E_TD_ENUMHASPROP}
  VLDTR_E_TD_ENUMHASEVENT         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12F8); // TypeDef extends System.Enum but has event(s)
  {$EXTERNALSYM VLDTR_E_TD_ENUMHASEVENT}
  VLDTR_E_TD_BADMETHODLST         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12F9); // TypeDef has MethodList > Nmethods+1
  {$EXTERNALSYM VLDTR_E_TD_BADMETHODLST}
  VLDTR_E_TD_BADFIELDLST          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12FA); // TypeDef has FieldList > Nfields+1
  {$EXTERNALSYM VLDTR_E_TD_BADFIELDLST}
  VLDTR_E_CN_BADTYPE              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12FB); // Constant has wrong type
  {$EXTERNALSYM VLDTR_E_CN_BADTYPE}
  VLDTR_E_TD_ENUMNOINSTFLD        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12FC); // Enum has no instance fields
  {$EXTERNALSYM VLDTR_E_TD_ENUMNOINSTFLD}
  VLDTR_E_TD_ENUMMULINSTFLD       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12FD); // Enum has multiple instance fields
  {$EXTERNALSYM VLDTR_E_TD_ENUMMULINSTFLD}


  VLDTR_E_INTERRUPTED             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12FE); // Validator has been interrupted by the VEHandler.
  {$EXTERNALSYM VLDTR_E_INTERRUPTED}
  VLDTR_E_NOTINIT                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $12FF); // Validator failed to initialize correctly.
  {$EXTERNALSYM VLDTR_E_NOTINIT}

  VLDTR_E_IFACE_NOTIFACE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B00); // Interface in InterfaceImpl is not marked tdInterface
  {$EXTERNALSYM VLDTR_E_IFACE_NOTIFACE}
  VLDTR_E_FD_RVAHASNORVA          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B01); // Field marked fdHasFieldRVA but has no RVA rec
  {$EXTERNALSYM VLDTR_E_FD_RVAHASNORVA}
  VLDTR_E_FD_RVAHASZERORVA        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B02); // Field marked fdHasFieldRVA has RVA =0
  {$EXTERNALSYM VLDTR_E_FD_RVAHASZERORVA}
  VLDTR_E_MD_RVAANDIMPLMAP        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B03); // Method has both RVA !=0 and ImplMap
  {$EXTERNALSYM VLDTR_E_MD_RVAANDIMPLMAP}
  VLDTR_E_TD_EXTRAFLAGS           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B04); // TypeDef has extraneous bits in flags
  {$EXTERNALSYM VLDTR_E_TD_EXTRAFLAGS}
  VLDTR_E_TD_EXTENDSITSELF        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B05); // TypeDef extends itself
  {$EXTERNALSYM VLDTR_E_TD_EXTENDSITSELF}
  VLDTR_E_TD_SYSVTNOTEXTOBJ       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B06); // System.ValueType does not extend System.Object
  {$EXTERNALSYM VLDTR_E_TD_SYSVTNOTEXTOBJ}
  VLDTR_E_TD_EXTTYPESPEC          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B07); // Class extends TypeSpec (warning)
  {$EXTERNALSYM VLDTR_E_TD_EXTTYPESPEC}
  VLDTR_E_TD_VTNOSIZE             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B09); // Value Class has zero size
  {$EXTERNALSYM VLDTR_E_TD_VTNOSIZE}
  VLDTR_E_TD_IFACESEALED          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B0A); // Interface is sealed
  {$EXTERNALSYM VLDTR_E_TD_IFACESEALED}
  VLDTR_E_NC_BADNESTED            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B0B); // Bad "nested" token in NestedClass
  {$EXTERNALSYM VLDTR_E_NC_BADNESTED}
  VLDTR_E_NC_BADENCLOSER          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B0C); // Bad "enclosing" token in NestedClass
  {$EXTERNALSYM VLDTR_E_NC_BADENCLOSER}
  VLDTR_E_NC_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B0D); // Duplicate NestedClass record
  {$EXTERNALSYM VLDTR_E_NC_DUP}
  VLDTR_E_NC_DUPENCLOSER          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B0E); // Duplicate NestedClass with different encloser
  {$EXTERNALSYM VLDTR_E_NC_DUPENCLOSER}
  VLDTR_E_FRVA_ZERORVA            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B0F); // RVA=0 in FieldRVA record
  {$EXTERNALSYM VLDTR_E_FRVA_ZERORVA}
  VLDTR_E_FRVA_BADFIELD           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B10); // Invalid field token in FieldRVA record
  {$EXTERNALSYM VLDTR_E_FRVA_BADFIELD}
  VLDTR_E_FRVA_DUPRVA             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B11); // Duplicate RVA in FieldRVA record
  {$EXTERNALSYM VLDTR_E_FRVA_DUPRVA}
  VLDTR_E_FRVA_DUPFIELD           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B12); // Duplicate field in FieldRVA record
  {$EXTERNALSYM VLDTR_E_FRVA_DUPFIELD}
  VLDTR_E_EP_BADTOKEN             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B13); // Bad token as entry point in CLR header
  {$EXTERNALSYM VLDTR_E_EP_BADTOKEN}
  VLDTR_E_EP_INSTANCE             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B14); // Entry point in CLR header is a token of instance method
  {$EXTERNALSYM VLDTR_E_EP_INSTANCE}
  VLDTR_E_TD_ENUMFLDBADTYPE       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B15); // Enum has non-integral underlying type
  {$EXTERNALSYM VLDTR_E_TD_ENUMFLDBADTYPE}
  VLDTR_E_MD_BADRVA               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B16); // Method has bogus RVA
  {$EXTERNALSYM VLDTR_E_MD_BADRVA}
  VLDTR_E_FD_LITERALNODEFAULT     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B17); // Literal field has no const value
  {$EXTERNALSYM VLDTR_E_FD_LITERALNODEFAULT}
  VLDTR_E_IFACE_METHNOTIMPL       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B18); // Class implementing an interface doesn't impl.one of methods
  {$EXTERNALSYM VLDTR_E_IFACE_METHNOTIMPL}
  VLDTR_E_CA_BADPARENT            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B19); // CA has invalid owner
  {$EXTERNALSYM VLDTR_E_CA_BADPARENT}
  VLDTR_E_CA_BADTYPE              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B1A); // CA has invalid type
  {$EXTERNALSYM VLDTR_E_CA_BADTYPE}
  VLDTR_E_CA_NOTCTOR              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B1B); // CA type is not .ctor
  {$EXTERNALSYM VLDTR_E_CA_NOTCTOR}
  VLDTR_E_CA_BADSIG               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B1C); // CA type has bad signature
  {$EXTERNALSYM VLDTR_E_CA_BADSIG}
  VLDTR_E_CA_NOSIG                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B1D); // CA type has no signature
  {$EXTERNALSYM VLDTR_E_CA_NOSIG}
  VLDTR_E_CA_BADPROLOG            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B1E); // CA blob has bad prolog (not 0x01 0x00)
  {$EXTERNALSYM VLDTR_E_CA_BADPROLOG}
  VLDTR_E_MD_BADLOCALSIGTOK       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B1F); // Method has invalid LocalSig token
  {$EXTERNALSYM VLDTR_E_MD_BADLOCALSIGTOK}
  VLDTR_E_MD_BADHEADER            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B20); // Method has invalid header
  {$EXTERNALSYM VLDTR_E_MD_BADHEADER}
  VLDTR_E_EP_TOOMANYARGS          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B21); // Entry point has more than one arg
  {$EXTERNALSYM VLDTR_E_EP_TOOMANYARGS}
  VLDTR_E_EP_BADRET               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B22); // Entry point has bad return type
  {$EXTERNALSYM VLDTR_E_EP_BADRET}
  VLDTR_E_EP_BADARG               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B23); // Entry point has bad argument
  {$EXTERNALSYM VLDTR_E_EP_BADARG}
  VLDTR_E_SIG_BADVOID             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B24); // Illegal "void" in signature
  {$EXTERNALSYM VLDTR_E_SIG_BADVOID}
  VLDTR_E_IFACE_METHMULTIMPL      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B25); // Multiple implementation of method
  {$EXTERNALSYM VLDTR_E_IFACE_METHMULTIMPL}
//@GENERICS
  VLDTR_E_GP_NAMENULL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B26); // GenericParam name is NULL
  {$EXTERNALSYM VLDTR_E_GP_NAMENULL}
  VLDTR_E_GP_OWNERNIL             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B27); // GenericParam has nil owner.
  {$EXTERNALSYM VLDTR_E_GP_OWNERNIL}
  VLDTR_E_GP_DUPNAME              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B28); // GenericParam has duplicate by owner and name.
  {$EXTERNALSYM VLDTR_E_GP_DUPNAME}
  VLDTR_E_GP_DUPNUMBER            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B29); // GenericParam has duplicate by owner and number.
  {$EXTERNALSYM VLDTR_E_GP_DUPNUMBER}
  VLDTR_E_GP_NONSEQ_BY_OWNER      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B2A); // GenericParam is non sequential by owner
  {$EXTERNALSYM VLDTR_E_GP_NONSEQ_BY_OWNER}
  VLDTR_E_GP_NONSEQ_BY_NUMBER     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B2B); // GenericParam is non sequential by number
  {$EXTERNALSYM VLDTR_E_GP_NONSEQ_BY_NUMBER}
  VLDTR_E_GP_UNEXPECTED_OWNER_FOR_VARIANT_VAR = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B2C); // GenericParam has variance but its owner is not an interface or delegate
  {$EXTERNALSYM VLDTR_E_GP_UNEXPECTED_OWNER_FOR_VARIANT_VAR}
  VLDTR_E_GP_ILLEGAL_VARIANT_MVAR  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B2D); // GenericParam is a method type parameter and must be non-variant
  {$EXTERNALSYM VLDTR_E_GP_ILLEGAL_VARIANT_MVAR}
  VLDTR_E_GP_ILLEGAL_VARIANCE_FLAGS  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B2E); // GenericParam has illegal value for variance flags
  {$EXTERNALSYM VLDTR_E_GP_ILLEGAL_VARIANCE_FLAGS}
  VLDTR_E_GP_REFANDVALUETYPE      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B2F); // GenericParam has incompatible special constraints reference type and valuetype
  {$EXTERNALSYM VLDTR_E_GP_REFANDVALUETYPE}
  VLDTR_E_GPC_OWNERNIL            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B30); // GenericParamConstraint has nil owner
  {$EXTERNALSYM VLDTR_E_GPC_OWNERNIL}
  VLDTR_E_GPC_DUP                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B31); // GenericParamConstraint has duplicate by owner and constraint
  {$EXTERNALSYM VLDTR_E_GPC_DUP}
  VLDTR_E_GPC_NONCONTIGUOUS       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B32); // GenericParamConstraint is non-contiguous with preceeding constraints for same owner
  {$EXTERNALSYM VLDTR_E_GPC_NONCONTIGUOUS}
  VLDTR_E_MS_METHODNIL            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B33);  // MethodSpec has nil method
  {$EXTERNALSYM VLDTR_E_MS_METHODNIL}
  VLDTR_E_MS_DUP                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B34);  // MethodSpec has duplicate based own method and instantiation
  {$EXTERNALSYM VLDTR_E_MS_DUP}
  VLDTR_E_MS_BADCALLINGCONV       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B35);  // MethodSpec signature has invalid calling convention
  {$EXTERNALSYM VLDTR_E_MS_BADCALLINGCONV}
  VLDTR_E_MS_MISSARITY            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B36);    // MethodSpec signature is missing arity specification
  {$EXTERNALSYM VLDTR_E_MS_MISSARITY}
  VLDTR_E_MS_MISSARG              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B37);    // MethodSpec signature is missing type argument
  {$EXTERNALSYM VLDTR_E_MS_MISSARG}
  VLDTR_E_MS_ARITYMISMATCH        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B38);    // MethodSpec arity of generic method and instantiation do not match
  {$EXTERNALSYM VLDTR_E_MS_ARITYMISMATCH}
  VLDTR_E_MS_METHODNOTGENERIC     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B39);    // MethodSpec method is not generic
  {$EXTERNALSYM VLDTR_E_MS_METHODNOTGENERIC}
  VLDTR_E_SIG_MISSARITY           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B3A);    // Signature missing arity of instantiated generic type
  {$EXTERNALSYM VLDTR_E_SIG_MISSARITY}
  VLDTR_E_SIG_ARITYMISMATCH       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B3B);    // Signature has generic type of arity instantiated at different arity
  {$EXTERNALSYM VLDTR_E_SIG_ARITYMISMATCH}
  VLDTR_E_MD_GENERIC_CCTOR        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B3C);    // Method cannot be both generic and a class constructor
  {$EXTERNALSYM VLDTR_E_MD_GENERIC_CCTOR}
  VLDTR_E_MD_GENERIC_CTOR         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B3D);    // Method cannot be both generic and an instance constructor
  {$EXTERNALSYM VLDTR_E_MD_GENERIC_CTOR}
  VLDTR_E_MD_GENERIC_IMPORT       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B3E);    // Method cannot be both generic and defined on an imported type
  {$EXTERNALSYM VLDTR_E_MD_GENERIC_IMPORT}
  VLDTR_E_MD_GENERIC_BADCALLCONV  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B3F);    // Method cannot be both generic and have non-default calling convention
  {$EXTERNALSYM VLDTR_E_MD_GENERIC_BADCALLCONV}
  VLDTR_E_EP_GENERIC_METHOD       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B40);    // Entry point in CLR header is the token for a generic method
  {$EXTERNALSYM VLDTR_E_EP_GENERIC_METHOD}
  VLDTR_E_MD_MISSARITY            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B41);    // Method signature is generic but is missing its arity
  {$EXTERNALSYM VLDTR_E_MD_MISSARITY}
  VLDTR_E_MD_ARITYZERO            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B42);    // Method signature is generic but its arity is zero
  {$EXTERNALSYM VLDTR_E_MD_ARITYZERO}
  VLDTR_E_SIG_ARITYZERO           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B43);    // Signature has generic type instantiated at arity 0
  {$EXTERNALSYM VLDTR_E_SIG_ARITYZERO}
  VLDTR_E_MS_ARITYZERO            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B44);    // MethodSpec signature has arity 0
  {$EXTERNALSYM VLDTR_E_MS_ARITYZERO}
  VLDTR_E_MD_GPMISMATCH           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B45);    // MethodDef signature has arity n but owns m GenericParams
  {$EXTERNALSYM VLDTR_E_MD_GPMISMATCH}
  VLDTR_E_EP_GENERIC_TYPE         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B46);    // Entry point in CLR header is the token for a method in a generic type
  {$EXTERNALSYM VLDTR_E_EP_GENERIC_TYPE}
  VLDTR_E_MI_DECLNOTGENERIC       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B47);    // MethodImpl overrides non-generic method with generic method
  {$EXTERNALSYM VLDTR_E_MI_DECLNOTGENERIC}
  VLDTR_E_MI_IMPLNOTGENERIC       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B48);    // MethodImpl overrides non-generic method with generic method
  {$EXTERNALSYM VLDTR_E_MI_IMPLNOTGENERIC}
  VLDTR_E_MI_ARITYMISMATCH        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B49);    // MethodImpl overrides generic method of arity n with generic method of arity m
  {$EXTERNALSYM VLDTR_E_MI_ARITYMISMATCH}
  VLDTR_E_TD_EXTBADTYPESPEC       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B4A);    // TypeDef extends a TypeSpec that is not an instantiated type
  {$EXTERNALSYM VLDTR_E_TD_EXTBADTYPESPEC}
  VLDTR_E_SIG_BYREFINST           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B4B);    // Signature has type instantiated at byref at offset i
  {$EXTERNALSYM VLDTR_E_SIG_BYREFINST}
  VLDTR_E_MS_BYREFINST            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B4C);    // Signature has type instantiated at byref at offset i
  {$EXTERNALSYM VLDTR_E_MS_BYREFINST}
  VLDTR_E_TS_EMPTY                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B4D);    // TypeSpec has empty signature
  {$EXTERNALSYM VLDTR_E_TS_EMPTY}
  VLDTR_E_TS_HASSENTINALS         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B4E);    // TypeSpec has signature containing one or more sentinals
  {$EXTERNALSYM VLDTR_E_TS_HASSENTINALS}
  VLDTR_E_TD_GENERICHASEXPLAYOUT  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B4F);    // TypeDef is generic but has explicit layout
  {$EXTERNALSYM VLDTR_E_TD_GENERICHASEXPLAYOUT}
  VLDTR_E_SIG_BADTOKTYPE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B50);    // Signature has token following ELEMENT_TYPE_CLASS (_VALUETYPE) that is not a TypeDef or TypeRef
  {$EXTERNALSYM VLDTR_E_SIG_BADTOKTYPE}
  VLDTR_E_IFACE_METHNOTIMPLTHISMOD = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1B51);   // Warn:Class doesn't implement interface method in this module
  {$EXTERNALSYM VLDTR_E_IFACE_METHNOTIMPLTHISMOD}

//**** Common Language Runtime Debugging Services errors
  CORDBG_E_UNRECOVERABLE_ERROR                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1300); // Unrecoverable API error.
  {$EXTERNALSYM CORDBG_E_UNRECOVERABLE_ERROR}
  CORDBG_E_PROCESS_TERMINATED                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1301); // Process was terminated.
  {$EXTERNALSYM CORDBG_E_PROCESS_TERMINATED}
  CORDBG_E_PROCESS_NOT_SYNCHRONIZED               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1302); // Process not synchronized.
  {$EXTERNALSYM CORDBG_E_PROCESS_NOT_SYNCHRONIZED}
  CORDBG_E_CLASS_NOT_LOADED                       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1303); // A class is not loaded.
  {$EXTERNALSYM CORDBG_E_CLASS_NOT_LOADED}
  CORDBG_E_IL_VAR_NOT_AVAILABLE                   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1304); // An IL variable is not available at the
  {$EXTERNALSYM CORDBG_E_IL_VAR_NOT_AVAILABLE}
                                                                        // current native IP.
  CORDBG_E_BAD_REFERENCE_VALUE                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1305); // A reference value was found to be bad
  {$EXTERNALSYM CORDBG_E_BAD_REFERENCE_VALUE}
                                                                        // during dereferencing.
  CORDBG_E_FIELD_NOT_AVAILABLE                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1306); // A field in a class is not available,
  {$EXTERNALSYM CORDBG_E_FIELD_NOT_AVAILABLE}
                                                                        // because the runtime optimized it away.
  CORDBG_E_NON_NATIVE_FRAME                       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1307); // "Native frame only" operation on
  {$EXTERNALSYM CORDBG_E_NON_NATIVE_FRAME}
                                                                        // non-native frame
  CORDBG_E_NONCONTINUABLE_EXCEPTION               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1308); // Continue on non-continuable exception
  {$EXTERNALSYM CORDBG_E_NONCONTINUABLE_EXCEPTION}
  CORDBG_E_CODE_NOT_AVAILABLE                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1309); // The code is currently unavailable
  {$EXTERNALSYM CORDBG_E_CODE_NOT_AVAILABLE}
  CORDBG_E_FUNCTION_NOT_IL                        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $130A); // Attempt to get a ICorDebugFunction for
  {$EXTERNALSYM CORDBG_E_FUNCTION_NOT_IL}
                                                                        // a function that is not IL.
  CORDBG_S_BAD_START_SEQUENCE_POINT               = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $130B); // Attempt to SetIP not at a sequence point
  {$EXTERNALSYM CORDBG_S_BAD_START_SEQUENCE_POINT}
  CORDBG_S_BAD_END_SEQUENCE_POINT                 = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $130C); // Attempt to SetIP when not going to a
  {$EXTERNALSYM CORDBG_S_BAD_END_SEQUENCE_POINT}
                                                                        // sequence point.  If both this and
                                                                        // CORDBG_E_BAD_START_SEQUENCE_POINT are
                                                                        // true, only CORDBG_E_BAD_START_SEQUENCE_POINT
                                                                        // will be reported.
  CORDBG_S_INSUFFICIENT_INFO_FOR_SET_IP           = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $130D); // SetIP is possible, but the debugger doesn't
  {$EXTERNALSYM CORDBG_S_INSUFFICIENT_INFO_FOR_SET_IP}
                                                                        // have enough info to fix variable locations,
                                                                        // GC refs, or anything else. Use at your own
                                                                        // risk.
  CORDBG_E_CANT_SET_IP_INTO_FINALLY               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $130E); // SetIP isn't possible, because SetIP would
  {$EXTERNALSYM CORDBG_E_CANT_SET_IP_INTO_FINALLY}
                                                                        // move EIP from outside of an exception
                                                                        // handling finally clause to a point inside
                                                                        // of one.
  CORDBG_E_CANT_SET_IP_OUT_OF_FINALLY             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $130F); // SetIP isn't possible because it would move
  {$EXTERNALSYM CORDBG_E_CANT_SET_IP_OUT_OF_FINALLY}
                                                                        // EIP from within an exception handling finally
                                                                        // clause to a point outside of one.
  CORDBG_E_CANT_SET_IP_INTO_CATCH                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1310); // SetIP isn't possible, because SetIP would
  {$EXTERNALSYM CORDBG_E_CANT_SET_IP_INTO_CATCH}
                                                                        // move EIP from outside of an exception
                                                                        // handling catch clause to a point inside of
                                                                        // one.
  CORDBG_E_SET_IP_NOT_ALLOWED_ON_NONLEAF_FRAME    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1311); // Setip cannot be done on any frame except
  {$EXTERNALSYM CORDBG_E_SET_IP_NOT_ALLOWED_ON_NONLEAF_FRAME}
                                                                        // the leaf frame.
  CORDBG_E_SET_IP_IMPOSSIBLE                      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1312); // SetIP isn't allowed. For example, there is
  {$EXTERNALSYM CORDBG_E_SET_IP_IMPOSSIBLE}
                                                                        // insufficient memory to perform SetIP.
  CORDBG_E_FUNC_EVAL_BAD_START_POINT              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1313); // Func eval can't work if we're, for example,
  {$EXTERNALSYM CORDBG_E_FUNC_EVAL_BAD_START_POINT}
                                                                        // not stopped at a GC safe point.
  CORDBG_E_INVALID_OBJECT                         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1314); // This object value is no longer valid.
  {$EXTERNALSYM CORDBG_E_INVALID_OBJECT}
  CORDBG_E_FUNC_EVAL_NOT_COMPLETE                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1315); // If you call CordbEval::GetResult before the
  {$EXTERNALSYM CORDBG_E_FUNC_EVAL_NOT_COMPLETE}
                                                                        // func eval has finished, you'll get this
                                                                        // result.
  CORDBG_S_FUNC_EVAL_HAS_NO_RESULT                = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1316); // Some Func evals will lack a return value,
  {$EXTERNALSYM CORDBG_S_FUNC_EVAL_HAS_NO_RESULT}
                                                                        // such as those whose return type is void.
  CORDBG_S_VALUE_POINTS_TO_VOID                   = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1317); // The Debugging API doesn't support
  {$EXTERNALSYM CORDBG_S_VALUE_POINTS_TO_VOID}
                                                                        // dereferencing pointers of type void.
  CORDBG_E_INPROC_NOT_IMPL                        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1318); // The inproc version of the debugging API
  {$EXTERNALSYM CORDBG_E_INPROC_NOT_IMPL}
                                                                        // doesn't implement this function,
  CORDBG_S_FUNC_EVAL_ABORTED                      = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1319); // The func eval completed, but was aborted.
  {$EXTERNALSYM CORDBG_S_FUNC_EVAL_ABORTED}
  CORDBG_E_STATIC_VAR_NOT_AVAILABLE               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $131A); // A static variable isn't available because
  {$EXTERNALSYM CORDBG_E_STATIC_VAR_NOT_AVAILABLE}
                                                                        // it hasn't been initialized yet.
  CORDBG_E_OBJECT_IS_NOT_COPYABLE_VALUE_CLASS     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $131B); // Can't copy a VC with object refs in it.
  {$EXTERNALSYM CORDBG_E_OBJECT_IS_NOT_COPYABLE_VALUE_CLASS}
  CORDBG_E_CANT_SETIP_INTO_OR_OUT_OF_FILTER       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $131C); // SetIP can't leave or enter a filter
  {$EXTERNALSYM CORDBG_E_CANT_SETIP_INTO_OR_OUT_OF_FILTER}
  CORDBG_E_CANT_CHANGE_JIT_SETTING_FOR_ZAP_MODULE = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $131D); // You can't change JIT settings for ZAP
  {$EXTERNALSYM CORDBG_E_CANT_CHANGE_JIT_SETTING_FOR_ZAP_MODULE}
                                                                        // modules.
  CORDBG_E_CANT_SET_IP_OUT_OF_FINALLY_ON_WIN64    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $131E); // SetIP isn't possible because it would move
  {$EXTERNALSYM CORDBG_E_CANT_SET_IP_OUT_OF_FINALLY_ON_WIN64}
                                                                        // EIP from within a finally clause to a point
                                                                        // outside of one on WIN64 platforms.
  CORDBG_E_CANT_SET_IP_OUT_OF_CATCH_ON_WIN64      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $131F); // SetIP isn't possible because it would move
  {$EXTERNALSYM CORDBG_E_CANT_SET_IP_OUT_OF_CATCH_ON_WIN64}
                                                                        // EIP from within a catch clause to a point
                                                                        // outside of one on WIN64 platforms.

  CORDBG_E_REMOTE_CONNECTION_CONN_RESET           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1320); // The remote device closed the connection.
  {$EXTERNALSYM CORDBG_E_REMOTE_CONNECTION_CONN_RESET}
  CORDBG_E_REMOTE_CONNECTION_KEEP_ALIVE           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1321); // The connection was closed due to akeep alive failure.
  {$EXTERNALSYM CORDBG_E_REMOTE_CONNECTION_KEEP_ALIVE}
  CORDBG_E_REMOTE_CONNECTION_FATAL_ERROR          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1322); // Generic error that the device connection has been broken with no chance for recovery.
  {$EXTERNALSYM CORDBG_E_REMOTE_CONNECTION_FATAL_ERROR}

  CORDBG_E_CANT_SET_TO_JMC                        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1323); // Can't use JMC on this code (likely wrong jit settings).
  {$EXTERNALSYM CORDBG_E_CANT_SET_TO_JMC}

  CORDBG_E_BAD_THREAD_STATE                       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $132d); // The state of the thread is invalid.
  {$EXTERNALSYM CORDBG_E_BAD_THREAD_STATE}
  CORDBG_E_DEBUGGER_ALREADY_ATTACHED              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $132e); // This process has already been attached to
  {$EXTERNALSYM CORDBG_E_DEBUGGER_ALREADY_ATTACHED}
  CORDBG_E_SUPERFLOUS_CONTINUE                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $132f); // Returned from a call to Continue that was
  {$EXTERNALSYM CORDBG_E_SUPERFLOUS_CONTINUE}
                                                                        // Not matched with a stopping event.
  CORDBG_E_SET_VALUE_NOT_ALLOWED_ON_NONLEAF_FRAME = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1330); // Can't perfrom SetValue on non-leaf frames.
  {$EXTERNALSYM CORDBG_E_SET_VALUE_NOT_ALLOWED_ON_NONLEAF_FRAME}
  CORDBG_E_ENC_EH_MAX_NESTING_LEVEL_CANT_INCREASE = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1331); // When doing EnC, some JITters don't let you
  {$EXTERNALSYM CORDBG_E_ENC_EH_MAX_NESTING_LEVEL_CANT_INCREASE}
                                                                        // increase the maximum level to which
                                                                        // exception handling can be nested.
  CORDBG_E_ENC_MODULE_NOT_ENC_ENABLED             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1332); // Tried to do EnC on a module that wasn't
  {$EXTERNALSYM CORDBG_E_ENC_MODULE_NOT_ENC_ENABLED}
                                                                        // started in EnC mode.
  CORDBG_E_SET_IP_NOT_ALLOWED_ON_EXCEPTION        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1333); // Setip cannot be done on any exception
  {$EXTERNALSYM CORDBG_E_SET_IP_NOT_ALLOWED_ON_EXCEPTION}
  CORDBG_E_VARIABLE_IS_ACTUALLY_LITERAL           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1334); // The 'variable' doesn't exist because it is a
  {$EXTERNALSYM CORDBG_E_VARIABLE_IS_ACTUALLY_LITERAL}
                                                                        // literal optimized away by the compiler - ask
                                                                        // Metadata for it's default value, instead.
  CORDBG_E_PROCESS_DETACHED                       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1335); // Process has been detached from
  {$EXTERNALSYM CORDBG_E_PROCESS_DETACHED}
  CORDBG_E_ENC_METHOD_SIG_CHANGED                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1336); // Not allowed to change the signature of an
  {$EXTERNALSYM CORDBG_E_ENC_METHOD_SIG_CHANGED}
                                                                        // existing method - compiler should make new method
                                                                        // instead.
  CORDBG_E_ENC_METHOD_NO_LOCAL_SIG                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1337); // Can't get the local signature for the method
  {$EXTERNALSYM CORDBG_E_ENC_METHOD_NO_LOCAL_SIG}
                                                                        // we're trying to EnC.
  CORDBG_E_ENC_CANT_ADD_FIELD_TO_VALUE_OR_LAYOUT_CLASS = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1338); // Adding a field to a value or layout class is prohibitted,
  {$EXTERNALSYM CORDBG_E_ENC_CANT_ADD_FIELD_TO_VALUE_OR_LAYOUT_CLASS}
                                                                        // since we can't guarantee the new field is contiguous to
                                                                        // VC's on the stack, embedded in other objects, etc.
  CORDBG_E_ENC_CANT_CHANGE_FIELD                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1339); // Once you've got a field, you're not allowed to change
  {$EXTERNALSYM CORDBG_E_ENC_CANT_CHANGE_FIELD}
                                                                        // it, since that would change the size of the type it belongs to.
  CORDBG_E_ENC_CANT_ADD_NON_PRIVATE_MEMBER        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $133A); // Only support addition of private members.
  {$EXTERNALSYM CORDBG_E_ENC_CANT_ADD_NON_PRIVATE_MEMBER}
  CORDBG_E_FIELD_NOT_STATIC                       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $133B); // Returned if someone tries to call GetStaticFieldValue
  {$EXTERNALSYM CORDBG_E_FIELD_NOT_STATIC}
                                                                        // on a non-static field
  CORDBG_E_FIELD_NOT_INSTANCE                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $133C); // Returned if someone tries to call GetStaticFieldValue
  {$EXTERNALSYM CORDBG_E_FIELD_NOT_INSTANCE}
                                                                        // on a non-instance field
  CORDBG_E_ENC_ZAPPED_WITHOUT_ENC                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $133D); // If a zap file was created without the EnC flag set, then
  {$EXTERNALSYM CORDBG_E_ENC_ZAPPED_WITHOUT_ENC}
                                                                        // we can't do EnC on it, no matter what.
  CORDBG_E_ENC_BAD_METHOD_INFO                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $133E); // Lacking information about method.
  {$EXTERNALSYM CORDBG_E_ENC_BAD_METHOD_INFO}
  CORDBG_E_ENC_JIT_CANT_UPDATE                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $133F); // The JIT is unable to update the method.
  {$EXTERNALSYM CORDBG_E_ENC_JIT_CANT_UPDATE}
  CORDBG_E_ENC_MISSING_CLASS                      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1340); // An internal structure about the class is missing
  {$EXTERNALSYM CORDBG_E_ENC_MISSING_CLASS}
  CORDBG_E_ENC_INTERNAL_ERROR                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1341); // Generic message for "Something user doesn't control went wrong" message.
  {$EXTERNALSYM CORDBG_E_ENC_INTERNAL_ERROR}
  CORDBG_E_ENC_HANGING_FIELD                      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1342); // The field was added via enc after the class was loaded, and so instead of
  {$EXTERNALSYM CORDBG_E_ENC_HANGING_FIELD}
                                                                        // the field being contiguous with the other fields, it's 'hanging' off the
                                                                        // instance, so the right side will have to go & get (instance-specific
                                                                        // info based on the particular object.
  CORDBG_E_MODULE_NOT_LOADED                      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1343); // If the module isn't loaded, including if it's been unloaded.
  {$EXTERNALSYM CORDBG_E_MODULE_NOT_LOADED}

  CORDBG_E_ENC_CANT_CHANGE_SUPERCLASS             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1344); // Not allowed to change which class something inherits from
  {$EXTERNALSYM CORDBG_E_ENC_CANT_CHANGE_SUPERCLASS}
  CORDBG_E_UNABLE_TO_SET_BREAKPOINT               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1345); // Can't set a breakpoint here.
  {$EXTERNALSYM CORDBG_E_UNABLE_TO_SET_BREAKPOINT}
  CORDBG_E_DEBUGGING_NOT_POSSIBLE                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1346); // Debugging isn't possible due to an incompatability within the CLR implementation.
  {$EXTERNALSYM CORDBG_E_DEBUGGING_NOT_POSSIBLE}
  CORDBG_E_KERNEL_DEBUGGER_ENABLED                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1347); // Debugging isn't possible because a kernel debugger is enabled on the system.
  {$EXTERNALSYM CORDBG_E_KERNEL_DEBUGGER_ENABLED}
  CORDBG_E_KERNEL_DEBUGGER_PRESENT                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1348); // Debugging isn't possible because a kernel debugger is present on the system.
  {$EXTERNALSYM CORDBG_E_KERNEL_DEBUGGER_PRESENT}
  CORDBG_E_HELPER_THREAD_DEAD                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1349); // The debugger's internal helper thread is dead.
  {$EXTERNALSYM CORDBG_E_HELPER_THREAD_DEAD}
  CORDBG_E_INTERFACE_INHERITANCE_CANT_CHANGE      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $134A); // Not allowed to change interface inheritance.
  {$EXTERNALSYM CORDBG_E_INTERFACE_INHERITANCE_CANT_CHANGE}
  CORDBG_E_INCOMPATIBLE_PROTOCOL                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $134B); // The debugger's protocol is incompatible with the debuggee.
  {$EXTERNALSYM CORDBG_E_INCOMPATIBLE_PROTOCOL}
  CORDBG_E_TOO_MANY_PROCESSES                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $134C); // The debugger can only handle a finite number of debuggees.
  {$EXTERNALSYM CORDBG_E_TOO_MANY_PROCESSES}
  CORDBG_E_INTEROP_NOT_SUPPORTED                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $134D); // Interop is not allowed on a win9x platform
  {$EXTERNALSYM CORDBG_E_INTEROP_NOT_SUPPORTED}
  CORDBG_E_NO_REMAP_BREAKPIONT                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $134E); // Cannot call RemapFunction until have received RemapBreakpoint
  {$EXTERNALSYM CORDBG_E_NO_REMAP_BREAKPIONT}
  CORDBG_E_OBJECT_NEUTERED                        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $134F); // Object has been neutered (it's in a zombie state).
  {$EXTERNALSYM CORDBG_E_OBJECT_NEUTERED}
// NOTE!  YOU CANNOT PUT MORE ERRORS HERE!  They run into the range for profiling errors.  All new
// new error need to be added below (search for cordbg_e_ in your editor).

//**** Common Language Runtime Profiling Services errors
  CORPROF_E_FUNCTION_NOT_COMPILED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1350);     // Function not yet compiled.
  {$EXTERNALSYM CORPROF_E_FUNCTION_NOT_COMPILED}
  CORPROF_E_DATAINCOMPLETE        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1351);     // The ID is not fully loaded/defined yet.
  {$EXTERNALSYM CORPROF_E_DATAINCOMPLETE}
  CORPROF_E_NOT_REJITABLE_METHODS = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1352);     // The Module is not configured for updateable methods.
  {$EXTERNALSYM CORPROF_E_NOT_REJITABLE_METHODS}
  CORPROF_E_CANNOT_UPDATE_METHOD  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1353);     // The Method could not be updated for re-jit.
  {$EXTERNALSYM CORPROF_E_CANNOT_UPDATE_METHOD}
  CORPROF_E_FUNCTION_NOT_IL       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1354);     // The Method has no associated IL
  {$EXTERNALSYM CORPROF_E_FUNCTION_NOT_IL}
  CORPROF_E_NOT_MANAGED_THREAD    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1355);     // The thread has never run managed code before
  {$EXTERNALSYM CORPROF_E_NOT_MANAGED_THREAD}
  CORPROF_E_CALL_ONLY_FROM_INIT   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1356);     // The function may only be called during profiler init
  {$EXTERNALSYM CORPROF_E_CALL_ONLY_FROM_INIT}
  CORPROF_E_INPROC_NOT_ENABLED    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1357);     // Inprocess debugging must be enabled during init
  {$EXTERNALSYM CORPROF_E_INPROC_NOT_ENABLED}
                                                            // Also returned when BeginInprocDebugging not called
                                                            // before using the inprocess debugging services
  CORPROF_E_JITMAPS_NOT_ENABLED   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1358);     // Can't get a JIT map becuase they are not enabled
  {$EXTERNALSYM CORPROF_E_JITMAPS_NOT_ENABLED}
  CORPROF_E_INPROC_ALREADY_BEGUN  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1359);     // If a profiler tries to call BeginInprocDebugging more than
  {$EXTERNALSYM CORPROF_E_INPROC_ALREADY_BEGUN}
                                                            // once, it will get this error.
  CORPROF_E_INPROC_NOT_AVAILABLE  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $135A);     // States that inprocess debugging not allowed at this point
  {$EXTERNALSYM CORPROF_E_INPROC_NOT_AVAILABLE}
                                                            // (for example during GC callbacks or RuntimeSuspention callbacks
  CORPROF_E_NOT_YET_AVAILABLE     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $135B);     // This is a general error used to indicated that the information
  {$EXTERNALSYM CORPROF_E_NOT_YET_AVAILABLE}
                                                            // requested is not yet available
  CORPROF_E_TYPE_IS_PARAMETERIZED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $135C);     // The given type is a generic and cannot be used with this method.
  {$EXTERNALSYM CORPROF_E_TYPE_IS_PARAMETERIZED}
  CORPROF_E_FUNCTION_IS_PARAMETERIZED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $135D); // The given function is a generic and cannot be used with this method.
  {$EXTERNALSYM CORPROF_E_FUNCTION_IS_PARAMETERIZED}
  CORPROF_E_STACKSNAPSHOT_INVALID_TGT_THREAD = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $135E); // A profiler tried to walk the stack of an invalid thread
  {$EXTERNALSYM CORPROF_E_STACKSNAPSHOT_INVALID_TGT_THREAD}
  CORPROF_E_STACKSNAPSHOT_UNMANAGED_CTX        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $135F); // A profiler can not walk a thread that is currently executing unmanaged code
  {$EXTERNALSYM CORPROF_E_STACKSNAPSHOT_UNMANAGED_CTX}
  CORPROF_E_STACKSNAPSHOT_UNSAFE  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1360);     // A stackwalk at this point may cause dead locks or data corruption
  {$EXTERNALSYM CORPROF_E_STACKSNAPSHOT_UNSAFE}
  CORPROF_E_STACKSNAPSHOT_ABORTED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1361);     // Stackwalking callback requested the walk to abort
  {$EXTERNALSYM CORPROF_E_STACKSNAPSHOT_ABORTED}
  CORPROF_E_LITERALS_HAVE_NO_ADDRESS = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1362);  // Returned when asked for the address of a static that is a literal.
  {$EXTERNALSYM CORPROF_E_LITERALS_HAVE_NO_ADDRESS}
  CORPROF_E_UNSUPPORTED_CALL_SEQUENCE = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1363); // A call was made at an unsupported time (e.g., API illegally called asynchronously)
  {$EXTERNALSYM CORPROF_E_UNSUPPORTED_CALL_SEQUENCE}
  CORPROF_E_ASYNCHRONOUS_UNSAFE           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1364); // A legal asynchronous call was made at an unsafe time (e.g., CLR locks are held)
  {$EXTERNALSYM CORPROF_E_ASYNCHRONOUS_UNSAFE}
  CORPROF_E_CLASSID_IS_ARRAY                      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1365); // The specified ClassID cannot be inspected by this function because it is an array
  {$EXTERNALSYM CORPROF_E_CLASSID_IS_ARRAY}
  CORPROF_E_CLASSID_IS_COMPOSITE              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1366); // The specified ClassID is a non-array composite type (e.g., ref) and cannot be inspected
  {$EXTERNALSYM CORPROF_E_CLASSID_IS_COMPOSITE}


//**** Security errors
  SECURITY_E_XML_TO_ASN_ENCODING  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1400);     // Failed to convert XML to ASN
  {$EXTERNALSYM SECURITY_E_XML_TO_ASN_ENCODING}
  SECURITY_E_INCOMPATIBLE_SHARE   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1401);     // Loading this assembly would produce a different grant set from other instances
  {$EXTERNALSYM SECURITY_E_INCOMPATIBLE_SHARE}
  SECURITY_E_UNVERIFIABLE         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1402);     // Unverifable code failed policy check
  {$EXTERNALSYM SECURITY_E_UNVERIFIABLE}
  SECURITY_E_INCOMPATIBLE_EVIDENCE = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1403);     // Assembly already loaded without additional security evidence.
  {$EXTERNALSYM SECURITY_E_INCOMPATIBLE_EVIDENCE}

//**** Reserved.
  CLDB_E_INTERNALERROR            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1fff);
  {$EXTERNALSYM CLDB_E_INTERNALERROR}

// ******************
// Debugger & Profiler errors
// ******************


// ******************
// Security errors
// ******************

  CORSEC_E_DECODE_SET             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1410);         // Failure decoding permission set
  {$EXTERNALSYM CORSEC_E_DECODE_SET}
  CORSEC_E_ENCODE_SET             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1411);         // Failure encoding permission set
  {$EXTERNALSYM CORSEC_E_ENCODE_SET}
  CORSEC_E_UNSUPPORTED_FORMAT     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1412);         // Unrecognized encoding format
  {$EXTERNALSYM CORSEC_E_UNSUPPORTED_FORMAT}
  SN_CRYPTOAPI_CALL_FAILED        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1413);         // StrongName APIs not supported on system
  {$EXTERNALSYM SN_CRYPTOAPI_CALL_FAILED}
  CORSEC_E_CRYPTOAPI_CALL_FAILED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1413);         // StrongName APIs not supported on system
  {$EXTERNALSYM CORSEC_E_CRYPTOAPI_CALL_FAILED}
  SN_NO_SUITABLE_CSP              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1414);         // StrongName APIs couldn't locate a matching CSP
  {$EXTERNALSYM SN_NO_SUITABLE_CSP}
  CORSEC_E_NO_SUITABLE_CSP        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1414);         // StrongName APIs couldn't locate a matching CSP
  {$EXTERNALSYM CORSEC_E_NO_SUITABLE_CSP}
  CORSEC_E_INVALID_ATTR           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1415);         // Invalid security custom attribute
  {$EXTERNALSYM CORSEC_E_INVALID_ATTR}
  CORSEC_E_POLICY_EXCEPTION       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1416);         // PolicyException thrown
  {$EXTERNALSYM CORSEC_E_POLICY_EXCEPTION}
  CORSEC_E_MIN_GRANT_FAIL         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1417);         // Failed to grant minimum permission requests
  {$EXTERNALSYM CORSEC_E_MIN_GRANT_FAIL}
  CORSEC_E_NO_EXEC_PERM           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1418);         // Failed to grant permission to execute
  {$EXTERNALSYM CORSEC_E_NO_EXEC_PERM}
  CORSEC_E_XMLSYNTAX              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1419);         // XML Syntax error
  {$EXTERNALSYM CORSEC_E_XMLSYNTAX}
  CORSEC_E_INVALID_STRONGNAME     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $141a);         // Strong name validation failed
  {$EXTERNALSYM CORSEC_E_INVALID_STRONGNAME}
  CORSEC_E_MISSING_STRONGNAME     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $141b);         // Assembly is not strong named
  {$EXTERNALSYM CORSEC_E_MISSING_STRONGNAME}
  CORSEC_E_CONTAINER_NOT_FOUND    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $141c);         // Strong name key container not found
  {$EXTERNALSYM CORSEC_E_CONTAINER_NOT_FOUND}
  CORSEC_E_INVALID_IMAGE_FORMAT   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $141d);         // Invalid assembly file format
  {$EXTERNALSYM CORSEC_E_INVALID_IMAGE_FORMAT}
  CORSEC_E_INVALID_PUBLICKEY      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $141e);         // Invalid assembly public key
  {$EXTERNALSYM CORSEC_E_INVALID_PUBLICKEY}
  CORSEC_E_SIGNATURE_MISMATCH     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1420);         // Signature size mismatch
  {$EXTERNALSYM CORSEC_E_SIGNATURE_MISMATCH}

//**** crypto errors 1430 -- 1439
  CORSEC_E_CRYPTO                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1430);         // generic CryptographicException
  {$EXTERNALSYM CORSEC_E_CRYPTO}
  CORSEC_E_CRYPTO_UNEX_OPER       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1431);         // generic CryptographicUnexpectedOperationException
  {$EXTERNALSYM CORSEC_E_CRYPTO_UNEX_OPER}

//**** security custom attribute errors 143a -- 144f
  CORSECATTR_E_BAD_ATTRIBUTE              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $143a); // Generic problem with a custom attribute
  {$EXTERNALSYM CORSECATTR_E_BAD_ATTRIBUTE}
  CORSECATTR_E_MISSING_CONSTRUCTOR        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $143b); // Missing a required constructor
  {$EXTERNALSYM CORSECATTR_E_MISSING_CONSTRUCTOR}
  CORSECATTR_E_FAILED_TO_CREATE_PERM      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $143c); // Unable to create a permission for this attribute
  {$EXTERNALSYM CORSECATTR_E_FAILED_TO_CREATE_PERM}
  CORSECATTR_E_BAD_ACTION_ASM             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $143d); // SecurityAction type invalid on assembly
  {$EXTERNALSYM CORSECATTR_E_BAD_ACTION_ASM}
  CORSECATTR_E_BAD_ACTION_OTHER           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $143e); // SecurityAction type invalid on types and methods
  {$EXTERNALSYM CORSECATTR_E_BAD_ACTION_OTHER}
  CORSECATTR_E_BAD_PARENT                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $143f); // Security custom attribute attached to invalid parent
  {$EXTERNALSYM CORSECATTR_E_BAD_PARENT}
  CORSECATTR_E_TRUNCATED                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1440); // Bad custom attribute serialized blob
  {$EXTERNALSYM CORSECATTR_E_TRUNCATED}
  CORSECATTR_E_BAD_VERSION                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1441); // Bad custom attribute serialized blob version
  {$EXTERNALSYM CORSECATTR_E_BAD_VERSION}
  CORSECATTR_E_BAD_ACTION                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1442); // Invalid security action code
  {$EXTERNALSYM CORSECATTR_E_BAD_ACTION}
  CORSECATTR_E_NO_SELF_REF                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1443); // CA ref to CA def'd in same assembly
  {$EXTERNALSYM CORSECATTR_E_NO_SELF_REF}
  CORSECATTR_E_BAD_NONCAS                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1444); // Use of non-CAS perm with invalid action
  {$EXTERNALSYM CORSECATTR_E_BAD_NONCAS}
  CORSECATTR_E_ASSEMBLY_LOAD_FAILED       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1445); // Failed to load assembly containing CA (or req'd CA type)
  {$EXTERNALSYM CORSECATTR_E_ASSEMBLY_LOAD_FAILED}
  CORSECATTR_E_ASSEMBLY_LOAD_FAILED_EX    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1446); // Failed to load assembly containing CA (or req'd CA type)
  {$EXTERNALSYM CORSECATTR_E_ASSEMBLY_LOAD_FAILED_EX}
  CORSECATTR_E_TYPE_LOAD_FAILED           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1447); // Failed to load CA type (or reqd CA type)
  {$EXTERNALSYM CORSECATTR_E_TYPE_LOAD_FAILED}
  CORSECATTR_E_TYPE_LOAD_FAILED_EX        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1448); // Failed to load CA type (or reqd CA type)
  {$EXTERNALSYM CORSECATTR_E_TYPE_LOAD_FAILED_EX}
  CORSECATTR_E_ABSTRACT                   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1449); // CA type is abstract
  {$EXTERNALSYM CORSECATTR_E_ABSTRACT}
  CORSECATTR_E_UNSUPPORTED_TYPE           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $144a); // Unsupported type for field/property setter
  {$EXTERNALSYM CORSECATTR_E_UNSUPPORTED_TYPE}
  CORSECATTR_E_UNSUPPORTED_ENUM_TYPE      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $144b); // Unsupported base type for enum field/property
  {$EXTERNALSYM CORSECATTR_E_UNSUPPORTED_ENUM_TYPE}
  CORSECATTR_E_NO_FIELD                   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $144c); // Couldn't find a CA field
  {$EXTERNALSYM CORSECATTR_E_NO_FIELD}
  CORSECATTR_E_NO_PROPERTY                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $144d); // Couldn't find a CA property
  {$EXTERNALSYM CORSECATTR_E_NO_PROPERTY}
  CORSECATTR_E_EXCEPTION                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $144e); // Unexpected exception
  {$EXTERNALSYM CORSECATTR_E_EXCEPTION}
  CORSECATTR_E_EXCEPTION_HR               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $144f); // Unexpected exception
  {$EXTERNALSYM CORSECATTR_E_EXCEPTION_HR}


//**** Isolated Storage Errors 1450 - 14FF
  ISS_E_ISOSTORE                   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1450);
  {$EXTERNALSYM ISS_E_ISOSTORE}

  ISS_E_OPEN_STORE_FILE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1460);
  {$EXTERNALSYM ISS_E_OPEN_STORE_FILE}
  ISS_E_OPEN_FILE_MAPPING          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1461);
  {$EXTERNALSYM ISS_E_OPEN_FILE_MAPPING}
  ISS_E_MAP_VIEW_OF_FILE           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1462);
  {$EXTERNALSYM ISS_E_MAP_VIEW_OF_FILE}
  ISS_E_GET_FILE_SIZE              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1463);
  {$EXTERNALSYM ISS_E_GET_FILE_SIZE}
  ISS_E_CREATE_MUTEX               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1464);
  {$EXTERNALSYM ISS_E_CREATE_MUTEX}
  ISS_E_LOCK_FAILED                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1465);
  {$EXTERNALSYM ISS_E_LOCK_FAILED}
  ISS_E_FILE_WRITE                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1466);
  {$EXTERNALSYM ISS_E_FILE_WRITE}
  ISS_E_SET_FILE_POINTER           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1467);
  {$EXTERNALSYM ISS_E_SET_FILE_POINTER}
  ISS_E_CREATE_DIR                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1468);
  {$EXTERNALSYM ISS_E_CREATE_DIR}
  ISS_E_STORE_NOT_OPEN             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1469);
  {$EXTERNALSYM ISS_E_STORE_NOT_OPEN}

  ISS_E_CORRUPTED_STORE_FILE       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1480);
  {$EXTERNALSYM ISS_E_CORRUPTED_STORE_FILE}
  ISS_E_STORE_VERSION              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1481);
  {$EXTERNALSYM ISS_E_STORE_VERSION}
  ISS_E_FILE_NOT_MAPPED            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1482);
  {$EXTERNALSYM ISS_E_FILE_NOT_MAPPED}
  ISS_E_BLOCK_SIZE_TOO_SMALL       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1483);
  {$EXTERNALSYM ISS_E_BLOCK_SIZE_TOO_SMALL}
  ISS_E_ALLOC_TOO_LARGE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1484);
  {$EXTERNALSYM ISS_E_ALLOC_TOO_LARGE}
  ISS_E_USAGE_WILL_EXCEED_QUOTA    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1485);
  {$EXTERNALSYM ISS_E_USAGE_WILL_EXCEED_QUOTA}
  ISS_E_TABLE_ROW_NOT_FOUND        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1486);
  {$EXTERNALSYM ISS_E_TABLE_ROW_NOT_FOUND}

  ISS_E_DEPRECATE                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $14A0);
  {$EXTERNALSYM ISS_E_DEPRECATE}
  ISS_E_CALLER                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $14A1);
  {$EXTERNALSYM ISS_E_CALLER}
  ISS_E_PATH_LENGTH                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $14A2);
  {$EXTERNALSYM ISS_E_PATH_LENGTH}
  ISS_E_MACHINE                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $14A3);
  {$EXTERNALSYM ISS_E_MACHINE}
  ISS_E_MACHINE_DACL               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $14A4);
  {$EXTERNALSYM ISS_E_MACHINE_DACL}

  ISS_E_ISOSTORE_START             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1450);
  {$EXTERNALSYM ISS_E_ISOSTORE_START}
  ISS_E_ISOSTORE_END               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $14FF);
  {$EXTERNALSYM ISS_E_ISOSTORE_END}

// ******************
// Classlib errors
// ******************


//
// MessageId: COR_E_APPLICATION
//
// MessageText:
//
// The base class for all "less serious" exceptions.
//
  COR_E_APPLICATION  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1600);
  {$EXTERNALSYM COR_E_APPLICATION}


//
// MessageId: COR_E_ARGUMENT
//
// MessageText:
//
// An argument does not meet the contract of the method.
//
  COR_E_ARGUMENT  = E_INVALIDARG;        // 0x80070057
  {$EXTERNALSYM COR_E_ARGUMENT}


//
// MessageId: COR_E_ARGUMENTOUTOFRANGE
//
// MessageText:
//
// An argument was out of its legal range.
//
  COR_E_ARGUMENTOUTOFRANGE  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1502);
  {$EXTERNALSYM COR_E_ARGUMENTOUTOFRANGE}


//
// MessageId: COR_E_ARITHMETIC
//
// MessageText:
//
// Overflow or underflow in mathematical operations.
//
  COR_E_ARITHMETIC   = HRESULT($80070216);     // 0x80070216 ERROR_ARITHMETIC_OVERFLOW
  {$EXTERNALSYM COR_E_ARITHMETIC}


//
// MessageId: COR_E_ARRAYTYPEMISMATCH
//
// MessageText:
//
// Attempted to store an object of the wrong type in an array
//
  COR_E_ARRAYTYPEMISMATCH  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1503);
  {$EXTERNALSYM COR_E_ARRAYTYPEMISMATCH}


//
// MessageId: COR_E_CONTEXTMARSHAL
//
// MessageText:
//
//
//
  COR_E_CONTEXTMARSHAL  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1504);
  {$EXTERNALSYM COR_E_CONTEXTMARSHAL}


//
// MessageId: COR_E_TIMEOUT
//
// MessageText:
//
//
//
  COR_E_TIMEOUT  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1505);
  {$EXTERNALSYM COR_E_TIMEOUT}


//
// MessageId: COR_E_KEYNOTFOUND
//
// MessageText:
//
//
//
  COR_E_KEYNOTFOUND  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1577);
  {$EXTERNALSYM COR_E_KEYNOTFOUND}



//
// MessageId: COR_E_DEVICESNOTSUPPORTED
//
// MessageText:
//
//
//
  COR_E_DEVICESNOTSUPPORTED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1540);
  {$EXTERNALSYM COR_E_DEVICESNOTSUPPORTED}

//
// MessageId: COR_E_DIVIDEBYZERO
//
// MessageText:
//
// Attempted to divide a number by zero.
//
  COR_E_DIVIDEBYZERO         = HRESULT($80020012); // DISP_E_DIVBYZERO
  {$EXTERNALSYM COR_E_DIVIDEBYZERO}


//
// MessageId: COR_E_EXCEPTION
//
// MessageText:
//
// Base class for all exceptions in the runtime
//
  COR_E_EXCEPTION  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1500);
  {$EXTERNALSYM COR_E_EXCEPTION}


//
// MessageId: COR_E_EXECUTIONENGINE
//
// MessageText:
//
// An internal error happened in the Common Language Runtime's Execution Engine
//
  COR_E_EXECUTIONENGINE  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1506);
  {$EXTERNALSYM COR_E_EXECUTIONENGINE}


//
// MessageId: COR_E_FIELDACCESS
//
// MessageText:
//
// Access to this field is denied.
//
  COR_E_FIELDACCESS  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1507);
  {$EXTERNALSYM COR_E_FIELDACCESS}


//
// MessageId: COR_E_FORMAT
//
// MessageText:
//
// The format of one arguments does not meet the contract of the method.
//
  COR_E_FORMAT  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1537);
  {$EXTERNALSYM COR_E_FORMAT}


//
// MessageId: COR_E_BADIMAGEFORMAT
//
// MessageText:
//
// The format of DLL or executable being loaded is invalid.
//
  COR_E_BADIMAGEFORMAT  = HRESULT($8007000B);
  {$EXTERNALSYM COR_E_BADIMAGEFORMAT}


//
// MessageId: COR_E_ASSEMBLYEXPECTED
//
// MessageText:
//
// The module was expected to contain an assembly manifest.
//
  COR_E_ASSEMBLYEXPECTED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1018);
  {$EXTERNALSYM COR_E_ASSEMBLYEXPECTED}

//
// MessageId: COR_E_TYPEUNLOADED
//
// MessageText:
//
// The type had been unloaded.
//
  COR_E_TYPEUNLOADED   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1013);
  {$EXTERNALSYM COR_E_TYPEUNLOADED}

//
// MessageId: COR_E_INDEXOUTOFRANGE
//
// MessageText:
//
// Attempted to access an element within an array by using an index that is
// not within the bound of that array.
//
  COR_E_INDEXOUTOFRANGE  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1508);
  {$EXTERNALSYM COR_E_INDEXOUTOFRANGE}


//
// MessageId: COR_E_INSUFFICIENTMEMORY
//
// MessageText:
//
// Not enough memory was available for an operation.
// This may not be potentially fatal (vs. an OutOfMemoryException).
//
  COR_E_INSUFFICIENTMEMORY  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $153D);
  {$EXTERNALSYM COR_E_INSUFFICIENTMEMORY}


//
// MessageId: COR_E_RUNTIMEWRAPPED
//
// MessageText:
//
// An object that does not derive from System.Exception has been wrapped in a RuntimeWrappedException.
//
  COR_E_RUNTIMEWRAPPED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $153E);
  {$EXTERNALSYM COR_E_RUNTIMEWRAPPED}


//
// MessageId: COR_E_INVALIDCAST
//
// MessageText:
//
// Indicates a bad cast condition
//
  COR_E_INVALIDCAST  = E_NOINTERFACE;        // 0x80004002
  {$EXTERNALSYM COR_E_INVALIDCAST}


//
// MessageId: COR_E_INVALIDOPERATION
//
// MessageText:
//
// An operation is not legal in the current state.
//
  COR_E_INVALIDOPERATION  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1509);
  {$EXTERNALSYM COR_E_INVALIDOPERATION}


//
// MessageId: COR_E_INVALIDPROGRAM
//
// MessageText:
//
// A program contained invalid IL or bad metadata.  Usually this is a compiler bug.
//
  COR_E_INVALIDPROGRAM  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $153A);
  {$EXTERNALSYM COR_E_INVALIDPROGRAM}


//
// MessageId: COR_E_MEMBERACCESS
//
// MessageText:
//
// Access to this member is denied.
//
  COR_E_MEMBERACCESS  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $151A);
  {$EXTERNALSYM COR_E_MEMBERACCESS}


//
// MessageId: COR_E_METHODACCESS
//
// MessageText:
//
// Access to this method is denied.
//
  COR_E_METHODACCESS  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1510);
  {$EXTERNALSYM COR_E_METHODACCESS}


//
// MessageId: COR_E_MISSINGFIELD
//
// MessageText:
//
// An attempt was made to dynamically access a field that does not exist.
//
  COR_E_MISSINGFIELD  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1511);
  {$EXTERNALSYM COR_E_MISSINGFIELD}


//
// MessageId: COR_E_MISSINGMANIFESTRESOURCE
//
// MessageText:
//
// An expected resource in the assembly manifest was missing.
//
  COR_E_MISSINGMANIFESTRESOURCE  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1532);
  {$EXTERNALSYM COR_E_MISSINGMANIFESTRESOURCE}


//
// MessageId: COR_E_MISSINGMEMBER
//
// MessageText:
//
// An attempt was made to dynamically invoke or access a field or method
// that does not exist.
//
  COR_E_MISSINGMEMBER  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1512);
  {$EXTERNALSYM COR_E_MISSINGMEMBER}


//
// MessageId: COR_E_MISSINGMETHOD
//
// MessageText:
//
// An attempt was made to dynamically invoke a method that does not exist
//
  COR_E_MISSINGMETHOD  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1513);
  {$EXTERNALSYM COR_E_MISSINGMETHOD}


//
// MessageId: COR_E_MISSINGSATELLITEASSEMBLY
//
// MessageText:
//
// An expected satellite assembly containing the ultimate fallback resources
// for a given culture was not found or couldn't be loaded.  Setup problem?
//
  COR_E_MISSINGSATELLITEASSEMBLY  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1536);
  {$EXTERNALSYM COR_E_MISSINGSATELLITEASSEMBLY}


//
// MessageId: COR_E_MULTICASTNOTSUPPORTED
//
// MessageText:
//
// Attempted to combine delegates that are not multicast
//
  COR_E_MULTICASTNOTSUPPORTED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1514);
  {$EXTERNALSYM COR_E_MULTICASTNOTSUPPORTED}


//
// MessageId: COR_E_NOTFINITENUMBER
//
// MessageText:
//
//  Thrown if value (a floating point number) is either the not a number value (NaN) or +- infinity value
//  VB needs this stuff
  COR_E_NOTFINITENUMBER     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1528);
  {$EXTERNALSYM COR_E_NOTFINITENUMBER}


//
// MessageId: COR_E_DUPLICATEWAITOBJECT
//
// MessageText:
//
// An object appears more than once in the wait objects array.
//
  COR_E_DUPLICATEWAITOBJECT   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1529);
  {$EXTERNALSYM COR_E_DUPLICATEWAITOBJECT}


//
// MessageId: COR_E_PLATFORMNOTSUPPORTED
//
// MessageText:
//
// The method is not supported on this platform
//
  COR_E_PLATFORMNOTSUPPORTED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1539);
  {$EXTERNALSYM COR_E_PLATFORMNOTSUPPORTED}

//
// MessageId: COR_E_NOTSUPPORTED
//
// MessageText:
//
// The operation is not supported
//
  COR_E_NOTSUPPORTED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1515);
  {$EXTERNALSYM COR_E_NOTSUPPORTED}

//
// MessageId: COR_E_NULLREFERENCE
//
// MessageText:
//
// Dereferencing a null reference. In general class libraries should not throw this
//
  COR_E_NULLREFERENCE  = E_POINTER;      // 0x80004003
  {$EXTERNALSYM COR_E_NULLREFERENCE}


//
// MessageId: COR_E_OUTOFMEMORY
//
// MessageText:
//
// The EE thows this exception when no more memory is avaible to continue execution
//
  COR_E_OUTOFMEMORY  = E_OUTOFMEMORY;        // 0x8007000E
  {$EXTERNALSYM COR_E_OUTOFMEMORY}


//
// MessageId: COR_E_OVERFLOW
//
// MessageText:
//
// An arithmetic, casting, or conversion operation overflowed or underflowed.
//
  COR_E_OVERFLOW  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1516);
  {$EXTERNALSYM COR_E_OVERFLOW}


//
// MessageId: COR_E_RANK
//
// MessageText:
//
// An array has the wrong number of dimensions for a particular operation.
//
  COR_E_RANK  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1517);
  {$EXTERNALSYM COR_E_RANK}


//
// MessageId: COR_E_REMOTING
//
// MessageText:
//
// An error relating to remoting occurred.
//
  COR_E_REMOTING  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $150B);
  {$EXTERNALSYM COR_E_REMOTING}
  COR_E_SERVER  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $150E);
  {$EXTERNALSYM COR_E_SERVER}

//
// MessageId: COR_E_SERVICEDCOMPONENT
//
// MessageText:
//
// An error relating to ServicedComponent occurred.
//
  COR_E_SERVICEDCOMPONENT  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $150F);
  {$EXTERNALSYM COR_E_SERVICEDCOMPONENT}


//
// MessageId: COR_E_SECURITY
//
// MessageText:
//
// An error relating to security occured.
//
  COR_E_SECURITY  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $150A);
  {$EXTERNALSYM COR_E_SECURITY}


//
// MessageID: COR_E_SERIALIZATION
//
// MessageText:
//
// An error relating to serialization has occurred.
//
  COR_E_SERIALIZATION = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $150C);
  {$EXTERNALSYM COR_E_SERIALIZATION}


//
// MessageId: COR_E_STACKOVERFLOW
//
// MessageText:
//
// Is raised by the EE when the execution stack overflows as it is attempting to ex
//
  COR_E_STACKOVERFLOW  = HRESULT($800703E9);       // 0x800703E9 ERROR_STACK_OVERFLOW
  {$EXTERNALSYM COR_E_STACKOVERFLOW}


//
// MessageId: COR_E_SYNCHRONIZATIONLOCK
//
// MessageText:
//
// Wait(), Notify() or NotifyAll() was called from an unsynchronized ** block of c
//
  COR_E_SYNCHRONIZATIONLOCK  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1518);
  {$EXTERNALSYM COR_E_SYNCHRONIZATIONLOCK}


//
// MessageId: COR_E_SYSTEM
//
// MessageText:
//
// The base class for the runtime's "less serious" exceptions
//
  COR_E_SYSTEM  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1501);
  {$EXTERNALSYM COR_E_SYSTEM}


//
// MessageId: COR_E_THREADABORTED
//
// MessageText:
//
// Thrown into a thread to cause it to abort. Not catchable.
//
  COR_E_THREADABORTED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1530);
  {$EXTERNALSYM COR_E_THREADABORTED}


//
// MessageId: COR_E_OPERATIONCANCELED
//
// MessageText:
//
// The operation was cancelled.
//
  COR_E_OPERATIONCANCELED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $153B);
  {$EXTERNALSYM COR_E_OPERATIONCANCELED}


//
// MessageId: COR_E_THREADINTERRUPTED
//
// MessageText:
//
// Indicates that the thread was interrupted from a waiting state
//
  COR_E_THREADINTERRUPTED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1519);
  {$EXTERNALSYM COR_E_THREADINTERRUPTED}


//
// MessageId: COR_E_THREADSTATE
//
// MessageText:
//
// Indicate that the Thread class is in an invalid state for the method call
//
  COR_E_THREADSTATE  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1520);
  {$EXTERNALSYM COR_E_THREADSTATE}


//
// MessageId: COR_E_THREADSTOP
//
// MessageText:
//
// Thrown into a thread to cause it to stop. This exception is typically not caught
//
  COR_E_THREADSTOP  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1521);
  {$EXTERNALSYM COR_E_THREADSTOP}


//
// MessageId: COR_E_THREADSTART
//
// MessageText:
//
// Indicate that a user thread fails to start.
//
  COR_E_THREADSTART  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1525);
  {$EXTERNALSYM COR_E_THREADSTART}


//
// MessageId: COR_E_TYPEINITIALIZATION
//
// MessageText:
//
// An exception was thrown by a type's initializer (.cctor).
//
  COR_E_TYPEINITIALIZATION  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1534);
  {$EXTERNALSYM COR_E_TYPEINITIALIZATION}


//
// MessageId: COR_E_TYPELOAD
//
// MessageText:
//
// Could not find or load a specific type (class, enum, etc).
//
  COR_E_TYPELOAD  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1522);
  {$EXTERNALSYM COR_E_TYPELOAD}


//
// MessageId: COR_E_ENTRYPOINTNOTFOUND
//
// MessageText:
//
// Could not find the specified DllImport entry point
//
  COR_E_ENTRYPOINTNOTFOUND  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1523);
  {$EXTERNALSYM COR_E_ENTRYPOINTNOTFOUND}


//
// MessageId: COR_E_DLLNOTFOUND
//
// MessageText:
//
// Could not find the specified DllImport DLL.
//
  COR_E_DLLNOTFOUND  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1524);
  {$EXTERNALSYM COR_E_DLLNOTFOUND}


//
// MessageId: COR_E_UNAUTHORIZEDACCESS
//
// MessageText:
//
// Access is denied.
//
  COR_E_UNAUTHORIZEDACCESS  = E_ACCESSDENIED;    // 0x80070005
  {$EXTERNALSYM COR_E_UNAUTHORIZEDACCESS}


//
// MessageId: COR_E_VERIFICATION
//
// MessageText:
//
// A verification failure occurred
//
  COR_E_VERIFICATION  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $150D);
  {$EXTERNALSYM COR_E_VERIFICATION}


//
// MessageId: COR_E_INVALIDCOMOBJECT
//
// MessageText:
//
// An invalid __ComObject has been used.
//
  COR_E_INVALIDCOMOBJECT     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1527);
  {$EXTERNALSYM COR_E_INVALIDCOMOBJECT}


//
// MessageId: COR_E_SEMAPHOREFULL
//
// MessageText:
//
// Adding the given count to the semaphore would cause it to exceed its maximum count.
//
  COR_E_SEMAPHOREFULL     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $152B);
  {$EXTERNALSYM COR_E_SEMAPHOREFULL}


//
// MessageId: COR_E_WAITHANDLECANNOTBEOPENED
//
// MessageText:
//
// No Semaphore of the given name exists.
//
  COR_E_WAITHANDLECANNOTBEOPENED     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $152C);
  {$EXTERNALSYM COR_E_WAITHANDLECANNOTBEOPENED}

//
// MessageId: COR_E_ABANDONEDMUTEX
//
// MessageText:
//
// The wait completed due to an abandoned mutex.
//
  COR_E_ABANDONEDMUTEX = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $152D);
  {$EXTERNALSYM COR_E_ABANDONEDMUTEX}

//
// MessageId: COR_E_MARSHALDIRECTIVE
//
// MessageText:
//
// The marshaling directives are invalid.
//
  COR_E_MARSHALDIRECTIVE     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1535);
  {$EXTERNALSYM COR_E_MARSHALDIRECTIVE}


//
// MessageId: COR_E_INVALIDOLEVARIANTTYPE
//
// MessageText:
//
// The type of an OLE variant that was passed into the runtime is invalid.
//
  COR_E_INVALIDOLEVARIANTTYPE    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1531);
  {$EXTERNALSYM COR_E_INVALIDOLEVARIANTTYPE}


//
// MessageId: COR_E_SAFEARRAYTYPEMISMATCH
//
// MessageText:
//
// A mismatch has occured between the runtime type of the array and the
// sub type recorded in the metadata.
//
  COR_E_SAFEARRAYTYPEMISMATCH    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1533);
  {$EXTERNALSYM COR_E_SAFEARRAYTYPEMISMATCH}


//
// MessageId: COR_E_SAFEARRAYRANKMISMATCH
//
// MessageText:
//
// A mismatch has occured between the runtime rank of the array and the
// rank recorded in the metadata.
//
  COR_E_SAFEARRAYRANKMISMATCH    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1538);
  {$EXTERNALSYM COR_E_SAFEARRAYRANKMISMATCH}

//
// MessageId: COR_E_DATAMISALIGNED
//
// MessageText:
//
// A datatype misalignment was detected in a load or store instruction.
//
  COR_E_DATAMISALIGNED    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1541);
  {$EXTERNALSYM COR_E_DATAMISALIGNED}


//
// MessageId: COR_E_TARGETPARAMCOUNT
//
// MessageText:
//
// There was a mismatch between number of arguments provided and the number expected
//
  COR_E_TARGETPARAMCOUNT     = HRESULT($8002000E); // DISP_E_BADPARAMCOUNT
  {$EXTERNALSYM COR_E_TARGETPARAMCOUNT}


//
// MessageId: COR_E_AMBIGUOUSMATCH
//
// MessageText:
//
// While late binding to a method via reflection, could not resolve between
// multiple overloads of a method.
//
  COR_E_AMBIGUOUSMATCH  = HRESULT($8000211D);
  {$EXTERNALSYM COR_E_AMBIGUOUSMATCH}


//
// MessageId: COR_E_INVALIDFILTERCRITERIA
//
// MessageText:
//
// The given filter criteria does not match the filter contract.
//
  COR_E_INVALIDFILTERCRITERIA  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1601);
  {$EXTERNALSYM COR_E_INVALIDFILTERCRITERIA}


//
// MessageId: COR_E_REFLECTIONTYPELOAD
//
// MessageText:
//
// Could not find or load a specific class that was requested through Reflection
//
  COR_E_REFLECTIONTYPELOAD  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1602);
  {$EXTERNALSYM COR_E_REFLECTIONTYPELOAD}


//
// MessageId: COR_E_TARGET
//
// MessageText:
//
// - If you attempt to invoke a non-static method with a null Object - If you atte
//
  COR_E_TARGET  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1603);
  {$EXTERNALSYM COR_E_TARGET}


//
// MessageId: COR_E_TARGETINVOCATION
//
// MessageText:
//
// If the method called throws an exception
//
  COR_E_TARGETINVOCATION  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1604);
  {$EXTERNALSYM COR_E_TARGETINVOCATION}


//
// MessageId: COR_E_CUSTOMATTRIBUTEFORMAT
//
// MessageText:
//
// If the binary format of a custom attribute is invalid.
//
  COR_E_CUSTOMATTRIBUTEFORMAT  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1605);
  {$EXTERNALSYM COR_E_CUSTOMATTRIBUTEFORMAT}


//
// MessageId: COR_E_ENDOFSTREAM
//
// MessageText:
//
// Thrown when the End of file is reached
//
  COR_E_ENDOFSTREAM   = HRESULT((LongWord(ERROR_HANDLE_EOF) and $0000FFFF) or (FACILITY_WIN32 shl 16) or $80000000); //ERROR_HANDLE_EOF
  {$EXTERNALSYM COR_E_ENDOFSTREAM}


//
// MessageId: COR_E_FILELOAD
//
// MessageText:
//
//
//
  COR_E_FILELOAD  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1621);
  {$EXTERNALSYM COR_E_FILELOAD}


//
// MessageId: COR_E_FILENOTFOUND
//
// MessageText:
//
//
//
  COR_E_FILENOTFOUND  = HRESULT((LongWord(ERROR_FILE_NOT_FOUND) and $0000FFFF) or (FACILITY_WIN32 shl 16) or $80000000); //ERROR_FILE_NOT_FOUND
  {$EXTERNALSYM COR_E_FILENOTFOUND}

//
// MessageId: ERROR_BAD_PATHNAME
//
// MessageText:
//
//  The specified path is invalid.
//
  COR_E_BAD_PATHNAME  = HRESULT((LongWord(ERROR_BAD_PATHNAME) and $0000FFFF) or (FACILITY_WIN32 shl 16) or $80000000); //ERROR_BAD_PATHNAME
  {$EXTERNALSYM COR_E_BAD_PATHNAME}

//
// MessageId: COR_E_IO
//
// MessageText:
//
// Some sort of I/O error.
//
  COR_E_IO  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1620);
  {$EXTERNALSYM COR_E_IO}


//
// MessageId: COR_E_DIRECTORYNOTFOUND
//
// MessageText:
//
// The specified path couldn't be found.
//
  COR_E_DIRECTORYNOTFOUND  = HRESULT((LongWord(ERROR_PATH_NOT_FOUND) and $0000FFFF) or (FACILITY_WIN32 shl 16) or $80000000); //ERROR_PATH_NOT_FOUND
  {$EXTERNALSYM COR_E_DIRECTORYNOTFOUND}


//
// MessageId: COR_E_PATHTOOLONG
//
// MessageText:
//
// The specified path was too long.
//
  COR_E_PATHTOOLONG  = HRESULT((LongWord(ERROR_FILENAME_EXCED_RANGE) and $0000FFFF) or (FACILITY_WIN32 shl 16) or $80000000); //ERROR_FILENAME_EXCED_RANGE
  {$EXTERNALSYM COR_E_PATHTOOLONG}


//
// MessageId: COR_E_OBJECTDISPOSED
//
// MessageText:
//
// The object has already been disposed.
//
  COR_E_OBJECTDISPOSED = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1622);
  {$EXTERNALSYM COR_E_OBJECTDISPOSED}


//
// MessageId: COR_E_FAILFAST
//
// MessageText:
//
// Runtime operation halted by call to System.Environment.FailFast().
//
  COR_E_FAILFAST  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1623);
  {$EXTERNALSYM COR_E_FAILFAST}


//
// MessageId: COR_E_HOSTPROTECTION
//
// MessageText:
//
// Attempted to perform an operation that was forbidden by the host.
//
  COR_E_HOSTPROTECTION  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1640);
  {$EXTERNALSYM COR_E_HOSTPROTECTION}


//
// MessageId: COR_E_ILLEGAL_REENTRANCY
//
// MessageText:
//
// Attempted to call into managed code when executing inside a low level extensibility point.
//
  COR_E_ILLEGAL_REENTRANCY  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1641);
  {$EXTERNALSYM COR_E_ILLEGAL_REENTRANCY}


//**** Shim errors 1700 - 1750
//
  CLR_E_SHIM_RUNTIMELOAD            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1700);     // Failed to load the runtime
  {$EXTERNALSYM CLR_E_SHIM_RUNTIMELOAD}
  CLR_E_SHIM_RUNTIMEEXPORT          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1701);     // Failed to find a required export in the runtime
  {$EXTERNALSYM CLR_E_SHIM_RUNTIMEEXPORT}
  CLR_E_SHIM_INSTALLROOT            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1702);     // Install root is not defined
  {$EXTERNALSYM CLR_E_SHIM_INSTALLROOT}
  CLR_E_SHIM_INSTALLCOMP            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1703);     // Expected component of the runtime is not available
  {$EXTERNALSYM CLR_E_SHIM_INSTALLCOMP}

//**** Verifier Errors 1800 - 18FF
// See src/dlls/mscorrc/mscorrc.rc for a description of each error

  VER_E_HRESULT           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1801);
  {$EXTERNALSYM VER_E_HRESULT}
  VER_E_OFFSET            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1802);
  {$EXTERNALSYM VER_E_OFFSET}
  VER_E_OPCODE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1803);
  {$EXTERNALSYM VER_E_OPCODE}
  VER_E_OPERAND           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1804);
  {$EXTERNALSYM VER_E_OPERAND}
  VER_E_TOKEN             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1805);
  {$EXTERNALSYM VER_E_TOKEN}
  VER_E_EXCEPT            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1806);
  {$EXTERNALSYM VER_E_EXCEPT}
  VER_E_STACK_SLOT        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1807);
  {$EXTERNALSYM VER_E_STACK_SLOT}
  VER_E_LOC               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1808);
  {$EXTERNALSYM VER_E_LOC}
  VER_E_ARG               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1809);
  {$EXTERNALSYM VER_E_ARG}
  VER_E_FOUND             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $180A);
  {$EXTERNALSYM VER_E_FOUND}
  VER_E_EXPECTED          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $180B);
  {$EXTERNALSYM VER_E_EXPECTED}
  VER_E_LOC_BYNAME        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $180C);
  {$EXTERNALSYM VER_E_LOC_BYNAME}

  VER_E_UNKNOWN_OPCODE    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1810);
  {$EXTERNALSYM VER_E_UNKNOWN_OPCODE}
  VER_E_SIG_CALLCONV      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1811);
  {$EXTERNALSYM VER_E_SIG_CALLCONV}
  VER_E_SIG_ELEMTYPE      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1812);
  {$EXTERNALSYM VER_E_SIG_ELEMTYPE}

  VER_E_RET_SIG           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1814);
  {$EXTERNALSYM VER_E_RET_SIG}
  VER_E_FIELD_SIG         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1815);
  {$EXTERNALSYM VER_E_FIELD_SIG}

  VER_E_INTERNAL          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1818);
  {$EXTERNALSYM VER_E_INTERNAL}
  VER_E_STACK_TOO_LARGE   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1819);
  {$EXTERNALSYM VER_E_STACK_TOO_LARGE}
  VER_E_ARRAY_NAME_LONG   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $181A);
  {$EXTERNALSYM VER_E_ARRAY_NAME_LONG}

  VER_E_FALLTHRU          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1820);
  {$EXTERNALSYM VER_E_FALLTHRU}
  VER_E_TRY_GTEQ_END      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1821);
  {$EXTERNALSYM VER_E_TRY_GTEQ_END}
  VER_E_TRYEND_GT_CS      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1822);
  {$EXTERNALSYM VER_E_TRYEND_GT_CS}
  VER_E_HND_GTEQ_END      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1823);
  {$EXTERNALSYM VER_E_HND_GTEQ_END}
  VER_E_HNDEND_GT_CS      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1824);
  {$EXTERNALSYM VER_E_HNDEND_GT_CS}
  VER_E_FLT_GTEQ_CS       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1825);
  {$EXTERNALSYM VER_E_FLT_GTEQ_CS}
  VER_E_TRY_START         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1826);
  {$EXTERNALSYM VER_E_TRY_START}
  VER_E_HND_START         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1827);
  {$EXTERNALSYM VER_E_HND_START}
  VER_E_FLT_START         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1828);
  {$EXTERNALSYM VER_E_FLT_START}
  VER_E_TRY_OVERLAP       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1829);
  {$EXTERNALSYM VER_E_TRY_OVERLAP}
  VER_E_TRY_EQ_HND_FIL    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $182A);
  {$EXTERNALSYM VER_E_TRY_EQ_HND_FIL}
  VER_E_TRY_SHARE_FIN_FAL = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $182B);
  {$EXTERNALSYM VER_E_TRY_SHARE_FIN_FAL}
  VER_E_HND_OVERLAP       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $182C);
  {$EXTERNALSYM VER_E_HND_OVERLAP}
  VER_E_HND_EQ            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $182D);
  {$EXTERNALSYM VER_E_HND_EQ}
  VER_E_FIL_OVERLAP       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $182E);
  {$EXTERNALSYM VER_E_FIL_OVERLAP}
  VER_E_FIL_EQ            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $182F);
  {$EXTERNALSYM VER_E_FIL_EQ}
  VER_E_FIL_CONT_TRY      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1830);
  {$EXTERNALSYM VER_E_FIL_CONT_TRY}
  VER_E_FIL_CONT_HND      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1831);
  {$EXTERNALSYM VER_E_FIL_CONT_HND}
  VER_E_FIL_CONT_FIL      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1832);
  {$EXTERNALSYM VER_E_FIL_CONT_FIL}
  VER_E_FIL_GTEQ_CS       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1833);
  {$EXTERNALSYM VER_E_FIL_GTEQ_CS}
  VER_E_FIL_START         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1834);
  {$EXTERNALSYM VER_E_FIL_START}
  VER_E_FALLTHRU_EXCEP    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1835);
  {$EXTERNALSYM VER_E_FALLTHRU_EXCEP}
  VER_E_FALLTHRU_INTO_HND = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1836);
  {$EXTERNALSYM VER_E_FALLTHRU_INTO_HND}
  VER_E_FALLTHRU_INTO_FIL = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1837);
  {$EXTERNALSYM VER_E_FALLTHRU_INTO_FIL}
  VER_E_LEAVE             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1838);
  {$EXTERNALSYM VER_E_LEAVE}
  VER_E_RETHROW           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1839);
  {$EXTERNALSYM VER_E_RETHROW}
  VER_E_ENDFINALLY        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $183A);
  {$EXTERNALSYM VER_E_ENDFINALLY}
  VER_E_ENDFILTER         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $183B);
  {$EXTERNALSYM VER_E_ENDFILTER}
  VER_E_ENDFILTER_MISSING = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $183C);
  {$EXTERNALSYM VER_E_ENDFILTER_MISSING}
  VER_E_BR_INTO_TRY       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $183D);
  {$EXTERNALSYM VER_E_BR_INTO_TRY}
  VER_E_BR_INTO_HND       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $183E);
  {$EXTERNALSYM VER_E_BR_INTO_HND}
  VER_E_BR_INTO_FIL       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $183F);
  {$EXTERNALSYM VER_E_BR_INTO_FIL}
  VER_E_BR_OUTOF_TRY      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1840);
  {$EXTERNALSYM VER_E_BR_OUTOF_TRY}
  VER_E_BR_OUTOF_HND      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1841);
  {$EXTERNALSYM VER_E_BR_OUTOF_HND}
  VER_E_BR_OUTOF_FIL      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1842);
  {$EXTERNALSYM VER_E_BR_OUTOF_FIL}
  VER_E_BR_OUTOF_FIN      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1843);
  {$EXTERNALSYM VER_E_BR_OUTOF_FIN}
  VER_E_RET_FROM_TRY      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1844);
  {$EXTERNALSYM VER_E_RET_FROM_TRY}
  VER_E_RET_FROM_HND      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1845);
  {$EXTERNALSYM VER_E_RET_FROM_HND}
  VER_E_RET_FROM_FIL      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1846);
  {$EXTERNALSYM VER_E_RET_FROM_FIL}
  VER_E_BAD_JMP_TARGET    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1847);
  {$EXTERNALSYM VER_E_BAD_JMP_TARGET}
  VER_E_PATH_LOC          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1848);
  {$EXTERNALSYM VER_E_PATH_LOC}
  VER_E_PATH_THIS         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1849);
  {$EXTERNALSYM VER_E_PATH_THIS}
  VER_E_PATH_STACK        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $184A);
  {$EXTERNALSYM VER_E_PATH_STACK}
  VER_E_PATH_STACK_DEPTH  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $184B);
  {$EXTERNALSYM VER_E_PATH_STACK_DEPTH}
  VER_E_THIS              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $184C);
  {$EXTERNALSYM VER_E_THIS}
  VER_E_THIS_UNINIT_EXCEP = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $184D);
  {$EXTERNALSYM VER_E_THIS_UNINIT_EXCEP}
  VER_E_THIS_UNINIT_STORE = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $184E);
  {$EXTERNALSYM VER_E_THIS_UNINIT_STORE}
  VER_E_THIS_UNINIT_RET   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $184F);
  {$EXTERNALSYM VER_E_THIS_UNINIT_RET}
  VER_E_THIS_UNINIT_V_RET = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1850);
  {$EXTERNALSYM VER_E_THIS_UNINIT_V_RET}
  VER_E_THIS_UNINIT_BR    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1851);
  {$EXTERNALSYM VER_E_THIS_UNINIT_BR}
  VER_E_LDFTN_CTOR        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1852);
  {$EXTERNALSYM VER_E_LDFTN_CTOR}
  VER_E_STACK_NOT_EQ      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1853);
  {$EXTERNALSYM VER_E_STACK_NOT_EQ}
  VER_E_STACK_UNEXPECTED  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1854);
  {$EXTERNALSYM VER_E_STACK_UNEXPECTED}
  VER_E_STACK_EXCEPTION   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1855);
  {$EXTERNALSYM VER_E_STACK_EXCEPTION}
  VER_E_STACK_OVERFLOW    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1856);
  {$EXTERNALSYM VER_E_STACK_OVERFLOW}
  VER_E_STACK_UNDERFLOW   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1857);
  {$EXTERNALSYM VER_E_STACK_UNDERFLOW}
  VER_E_STACK_EMPTY       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1858);
  {$EXTERNALSYM VER_E_STACK_EMPTY}
  VER_E_STACK_UNINIT      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1859);
  {$EXTERNALSYM VER_E_STACK_UNINIT}
  VER_E_STACK_I_I4_I8     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $185A);
  {$EXTERNALSYM VER_E_STACK_I_I4_I8}
  VER_E_STACK_R_R4_R8     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $185B);
  {$EXTERNALSYM VER_E_STACK_R_R4_R8}
  VER_E_STACK_NO_R_I8     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $185C);
  {$EXTERNALSYM VER_E_STACK_NO_R_I8}
  VER_E_STACK_NUMERIC     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $185D);
  {$EXTERNALSYM VER_E_STACK_NUMERIC}
  VER_E_STACK_OBJREF      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $185E);
  {$EXTERNALSYM VER_E_STACK_OBJREF}
  VER_E_STACK_P_OBJREF    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $185F);
  {$EXTERNALSYM VER_E_STACK_P_OBJREF}
  VER_E_STACK_BYREF       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1860);
  {$EXTERNALSYM VER_E_STACK_BYREF}
  VER_E_STACK_METHOD      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1861);
  {$EXTERNALSYM VER_E_STACK_METHOD}
  VER_E_STACK_ARRAY_SD    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1862);
  {$EXTERNALSYM VER_E_STACK_ARRAY_SD}
  VER_E_STACK_VALCLASS    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1863);
  {$EXTERNALSYM VER_E_STACK_VALCLASS}
  VER_E_STACK_P_VALCLASS  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1864);
  {$EXTERNALSYM VER_E_STACK_P_VALCLASS}
  VER_E_STACK_NO_VALCLASS = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1865);
  {$EXTERNALSYM VER_E_STACK_NO_VALCLASS}
  VER_E_LOC_DEAD          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1866);
  {$EXTERNALSYM VER_E_LOC_DEAD}
  VER_E_LOC_NUM           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1867);
  {$EXTERNALSYM VER_E_LOC_NUM}
  VER_E_ARG_NUM           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1868);
  {$EXTERNALSYM VER_E_ARG_NUM}
  VER_E_TOKEN_RESOLVE     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1869);
  {$EXTERNALSYM VER_E_TOKEN_RESOLVE}
  VER_E_TOKEN_TYPE        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $186A);
  {$EXTERNALSYM VER_E_TOKEN_TYPE}
  VER_E_TOKEN_TYPE_MEMBER = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $186B);
  {$EXTERNALSYM VER_E_TOKEN_TYPE_MEMBER}
  VER_E_TOKEN_TYPE_FIELD  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $186C);
  {$EXTERNALSYM VER_E_TOKEN_TYPE_FIELD}
  VER_E_TOKEN_TYPE_SIG    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $186D);
  {$EXTERNALSYM VER_E_TOKEN_TYPE_SIG}
  VER_E_UNVERIFIABLE      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $186E);
  {$EXTERNALSYM VER_E_UNVERIFIABLE}
  VER_E_LDSTR_OPERAND     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $186F);
  {$EXTERNALSYM VER_E_LDSTR_OPERAND}
  VER_E_RET_PTR_TO_STACK  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1870);
  {$EXTERNALSYM VER_E_RET_PTR_TO_STACK}
  VER_E_RET_VOID          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1871);
  {$EXTERNALSYM VER_E_RET_VOID}
  VER_E_RET_MISSING       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1872);
  {$EXTERNALSYM VER_E_RET_MISSING}
  VER_E_RET_EMPTY         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1873);
  {$EXTERNALSYM VER_E_RET_EMPTY}
  VER_E_RET_UNINIT        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1874);
  {$EXTERNALSYM VER_E_RET_UNINIT}
  VER_E_ARRAY_ACCESS      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1875);
  {$EXTERNALSYM VER_E_ARRAY_ACCESS}
  VER_E_ARRAY_V_STORE     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1876);
  {$EXTERNALSYM VER_E_ARRAY_V_STORE}
  VER_E_ARRAY_SD          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1877);
  {$EXTERNALSYM VER_E_ARRAY_SD}
  VER_E_ARRAY_SD_PTR      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1878);
  {$EXTERNALSYM VER_E_ARRAY_SD_PTR}
  VER_E_ARRAY_FIELD       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1879);
  {$EXTERNALSYM VER_E_ARRAY_FIELD}
  VER_E_ARGLIST           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $187A);
  {$EXTERNALSYM VER_E_ARGLIST}
  VER_E_VALCLASS          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $187B);
  {$EXTERNALSYM VER_E_VALCLASS}
  VER_E_METHOD_ACCESS     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $187C);
  {$EXTERNALSYM VER_E_METHOD_ACCESS}
  VER_E_FIELD_ACCESS      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $187D);
  {$EXTERNALSYM VER_E_FIELD_ACCESS}
  VER_E_DEAD              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $187E);
  {$EXTERNALSYM VER_E_DEAD}
  VER_E_FIELD_STATIC      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $187F);
  {$EXTERNALSYM VER_E_FIELD_STATIC}
  VER_E_FIELD_NO_STATIC   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1880);
  {$EXTERNALSYM VER_E_FIELD_NO_STATIC}
  VER_E_ADDR              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1881);
  {$EXTERNALSYM VER_E_ADDR}
  VER_E_ADDR_BYREF        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1882);
  {$EXTERNALSYM VER_E_ADDR_BYREF}
  VER_E_ADDR_LITERAL      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1883);
  {$EXTERNALSYM VER_E_ADDR_LITERAL}
  VER_E_INITONLY          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1884);
  {$EXTERNALSYM VER_E_INITONLY}
  VER_E_THROW             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1885);
  {$EXTERNALSYM VER_E_THROW}
  VER_E_CALLVIRT_VALCLASS = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1886);
  {$EXTERNALSYM VER_E_CALLVIRT_VALCLASS}
  VER_E_CALL_SIG          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1887);
  {$EXTERNALSYM VER_E_CALL_SIG}
  VER_E_CALL_STATIC       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1888);
  {$EXTERNALSYM VER_E_CALL_STATIC}
  VER_E_CTOR              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1889);
  {$EXTERNALSYM VER_E_CTOR}
  VER_E_CTOR_VIRT         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $188A);
  {$EXTERNALSYM VER_E_CTOR_VIRT}
  VER_E_CTOR_OR_SUPER     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $188B);
  {$EXTERNALSYM VER_E_CTOR_OR_SUPER}
  VER_E_CTOR_MUL_INIT     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $188C);
  {$EXTERNALSYM VER_E_CTOR_MUL_INIT}
  VER_E_SIG               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $188D);
  {$EXTERNALSYM VER_E_SIG}
  VER_E_SIG_ARRAY         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $188E);
  {$EXTERNALSYM VER_E_SIG_ARRAY}
  VER_E_SIG_ARRAY_PTR     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $188F);
  {$EXTERNALSYM VER_E_SIG_ARRAY_PTR}
  VER_E_SIG_ARRAY_BYREF   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1890);
  {$EXTERNALSYM VER_E_SIG_ARRAY_BYREF}
  VER_E_SIG_ELEM_PTR      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1891);
  {$EXTERNALSYM VER_E_SIG_ELEM_PTR}
  VER_E_SIG_VARARG        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1892);
  {$EXTERNALSYM VER_E_SIG_VARARG}
  VER_E_SIG_VOID          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1893);
  {$EXTERNALSYM VER_E_SIG_VOID}
  VER_E_SIG_BYREF_BYREF   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1894);
  {$EXTERNALSYM VER_E_SIG_BYREF_BYREF}
  VER_E_CODE_SIZE_ZERO    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1896);
  {$EXTERNALSYM VER_E_CODE_SIZE_ZERO}
  VER_E_BAD_VARARG        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1897);
  {$EXTERNALSYM VER_E_BAD_VARARG}
  VER_E_TAIL_CALL         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1898);
  {$EXTERNALSYM VER_E_TAIL_CALL}
  VER_E_TAIL_BYREF        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1899);
  {$EXTERNALSYM VER_E_TAIL_BYREF}
  VER_E_TAIL_RET          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $189A);
  {$EXTERNALSYM VER_E_TAIL_RET}
  VER_E_TAIL_RET_VOID     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $189B);
  {$EXTERNALSYM VER_E_TAIL_RET_VOID}
  VER_E_TAIL_RET_TYPE     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $189C);
  {$EXTERNALSYM VER_E_TAIL_RET_TYPE}
  VER_E_TAIL_STACK_EMPTY  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $189D);
  {$EXTERNALSYM VER_E_TAIL_STACK_EMPTY}
  VER_E_METHOD_END        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $189E);
  {$EXTERNALSYM VER_E_METHOD_END}
  VER_E_BAD_BRANCH        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $189F);
  {$EXTERNALSYM VER_E_BAD_BRANCH}
  VER_E_FIN_OVERLAP       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18A0);
  {$EXTERNALSYM VER_E_FIN_OVERLAP}
  VER_E_LEXICAL_NESTING   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18A1);
  {$EXTERNALSYM VER_E_LEXICAL_NESTING}
  VER_E_VOLATILE          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18A2);
  {$EXTERNALSYM VER_E_VOLATILE}
  VER_E_UNALIGNED         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18A3);
  {$EXTERNALSYM VER_E_UNALIGNED}
  VER_E_INNERMOST_FIRST   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18A4);
  {$EXTERNALSYM VER_E_INNERMOST_FIRST}
  VER_E_CALLI_VIRTUAL     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18A5);
  {$EXTERNALSYM VER_E_CALLI_VIRTUAL}
  VER_E_CALL_ABSTRACT     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18A6);
  {$EXTERNALSYM VER_E_CALL_ABSTRACT}
  VER_E_STACK_UNEXP_ARRAY = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18A7);
  {$EXTERNALSYM VER_E_STACK_UNEXP_ARRAY}
  VER_E_NOT_IN_GC_HEAP    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18A8);
  {$EXTERNALSYM VER_E_NOT_IN_GC_HEAP}
  VER_E_TRY_N_EMPTY_STACK = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18A9);
  {$EXTERNALSYM VER_E_TRY_N_EMPTY_STACK}
  VER_E_DLGT_CTOR         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18AA);
  {$EXTERNALSYM VER_E_DLGT_CTOR}
  VER_E_DLGT_BB           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18AB);
  {$EXTERNALSYM VER_E_DLGT_BB}
  VER_E_DLGT_PATTERN      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18AC);
  {$EXTERNALSYM VER_E_DLGT_PATTERN}
  VER_E_DLGT_LDFTN        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18AD);
  {$EXTERNALSYM VER_E_DLGT_LDFTN}
  VER_E_FTN_ABSTRACT      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18AE);
  {$EXTERNALSYM VER_E_FTN_ABSTRACT}
  VER_E_SIG_C_VC          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18AF);
  {$EXTERNALSYM VER_E_SIG_C_VC}
  VER_E_SIG_VC_C          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18B0);
  {$EXTERNALSYM VER_E_SIG_VC_C}
  VER_E_BOX_PTR_TO_STACK  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18B1);
  {$EXTERNALSYM VER_E_BOX_PTR_TO_STACK}
  VER_E_SIG_BYREF_TB_AH   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18B2);
  {$EXTERNALSYM VER_E_SIG_BYREF_TB_AH}
  VER_E_SIG_ARRAY_TB_AH   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18B3);
  {$EXTERNALSYM VER_E_SIG_ARRAY_TB_AH}
  VER_E_ENDFILTER_STACK   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18B4);
  {$EXTERNALSYM VER_E_ENDFILTER_STACK}
  VER_E_DLGT_SIG_I        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18B5);
  {$EXTERNALSYM VER_E_DLGT_SIG_I}
  VER_E_DLGT_SIG_O        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18B6);
  {$EXTERNALSYM VER_E_DLGT_SIG_O}
  VER_E_RA_PTR_TO_STACK   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18B7);
  {$EXTERNALSYM VER_E_RA_PTR_TO_STACK}
  VER_E_CATCH_VALUE_TYPE  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18B8);
  {$EXTERNALSYM VER_E_CATCH_VALUE_TYPE}
  VER_E_CATCH_BYREF       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18B9);
  {$EXTERNALSYM VER_E_CATCH_BYREF}
  VER_E_FIL_PRECEED_HND   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18BA);
  {$EXTERNALSYM VER_E_FIL_PRECEED_HND}
  VER_E_LDVIRTFTN_STATIC  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18BB);
  {$EXTERNALSYM VER_E_LDVIRTFTN_STATIC}
  VER_E_CALLVIRT_STATIC   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18BC);
  {$EXTERNALSYM VER_E_CALLVIRT_STATIC}
  VER_E_INITLOCALS        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18BD);
  {$EXTERNALSYM VER_E_INITLOCALS}
  VER_E_BR_TO_EXCEPTION   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18BE);
  {$EXTERNALSYM VER_E_BR_TO_EXCEPTION}
  VER_E_CALL_CTOR         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18BF);
  {$EXTERNALSYM VER_E_CALL_CTOR}

//@GENERICSVER: new generics related error messages
  VER_E_VALCLASS_OBJREF_VAR          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18C0);
  {$EXTERNALSYM VER_E_VALCLASS_OBJREF_VAR}
  VER_E_STACK_P_VALCLASS_OBJREF_VAR  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18C1);
  {$EXTERNALSYM VER_E_STACK_P_VALCLASS_OBJREF_VAR}
  VER_E_SIG_VAR_PARAM     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18C2);
  {$EXTERNALSYM VER_E_SIG_VAR_PARAM}
  VER_E_SIG_MVAR_PARAM    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18C3);
  {$EXTERNALSYM VER_E_SIG_MVAR_PARAM}
  VER_E_SIG_VAR_ARG       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18C4);
  {$EXTERNALSYM VER_E_SIG_VAR_ARG}
  VER_E_SIG_MVAR_ARG      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18C5);
  {$EXTERNALSYM VER_E_SIG_MVAR_ARG}
  VER_E_SIG_GENERICINST   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18C6);
  {$EXTERNALSYM VER_E_SIG_GENERICINST}
  VER_E_SIG_METHOD_INST   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18C7);
  {$EXTERNALSYM VER_E_SIG_METHOD_INST}
  VER_E_SIG_METHOD_PARENT_INST    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18C8);
  {$EXTERNALSYM VER_E_SIG_METHOD_PARENT_INST}
  VER_E_SIG_FIELD_PARENT_INST     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18C9);
  {$EXTERNALSYM VER_E_SIG_FIELD_PARENT_INST}
  VER_E_CALLCONV_NOT_GENERICINST  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18CA);
  {$EXTERNALSYM VER_E_CALLCONV_NOT_GENERICINST}
  VER_E_TOKEN_BAD_METHOD_SPEC     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18CB);
  {$EXTERNALSYM VER_E_TOKEN_BAD_METHOD_SPEC}
  VER_E_BAD_READONLY_PREFIX       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18CC);
  {$EXTERNALSYM VER_E_BAD_READONLY_PREFIX}
  VER_E_BAD_CONSTRAINED_PREFIX    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18CD);
  {$EXTERNALSYM VER_E_BAD_CONSTRAINED_PREFIX}
//these two are actually raised by the EE - should they appear elsewhere?
  VER_E_CIRCULAR_VAR_CONSTRAINTS  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18CE);
  {$EXTERNALSYM VER_E_CIRCULAR_VAR_CONSTRAINTS}
  VER_E_CIRCULAR_MVAR_CONSTRAINTS = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18CF);
  {$EXTERNALSYM VER_E_CIRCULAR_MVAR_CONSTRAINTS}
//these are used by the new peverify
  VER_E_UNSATISFIED_METHOD_INST           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18D0);
  {$EXTERNALSYM VER_E_UNSATISFIED_METHOD_INST}
  VER_E_UNSATISFIED_METHOD_PARENT_INST    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18D1);
  {$EXTERNALSYM VER_E_UNSATISFIED_METHOD_PARENT_INST}
  VER_E_UNSATISFIED_FIELD_PARENT_INST     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18D2);
  {$EXTERNALSYM VER_E_UNSATISFIED_FIELD_PARENT_INST}
  VER_E_UNSATISFIED_BOX_OPERAND           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18D3);
  {$EXTERNALSYM VER_E_UNSATISFIED_BOX_OPERAND}
  VER_E_CONSTRAINED_CALL_WITH_NON_BYREF_THIS  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18D4);
  {$EXTERNALSYM VER_E_CONSTRAINED_CALL_WITH_NON_BYREF_THIS}
  VER_E_CONSTRAINED_OF_NON_VARIABLE_TYPE = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18D5);
  {$EXTERNALSYM VER_E_CONSTRAINED_OF_NON_VARIABLE_TYPE}
  VER_E_READONLY_UNEXPECTED_CALLEE       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18D6);
  {$EXTERNALSYM VER_E_READONLY_UNEXPECTED_CALLEE}
  VER_E_READONLY_ILLEGAL_WRITE           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18D7);
  {$EXTERNALSYM VER_E_READONLY_ILLEGAL_WRITE}
  VER_E_READONLY_IN_MKREFANY             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18D8);
  {$EXTERNALSYM VER_E_READONLY_IN_MKREFANY}
  VER_E_UNALIGNED_ALIGNMENT              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18D9);
  {$EXTERNALSYM VER_E_UNALIGNED_ALIGNMENT}
  VER_E_TAILCALL_INSIDE_EH               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18DA);
  {$EXTERNALSYM VER_E_TAILCALL_INSIDE_EH}
  VER_E_BACKWARD_BRANCH                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18DB);
  {$EXTERNALSYM VER_E_BACKWARD_BRANCH}
  VER_E_CALL_TO_VTYPE_BASE               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18DC);
  {$EXTERNALSYM VER_E_CALL_TO_VTYPE_BASE}
  VER_E_NEWOBJ_OF_ABSTRACT_CLASS         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18DD);
  {$EXTERNALSYM VER_E_NEWOBJ_OF_ABSTRACT_CLASS}
  VER_E_UNMANAGED_POINTER                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18DE);
  {$EXTERNALSYM VER_E_UNMANAGED_POINTER}
  VER_E_LDFTN_NON_FINAL_VIRTUAL          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18DF);
  {$EXTERNALSYM VER_E_LDFTN_NON_FINAL_VIRTUAL}
  VER_E_FIELD_OVERLAP                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18E0);
  {$EXTERNALSYM VER_E_FIELD_OVERLAP}
  VER_E_THIS_MISMATCH                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18E1);
  {$EXTERNALSYM VER_E_THIS_MISMATCH}
  VER_E_STACK_I_I4                       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18E2);
  {$EXTERNALSYM VER_E_STACK_I_I4}

  VER_E_BAD_PE            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18F0);
  {$EXTERNALSYM VER_E_BAD_PE}
  VER_E_BAD_MD            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18F1);
  {$EXTERNALSYM VER_E_BAD_MD}
  VER_E_BAD_APPDOMAIN     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18F2);
  {$EXTERNALSYM VER_E_BAD_APPDOMAIN}
  VER_E_TYPELOAD          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18F3);
  {$EXTERNALSYM VER_E_TYPELOAD}
  VER_E_PE_LOAD           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18F4);
  {$EXTERNALSYM VER_E_PE_LOAD}
  VER_E_WRITE_RVA_STATIC  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $18F5);
  {$EXTERNALSYM VER_E_WRITE_RVA_STATIC}


//
// ATTENTION: Range 0x1900 - 0x1AFF is reserved for Framework errors
//            Range 0x1B00 - 0x1BFF is reserved for MD Validator errors (see above VLDTR_E_...)
//

// System.Xml
  COR_E_Xml                        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1940);
  {$EXTERNALSYM COR_E_Xml}
  COR_E_XmlSchema                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1941);
  {$EXTERNALSYM COR_E_XmlSchema}
  COR_E_XmlXslt                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1942);
  {$EXTERNALSYM COR_E_XmlXslt}
  COR_E_XmlXPath                   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1943);
  {$EXTERNALSYM COR_E_XmlXPath}
  COR_E_XmlQuery                   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1944);
  {$EXTERNALSYM COR_E_XmlQuery}

// System.Data DataSet
  COR_E_Data                       = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1920);
  {$EXTERNALSYM COR_E_Data}
  COR_E_DataDeletedRowInaccessible = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1921);
  {$EXTERNALSYM COR_E_DataDeletedRowInaccessible}
  COR_E_DataDuplicateName          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1922);
  {$EXTERNALSYM COR_E_DataDuplicateName}
  COR_E_DataInRowChangingEvent     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1923);
  {$EXTERNALSYM COR_E_DataInRowChangingEvent}
  COR_E_DataInvalidConstraint      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1924);
  {$EXTERNALSYM COR_E_DataInvalidConstraint}
  COR_E_DataMissingPrimaryKey      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1925);
  {$EXTERNALSYM COR_E_DataMissingPrimaryKey}
  COR_E_DataNoNullAllowed          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1926);
  {$EXTERNALSYM COR_E_DataNoNullAllowed}
  COR_E_DataReadOnly               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1927);
  {$EXTERNALSYM COR_E_DataReadOnly}
  COR_E_DataRowNotInTable          = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1928);
  {$EXTERNALSYM COR_E_DataRowNotInTable}
  COR_E_DataVersionNotFound        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1929);
  {$EXTERNALSYM COR_E_DataVersionNotFound}
  COR_E_DataConstraint             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $192A);
  {$EXTERNALSYM COR_E_DataConstraint}
  COR_E_StrongTyping               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $192B);
  {$EXTERNALSYM COR_E_StrongTyping}

// System.Data Managed Providers
  COR_E_SqlType                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1930);
  {$EXTERNALSYM COR_E_SqlType}
  COR_E_SqlNullValue               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1931);
  {$EXTERNALSYM COR_E_SqlNullValue}
  COR_E_SqlTruncate                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1932);
  {$EXTERNALSYM COR_E_SqlTruncate}
  COR_E_AdapterMapping             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1933);
  {$EXTERNALSYM COR_E_AdapterMapping}
  COR_E_DataAdapter                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1934);
  {$EXTERNALSYM COR_E_DataAdapter}
  COR_E_DBConcurrency              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1935);
  {$EXTERNALSYM COR_E_DBConcurrency}
  COR_E_OperationAborted           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1936);
  {$EXTERNALSYM COR_E_OperationAborted}
  COR_E_InvalidUdt                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1937);
  {$EXTERNALSYM COR_E_InvalidUdt}

  COR_E_SqlException               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1904);  // System.Data.SqlClient.SqlClientException
  {$EXTERNALSYM COR_E_SqlException}
  COR_E_OdbcException              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1937);  // System.Data.Odbc.OdbcException
  {$EXTERNALSYM COR_E_OdbcException}
  COR_E_OracleException            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1938);  // System.Data.OracleClient.OracleException
  {$EXTERNALSYM COR_E_OracleException}


//**** More debugger error 1C00 - 1CFF
//
  CORDBG_E_THREAD_NOT_SCHEDULED                   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C00); // Thread is not scheduled. Thus we may not have OSThreadId, handle, or context
  {$EXTERNALSYM CORDBG_E_THREAD_NOT_SCHEDULED}
  CORDBG_E_HANDLE_HAS_BEEN_DISPOSED               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C01); // Handle has been disposed.
  {$EXTERNALSYM CORDBG_E_HANDLE_HAS_BEEN_DISPOSED}
  CORDBG_E_NONINTERCEPTABLE_EXCEPTION             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C02); // Cant intercept this exception.
  {$EXTERNALSYM CORDBG_E_NONINTERCEPTABLE_EXCEPTION}
  CORDBG_E_CANT_UNWIND_ABOVE_CALLBACK             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C03); // When intercepting an exception, cannot intercept above the current frame.
  {$EXTERNALSYM CORDBG_E_CANT_UNWIND_ABOVE_CALLBACK}
  CORDBG_E_INTERCEPT_FRAME_ALREADY_SET            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C04); // The intercept frame for this exception has already been set.
  {$EXTERNALSYM CORDBG_E_INTERCEPT_FRAME_ALREADY_SET}
  CORDBG_E_NO_NATIVE_PATCH_AT_ADDR                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C05); // there's no native patch at the given address.
  {$EXTERNALSYM CORDBG_E_NO_NATIVE_PATCH_AT_ADDR}
  CORDBG_E_MUST_BE_INTEROP_DEBUGGING              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C06); // This API is only allowed when interop debugging.
  {$EXTERNALSYM CORDBG_E_MUST_BE_INTEROP_DEBUGGING}
  CORDBG_E_NATIVE_PATCH_ALREADY_AT_ADDR           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C07); // There's already a native patch at the address
  {$EXTERNALSYM CORDBG_E_NATIVE_PATCH_ALREADY_AT_ADDR}
  CORDBG_E_TIMEOUT                                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C08); // a wait timed out .. likely an indication of deadlock.
  {$EXTERNALSYM CORDBG_E_TIMEOUT}
  CORDBG_E_CANT_CALL_ON_THIS_THREAD               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C09); // Can't use the API on this thread.
  {$EXTERNALSYM CORDBG_E_CANT_CALL_ON_THIS_THREAD}
  CORDBG_E_ENC_INFOLESS_METHOD                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C0A); // Method was not JITed in EnC mode
  {$EXTERNALSYM CORDBG_E_ENC_INFOLESS_METHOD}
  CORDBG_E_ENC_NESTED_HANLDERS                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C0B); // Frame cant be updated due to change in max nesting of handlers
  {$EXTERNALSYM CORDBG_E_ENC_NESTED_HANLDERS}
  CORDBG_E_ENC_IN_FUNCLET                         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C0C); // Method is in a callable handler/filter. Cant grow stack
  {$EXTERNALSYM CORDBG_E_ENC_IN_FUNCLET}
  CORDBG_E_ENC_LOCALLOC                           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C0D); // Frame cant be updated due to localloc
  {$EXTERNALSYM CORDBG_E_ENC_LOCALLOC}
  CORDBG_E_ENC_EDIT_NOT_SUPPORTED                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C0E); // Attempt to perform unsupported edit
  {$EXTERNALSYM CORDBG_E_ENC_EDIT_NOT_SUPPORTED}
  CORDBG_E_FEABORT_DELAYED_UNTIL_THREAD_RESUMED   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C0F); // Attempt to func eval abort on a suspended thread.
  {$EXTERNALSYM CORDBG_E_FEABORT_DELAYED_UNTIL_THREAD_RESUMED}
  CORDBG_E_NOTREADY                               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C10); // The LS is not in a good spot to perform the requested operation.
  {$EXTERNALSYM CORDBG_E_NOTREADY}
  CORDBG_E_CANNOT_RESOLVE_ASSEMBLY                = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c11); // We failed to resolve assembly given an AssemblyRef token. Assembly may be not loaded yet or not a valid token.
  {$EXTERNALSYM CORDBG_E_CANNOT_RESOLVE_ASSEMBLY}
  CORDBG_E_MUST_BE_IN_LOAD_MODULE                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C12); // Must be in context of LoadModule callback to perform requested operation
  {$EXTERNALSYM CORDBG_E_MUST_BE_IN_LOAD_MODULE}
  CORDBG_E_CANNOT_BE_ON_ATTACH                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C13); // Requested operation cannot be performed during an attach operation
  {$EXTERNALSYM CORDBG_E_CANNOT_BE_ON_ATTACH}
  CORDBG_S_NOT_ALL_BITS_SET                       = HRESULT((LongWord(SEVERITY_SUCCESS) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C13); // Not all bits specified were successfully applied
  {$EXTERNALSYM CORDBG_S_NOT_ALL_BITS_SET}
  CORDBG_E_NGEN_NOT_SUPPORTED                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C14); // NGEN must be supported to perform the requested operation
  {$EXTERNALSYM CORDBG_E_NGEN_NOT_SUPPORTED}
  CORDBG_E_ILLEGAL_SHUTDOWN_ORDER                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C15); // Trying to shutdown out of order.
  {$EXTERNALSYM CORDBG_E_ILLEGAL_SHUTDOWN_ORDER}
  CORDBG_E_CANNOT_DEBUG_FIBER_PROCESS             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C16); // For Whidbey, we don't support debugging fiber mode managed process
  {$EXTERNALSYM CORDBG_E_CANNOT_DEBUG_FIBER_PROCESS}
  CORDBG_E_MUST_BE_IN_CREATE_PROCESS              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C17); // Must be in context of CreateProcess callback to perform requested operation
  {$EXTERNALSYM CORDBG_E_MUST_BE_IN_CREATE_PROCESS}
  CORDBG_E_DETACH_FAILED_OUTSTANDING_EVALS        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C18); // All outstanding func-evals have not completed, detaching is not allowed at this time.
  {$EXTERNALSYM CORDBG_E_DETACH_FAILED_OUTSTANDING_EVALS}
  CORDBG_E_DETACH_FAILED_OUTSTANDING_STEPPERS     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C19); // All outstanding steppers have not been closed, detaching is not allowed at this time.
  {$EXTERNALSYM CORDBG_E_DETACH_FAILED_OUTSTANDING_STEPPERS}
  CORDBG_E_CANT_INTEROP_STEP_OUT                  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C20); // Can't have an ICorDebugStepper do a native step-out.
  {$EXTERNALSYM CORDBG_E_CANT_INTEROP_STEP_OUT}
  CORDBG_E_DETACH_FAILED_OUTSTANDING_BREAKPOINTS  = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1C21); // All outstanding breakpoints have not been closed, detaching is not allowed at this time.
  {$EXTERNALSYM CORDBG_E_DETACH_FAILED_OUTSTANDING_BREAKPOINTS}
  CORDBG_E_ILLEGAL_IN_STACK_OVERFLOW              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c22); // the operation is illegal because of a stackoverflow.
  {$EXTERNALSYM CORDBG_E_ILLEGAL_IN_STACK_OVERFLOW}
  CORDBG_E_ILLEGAL_AT_GC_UNSAFE_POINT             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c23); // The operation failed because it's a GC unsafe point.
  {$EXTERNALSYM CORDBG_E_ILLEGAL_AT_GC_UNSAFE_POINT}
  CORDBG_E_ILLEGAL_IN_PROLOG                      = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c24); // The operation failed because the thread is in the prolog
  {$EXTERNALSYM CORDBG_E_ILLEGAL_IN_PROLOG}
  CORDBG_E_ILLEGAL_IN_NATIVE_CODE                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c25); // The operation failed because the thread is in native code
  {$EXTERNALSYM CORDBG_E_ILLEGAL_IN_NATIVE_CODE}
  CORDBG_E_ILLEGAL_IN_OPTIMIZED_CODE              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c26); // The operation failed because the thread is in optimized code.
  {$EXTERNALSYM CORDBG_E_ILLEGAL_IN_OPTIMIZED_CODE}
  CORDBG_E_MINIDUMP_UNSUPPORTED                   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c27); //
  {$EXTERNALSYM CORDBG_E_MINIDUMP_UNSUPPORTED}
  CORDBG_E_APPDOMAIN_MISMATCH                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c28); // A supplied object or type belongs to the wrong AppDomain
  {$EXTERNALSYM CORDBG_E_APPDOMAIN_MISMATCH}
  CORDBG_E_CONTEXT_UNVAILABLE                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c29); // The thread's context is not available.
  {$EXTERNALSYM CORDBG_E_CONTEXT_UNVAILABLE}
  CORDBG_E_UNCOMPATIBLE_PLATFORMS                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c30); // The operation failed because debuggee and debugger are on incompatible platform
  {$EXTERNALSYM CORDBG_E_UNCOMPATIBLE_PLATFORMS}
  CORDBG_E_DEBUGGING_DISABLED                     = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c31); // The operation failed because the debugging has been disabled
  {$EXTERNALSYM CORDBG_E_DEBUGGING_DISABLED}
  CORDBG_E_DETACH_FAILED_ON_ENC                   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c32); // Detach is illegal after a module has been EnCed.
  {$EXTERNALSYM CORDBG_E_DETACH_FAILED_ON_ENC}
  CORDBG_E_CURRENT_EXCEPTION_IS_OUTSIDE_CURRENT_EXECUTION_SCOPE = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c33); // Interception of the current exception is not legal
  {$EXTERNALSYM CORDBG_E_CURRENT_EXCEPTION_IS_OUTSIDE_CURRENT_EXECUTION_SCOPE}
  CORDBG_E_HELPER_MAY_DEADLOCK                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1c34); // Helper thread can not safely run code. The opereration may work at a later time.
  {$EXTERNALSYM CORDBG_E_HELPER_MAY_DEADLOCK}



//**** PE Format validation errors 1D00 - 1DFF
//
  PEFMT_E_NO_CONTENTS                             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D00); // File is empty
  {$EXTERNALSYM PEFMT_E_NO_CONTENTS}
  PEFMT_E_NO_NTHEADERS                            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D01); // File has no NT headers
  {$EXTERNALSYM PEFMT_E_NO_NTHEADERS}
  PEFMT_E_64BIT                                   = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D02); // File is PE32+
  {$EXTERNALSYM PEFMT_E_64BIT}
  PEFMT_E_NO_CORHEADER                            = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D03); // File has no COR header
  {$EXTERNALSYM PEFMT_E_NO_CORHEADER}
  PEFMT_E_NOT_ILONLY                              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D04); // Flag IL_ONLY not set
  {$EXTERNALSYM PEFMT_E_NOT_ILONLY}
  PEFMT_E_IMPORT_DLLS                             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D05); // Bad import DLLs
  {$EXTERNALSYM PEFMT_E_IMPORT_DLLS}
  PEFMT_E_EXE_NOENTRYPOINT                        = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D06); // EXE file has no mgd entry point
  {$EXTERNALSYM PEFMT_E_EXE_NOENTRYPOINT}
  PEFMT_E_BASE_RELOCS                             = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D07); // Bad base relocations
  {$EXTERNALSYM PEFMT_E_BASE_RELOCS}
  PEFMT_E_ENTRYPOINT                              = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D08); // Bad managed entry point
  {$EXTERNALSYM PEFMT_E_ENTRYPOINT}
  PEFMT_E_ZERO_SIZEOFCODE                         = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D09); // OptHeader.SizeOfCode==0
  {$EXTERNALSYM PEFMT_E_ZERO_SIZEOFCODE}
  PEFMT_E_BAD_CORHEADER                           = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1D0A); // File has invalid COR header
  {$EXTERNALSYM PEFMT_E_BAD_CORHEADER}

//**** CLR Optimization service 1E00 - 1EFF
//
  CLR_OPTSVC_E_CONTROLLER_INTERRUPT               = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1E00); // Service controller interrupted work
  {$EXTERNALSYM CLR_OPTSVC_E_CONTROLLER_INTERRUPT}


//**** CLR Optimization service 1F00 - 1FFF
//
  NGEN_FAILED_GET_DEPENDENCIES                    = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1F00);  // Service manager failed to get ICorSvcDependencies interface
  {$EXTERNALSYM NGEN_FAILED_GET_DEPENDENCIES}
  NGEN_FAILED_NATIVE_IMAGE_DELETE                 = HRESULT((LongWord(SEVERITY_ERROR) shl 31) or LongWord(FACILITY_URT) shl 16 or $1F01);  // Failed to delete native image
  {$EXTERNALSYM NGEN_FAILED_NATIVE_IMAGE_DELETE}

implementation

end.
