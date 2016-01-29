{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: cor.h                                  }
{          Copyright (c) Microsoft Corporation.         }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

(*****************************************************************************
 **                                                                         **
 ** Cor.h - general header for the Runtime.                                 **
 **                                                                         **
 *****************************************************************************)


//#ifndef _COR_H_
//#pragma option push -b -a8 -pc -A- /*P_O_Push*/
//#define _COR_H_
unit Winapi.Cor;

{$WEAKPACKAGEUNIT}
{$WARN UNSUPPORTED_CONSTRUCT OFF}

(*$HPPEMIT '#include <cor.h>'*)

interface

//*****************************************************************************
// Required includes
//#include <ole2.h>                       // Definitions of OLE types.
//#include <specstrings.h>
//#include "corerror.h"

uses Winapi.Windows, Winapi.ActiveX, Winapi.CorError, Winapi.CorHdr;

//*****************************************************************************

const
// {BED7F4EA-1A96-11d2-8F08-00A0C9A6186D}
  LIBID_ComPlusRuntime: TGuid = '{BED7F4EA-1A96-11d2-8F08-00A0C9A6186D}';
  {$EXTERNALSYM LIBID_ComPlusRuntime}

// {90883F05-3D28-11D2-8F17-00A0C9A6186D}
  GUID_ExportedFromComPlus: TGuid = '{90883F05-3D28-11D2-8F17-00A0C9A6186D}';
  {$EXTERNALSYM GUID_ExportedFromComPlus}

// {0F21F359-AB84-41e8-9A78-36D110E6D2F9}
  GUID_ManagedName: TGuid = '{0F21F359-AB84-41e8-9A78-36D110E6D2F9}';
  {$EXTERNALSYM GUID_ManagedName}

// {54FC8F55-38DE-4703-9C4E-250351302B1C}
  GUID_Function2Getter: TGuid = '{54FC8F55-38DE-4703-9C4E-250351302B1C}';
  {$EXTERNALSYM GUID_Function2Getter}

// CLSID_CorMetaDataDispenserRuntime: {1EC2DE53-75CC-11d2-9775-00A0C9B4D50C}
//  Dispenser coclass for version 1.5 and 2.0 meta data.  To get the "latest" bind
//  to CLSID_MetaDataDispenser.
  CLSID_CorMetaDataDispenserRuntime: TGuid = '{1EC2DE53-75CC-11d2-9775-00A0C9B4D50C}';
  {$EXTERNALSYM CLSID_CorMetaDataDispenserRuntime}

// {CD2BC5C9-F452-4326-B714-F9C539D4DA58}
  GUID_DispIdOverride: TGuid = '{CD2BC5C9-F452-4326-B714-F9C539D4DA58}';
  {$EXTERNALSYM GUID_DispIdOverride}

// {B64784EB-D8D4-4d9b-9ACD-0E30806426F7}
  GUID_ForceIEnumerable: TGuid = '{B64784EB-D8D4-4d9b-9ACD-0E30806426F7}';
  {$EXTERNALSYM GUID_ForceIEnumerable}

// {2941FF83-88D8-4F73-B6A9-BDF8712D000D}
  GUID_PropGetCA: TGuid = '{2941FF83-88D8-4F73-B6A9-BDF8712D000D}';
  {$EXTERNALSYM GUID_PropGetCA}

// {29533527-3683-4364-ABC0-DB1ADD822FA2}
  GUID_PropPutCA: TGuid = '{29533527-3683-4364-ABC0-DB1ADD822FA2}';
  {$EXTERNALSYM GUID_PropPutCA}

// CLSID_CLR_v1_MetaData: {005023CA-72B1-11D3-9FC4-00C04F79A0A3}
//  Used to generate v1 metadata (for v1.0 and v1.1 CLR compatibility).
  CLSID_CLR_v1_MetaData: TGuid = '{005023CA-72B1-11D3-9FC4-00C04F79A0A3}';
  {$EXTERNALSYM CLSID_CLR_v1_MetaData}

// CLSID_CLR_v2_MetaData: {EFEA471A-44FD-4862-9292-0C58D46E1F3A}
//  Used to generate v1 metadata (for v1.0 and v1.1 CLR compatibility).
  CLSID_CLR_v2_MetaData: TGuid = '{EFEA471A-44FD-4862-9292-0C58D46E1F3A}';
  {$EXTERNALSYM CLSID_CLR_v2_MetaData}

// CLSID_CorMetaDataRuntime:
// This will can always be used to generate the "latest" metadata available.
  CLSID_CorMetaDataRuntime: TGuid = '{EFEA471A-44FD-4862-9292-0C58D46E1F3A}';  //CLSID_CLR_v2_MetaData;
  {$EXTERNALSYM CLSID_CorMetaDataRuntime}

// {30FE7BE8-D7D9-11D2-9F80-00C04F79A0A3}
  MetaDataCheckDuplicatesFor: TGuid = '{30FE7BE8-D7D9-11D2-9F80-00C04F79A0A3}';
  {$EXTERNALSYM MetaDataCheckDuplicatesFor}

// {DE3856F8-D7D9-11D2-9F80-00C04F79A0A3}
  MetaDataRefToDefCheck: TGuid = '{DE3856F8-D7D9-11D2-9F80-00C04F79A0A3}';
  {$EXTERNALSYM MetaDataRefToDefCheck}

// {E5D71A4C-D7DA-11D2-9F80-00C04F79A0A3}
  MetaDataNotificationForTokenMovement: TGuid = '{E5D71A4C-D7DA-11D2-9F80-00C04F79A0A3}';
  {$EXTERNALSYM MetaDataNotificationForTokenMovement}

// {2eee315c-d7db-11d2-9f80-00c04f79a0a3}
  MetaDataSetUpdate: TGuid = '{2eee315c-d7db-11d2-9f80-00c04f79a0a3}';
  {$EXTERNALSYM MetaDataSetUpdate}
  MetaDataSetENC: TGuid = '{2eee315c-d7db-11d2-9f80-00c04f79a0a3}'; //MetaDataSetUpdate;
  {$EXTERNALSYM MetaDataSetENC }

// Use this guid in SetOption to indicate if the import enumerator should skip over
// delete items or not. The default is yes.
//
// {79700F36-4AAC-11d3-84C3-009027868CB1}
  MetaDataImportOption: TGuid = '{79700F36-4AAC-11d3-84C3-009027868CB1}';
  {$EXTERNALSYM MetaDataImportOption}

// Use this guid in the SetOption if compiler wants to have MetaData API to take reader/writer lock
//
// {F7559806-F266-42ea-8C63-0ADB45E8B234}
  MetaDataThreadSafetyOptions: TGuid = '{F7559806-F266-42ea-8C63-0ADB45E8B234}';
  {$EXTERNALSYM MetaDataThreadSafetyOptions}

// Use this guid in the SetOption if compiler wants error when some tokens are emitted out of order
// {1547872D-DC03-11d2-9420-0000F8083460}
  MetaDataErrorIfEmitOutOfOrder: TGuid = '{1547872D-DC03-11d2-9420-0000F8083460}';
  {$EXTERNALSYM MetaDataErrorIfEmitOutOfOrder}

// Use this guid in the SetOption to indicate if the tlbimporter should generate the
// TCE adapters for COM connection point containers.
// {DCC9DE90-4151-11d3-88D6-00902754C43A}
  MetaDataGenerateTCEAdapters: TGuid = '{DCC9DE90-4151-11d3-88D6-00902754C43A}';
  {$EXTERNALSYM MetaDataGenerateTCEAdapters}

// Use this guid in the SetOption to specifiy a non-default namespace for typelib import.
// {F17FF889-5A63-11d3-9FF2-00C04FF7431A}
  MetaDataTypeLibImportNamespace: TGuid = '{F17FF889-5A63-11d3-9FF2-00C04FF7431A}';
  {$EXTERNALSYM MetaDataTypeLibImportNamespace}

// Use this guid in the SetOption to specify the behavior of UnmarkAll. See CorLinkerOptions.
// {47E099B6-AE7C-4797-8317-B48AA645B8F9}
  MetaDataLinkerOptions: TGuid = '{47E099B6-AE7C-4797-8317-B48AA645B8F9}';
  {$EXTERNALSYM MetaDataLinkerOptions}

// Use this guid in the SetOption to specify the runtime version stored in the CLR metadata.
// {47E099B7-AE7C-4797-8317-B48AA645B8F9}
  MetaDataRuntimeVersion: TGuid = '{47E099B7-AE7C-4797-8317-B48AA645B8F9}';
  {$EXTERNALSYM MetaDataRuntimeVersion}

// Use this guid in the SetOption to specify the behavior of the merger.
// {132D3A6E-B35D-464e-951A-42EFB9FB6601}
  MetaDataMergerOptions: TGuid = '{132D3A6E-B35D-464e-951A-42EFB9FB6601}';
  {$EXTERNALSYM MetaDataMergerOptions}

// Constant for connection id and task id
  INVALID_CONNECTION_ID   = $0;
  {$EXTERNALSYM INVALID_CONNECTION_ID}
  INVALID_TASK_ID         = $0;
  {$EXTERNALSYM INVALID_TASK_ID}
  MAX_CONNECTION_NAME     = MAX_PATH;
  {$EXTERNALSYM MAX_CONNECTION_NAME}

  MSCOREE_SHIM_W                = 'mscoree.dll';
  {$EXTERNALSYM MSCOREE_SHIM_W}
  MSCOREE_SHIM_A                = MSCOREE_SHIM_W;
  {$EXTERNALSYM MSCOREE_SHIM_A}

  SWITCHOUT_HANDLE_VALUE        = THandle(-2);
  {$EXTERNALSYM SWITCHOUT_HANDLE_VALUE}

//
//*****************************************************************************
//*****************************************************************************

// CLSID_Cor: {bee00000-ee77-11d0-a015-00c04fbbb884}
  CLSID_Cor: TGuid = '{bee00000-ee77-11d0-a015-00c04fbbb884}';
  {$EXTERNALSYM CLSID_Cor}

// CLSID_CorMetaDataDispenser: {E5CB7A31-7512-11d2-89CE-0080C792E5D8}
//  This is the "Master Dispenser", always guaranteed to be the most recent
//  dispenser on the machine.
  CLSID_CorMetaDataDispenser: TGuid = '{E5CB7A31-7512-11d2-89CE-0080C792E5D8}';
  {$EXTERNALSYM CLSID_CorMetaDataDispenser}

// CLSID_CorMetaDataDispenserReg: {435755FF-7397-11d2-9771-00A0C9B4D50C}
//  Dispenser coclass for version 1.0 meta data.  To get the "latest" bind
//  to CLSID_CorMetaDataDispenser.
  CLSID_CorMetaDataDispenserReg: TGuid = '{435755FF-7397-11d2-9771-00A0C9B4D50C}';
  {$EXTERNALSYM CLSID_CorMetaDataDispenserReg}

// CLSID_CorMetaDataReg: {87F3A1F5-7397-11d2-9771-00A0C9B4D50C}
// For COM+ Meta Data, Data Driven Registration
  CLSID_CorMetaDataReg: TGuid = '{87F3A1F5-7397-11d2-9771-00A0C9B4D50C}';
  {$EXTERNALSYM CLSID_CorMetaDataReg}

// IID_IMetaDataInternal {39EE28B3-0181-4d48-B53C-2FFAFFD5FEC1}
  IID_IMetaDataInternal: TGuid = '{39EE28B3-0181-4d48-B53C-2FFAFFD5FEC1}';
  {$EXTERNALSYM IID_IMetaDataInternal}

//-------------------------------------
//--- IMetaDataError
//-------------------------------------
// {B81FF171-20F3-11d2-8DCC-00A0C9B09C19}
  IID_IMetaDataError: TGuid = '{B81FF171-20F3-11d2-8DCC-00A0C9B09C19}';
  {$EXTERNALSYM IID_IMetaDataError}

//-------------------------------------
//--- IMapToken
//-------------------------------------
// IID_IMapToken: {06A3EA8B-0225-11d1-BF72-00C04FC31E12}
  IID_IMapToken: TGuid = '{06A3EA8B-0225-11d1-BF72-00C04FC31E12}';
  {$EXTERNALSYM IID_IMapToken}

//-------------------------------------
//--- IMetaDataDispenser
//-------------------------------------
// {B81FF171-20F3-11d2-8DCC-00A0C9B09C19} // Header file comment Wrong!!!!
// {809c652e-7396-11d2-9771-00a0c9b4d50c} // Correct GUID
  IID_IMetaDataDispenser: TGuid = '{809c652e-7396-11d2-9771-00a0c9b4d50c}';
  {$EXTERNALSYM IID_IMetaDataDispenser}

//-------------------------------------
//--- IMetaDataEmit
//-------------------------------------
// {BA3FEE4C-ECB9-4e41-83B7-183FA41CD859}
  IID_IMetaDataEmit: TGuid = '{BA3FEE4C-ECB9-4e41-83B7-183FA41CD859}';
  {$EXTERNALSYM IID_IMetaDataEmit}

//-------------------------------------
//--- IMetaDataEmit2
//-------------------------------------
// {F5DD9950-F693-42e6-830E-7B833E8146A9}
  IID_IMetaDataEmit2: TGuid = '{F5DD9950-F693-42e6-830E-7B833E8146A9}';
  {$EXTERNALSYM IID_IMetaDataEmit2}

//-------------------------------------
//--- IMetaDataImport
//-------------------------------------
// {7DAC8207-D3AE-4c75-9B67-92801A497D44}
  IID_IMetaDataImport: TGuid = '{7DAC8207-D3AE-4c75-9B67-92801A497D44}';
  {$EXTERNALSYM IID_IMetaDataImport}

//-------------------------------------
//--- IMetaDataImport2
//-------------------------------------
// {FCE5EFA0-8BBA-4f8e-A036-8F2022B08466}
  IID_IMetaDataImport2: TGuid = '{FCE5EFA0-8BBA-4f8e-A036-8F2022B08466}';
  {$EXTERNALSYM IID_IMetaDataImport2}

//-------------------------------------
//--- IMetaDataFilter
//-------------------------------------
// {D0E80DD1-12D4-11d3-B39D-00C04FF81795}
  IID_IMetaDataFilter: TGuid = '{D0E80DD1-12D4-11d3-B39D-00C04FF81795}';
  {$EXTERNALSYM IID_IMetaDataFilter}

//-------------------------------------
//--- IHostFilter
//-------------------------------------
// {D0E80DD3-12D4-11d3-B39D-00C04FF81795}
  IID_IHostFilter: TGuid = '{D0E80DD3-12D4-11d3-B39D-00C04FF81795}';
  {$EXTERNALSYM IID_IHostFilter}

//--------------------------------------
//--- IMetaDataConverter
//--------------------------------------
// {D9DEBD79-2992-11d3-8BC1-0000F8083A57}
  IID_IMetaDataConverter: TGuid = '{D9DEBD79-2992-11d3-8BC1-0000F8083A57}';
  {$EXTERNALSYM IID_IMetaDataConverter}

// {211EF15B-5317-4438-B196-DEC87B887693}
  IID_IMetaDataAssemblyEmit: TGuid = '{211EF15B-5317-4438-B196-DEC87B887693}';
  {$EXTERNALSYM IID_IMetaDataAssemblyEmit}

// {EE62470B-E94B-424e-9B7C-2F00C9249F93}
  IID_IMetaDataAssemblyImport: TGuid = '{EE62470B-E94B-424e-9B7C-2F00C9249F93}';
  {$EXTERNALSYM IID_IMetaDataAssemblyImport}

// {4709C9C6-81FF-11D3-9FC7-00C04F79A0A3}
  IID_IMetaDataValidate: TGuid = '{4709C9C6-81FF-11D3-9FC7-00C04F79A0A3}';
  {$EXTERNALSYM IID_IMetaDataValidate}

// {31BCFCE2-DAFB-11D2-9F81-00C04F79A0A3}
  IID_IMetaDataDispenserEx: TGuid = '{31BCFCE2-DAFB-11D2-9F81-00C04F79A0A3}';
  {$EXTERNALSYM IID_IMetaDataDispenserEx}

//-------------------------------------
//--- ICeeGen
//-------------------------------------
// {7ED1BDFF-8E36-11d2-9C56-00A0C9B7CC45}
  IID_ICeeGen: TGuid = '{7ED1BDFF-8E36-11d2-9C56-00A0C9B7CC45}';
  {$EXTERNALSYM IID_ICeeGen}

//-------------------------------------
//--- ICorModule
//-------------------------------------
// {2629F8E1-95E5-11d2-9C56-00A0C9B7CC45}
  IID_ICorModule: TGuid = '{2629F8E1-95E5-11d2-9C56-00A0C9B7CC45}';
  {$EXTERNALSYM IID_ICorModule}

// {D8F579AB-402D-4b8e-82D9-5D63B1065C68}
  IID_IMetaDataTables: TGuid = '{D8F579AB-402D-4b8e-82D9-5D63B1065C68}';
  {$EXTERNALSYM IID_IMetaDataTables}

// {BADB5F70-58DA-43a9-A1C6-D74819F19B15}
  IID_IMetaDataTables2: TGuid = '{BADB5F70-58DA-43a9-A1C6-D74819F19B15}';
  {$EXTERNALSYM IID_IMetaDataTables2}

// {814C9E35-3F3F-4975-977A-371F0A878AC7}
  IID_INativeImageDependency: TGuid = '{814C9E35-3F3F-4975-977A-371F0A878AC7}';
  {$EXTERNALSYM IID_INativeImageDependency}

// {065AA013-9BDC-447c-922F-FEE929908447}
  IID_INativeImageEvaluate: TGuid = '{065AA013-9BDC-447c-922F-FEE929908447}';
  {$EXTERNALSYM IID_INativeImageEvaluate}

// {0EA273D0-B4DA-4008-A60D-8D6EFFDD6E91}
  IID_INativeImageInstallInfo: TGuid = '{0EA273D0-B4DA-4008-A60D-8D6EFFDD6E91}';
  {$EXTERNALSYM IID_INativeImageInstallInfo}

  IMAGE_REL_BASED_REL32           = 7;
  {$EXTERNALSYM IMAGE_REL_BASED_REL32}
  IMAGE_REL_BASED_IA64_PCREL21    = 11;
  {$EXTERNALSYM IMAGE_REL_BASED_IA64_PCREL21}
  IMAGE_REL_BASED_IA64_PCREL60    = 12;
  {$EXTERNALSYM IMAGE_REL_BASED_IA64_PCREL60}

  iRidMax                         = ULONG(63);
  {$EXTERNALSYM iRidMax}
  iCodedToken                     = ULONG(64);   // base of coded tokens.
  {$EXTERNALSYM iCodedToken}
  iCodedTokenMax                  = ULONG(95);
  {$EXTERNALSYM iCodedTokenMax}
  iSHORT                          = ULONG(96);   // fixed types.
  {$EXTERNALSYM iSHORT}
  iUSHORT                         = ULONG(97);
  {$EXTERNALSYM iUSHORT}
  iLONG                           = ULONG(98);
  {$EXTERNALSYM iLONG}
  iULONG                          = ULONG(99);
  {$EXTERNALSYM iULONG}
  iBYTE                           = ULONG(100);
  {$EXTERNALSYM iBYTE}
  iSTRING                         = ULONG(101);  // pool types.
  {$EXTERNALSYM iSTRING}
  iGUID                           = ULONG(102);
  {$EXTERNALSYM iGUID}
  iBLOB                           = ULONG(103);
  {$EXTERNALSYM iBLOB}

  //
  // Native Link method custom value definitions. This is for N-direct support.
  //

  COR_NATIVE_LINK_CUSTOM_VALUE        = 'COMPLUS_NativeLink';
  {$EXTERNALSYM COR_NATIVE_LINK_CUSTOM_VALUE}
  COR_NATIVE_LINK_CUSTOM_VALUE_ANSI   = COR_NATIVE_LINK_CUSTOM_VALUE;
  {$EXTERNALSYM COR_NATIVE_LINK_CUSTOM_VALUE_ANSI}

  // count of chars for COR_NATIVE_LINK_CUSTOM_VALUE(_ANSI)
  COR_NATIVE_LINK_CUSTOM_VALUE_CC     = 18;
  {$EXTERNALSYM COR_NATIVE_LINK_CUSTOM_VALUE_CC}

  COR_DUAL_CUSTOM_VALUE      = 'IsDual';
  {$EXTERNALSYM COR_DUAL_CUSTOM_VALUE}
  COR_DUAL_CUSTOM_VALUE_ANSI = COR_DUAL_CUSTOM_VALUE;
  {$EXTERNALSYM COR_DUAL_CUSTOM_VALUE_ANSI}

  COR_DISPATCH_CUSTOM_VALUE      = 'DISPID';
  {$EXTERNALSYM COR_DISPATCH_CUSTOM_VALUE}
  COR_DISPATCH_CUSTOM_VALUE_ANSI = COR_DISPATCH_CUSTOM_VALUE;
  {$EXTERNALSYM COR_DISPATCH_CUSTOM_VALUE_ANSI}

  //
  // Security custom value definitions (these are all deprecated).
  //

  COR_PERM_REQUEST_REQD_CUSTOM_VALUE      = 'SecPermReq_Reqd';
  {$EXTERNALSYM COR_PERM_REQUEST_REQD_CUSTOM_VALUE}
  COR_PERM_REQUEST_REQD_CUSTOM_VALUE_ANSI = COR_PERM_REQUEST_REQD_CUSTOM_VALUE;
  {$EXTERNALSYM COR_PERM_REQUEST_REQD_CUSTOM_VALUE_ANSI}

  COR_PERM_REQUEST_OPT_CUSTOM_VALUE      = 'SecPermReq_Opt';
  {$EXTERNALSYM COR_PERM_REQUEST_OPT_CUSTOM_VALUE}
  COR_PERM_REQUEST_OPT_CUSTOM_VALUE_ANSI = COR_PERM_REQUEST_OPT_CUSTOM_VALUE;
  {$EXTERNALSYM COR_PERM_REQUEST_OPT_CUSTOM_VALUE_ANSI}

  COR_PERM_REQUEST_REFUSE_CUSTOM_VALUE      = 'SecPermReq_Refuse';
  {$EXTERNALSYM COR_PERM_REQUEST_REFUSE_CUSTOM_VALUE}
  COR_PERM_REQUEST_REFUSE_CUSTOM_VALUE_ANSI = COR_PERM_REQUEST_REFUSE_CUSTOM_VALUE;
  {$EXTERNALSYM COR_PERM_REQUEST_REFUSE_CUSTOM_VALUE_ANSI}

  //
  // Base class for security custom attributes.
  //

  COR_BASE_SECURITY_ATTRIBUTE_CLASS      = 'System.Security.Permissions.SecurityAttribute';
  {$EXTERNALSYM COR_BASE_SECURITY_ATTRIBUTE_CLASS}
  COR_BASE_SECURITY_ATTRIBUTE_CLASS_ANSI = COR_BASE_SECURITY_ATTRIBUTE_CLASS;
  {$EXTERNALSYM COR_BASE_SECURITY_ATTRIBUTE_CLASS_ANSI}

  //
  // Name of custom attribute used to indicate that per-call security checks should
  // be disabled for P/Invoke calls.
  //

  COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE      = 'System.Security.SuppressUnmanagedCodeSecurityAttribute';
  {$EXTERNALSYM COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE}
  COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE_ANSI = COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE;
  {$EXTERNALSYM COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE_ANSI}

  //
  // Name of custom attribute tagged on module to indicate it contains
  // unverifiable code.
  //

  COR_UNVER_CODE_ATTRIBUTE      = 'System.Security.UnverifiableCodeAttribute';
  {$EXTERNALSYM COR_UNVER_CODE_ATTRIBUTE}
  COR_UNVER_CODE_ATTRIBUTE_ANSI = COR_UNVER_CODE_ATTRIBUTE;
  {$EXTERNALSYM COR_UNVER_CODE_ATTRIBUTE_ANSI}

  //
  // Name of custom attribute indicating that a method requires a security object
  // slot on the caller's stack.
  //

  COR_REQUIRES_SECOBJ_ATTRIBUTE      = 'System.Security.DynamicSecurityMethodAttribute';
  {$EXTERNALSYM COR_REQUIRES_SECOBJ_ATTRIBUTE}
  COR_REQUIRES_SECOBJ_ATTRIBUTE_ANSI = COR_REQUIRES_SECOBJ_ATTRIBUTE;
  {$EXTERNALSYM COR_REQUIRES_SECOBJ_ATTRIBUTE_ANSI}

  COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE      = 'System.Runtime.CompilerServices.DiscardableAttribute';
  {$EXTERNALSYM COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE}
  COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE_ASNI = COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE; // Mispelled in PSDK!!
  {$EXTERNALSYM COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE_ASNI}
  COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE_ANSI = COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE; // Corrected
  {$EXTERNALSYM COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE_ANSI}

type
  IMetaDataImport = interface;
  {$EXTERNALSYM IMetaDataImport}
  IMetaDataAssemblyEmit = interface;
  {$EXTERNALSYM IMetaDataAssemblyEmit}
  IMetaDataAssemblyImport = interface;
  {$EXTERNALSYM IMetaDataAssemblyImport}
  IMetaDataEmit = interface;
  {$EXTERNALSYM IMetaDataEmit}

  UVCP_CONSTANT = Pointer;
  {$EXTERNALSYM UVCP_CONSTANT}

  //
  // CoInitializeCor flags.
  //
  tagCOINITCOR = (
    COINITCOR_DEFAULT       = $0           // Default initialization mode.
    {$EXTERNALSYM COINITCOR_DEFAULT}
  );
  {$EXTERNALSYM tagCOINITCOR}
  COINITICOR = tagCOINITCOR;
  {$EXTERNALSYM COINITICOR}
  TCoInitICor = tagCOINITCOR;

  //
  // CoInitializeEE flags.
  //
  tagCOINITEE = (
    COINITEE_DEFAULT        = $0,          // Default initialization mode.
    {$EXTERNALSYM COINITEE_DEFAULT}
    COINITEE_DLL            = $1,          // Initialization mode for loading DLL.
    {$EXTERNALSYM COINITEE_DLL}
    COINITEE_MAIN           = $2           // Initialize prior to entering the main routine
    {$EXTERNALSYM COINITEE_MAIN}
  );
  {$EXTERNALSYM tagCOINITEE}
  COINITIEE = tagCOINITEE;
  {$EXTERNALSYM COINITIEE}
  TCoInitIEE = tagCOINITEE;

  //
  // CoInitializeEE flags.
  //
  tagCOUNINITEE = (
      COUNINITEE_DEFAULT      = $0,          // Default uninitialization mode.
      {$EXTERNALSYM COUNINITEE_DEFAULT}
      COUNINITEE_DLL          = $1           // Uninitialization mode for unloading DLL.
      {$EXTERNALSYM COUNINITEE_DLL}
  );
  {$EXTERNALSYM tagCOUNINITEE}
  COUNINITIEE = tagCOUNINITEE;
  {$EXTERNALSYM COUNINITIEE}
  TCoUninitIEE = tagCOUNINITEE;
  {$EXTERNALSYM TCoUninitIEE}

  IMetaDataDispenser = interface;

  //---
  IMetaDataError = interface(IUnknown)
    [IID_IMetaDataError]
    function OnError(hrError: HRESULT; token: mdToken): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IMetaDataError}

  //---
  IMapToken = interface(IUnknown)
    [IID_IMapToken]
    function Map(tkImp: mdToken; tkEmit: mdToken): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IMapToken}

  //---
  IMetaDataDispenser = interface(IUnknown)
    [IID_IMetaDataDispenser]
    function DefineScope(
        const rclsid:    TCLSID;            // [in] What version to create.
        dwCreateFlags:   DWORD;             // [in] Flags on the create.
        const riid:      TIID;              // [in] The interface desired.
        out ppIUnk):                        // [out] Return interface on success.
                         HRESULT; stdcall;  // Return code.

    function OpenScope(
        szScope:         LPCWSTR;           // [in] The scope to open.
        dwOpenFlags:     DWORD;             // [in] Open mode flags.
        const riid:      TIID;              // [in] The interface desired.
        out ppIUnk):                        // [out] Return interface on success.
                         HRESULT; stdcall;  // Return code.

    function OpenScopeOnMemory(
        pData:           LPCVOID;           // [in] Location of scope data.
        cbData:          ULONG;             // [in] Size of the data pointed to by pData.
        dwOpenFlags:     DWORD;             // [in] Open mode flags.
        const riid:      TIID;              // [in] The interface desired.
        out ppIUnk):                        // [out] Return interface on success.
                         HRESULT; stdcall;  // Return code.
  end;
  {$EXTERNALSYM IMetaDataDispenser}

  //---
  IMetaDataEmit = interface(IUnknown)
    [IID_IMetaDataEmit]
    function SetModuleProps(
        szName:          LPCWSTR):          // [IN] If not NULL, the name of the module to set.
                         HRESULT; stdcall;  // S_OK or error.

    function Save(
        szFile:          LPCWSTR;           // [IN] The filename to save to.
        dwSaveFlags:     DWORD):            // [IN] Flags for the save.
                         HRESULT; stdcall;  // S_OK or error.

    function SaveToStream(
        const pIStream:  IStream;           // [IN] A writable stream to save to.
        dwSaveFlags:     DWORD):            // [IN] Flags for the save.
                         HRESULT; stdcall;  // S_OK or error.

    function GetSaveSize(
        fSave:           CorSaveSize;       // [IN] cssAccurate or cssQuick.
        out pdwSaveSize: DWORD):            // [OUT] Put the size here.
                         HRESULT; stdcall;  // S_OK or error.

    function DefineTypeDef(
        szTypeDef:       LPCWSTR;           // [IN] Name of TypeDef
        dwTypeDefFlags:  DWORD;             // [IN] CustomAttribute flags
        tkExtends:       mdToken;           // [IN] extends this TypeDef or typeref
        rtkImplements:   pmdToken;          // [IN] Implements interfaces
        out ptd:         mdTypeDef):        // [OUT] Put TypeDef token here
                         HRESULT; stdcall;  // S_OK or error.

    function DefineNestedType(
        szTypeDef:       LPCWSTR;           // [IN] Name of TypeDef
        dwTypeDefFlags:  DWORD;             // [IN] CustomAttribute flags
        tkExtends:       mdToken;           // [IN] extends this TypeDef or typeref
        rtkImplements:   pmdToken;          // [IN] Implements interfaces
        tdEncloser:      mdTypeDef;         // [IN] TypeDef token of the enclosing type.
        out ptd:         mdTypeDef):        // [OUT] Put TypeDef token here
                         HRESULT;           // S_OK or error.

    function SetHandler(
        const pUnk:      IUnknown):         // [IN] The new error handler.
                         HRESULT; stdcall;  // S_OK.

    function DefineMethod(
        td:              mdTypeDef;         // Parent TypeDef
        szName:          LPCWSTR;           // Name of member
        dwMethodFlags:   DWORD;             // Member attributes
        pvSigBlob:       PCCOR_SIGNATURE;   // [IN] point to a blob value of CLR signature
        cbSigBlob:       ULONG;             // [IN] count of bytes in the signature blob
        ulCodeRVA:       ULONG;
        dwImplFlags:     DWORD;
        out pmd:         mdMethodDef):      // Put member token here
                         HRESULT; stdcall;  // S_OK or error.

    function DefineMethodImpl(
        td:              mdTypeDef;         // [IN] The class implementing the method
        tkBody:          mdToken;           // [IN] Method body - MethodDef or MethodRef
        tkDecl:          mdToken):          // [IN] Method declaration - MethodDef or MethodRef
                         HRESULT; stdcall;  // S_OK or error.

    function DefineTypeRefByName(
        tkResolutionScope: mdToken;         // [IN] ModuleRef, AssemblyRef or TypeRef.
        szName:          LPCWSTR;           // [IN] Name of the TypeRef.
        out ptr:         mdTypeRef):        // [OUT] Put TypeRef token here.
                         HRESULT; stdcall;  // S_OK or error.

    function DefineImportType(
        const pAssemImport: IMetaDataAssemblyImport;  // [IN] Assembly containing the TypeDef.
        const pbHashValue: Pointer;         // [IN] Hash Blob for Assembly.
        cbHashValue:     ULONG;             // [IN] Count of bytes.
        const pImport:   IMetaDataImport;   // [IN] Scope containing the TypeDef.
        tdImport:        mdTypeDef;         // [IN] The imported TypeDef.
        const pAssemEmit: IMetaDataAssemblyEmit; // [IN] Assembly into which the TypeDef is imported.
        out ptr:         mdTypeRef):        // [OUT] Put TypeRef token here.
                         HRESULT; stdcall;  // S_OK or error.

    function DefineMemberRef(
        tkImport:        mdToken;           // [IN] ClassRef or ClassDef importing a member.
        szName:          LPCWSTR;           // [IN] member's name
        pvSigBlob:       PCCOR_SIGNATURE;   // [IN] point to a blob value of CLR signature
        cbSigBlob:       ULONG;             // [IN] count of bytes in the signature blob
        out pmr:         mdMemberRef):      // [OUT] memberref token
                         HRESULT; stdcall;  // S_OK or error

    function DefineImportMember(
        const pAssemImport: IMetaDataAssemblyImport;  // [IN] Assembly containing the Member.
        const pbHashValue: Pointer;         // [IN] Hash Blob for Assembly.
        cbHashValue:     ULONG;             // [IN] Count of bytes.
        const pImport:   IMetaDataImport;   // [IN] Scope containing the TypeDef.
        mbMember:        mdToken;           // [IN] Member in import scope.
        const pAssemEmit: IMetaDataAssemblyEmit; // [IN] Assembly into which the Member is imported.
        tkParent:        mdToken;           // [IN] Classref or classdef in emit scope.
        out pmr:         mdMemberRef):      // [OUT] Put member ref here.
                         HRESULT; stdcall;  // S_OK or error.

    function DefineEvent(
        td:              mdTypeDef;         // [IN] the class/interface on which the event is being defined
        szEvent:         LPCWSTR;           // [IN] Name of the event
        dwEventFlags:    DWORD;             // [IN] CorEventAttr
        tkEventType:     mdToken;           // [IN] a reference (mdTypeRef or mdTypeRef) to the Event class
        mdAddOn:         mdMethodDef;       // [IN] required add method
        mdRemoveOn:      mdMethodDef;       // [IN] required remove method
        mdFire:          mdMethodDef;       // [IN] optional fire method
        rmdOtherMethods: pmdMethodDef;      // [IN] optional array of other methods associate with the event
        out pmdEvent:    mdEvent):          // [OUT] output event token
                         HRESULT; stdcall;

    function SetClassLayout(
        td:              mdTypeDef;         // [IN] typedef
        dwPackSize:      DWORD;             // [IN] packing size specified as 1, 2, 4, 8, or 16
        rFieldOffsets:   PCOR_FIELD_OFFSET; // [IN] array of layout specification
        ulClassSize:     ULONG):            // [IN] size of the class
                         HRESULT; stdcall;

    function DeleteClassLayout(
        td:              mdTypeDef):        // [IN] typedef whose layout is to be deleted.
                         HRESULT; stdcall;

    function SetFieldMarshal(
        tk:              mdToken;           // [IN] given a fieldDef or paramDef token
        pvNativeType:    PCCOR_SIGNATURE;   // [IN] native type specification
        cbNativeType:    ULONG):            // [IN] count of bytes of pvNativeType
                         HRESULT; stdcall;

    function DeleteFieldMarshal(
        tk:              mdToken):          // [IN] given a fieldDef or paramDef token
                         HRESULT; stdcall;

    function DefinePermissionSet(
        tk:              mdToken;           // [IN] the object to be decorated.
        dwAction:        DWORD;             // [IN] CorDeclSecurity.
        var pvPermission;                   // [IN] permission blob.
        cbPermission:    ULONG;             // [IN] count of bytes of pvPermission.
        out ppm:         mdPermission):     // [OUT] returned permission token.
                         HRESULT; stdcall;

    function SetRVA(
        md:              mdMethodDef;       // [IN] Method for which to set offset
        ulRVA:           ULONG):            // [IN] The offset
                         HRESULT; stdcall;  // S_OK or error.

    function GetTokenFromSig(
        pvSig:           PCCOR_SIGNATURE;   // [IN] Signature to define.
        cbSig:           ULONG;             // [IN] Size of signature data.
        out pmsig:       mdSignature):      // [OUT] returned signature token.
                         HRESULT; stdcall;  // S_OK or error.

    function DefineModuleRef(
        szName:          LPCWSTR;           // [IN] DLL name
        out pmur:        mdModuleRef):      // [OUT] returned
                         HRESULT; stdcall;  // S_OK or error.

    // <TODO>@FUTURE:  This should go away once everyone starts using SetMemberRefProps - todo in sdk</TODO>
    function SetParent(                     // S_OK or error.
        mr:              mdMemberRef;       // [IN] Token for the ref to be fixed up.
        tk:              mdToken):          // [IN] The ref parent.
                         HRESULT; stdcall;

    function GetTokenFromTypeSpec(
        pvSig:           PCCOR_SIGNATURE;   // [IN] TypeSpec Signature to define.
        cbSig:           ULONG;             // [IN] Size of signature data.
        out ptypespec:   mdTypeSpec):       // [OUT] returned TypeSpec token.
                         HRESULT; stdcall;  // S_OK or error.

    function SaveToMemory(
        var pbData;                         // [OUT] Location to write data.
        cbData:          ULONG):            // [IN] Max size of data buffer.
                         HRESULT; stdcall;  // S_OK or error.

    function DefineUserString(
        szString:        LPCWSTR;           // [IN] User literal string.
        cchString:       ULONG;             // [IN] Length of string.
        out pstk:        mdString):         // [OUT] String token.
                         HRESULT; stdcall;  // Return code.

    function DeleteToken(
        tkObj:           mdToken):          // [IN] The token to be deleted
                         HRESULT; stdcall;  // Return code.

    function SetMethodProps(
        md:              mdMethodDef;       // [IN] The MethodDef.
        dwMethodFlags:   DWORD;             // [IN] Method attributes.
        ulCodeRVA:       ULONG;             // [IN] Code RVA.
        dwImplFlags:     DWORD):            // [IN] Impl flags.
                         HRESULT; stdcall;  // S_OK or error.

    function SetTypeDefProps(
        td:              mdTypeDef;         // [IN] The TypeDef.
        dwTypeDefFlags:  DWORD;             // [IN] TypeDef flags.
        tkExtends:       mdToken;           // [IN] Base TypeDef or TypeRef.
        rtkImplements:   pmdToken):         // [IN] Implemented interfaces.
                         HRESULT; stdcall;   // S_OK or error.

    function SetEventProps(
        ev:              mdEvent;           // [IN] The event token.
        dwEventFlags:    DWORD;             // [IN] CorEventAttr.
        tkEventType:     mdToken;           // [IN] A reference (mdTypeRef or mdTypeRef) to the Event class.
        mdAddOn:         mdMethodDef;       // [IN] Add method.
        mdRemoveOn:      mdMethodDef;       // [IN] Remove method.
        mdFire:          mdMethodDef;       // [IN] Fire method.
        rmdOtherMethods: pmdMethodDef):     // [IN] Array of other methods associate with the event.
                         HRESULT; stdcall;  // S_OK or error.

    function SetPermissionSetProps(
        tk:              mdToken;           // [IN] The object to be decorated.
        dwAction:        DWORD;             // [IN] CorDeclSecurity.
        var pvPermission;                   // [IN] Permission blob.
        cbPermission:    ULONG;             // [IN] Count of bytes of pvPermission.
        out ppm:         mdPermission):     // [OUT] Permission token.
                         HRESULT; stdcall;  // S_OK or error.

    function DefinePinvokeMap(
        tk:              mdToken;           // [IN] FieldDef or MethodDef.
        dwMappingFlags:  DWORD;             // [IN] Flags used for mapping.
        szImportName:    LPCWSTR;           // [IN] Import name.
        mrImportDLL:     mdModuleRef):      // [IN] ModuleRef token for the target DLL.
                         HRESULT; stdcall;  // Return code.

    function SetPinvokeMap(
        tk:              mdToken;           // [IN] FieldDef or MethodDef.
        dwMappingFlags:  DWORD;             // [IN] Flags used for mapping.
        szImportName:    LPCWSTR;           // [IN] Import name.
        mrImportDLL:     mdModuleRef):      // [IN] ModuleRef token for the target DLL.
                         HRESULT; stdcall;  // Return code.

    function DeletePinvokeMap(
        tk:              mdToken):          // [IN] FieldDef or MethodDef.
                         HRESULT; stdcall;  // Return code.

    // New CustomAttribute functions.
    function DefineCustomAttribute(
        tkObj:           mdToken;           // [IN] The object to put the value on.
        tkType:          mdToken;           // [IN] Type of the CustomAttribute (TypeRef/TypeDef).
        var pCustomAttribute;               // [IN] The custom value data.
        cbCustomAttribute: ULONG;           // [IN] The custom value data length.
        out pcv:         mdCustomAttribute):// [OUT] The custom value token value on return.
                         HRESULT; stdcall;  // Return code.

    function SetCustomAttributeValue(
        pcv:             mdCustomAttribute; // [IN] The custom value token whose value to replace.
        var pCustomAttribute;               // [IN] The custom value data.
        cbCustomAttribute: ULONG):          // [IN] The custom value data length.
                         HRESULT; stdcall;  // Return code.

    function DefineField(
        td:              mdTypeDef;         // Parent TypeDef
        szName:          LPCWSTR;           // Name of member
        dwFieldFlags:    DWORD;             // Member attributes
        pvSigBlob:       PCCOR_SIGNATURE;   // [IN] point to a blob value of CLR signature
        cbSigBlob:       ULONG;             // [IN] count of bytes in the signature blob
        dwCPlusTypeFlag: DWORD;             // [IN] flag for value type. selected ELEMENT_TYPE_*
        pValue:          PVOID;             // [IN] constant value
        cchValue:        ULONG;             // [IN] size of constant value (string, in wide chars).
        out pmd:         mdFieldDef):       // [OUT] Put member token here
                         HRESULT; stdcall;  // S_OK or error.

    function DefineProperty(
        td:              mdTypeDef;         // [IN] the class/interface on which the property is being defined
        szProperty:      LPCWSTR;           // [IN] Name of the property
        dwPropFlags:     DWORD;             // [IN] CorPropertyAttr
        pvSig:           PCCOR_SIGNATURE;   // [IN] the required type signature
        cbSig:           ULONG;             // [IN] the size of the type signature blob
        dwCPlusTypeFlag: DWORD;             // [IN] flag for value type. selected ELEMENT_TYPE_*
        pValue:          PVOID;             // [IN] constant value
        cchValue:        ULONG;             // [IN] size of constant value (string, in wide chars).
        mdSetter,                           // [IN] optional setter of the property
        mdGetter:        mdMethodDef;       // [IN] optional getter of the property
        rmdOtherMethods: pmdMethodDef;      // [IN] an optional array of other methods
        out pmdProp:     mdProperty):       // [OUT] output property token
                         HRESULT; stdcall;

    function DefineParam(
        md:              mdMethodDef;       // [IN] Owning method
        ulParamSeq:      ULONG;             // [IN] Which param
        szName:          LPCWSTR;           // [IN] Optional param name
        dwParamFlags:    DWORD;             // [IN] Optional param flags
        dwCPlusTypeFlag: DWORD;             // [IN] flag for value type. selected ELEMENT_TYPE_*
        pValue:          PVOID;             // [IN] constant value
        cchValue:        ULONG;             // [IN] size of constant value (string, in wide chars).
        out ppd:         mdParamDef):       // [OUT] Put param token here
                         HRESULT; stdcall;

    function SetFieldProps(
        fd:              mdFieldDef;        // [IN] The FieldDef.
        dwFieldFlags:    DWORD;             // [IN] Field attributes.
        dwCPlusTypeFlag: DWORD;             // [IN] Flag for the value type, selected ELEMENT_TYPE_*
        pValue:          PVOID;             // [IN] Constant value.
        cchValue:        ULONG):            // [IN] size of constant value (string, in wide chars).
                         HRESULT; stdcall;  // S_OK or error.

    function SetPropertyProps(
        pr:              mdProperty;        // [IN] Property token.
        dwPropFlags:     DWORD;             // [IN] CorPropertyAttr.
        dwCPlusTypeFlag: DWORD;             // [IN] Flag for value type, selected ELEMENT_TYPE_*
        pValue:          PVOID;             // [IN] Constant value.
        cchValue:        ULONG;             // [IN] size of constant value (string, in wide chars).
        mdSetter,                           // [IN] Setter of the property.
        mdGetter:        mdMethodDef;       // [IN] Getter of the property.
        rmdOtherMethods: pmdMethodDef):     // [IN] Array of other methods.
                         HRESULT; stdcall;  // S_OK or error.

    function SetParamProps(
        pd:              mdParamDef;        // [IN] Param token.
        szName:          LPCWSTR;           // [IN] Param name.
        dwParamFlags:    DWORD;             // [IN] Param flags.
        dwCPlusTypeFlag: DWORD;             // [IN] Flag for value type. selected ELEMENT_TYPE_*.
        pValue:          PVOID;             // [OUT] Constant value.
        cchValue:        ULONG):            // [IN] size of constant value (string, in wide chars).
                         HRESULT; stdcall;  // Return code.

    // Specialized Custom Attributes for security.
    function DefineSecurityAttributeSet(
        tkObj:           mdToken;           // [IN] Class or method requiring security attributes.
        rSecAttrs:       PCOR_SECATTR;      // [IN] Array of security attribute descriptions.
        cSecAttrs:       ULONG;             // [IN] Count of elements in above array.
        out pulErrorAttr: ULONG):           // [OUT] On error, index of attribute causing problem.
                         HRESULT; stdcall;  // Return code.

    function ApplyEditAndContinue(
        const pImport:   IUnknown):         // [IN] Metadata from the delta PE.
                         HRESULT; stdcall;  // S_OK or error.

    function TranslateSigWithScope(
        const pAssemImport: IMetaDataAssemblyImport; // [IN] importing assembly interface
        pbHashValue:     PVOID;             // [IN] Hash Blob for Assembly.
        cbHashValue:     ULONG;             // [IN] Count of bytes.
        const import:    IMetaDataImport;   // [IN] importing interface
        pbSigBlob:       PCCOR_SIGNATURE;   // [IN] signature in the importing scope
        cbSigBlob:       ULONG;             // [IN] count of bytes of signature
        const pAssemEmit: IMetaDataAssemblyEmit;  // [IN] emit assembly interface
        const emit:      IMetaDataEmit;     // [IN] emit interface
        pvTranslatedSig: PCOR_SIGNATURE;    // [OUT] buffer to hold translated signature
        cbTranslatedSigMax: ULONG;
        out pcbTranslatedSig: ULONG):       // [OUT] count of bytes in the translated signature
                         HRESULT; stdcall;

    function SetMethodImplFlags(
        md:              mdMethodDef;       // [IN] Method for which to set ImplFlags
        dwImplFlags:     DWORD):
                         HRESULT; stdcall;  // S_OK or error.

    function SetFieldRVA(
        fd:              mdFieldDef;        // [IN] Field for which to set offset
        ulRVA:           ULONG):            // [IN] The offset
                         HRESULT; stdcall;  // S_OK or error.

    function Merge(
        const pImport:   IMetaDataImport;   // [IN] The scope to be merged.
        const pHostMapToken: IMapToken;     // [IN] Host IMapToken interface to receive token remap notification
        const pHandler:  IUnknown):         // [IN] An object to receive to receive error notification.
                         HRESULT; stdcall;  // S_OK or error.

    function MergeEnd:   HRESULT; stdcall;  // S_OK or error.

    // This interface is sealed.  Do not change, add, or remove anything.  Instead, derive a new iterface.

  end;      // IMetaDataEmit
  {$EXTERNALSYM IMetaDataEmit}

  //---
  IMetaDataEmit2 = interface(IMetaDataEmit)
    [IID_IMetaDataEmit2]
    function DefineMethodSpec(
        tkParent:      mdToken;             // [IN] MethodDef or MemberRef
        pvSigBlob:     PCCOR_SIGNATURE;     // [IN] point to a blob value of COM+ signature
        cbSigBlob:     ULONG;               // [IN] count of bytes in the signature blob
        out pmi:       mdMethodSpec):       // [OUT] method instantiation token
                       HRESULT; stdcall;

    function GetDeltaSaveSize(
        fSave:         CorSaveSize;         // [IN] cssAccurate or cssQuick.
        out pdwSaveSize: DWORD):            // [OUT] Put the size here.
                       HRESULT; stdcall;    // S_OK or error.

    function SaveDelta(
        szFile:        LPCWSTR;             // [IN] The filename to save to.
        dwSaveFlags:   DWORD):              // [IN] Flags for the save.
                       HRESULT; stdcall;    // S_OK or error.

    function SaveDeltaToStream(
        const pIStream: IStream;            // [IN] A writable stream to save to.
        dwSaveFlags:   DWORD):              // [IN] Flags for the save.
                       HRESULT; stdcall;    // S_OK or error.

    function SaveDeltaToMemory(
        pbData:        PVOID;               // [OUT] Location to write data.
        cbData:        ULONG):              // [IN] Max size of data buffer.
                       HRESULT; stdcall;    // S_OK or error.

    function DefineGenericParam(
        tk:            mdToken;             // [IN] TypeDef or MethodDef
        ulParamSeq:    ULONG;               // [IN] Index of the type parameter
        dwParamFlags:  DWORD;               // [IN] Flags, for future use (e.g. variance)
        szname:        LPCWSTR;             // [IN] Name
        reserved:      DWORD;               // [IN] For future use (e.g. non-type parameters)
        rtkConstraints: pmdToken;           // [IN] Array of type constraints (TypeDef,TypeRef,TypeSpec)
        out pgp:       mdGenericParam):     // [OUT] Put GenericParam token here
                       HRESULT; stdcall;    // S_OK or error.

    function SetGenericParamProps(
        gp:            mdGenericParam;      // [IN] GenericParam
        dwParamFlags:  DWORD;               // [IN] Flags, for future use (e.g. variance)
        szName:        LPCWSTR;             // [IN] Optional name
        reserved:      DWORD;               // [IN] For future use (e.g. non-type parameters)
        rtkConstraints: pmdToken):          // [IN] Array of type constraints (TypeDef,TypeRef,TypeSpec)
                       HRESULT; stdcall;    // S_OK or error.

    function ResetENCLog: HRESULT; stdcall; // S_OK or error.
  end;

  //---
  IMetaDataImport = interface(IUnknown)
    [IID_IMetaDataImport]
    procedure CloseEnum(hEnum: HCORENUM); stdcall;
    function CountEnum(hEnum: HCORENUM; out pulCount: ULONG): HRESULT; stdcall;
    function ResetEnum(hEnum: HCORENUM; ulPos: ULONG): HRESULT; stdcall;
    function EnumTypeDefs(var phEnum: HCORENUM; rTypeDefs: pmdTypeDef;
                            cMax: ULONG; out pcTypeDefs: ULONG): HRESULT; stdcall;
    function EnumInterfaceImpls(var phEnum: HCORENUM; td: mdTypeDef;
                            rImpls: pmdInterfaceImpl; cMax: ULONG;
                            out pcImpls: ULONG): HRESULT; stdcall;
    function EnumTypeRefs(var phEnum: HCORENUM; rTypeRefs: pmdTypeRef;
                            cMax: ULONG; out pcTypeRefs: ULONG): HRESULT; stdcall;

    function FindTypeDefByName(
        szTypeDef:     LPCWSTR;             // [IN] Name of the Type.
        tkEnclosingClass: mdToken;          // [IN] TypeDef/TypeRef for Enclosing class.
        out ptd:       mdTypeDef):          // [OUT] Put the TypeDef token here.
                       HRESULT; stdcall;    // S_OK or error.

    function GetScopeProps(
        // __out_ecount_part_opt(cchName, *pchName)
        szName:       LPWSTR;               // [OUT] Put the name here.
        cchName:      ULONG;                // [IN] Size of name buffer in wide chars.
        out pchName:  ULONG;                // [OUT] Put size of name (wide chars) here.
        pmvid:        PGUID):               // [OUT, OPTIONAL] Put MVID here.
                      HRESULT; stdcall;     // S_OK or error.

    function GetModuleFromScope(
        out pmd:      mdModule):            // [OUT] Put mdModule token here.
                      HRESULT; stdcall;     // S_OK.

    function GetTypeDefProps(
        td:           mdTypeDef;            // [IN] TypeDef token for inquiry.
        // __out_ecount_part_opt(cchTypeDef, pchTypeDef)
        szTypeDef:    LPWSTR;               // [OUT] Put name here.
        cchTypeDef:   ULONG;                // [IN] size of name buffer in wide chars.
        out pchTypeDef: ULONG;              // [OUT] put size of name (wide chars) here.
        out pdwTypeDefFlags: DWORD;         // [OUT] Put flags here.
        out ptkExtends: mdToken):           // [OUT] Put base class TypeDef/TypeRef here.
                      HRESULT; stdcall;     // S_OK or error.

    function GetInterfaceImplProps(
        iiImpl:       mdInterfaceImpl;      // [IN] InterfaceImpl token.
        out pClass:   mdTypeDef;            // [OUT] Put implementing class token here.
        out ptkIface: mdToken):             // [OUT] Put implemented interface token here.
                      HRESULT; stdcall;     // S_OK or error.

    function GetTypeRefProps(
        tr:           mdTypeRef;            // [IN] TypeRef token.
        out ptkResolutionScope: mdToken;    // [OUT] Resolution scope, ModuleRef or AssemblyRef.
        // __out_ecount_part_opt(cchName, *pchName)
        szName:       LPWSTR;               // [OUT] Name of the TypeRef.
        cchName:      ULONG;                // [IN] Size of buffer.
        out pchName:  ULONG):               // [OUT] Size of Name.
                      HRESULT; stdcall;     // S_OK or error.

    function ResolveTypeRef(tr: mdTypeRef; const riid: TIID; out ppIScope; out ptd: mdTypeDef): HRESULT; stdcall;

    function EnumMembers(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        cl:           mdTypeDef;            // [IN] TypeDef to scope the enumeration.
        rMembers:     pmdToken;             // [OUT] Put MemberDefs here.
        cMax:         ULONG;                // [IN] Max MemberDefs to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function EnumMembersWithName(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        cl:           mdTypeDef;            // [IN] TypeDef to scope the enumeration.
        szName:       LPCWSTR;              // [IN] Limit results to those with this name.
        rMembers:     pmdToken;             // [OUT] Put MemberDefs here.
        cMax:         ULONG;                // [IN] Max MemberDefs to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function EnumMethods(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        cl:           mdTypeDef;            // [IN] TypeDef to scope the enumeration.
        rMethods:     pmdMethodDef;         // [OUT] Put MethodDefs here.
        cMax:         ULONG;                // [IN] Max MethodDefs to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function EnumMethodsWithName(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        cl:           mdTypeDef;            // [IN] TypeDef to scope the enumeration.
        szName:       LPCWSTR;              // [IN] Limit results to those with this name.
        rMethods:     pmdMethodDef;         // [OUT] Put MethodDefs here.
        cMax:         ULONG;                // [IN] Max MethodDefs to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function EnumFields(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        cl:           mdTypeDef;            // [IN] TypeDef to scope the enumeration.
        rFields:      pmdFieldDef;          // [OUT] Put FieldDefs here.
        cMax:         ULONG;                // [IN] Max FieldDefs to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function EnumFieldsWithName(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        cl:           mdTypeDef;            // [IN] TypeDef to scope the enumeration.
        szName:       LPCWSTR;              // [IN] Limit results to those with this name.
        rFields:      pmdFieldDef;          // [OUT] Put MemberDefs here.
        cMax:         ULONG;                // [IN] Max MemberDefs to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.


    function EnumParams(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        mb:           mdMethodDef;          // [IN] MethodDef to scope the enumeration.
        rParams:      pmdParamDef;          // [OUT] Put ParamDefs here.
        cMax:         ULONG;                // [IN] Max ParamDefs to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function EnumMemberRefs(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        tkParent:     mdToken;              // [IN] Parent token to scope the enumeration.
        rMemberRefs:  pmdMemberRef;         // [OUT] Put MemberRefs here.
        cMax:         ULONG;                // [IN] Max MemberRefs to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function EnumMethodImpls(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        td:           mdTypeDef;            // [IN] TypeDef to scope the enumeration.
        rMethodBody:  pmdToken;             // [OUT] Put Method Body tokens here.
        rMethodDecl:  pmdToken;             // [OUT] Put Method Declaration tokens here.
        cMax:         ULONG;                // [IN] Max tokens to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error

    function EnumPermissionSets(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        tk:           mdToken;              // [IN] if !NIL, token to scope the enumeration.
        dwActions:    DWORD;                // [IN] if !0, return only these actions.
        rPermission:  pmdPermission;        // [OUT] Put Permissions here.
        cMax:         ULONG;                // [IN] Max Permissions to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function FindMember(
        td:           mdTypeDef;            // [IN] given typedef
        szName:       LPCWSTR;              // [IN] member name
        pvSigBlob:    PCCOR_SIGNATURE;      // [IN] point to a blob value of CLR signature
        cbSigBlob:    ULONG;                // [IN] count of bytes in the signature blob
        out pmb:      mdToken):             // [OUT] matching memberdef
                      HRESULT; stdcall;

    function FindMethod(
        td:           mdTypeDef;            // [IN] given typedef
        szName:       LPCWSTR;              // [IN] member name
        pvSigBlob:    PCCOR_SIGNATURE;      // [IN] point to a blob value of CLR signature
        cbSigBlob:    ULONG;                // [IN] count of bytes in the signature blob
        out pmb:      mdMethodDef):         // [OUT] matching memberdef
                      HRESULT; stdcall;

    function FindField(
        td:           mdTypeDef;            // [IN] given typedef
        szName:       LPCWSTR;              // [IN] member name
        pvSigBlob:    PCCOR_SIGNATURE;      // [IN] point to a blob value of CLR signature
        cbSigBlob:    ULONG;                // [IN] count of bytes in the signature blob
        out pmb:      mdFieldDef):          // [OUT] matching memberdef
                      HRESULT; stdcall;

    function FindMemberRef(
        td:           mdTypeDef;            // [IN] given typedef
        szName:       LPCWSTR;              // [IN] member name
        pvSigBlob:    PCCOR_SIGNATURE;      // [IN] point to a blob value of CLR signature
        cbSigBlob:    ULONG;                // [IN] count of bytes in the signature blob
        out pmr:      mdMemberRef):         // [OUT] matching memberref
                      HRESULT; stdcall;

    function GetMethodProps(
        mb:           mdMethodDef;          // The method for which to get props.
        out pClass:   mdTypeDef;            // Put method's class here.
        // __out_ecount_part_opt(cchMethod, *pchMethod)
        szMethod:     LPWSTR;               // Put method's name here.
        cchMethod:    ULONG;                // Size of szMethod buffer in wide chars.
        out pchMethod: ULONG;               // Put actual size here
        out pdwAttr:  DWORD;                // Put flags here.
        out ppvSigBlob: PCCOR_SIGNATURE;    // [OUT] point to the blob value of meta data
        out pcbSigBlob: ULONG;              // [OUT] actual size of signature blob
        out pulCodeRVA: ULONG;              // [OUT] codeRVA
        out pdwImplFlags: DWORD):           // [OUT] Impl. Flags
                      HRESULT; stdcall;

    function GetMemberRefProps(
        mr:           mdMemberRef;          // [IN] given memberref
        out ptk:      mdToken;              // [OUT] Put classref or classdef here.
        // __out_ecount_part_opt(cchMember, *pchMember)
        szMember:     LPWSTR;               // [OUT] buffer to fill for member's name
        cchMember:    ULONG;                // [IN] the count of char of szMember
        out pchMember: ULONG;               // [OUT] actual count of char in member name
        out ppvSigBlob: PCCOR_SIGNATURE;    // [OUT] point to meta data blob value
        out pbSig:    ULONG):               // [OUT] actual size of signature blob
                      HRESULT; stdcall;     // S_OK or error.

    function EnumProperties(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        td:           mdTypeDef;            // [IN] TypeDef to scope the enumeration.
        rProperties:  pmdProperty;          // [OUT] Put Properties here.
        cMax:         ULONG;                // [IN] Max properties to put.
        out pcProperties: ULONG):           // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function EnumEvents(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        td:           mdTypeDef;            // [IN] TypeDef to scope the enumeration.
        rEvents:      pmdEvent;             // [OUT] Put events here.
        cMax:         ULONG;                // [IN] Max events to put.
        out pcEvents: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function GetEventProps(
        ev:           mdEvent;              // [IN] event token
        out pClass:   mdTypeDef;            // [OUT] typedef containing the event declarion.
        szEvent:      LPCWSTR;              // [OUT] Event name
        cchEvent:     ULONG;                // [IN] the count of wchar of szEvent
        out pchEvent: ULONG;                // [OUT] actual count of wchar for event's name
        out pdwEventFlags: DWORD;           // [OUT] Event flags.
        out ptkEventType: mdToken;          // [OUT] EventType class
        out pmdAddOn: mdMethodDef;          // [OUT] AddOn method of the event
        out pmdRemoveOn: mdMethodDef;       // [OUT] RemoveOn method of the event
        out pmdFire:  mdMethodDef;          // [OUT] Fire method of the event
        rmdOtherMethod: pmdMethodDef;       // [OUT] other method of the event
        cMax:         ULONG;                // [IN] size of rmdOtherMethod
        out pcOtherMethod: ULONG):          // [OUT] total number of other method of this event
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function EnumMethodSemantics(
        out phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        mb:           mdMethodDef;          // [IN] MethodDef to scope the enumeration.
        rEventProp:   pmdToken;             // [OUT] Put Event/Property here.
        cMax:         ULONG;                // [IN] Max properties to put.
        out pcEventProp: ULONG):            // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function GetMethodSemantics(
        mb:           mdMethodDef;          // [IN] method token
        tkEventProp:  mdToken;              // [IN] event/property token.
        out pdwSemanticsFlags: DWORD):      // [OUT] the role flags for the method/propevent pair
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function GetClassLayout(
        td:           mdTypeDef;            // [IN] give typedef
        out pdwPackSize: DWORD;             // [OUT] 1, 2, 4, 8, or 16
        rFieldOffset: PCOR_FIELD_OFFSET;    // [OUT] field offset array
        cMax:         ULONG;                // [IN] size of the array
        out pcFieldOffset: ULONG;           // [OUT] needed array size
        out pulClassSize: ULONG):           // [OUT] the size of the class
                      HRESULT; stdcall;

    function GetFieldMarshal(
        tk:           mdToken;              // [IN] given a field's memberdef
        out ppvNativeType: PCCOR_SIGNATURE; // [OUT] native type of this field
        out pcbNativeType: ULONG):          // [OUT] the count of bytes of *ppvNativeType
                      HRESULT; stdcall;

    function GetRVA(
        tk:           mdToken;              // Member for which to set offset
        out pulCodeRVA: ULONG;              // The offset
        out pdwImplFlags: DWORD):           // the implementation flags
                      HRESULT; stdcall;     // S_OK or error.

    function GetPermissionSetProps(
        pm:           mdPermission;         // [IN] the permission token.
        out pdwAction: DWORD;               // [OUT] CorDeclSecurity.
        out ppvPermission: PVOID;           // [OUT] permission blob.
        out pcbPermission: ULONG):          // [OUT] count of bytes of pvPermission.
                      HRESULT; stdcall;

    function GetSigFromToken(
        mdSig:        mdSignature;          // [IN] Signature token.
        out ppvSig:   PCCOR_SIGNATURE;      // [OUT] return pointer to token.
        out pcbSig:   ULONG):               // [OUT] return size of signature.
                      HRESULT; stdcall;     // S_OK or error.

    function GetModuleRefProps(
        mur:          mdModuleRef;          // [IN] moduleref token.
        // __out_ecount_part_opt(cchName, *pchName)
        szName:       LPWSTR;               // [OUT] buffer to fill with the moduleref name.
        cchName:      ULONG;                // [IN] size of szName in wide characters.
        out pchName:  ULONG):               // [OUT] actual count of characters in the name.
                      HRESULT; stdcall;     // S_OK or error.

    function EnumModuleRefs(
        var phEnum:   HCORENUM;             // [IN|OUT] pointer to the enum.
        rModuleRefs:  pmdModuleRef;         // [OUT] put modulerefs here.
        cmax:         ULONG;                // [IN] max memberrefs to put.
        out pcModuleRefs: ULONG):           // [OUT] put # put here.
                      HRESULT; stdcall;     // S_OK or error.

    function GetTypeSpecFromToken(        // S_OK or error.
        typespec:     mdTypeSpec;           // [IN] TypeSpec token.
        out ppvSig:   PCCOR_SIGNATURE;      // [OUT] return pointer to TypeSpec signature
        out pcbSig:   ULONG):               // [OUT] return size of signature.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function GetNameFromToken(            // Not Recommended! May be removed!
        tk:           mdToken;              // [IN] Token to get name from.  Must have a name.
        out pszUtf8NamePtr: MDUTF8CSTR):    // [OUT] Return pointer to UTF8 name in heap.
                      HRESULT; stdcall;

    function EnumUnresolvedMethods(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        rMethods:     pmdToken;             // [OUT] Put MemberDefs here.
        cMax:         ULONG;                // [IN] Max MemberDefs to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function GetUserString(
        stk:          mdString;             // [IN] String token.
        // __out_ecount_part_opt(cchString, *pchString)
        szString:     LPWSTR;               // [OUT] Copy of string.
        cchString:    ULONG;                // [IN] Max chars of room in szString.
        out pchString: ULONG):              // [OUT] How many chars in actual string.
                      HRESULT; stdcall;     // S_OK or error.

    function GetPinvokeMap(
        tk:           mdToken;              // [IN] FieldDef or MethodDef.
        out pdwMappingFlags: DWORD;         // [OUT] Flags used for mapping.
        // __out_ecount_part_opt(cchImportName, *pchImportName)
        szImportName: LPWSTR;               // [OUT] Import name.
        cchImportName: ULONG;               // [IN] Size of the name buffer.
        out pchImportName: ULONG;           // [OUT] Actual number of characters stored.
        out pmrImportDLL: mdModuleRef):     // [OUT] ModuleRef token for the target DLL.
                      HRESULT; stdcall;     // S_OK or error.

    function EnumSignatures(
        var phEnum:   HCORENUM;             // [IN|OUT] pointer to the enum.
        rSignatures:  pmdSignature;         // [OUT] put signatures here.
        cmax:         ULONG;                // [IN] max signatures to put.
        out pcSignatures: ULONG):           // [OUT] put # put here.
                      HRESULT; stdcall;     // S_OK or error.

    function EnumTypeSpecs(
        var phEnum:   HCORENUM;             // [IN|OUT] pointer to the enum.
        rTypeSpecs:   pmdTypeSpec;          // [OUT] put TypeSpecs here.
        cmax:         ULONG;                // [IN] max TypeSpecs to put.
        out pcTypeSpecs: ULONG):            // [OUT] put # put here.
                      HRESULT; stdcall;     // S_OK or error.

    function EnumUserStrings(
        var phEnum:   HCORENUM;             // [IN/OUT] pointer to the enum.
        rStrings:     pmdString;            // [OUT] put Strings here.
        cmax:         ULONG;                // [IN] max Strings to put.
        out pcStrings: ULONG):              // [OUT] put # put here.
                      HRESULT; stdcall;     // S_OK or error.

    function GetParamForMethodIndex(
        md:           mdMethodDef;          // [IN] Method token.
        ulParamSeq:   ULONG;                // [IN] Parameter sequence.
        out ppd:      mdParamDef):          // [IN] Put Param token here.
                      HRESULT; stdcall;     // S_OK or error.

    function EnumCustomAttributes(
        var phEnum:   HCORENUM;             // [IN, OUT] COR enumerator.
        tk:           mdToken;              // [IN] Token to scope the enumeration, 0 for all.
        tkType:       mdToken;              // [IN] Type of interest, 0 for all.
        rCustomAttributes: pmdCustomAttribute; // [OUT] Put custom attribute tokens here.
        cMax:         ULONG;                // [IN] Size of rCustomAttributes.
        out pcCustomAttributes: ULONG):     // [OUT, OPTIONAL] Put count of token values here.
                      HRESULT; stdcall;     // S_OK or error.

    function GetCustomAttributeProps(
        cv:           mdCustomAttribute;    // [IN] CustomAttribute token.
        ptkObj:       pmdToken;             // [OUT, OPTIONAL] Put object token here.
        ptkType:      pmdToken;             // [OUT, OPTIONAL] Put AttrType token here.
        ppBlob:       PPVOID;               // [OUT, OPTIONAL] Put pointer to data here.
        pcbSize:      PULONG):              // [OUT, OPTIONAL] Put size of date here.
                      HRESULT; stdcall;     // S_OK or error.

    function FindTypeRef(
        tkResolutionScope: mdToken;         // [IN] ModuleRef, AssemblyRef or TypeRef.
        szName:       LPCWSTR;              // [IN] TypeRef Name.
        out ptr:      mdTypeRef):           // [OUT] matching TypeRef.
                      HRESULT; stdcall;

    function GetMemberProps(
        mb:           mdToken;              // The member for which to get props.
        out pClass:   mdTypeDef;            // Put member's class here.
        // __out_ecount_part_opt(cchMember, *pchMember)
        szMember:     LPWSTR;               // Put member's name here.
        cchMember:    ULONG;                // Size of szMember buffer in wide chars.
        out pchMember: ULONG;               // Put actual size here
        out pdwAttr:  DWORD;                // Put flags here.
        out ppvSigBlob: PCCOR_SIGNATURE;    // [OUT] point to the blob value of meta data
        out pcbSigBlob: ULONG;              // [OUT] actual size of signature blob
        out pulCodeRVA: ULONG;              // [OUT] codeRVA
        out pdwImplFlags: DWORD;            // [OUT] Impl. Flags
        out pdwCPlusTypeFlag: DWORD;        // [OUT] flag for value type. selected ELEMENT_TYPE_*
        out ppValue:  UVCP_CONSTANT;        // [OUT] constant value
        out pcchValue: ULONG):              // [OUT] size of constant string in chars, 0 for non-strings.
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function GetFieldProps(
        mb:           mdFieldDef;           // The field for which to get props.
        out pClass:   mdTypeDef;            // Put field's class here.
        // __out_ecount_part_opt(cchField, *pchField)
        szField:      LPWSTR;               // Put field's name here.
        cchField:     ULONG;                // Size of szField buffer in wide chars.
        out pchField: ULONG;                // Put actual size here
        out pdwAttr:  DWORD;                // Put flags here.
        out ppvSigBlob: PCCOR_SIGNATURE;    // [OUT] point to the blob value of meta data
        out pcbSigBlob: ULONG;              // [OUT] actual size of signature blob
        out pdwCPlusTypeFlag: DWORD;        // [OUT] flag for value type. selected ELEMENT_TYPE_*
        out ppValue:  UVCP_CONSTANT;        // [OUT] constant value
        out pcchValue: ULONG):              // [OUT] size of constant string in chars, 0 for non-strings.
                      HRESULT; stdcall;

    function GetPropertyProps(
        prop:         mdProperty;           // [IN] property token
        out pClass:   mdTypeDef;            // [OUT] typedef containing the property declarion.
        szProperty:   LPCWSTR;              // [OUT] Property name
        cchProperty:  ULONG;                // [IN] the count of wchar of szProperty
        out pchProperty: ULONG;             // [OUT] actual count of wchar for property name
        out pdwPropFlags: DWORD;            // [OUT] property flags.
        out ppvSig:   PCCOR_SIGNATURE;      // [OUT] property type. pointing to meta data internal blob
        out pbSig:    ULONG;                // [OUT] count of bytes in *ppvSig
        out pdwCPlusTypeFlag: DWORD;        // [OUT] flag for value type. selected ELEMENT_TYPE_*
        out ppDefaultValue: UVCP_CONSTANT;  // [OUT] constant value
        out pcchDefaultValue: ULONG;        // [OUT] size of constant string in chars, 0 for non-strings.
        out pmdSetter: mdMethodDef;         // [OUT] setter method of the property
        out pmdGetter: mdMethodDef;         // [OUT] getter method of the property
        out rmdOtherMethod: mdMethodDef;    // [OUT] other method of the property
        cMax:         ULONG;                // [IN] size of rmdOtherMethod
        out pcOtherMethod: ULONG):          // [OUT] total number of other method of this property
                      HRESULT; stdcall;     // S_OK, S_FALSE, or error.

    function GetParamProps(
        tk:           mdParamDef;           // [IN]The Parameter.
        out pmd:      mdMethodDef;          // [OUT] Parent Method token.
        out pulSequence: ULONG;             // [OUT] Parameter sequence.
        // __out_ecount_part_opt(cchName, *pchName)
        szName:       LPWSTR;               // [OUT] Put name here.
        cchName:      ULONG;                // [OUT] Size of name buffer.
        out pchName:  ULONG;                // [OUT] Put actual size of name here.
        out pdwAttr:  DWORD;                // [OUT] Put flags here.
        out pdwCPlusTypeFlag: DWORD;        // [OUT] Flag for value type. selected ELEMENT_TYPE_*.
        out ppValue:  UVCP_CONSTANT;        // [OUT] Constant value.
        out pcchValue: ULONG):              // [OUT] size of constant string in chars, 0 for non-strings.
                      HRESULT; stdcall;     // S_OK or error.

    function GetCustomAttributeByName(
        tkObj:        mdToken;              // [IN] Object with Custom Attribute.
        szName:       LPCWSTR;              // [IN] Name of desired Custom Attribute.
        out ppData:   PVOID;                // [OUT] Put pointer to data here.
        out pcbData:  ULONG):               // [OUT] Put size of data here.
                      HRESULT; stdcall;     // S_OK or error.

    function IsValidToken(
        tk:           mdToken):             // [IN] Given token.
                      BOOL; stdcall;        // True or False.

    function GetNestedClassProps(
        tdNestedClass: mdTypeDef;           // [IN] NestedClass token.
        out ptdEnclosingClass: mdTypeDef):  // [OUT] EnclosingClass token.
                      HRESULT; stdcall;     // S_OK or error.

    function GetNativeCallConvFromSig(
        pvSig:        PVOID;                // [IN] Pointer to signature.
        cbSig:        ULONG;                // [IN] Count of signature bytes.
        out pCallConv: ULONG):              // [OUT] Put calling conv here (see CorPinvokemap).
                      HRESULT; stdcall;     // S_OK or error.

    function IsGlobal(
        pd:           mdToken;              // [IN] Type, Field, or Method token.
        out pbGlobal: Integer):             // [OUT] Put 1 if global, 0 otherwise.
                      HRESULT; stdcall;     // S_OK or error.

    // This interface is sealed.  Do not change, add, or remove anything.  Instead, derive a new iterface.

  end;      // IMetaDataImport
  {$EXTERNALSYM IMetaDataEmit2}

  //---
  IMetaDataImport2 = interface(IMetaDataImport)
    [IID_IMetaDataImport2]
    function EnumGenericParams(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        tk:           mdToken;              // [IN] TypeDef or MethodDef whose generic parameters are requested
        rGenericParams: pmdGenericParam;    // [OUT] Put GenericParams here.
        cMax:         ULONG;                // [IN] Max GenericParams to put.
        out pcGenericParams: ULONG):        // [OUT] Put # put here.
                      HRESULT; stdcall;

    function GetGenericParamProps(
        gp:           mdGenericParam;       // [IN] GenericParam
        out pulParamSeq: ULONG;             // [OUT] Index of the type parameter
        out pdwParamFlags: DWORD;           // [OUT] Flags, for future use (e.g. variance)
        out ptOwner:  mdToken;              // [OUT] Owner (TypeDef or MethodDef)
        reserved:     Pointer;              // [OUT] For future use (e.g. non-type parameters)
        // __out_ecount_part_opt(cchName, *pchName)
        wzname:       LPWSTR;               // [OUT] Put name here
        cchName:      ULONG;                // [IN] Size of buffer
        out pchName:  ULONG):               // [OUT] Put size of name (wide chars) here.
                      HRESULT; stdcall;     // S_OK or error.

    function GetMethodSpecProps(
        mi:           mdMethodSpec;         // [IN] The method instantiation
        out tkParent: mdToken;              // [OUT] MethodDef or MemberRef
        out ppvSigBlob: PCCOR_SIGNATURE;    // [OUT] point to the blob value of meta data
        out pcbSigBlob: ULONG):             // [OUT] actual size of signature blob
                      HRESULT; stdcall;

    function EnumGenericParamConstraints(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        tk:           mdGenericParam;       // [IN] GenericParam whose constraints are requested
        rGenericParamConstraints: pmdGenericParamConstraint;  // [OUT] Put GenericParamConstraints here.
        cMax:         ULONG;                // [IN] Max GenericParamConstraints to put.
        out pcGenericParamConstraints: ULONG): // [OUT] Put # put here.
                      HRESULT; stdcall;

    function GetGenericParamConstraintProps(
        gpc:          mdGenericParamConstraint; // [IN] GenericParamConstraint
        out ptGenericParam: mdGenericParam;  // [OUT] GenericParam that is constrained
        out ptkConstraintType: mdToken):     // [OUT] TypeDef/Ref/Spec constraint
                      HRESULT; stdcall;      // S_OK or error.

    function GetPEKind(
        out pdwPEKind: DWORD;               // [OUT] The kind of PE (0 - not a PE)
        out pdwMAchine: DWORD):             // [OUT] Machine as defined in NT header
                      HRESULT; stdcall;     // S_OK or error.

    function GetVersionString(
        // __out_ecount_part_opt(cchBufSize, pccBufSize)
        pwzBuf:       LPWSTR;               // [OUT[ Put version string here.
        ccBufSize:    DWORD;                // [IN] size of the buffer, in wide chars
        out pccBufSize: DWORD):             // [OUT] Size of the version string, wide chars, including terminating nul.
                      HRESULT; stdcall;     // S_OK or error.

    function EnumMethodSpecs(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        tk:           mdToken;              // [IN] MethodDef or MemberRef whose MethodSpecs are requested
        rMethodSpecs: pmdMethodSpec;        // [OUT] Put MethodSpecs here.
        cMax:         ULONG;                // [IN] Max tokens to put.
        out pcMethodSpecs: ULONG):          // [OUT] Put actual count here.
                      HRESULT; stdcall;     // S_OK or error.

  end; // IMetaDataImport2
  {$EXTERNALSYM IMetaDataImport2}

  //---
  IMetaDataFilter = interface(IUnknown)
    [IID_IMetaDataFilter]
    function UnmarkAll: HRESULT; stdcall;
    function MarkToken(tk: mdToken): HRESULT; stdcall;
    function IsTokenMarked(tk: mdToken; out pIsMarked: BOOL): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IMetaDataFilter}

  //---
  IHostFilter = interface(IUnknown)
    [IID_IHostFilter]
    function MarkToken(tk: mdToken): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IHostFilter}

  //---
  IMetaDataConverter = interface(IUnknown)
    [IID_IMetaDataConverter]
    function GetMetaDataFromTypeInfo(
        const pITI:   ITypeInfo;            // [in] Type info
        out ppMDI:    IMetaDataImport):     // [out] return IMetaDataImport on success
                      HRESULT; stdcall;

    function GetMetaDataFromTypeLib(
        const pITL:   ITypeLib;             // [in] Type library
        out ppMDI:    IMetaDataImport):     // [out] return IMetaDataImport on success
                      HRESULT; stdcall;

    function GetTypeLibFromMetaData(
        strModule:    WideString;           // [in] Module name
        strTlbName:   WideString;           // [in] Type library name
        out ppITL:    ITypeLib):            // [out] return ITypeLib on success
                      HRESULT; stdcall;
  end;
  {$EXTERNALSYM IMetaDataConverter}

  //*****************************************************************************
  // Assembly Declarations
  //*****************************************************************************

  OSINFO = record
    dwOSPlatformId:   DWORD;                // Operating system platform.
    dwOSMajorVersion: DWORD;                // OS Major version.
    dwOSMinorVersion: DWORD;                // OS Minor version.
  end;
  {$EXTERNALSYM OSINFO}
  POSINFO = ^OSINFO;

  USHORT = Word;
  {$EXTERNALSYM USHORT}
  ASSEMBLYMETADATA = record
    usMajorVersion: USHORT;                 // Major Version.
    usMinorVersion: USHORT;                 // Minor Version.
    usBuildNumber:  USHORT;                 // Build Number.
    usRevisionNumber: USHORT;               // Revision Number.
    szLocale:       LPWSTR;                 // Locale.
    cbLocale:       ULONG;                  // [IN/OUT] Size of the buffer in wide chars/Actual size.
    rProcessor:     PDWORD;                 // Processor ID array.
    ulProcessor:    ULONG;                  // [IN/OUT] Size of the Processor ID array/Actual # of entries filled in.
    rOS:            POSINFO;                // OSINFO array.
    ulOS:           ULONG;                  // [IN/OUT]Size of the OSINFO array/Actual # of entries filled in.
  end;
  {$EXTERNALSYM  ASSEMBLYMETADATA}
  PASSEMBLYMETADATA = ^ASSEMBLYMETADATA;

  //---
  IMetaDataAssemblyEmit = interface(IUnknown)
    [IID_IMetaDataAssemblyEmit]
    function DefineAssembly(              // S_OK or error.
        pbPublicKey:  Pointer;              // [IN] Public key of the assembly.
        cbPublicKey:  ULONG;                // [IN] Count of bytes in the public key.
        ulHashAlgId:  ULONG;                // [IN] Hash algorithm used to hash the files.
        szName:       LPCWSTR;              // [IN] Name of the assembly.
        pMetaData:    PASSEMBLYMETADATA;    // [IN] Assembly MetaData.
        dwAssemblyFlags: DWORD;             // [IN] Flags.
        out pma:      mdAssembly):          // [OUT] Returned Assembly token.
                      HRESULT; stdcall;

    function DefineAssemblyRef(
        pbPublicKeyOrToken: Pointer;        // [IN] Public key or token of the assembly.
        cbPublicKeyOrToken: ULONG;          // [IN] Count of bytes in the public key or token.
        szName:       LPCWSTR;              // [IN] Name of the assembly being referenced.
        pMetaData:    PASSEMBLYMETADATA;    // [IN] Assembly MetaData.
        pbHashValue:  Pointer;              // [IN] Hash Blob.
        cbHashValue:  ULONG;                // [IN] Count of bytes in the Hash Blob.
        dwAssemblyRefFlags: DWORD;          // [IN] Flags.
        out pmdar:    mdAssemblyRef):       // [OUT] Returned AssemblyRef token.
                      HRESULT; stdcall;     // S_OK or error.

    function DefineFile(
        szName:       LPCWSTR;              // [IN] Name of the file.
        pbHashValue:  Pointer;              // [IN] Hash Blob.
        cbHashValue:  ULONG;                // [IN] Count of bytes in the Hash Blob.
        dwFileFlags:  DWORD;                // [IN] Flags.
        out pmdf:     mdFile):              // [OUT] Returned File token.
                      HRESULT; stdcall;     // S_OK or error.

    function DefineExportedType(
        szName:       LPCWSTR;              // [IN] Name of the Com Type.
        tkImplementation: mdToken;          // [IN] mdFile or mdAssemblyRef or mdExportedType
        tkTypeDef:    mdTypeDef;            // [IN] TypeDef token within the file.
        dwExportedTypeFlags: DWORD;         // [IN] Flags.
        out pmdct:    mdExportedType):      // [OUT] Returned ExportedType token.
                      HRESULT; stdcall;     // S_OK or error.

    function DefineManifestResource(
        szName:       LPCWSTR;              // [IN] Name of the resource.
        tkImplementation: mdToken;          // [IN] mdFile or mdAssemblyRef that provides the resource.
        dwOffset:     DWORD;                // [IN] Offset to the beginning of the resource within the file.
        dwResourceFlags: DWORD;             // [IN] Flags.
        out pmdmr:    mdManifestResource):  // [OUT] Returned ManifestResource token.
                      HRESULT; stdcall;     // S_OK or error.

    function SetAssemblyProps(
        pma:          mdAssembly;           // [IN] Assembly token.
        pbPublicKey:  Pointer;              // [IN] Public key of the assembly.
        cbPublicKey:  ULONG;                // [IN] Count of bytes in the public key.
        ulHashAlgId:  ULONG;                // [IN] Hash algorithm used to hash the files.
        szName:       LPCWSTR;              // [IN] Name of the assembly.
        pMetaData:    PASSEMBLYMETADATA;    // [IN] Assembly MetaData.
        dwAssemblyFlags: DWORD):            // [IN] Flags.
                      HRESULT; stdcall;     // S_OK or error.

    function SetAssemblyRefProps(
        ar:           mdAssemblyRef;        // [IN] AssemblyRefToken.
        pbPublicKeyOrToken: Pointer;        // [IN] Public key or token of the assembly.
        cbPublicKeyOrToken: ULONG;          // [IN] Count of bytes in the public key or token.
        szName:       LPCWSTR;              // [IN] Name of the assembly being referenced.
        pMetaData:    PASSEMBLYMETADATA;    // [IN] Assembly MetaData.
        pbHashValue:  Pointer;              // [IN] Hash Blob.
        cbHashValue:  ULONG;                // [IN] Count of bytes in the Hash Blob.
        dwAssemblyRefFlags: DWORD):         // [IN] Token for Execution Location.
                      HRESULT; stdcall;     // S_OK or error.

    function SetFileProps(
        afile:        mdFile;               // [IN] File token.
        pbHashValue:  Pointer;              // [IN] Hash Blob.
        cbHashValue:  ULONG;                // [IN] Count of bytes in the Hash Blob.
        dwFileFlags:  DWORD):               // [IN] Flags.
                      HRESULT; stdcall;     // S_OK or error.

    function SetExportedTypeProps(
        ct:           mdExportedType;       // [IN] ExportedType token.
        tkImplementation: mdToken;          // [IN] mdFile or mdAssemblyRef or mdExportedType.
        tkTypeDef:    mdTypeDef;            // [IN] TypeDef token within the file.
        dwExportedTypeFlags: DWORD):        // [IN] Flags.
                      HRESULT; stdcall;     // S_OK or error.

    function SetManifestResourceProps(
        mr:           mdManifestResource;   // [IN] ManifestResource token.
        tkImplementation: mdToken;          // [IN] mdFile or mdAssemblyRef that provides the resource.
        dwOffset:     DWORD;                // [IN] Offset to the beginning of the resource within the file.
        dwResourceFlags: DWORD):            // [IN] Flags.
                      HRESULT; stdcall;     // S_OK or error.

  end;  // IMetaDataAssemblyEmit
  {$EXTERNALSYM IMetaDataAssemblyEmit}

  //---
  IMetaDataAssemblyImport = interface(IUnknown)
    [IID_IMetaDataAssemblyImport]
    function GetAssemblyProps(
        mda:          mdAssembly;           // [IN] The Assembly for which to get the properties.
        out ppbPublicKey: PVOID;            // [OUT] Pointer to the public key.
        out pcbPublicKey: ULONG;            // [OUT] Count of bytes in the public key.
        out pulHashAlgId: ULONG;            // [OUT] Hash Algorithm.
        // __out_ecount_part_opt(cchName, *pchName)
        szName:       LPWSTR;               // [OUT] Buffer to fill with assembly's simply name.
        cchName:      ULONG;                // [IN] Size of buffer in wide chars.
        out pchName:  ULONG;                // [OUT] Actual # of wide chars in name.
        out pMetaData: ASSEMBLYMETADATA;    // [OUT] Assembly MetaData.
        out pdwAssemblyFlags: DWORD):       // [OUT] Flags.
                      HRESULT; stdcall;     // S_OK or error.

    function GetAssemblyRefProps(
        mdar:         mdAssemblyRef;        // [IN] The AssemblyRef for which to get the properties.
        out ppbPublicKeyOrToken: PVOID;     // [OUT] Pointer to the public key or token.
        out pcbPublicKeyOrToken: ULONG;     // [OUT] Count of bytes in the public key or token.
        //__out_ecount_part_opt(cchName, *pchName)
        szName:       LPWSTR;               // [OUT] Buffer to fill with name.
        cchName:      ULONG;                // [IN] Size of buffer in wide chars.
        out pchName:  ULONG;                // [OUT] Actual # of wide chars in name.
        out pMetaData: ASSEMBLYMETADATA;    // [OUT] Assembly MetaData.
        out ppbHashValue: PVOID;            // [OUT] Hash blob.
        out pcbHashValue: ULONG;            // [OUT] Count of bytes in the hash blob.
        out pdwAssemblyRefFlags: DWORD):    // [OUT] Flags.
                      HRESULT; stdcall;     // S_OK or error.

    function GetFileProps(
        mdf:          mdFile;               // [IN] The File for which to get the properties.
        //__out_ecount_part_opt(cchName, *pchName)
        szName:       LPWSTR;               // [OUT] Buffer to fill with name.
        cchName:      ULONG;                // [IN] Size of buffer in wide chars.
        out pchName:  ULONG;                // [OUT] Actual # of wide chars in name.
        out ppbHashValue: PVOID;            // [OUT] Pointer to the Hash Value Blob.
        out pcbHashValue: ULONG;            // [OUT] Count of bytes in the Hash Value Blob.
        out pdwFileFlags: DWORD):           // [OUT] Flags.
                      HRESULT; stdcall;     // S_OK or error.

    function GetExportedTypeProps(
        mdct:         mdExportedType;       // [IN] The ExportedType for which to get the properties.
        // __out_ecount_part_opt(cchName, *pchName)
        szName:       LPWSTR;               // [OUT] Buffer to fill with name.
        cchName:      ULONG;                // [IN] Size of buffer in wide chars.
        out pchName:  ULONG;                // [OUT] Actual # of wide chars in name.
        out ptkImplementation: mdToken;     // [OUT] mdFile or mdAssemblyRef or mdExportedType.
        out ptkTypeDef: mdTypeDef;          // [OUT] TypeDef token within the file.
        out pdwExportedTypeFlags: DWORD):   // [OUT] Flags.
                      HRESULT; stdcall;     // S_OK or error.

    function GetManifestResourceProps(
        mdmr:         mdManifestResource;   // [IN] The ManifestResource for which to get the properties.
        // __out_ecount_part_opt(cchName, *pchName)
        szName:       LPWSTR;               // [OUT] Buffer to fill with name.
        cchName:      ULONG;                // [IN] Size of buffer in wide chars.
        out pchName:  ULONG;                // [OUT] Actual # of wide chars in name.
        out ptkImplementation: mdToken;     // [OUT] mdFile or mdAssemblyRef that provides the ManifestResource.
        out pdwOffset: DWORD;               // [OUT] Offset to the beginning of the resource within the file.
        out pdwResourceFlags: DWORD):       // [OUT] Flags.
                      HRESULT; stdcall;     // S_OK or error.

    function EnumAssemblyRefs(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        rAssemblyRefs: pmdAssemblyRef;      // [OUT] Put AssemblyRefs here.
        cMax:         ULONG;                // [IN] Max AssemblyRefs to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK or error.

    function EnumFiles(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        rFiles:       pmdFile;              // [OUT] Put Files here.
        cMax:         ULONG;                // [IN] Max Files to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK or error.

    function EnumExportedTypes(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        rExportedTypes: pmdExportedType;    // [OUT] Put ExportedTypes here.
        cMax:         ULONG;                // [IN] Max ExportedTypes to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK or error.

    function EnumManifestResources(
        var phEnum:   HCORENUM;             // [IN|OUT] Pointer to the enum.
        rManifestResources: pmdManifestResource; // [OUT] Put ManifestResources here.
        cMax:         ULONG;                // [IN] Max Resources to put.
        out pcTokens: ULONG):               // [OUT] Put # put here.
                      HRESULT; stdcall;     // S_OK or error.

    function GetAssemblyFromScope(
        out ptkAssembly: mdAssembly):       // [OUT] Put token here.
                      HRESULT; stdcall;     // S_OK or error.

    function FindExportedTypeByName(
        szName:       LPCWSTR;              // [IN] Name of the ExportedType.
        mdtExportedType: mdToken;           // [IN] ExportedType for the enclosing class.
        out ptkExportedType: mdExportedType): // [OUT] Put the ExportedType token here.
                      HRESULT; stdcall;     // S_OK or error.

    function FindManifestResourceByName(
        szName:       LPCWSTR;              // [IN] Name of the ManifestResource.
        out ptkManifestResource: mdManifestResource): // [OUT] Put the ManifestResource token here.
                      HRESULT; stdcall;     // S_OK or error.

    procedure CloseEnum(
        hEnum: HCORENUM); stdcall;          // Enum to be closed.

    function FindAssembliesByName(
        szAppBase:    LPCWSTR;              // [IN] optional - can be NULL
        szPrivateBin: LPCWSTR;              // [IN] optional - can be NULL
        szAssemblyName: LPCWSTR;            // [IN] required - this is the assembly you are requesting
        out ppIUnk;                         // [OUT] put IMetaDataAssemblyImport pointers here
        cMax:         ULONG;                // [IN] The max number to put
        out pcAssemblies: ULONG):           // [OUT] The number of assemblies returned.
                      HRESULT; stdcall;     // S_OK or error.
  end;  // IMetaDataAssemblyImport
  {$EXTERNALSYM IMetaDataAssemblyImport}

//*****************************************************************************
// End Assembly Declarations
//*****************************************************************************

//*****************************************************************************
// MetaData Validator Declarations
//*****************************************************************************

  // Specifies the type of the module, PE file vs. .obj file.
  CorValidatorModuleType = (
      ValidatorModuleTypeInvalid      = $0,
      ValidatorModuleTypeMin          = $00000001,
      ValidatorModuleTypePE           = $00000001,
      ValidatorModuleTypeObj          = $00000002,
      ValidatorModuleTypeEnc          = $00000003,
      ValidatorModuleTypeIncr         = $00000004,
      ValidatorModuleTypeMax          = $00000004
  );
  {$EXTERNALSYM CorValidatorModuleType}


  //---
  IMetaDataValidate = interface(IUnknown)
    [IID_IMetaDataValidate]
      function ValidatorInit(
          dwModuleType: DWORD;              // [IN] Specifies the type of the module.
          const pUnk:  IUnknown):           // [IN] Validation error handler.
                       HRESULT; stdcall;    // S_OK or error.

      function ValidateMetaData:
                      HRESULT; stdcall;     // S_OK or error.
  end;  // IMetaDataValidate
  {$EXTERNALSYM IMetaDataValidate}

//*****************************************************************************
// End MetaData Validator Declarations
//*****************************************************************************

//*****************************************************************************
// IMetaDataDispenserEx declarations.
//*****************************************************************************

  IMetaDataDispenserEx = interface(IMetaDataDispenser)
    [IID_IMetaDataDispenserEx]
      function SetOption(
          const optionid: TGUID;            // [in] GUID for the option to be set.
          const value: Variant):            // [in] Value to which the option is to be set.
                      HRESULT; stdcall;     // Return code.

      function GetOption(
          const optionid: TGUID;            // [in] GUID for the option to be set.
          out pvalue: VARIANT):             // [out] Value to which the option is currently set.
                      HRESULT; stdcall;     // Return code.

      function OpenScopeOnITypeInfo(
          const pITI:  ITypeInfo;           // [in] ITypeInfo to open.
          dwOpenFlags: DWORD;               // [in] Open mode flags.
          const riid:  TIID;                // [in] The interface desired.
          out ppIUnk:  IUnknown):           // [out] Return interface on success.
                      HRESULT; stdcall;     // Return code.

      function GetCORSystemDirectory(
           // __out_ecount_part_opt(cchBuffer, *pchBuffer)
           szBuffer:   LPWSTR;              // [out] Buffer for the directory name
           cchBuffer:  DWORD;               // [in] Size of the buffer
           out pchBuffer: DWORD):           // [OUT] Number of characters returned
                      HRESULT; stdcall;     // Return code.

      function FindAssembly(
          szAppBase:  LPCWSTR;              // [IN] optional - can be NULL
          szPrivateBin: LPCWSTR;            // [IN] optional - can be NULL
          szGlobalBin: LPCWSTR;             // [IN] optional - can be NULL
          szAssemblyName: LPCWSTR;          // [IN] required - this is the assembly you are requesting
          szName:     LPCWSTR;              // [OUT] buffer - to hold name
          cchName:    ULONG;                // [IN] the name buffer's size
          out pcName: ULONG):               // [OUT] the number of characters returend in the buffer
                      HRESULT; stdcall;     // S_OK or error.

      function FindAssemblyModule(
          szAppBase:  LPCWSTR;              // [IN] optional - can be NULL
          szPrivateBin: LPCWSTR;            // [IN] optional - can be NULL
          szGlobalBin: LPCWSTR;             // [IN] optional - can be NULL
          szAssemblyName: LPCWSTR;          // [IN] required - this is the assembly you are requesting
          szModuleName: LPCWSTR;            // [IN] required - the name of the module
          // __out_ecount_part_opt(cchName, *pcName)
          szName:     LPWSTR;               // [OUT] buffer - to hold name
          cchName:    ULONG;                // [IN]  the name buffer's size
          out pcName: ULONG):               // [OUT] the number of characters returend in the buffer
                      HRESULT; stdcall;     // S_OK or error.

  end;
  {$EXTERNALSYM IMetaDataDispenserEx}

  //*****************************************************************************
  //*****************************************************************************
  //
  // Registration declarations.  Will be replace by Services' Registration
  //  implementation.
  //
  //*****************************************************************************
  //*****************************************************************************
  // Various flags for use in installing a module or a composite
  CorRegFlags = type DWORD;
  {$EXTERNALSYM CorRegFlags}
  TCorRegFlags = CorRegFlags;

const
  regNoCopy = CorRegFlags($00000001);         // Don't copy files into destination
  {$EXTERNALSYM regNoCopy}
  regConfig = CorRegFlags($00000002);         // Is a configuration
  {$EXTERNALSYM regConfig}
  regHasRefs = CorRegFlags($00000004);        // Has class references
  {$EXTERNALSYM regHasRefs}

type
  CVID = TGuid;
  {$EXTERNALSYM CVID}
  TCVID = CVID;

  CVStruct = record
      Major: SHORT;
      Minor: SHORT;
      Sub:   SHORT;
      Build: SHORT;
  end;
  {$EXTERNALSYM CVStruct}
  TCVStruct = CVStruct;

  //*****************************************************************************
  //*****************************************************************************
  //
  // CeeGen interfaces for generating in-memory Common Language Runtime files
  //
  //*****************************************************************************
  //*****************************************************************************

  HCEESECTION = Pointer;
  {$EXTERNALSYM HCEESECTION}

  CeeSectionAttr = (
      sdNone =        0,
      sdReadOnly =    Integer(IMAGE_SCN_MEM_READ or IMAGE_SCN_CNT_INITIALIZED_DATA),
      sdReadWrite =   sdReadOnly or Integer(IMAGE_SCN_MEM_WRITE),
      sdExecute =     IMAGE_SCN_MEM_READ or IMAGE_SCN_CNT_CODE or IMAGE_SCN_MEM_EXECUTE
  );
  {$EXTERNALSYM CeeSectionAttr}
  TCeeSectionAttr = CeeSectionAttr;

  //
  // Relocation types.
  //

  CeeSectionRelocType = (
      // generate only a section-relative reloc, nothing into .reloc section
      srRelocAbsolute,

      // generate a .reloc for a pointer sized location,
      // This is transformed into BASED_HIGHLOW or BASED_DIR64 based on the platform
      srRelocHighLow      = 3,

      // generate a .reloc for the top 16-bits of a 32 bit number, where the
      // bottom 16 bits are included in the next word in the .reloc table
      srRelocHighAdj,     // Never Used

      // generate a token map relocation, nothing into .reloc section
      srRelocMapToken,

      // relative address fixup
      srRelocRelative,

      // Generate only a section-relative reloc, nothing into .reloc
      // section.  This reloc is relative to the file position of the
      // section, not the section's virtual address.
      srRelocFilePos,

      // code relative address fixup
      srRelocCodeRelative,

      // generate a .reloc for a 64 bit address in an ia64 movl instruction
      srRelocIA64Imm64,

      // generate a .reloc for a 64 bit address
      srRelocDir64,

      // generate a .reloc for a 25-bit PC relative address in an ia64 br.call instruction
      srRelocIA64PcRel25,

      // generate a .reloc for a 64-bit PC relative address in an ia64 brl.call instruction
      srRelocIA64PcRel64,

      // generate a 30-bit section-relative reloc, used for tagged pointer values
      srRelocAbsoluteTagged,


      // A sentinel value to help ensure any additions to this enum are reflected
      // in PEWriter.cpp's RelocName array.
      srRelocSentinel,

      // Flags that can be used with the above reloc types

      // do not emit base reloc
      srNoBaseReloc = $4000,

      // pre-fixup contents of memory are ptr rather than a section offset
      srRelocPtr = $8000,

      // legal enums which include the Ptr flag
      srRelocAbsolutePtr  = srRelocPtr + srRelocAbsolute,
      srRelocHighLowPtr   = srRelocPtr + srRelocHighLow,
      srRelocRelativePtr  = srRelocPtr + srRelocRelative,
      srRelocIA64Imm64Ptr = srRelocPtr + srRelocIA64Imm64,
      srRelocDir64Ptr     = srRelocPtr + srRelocDir64
  );
  {$EXTERNALSYM CeeSectionRelocType}
  TCeeSectionRelocType = CeeSectionRelocType;

  CeeSectionRelocExtra = record
    highAdj: USHORT;
  end;
  {$EXTERNALSYM CeeSectionRelocExtra}
  TCeeSectionRelocExtra = CeeSectionRelocExtra;

  ICeeGen = interface(IUnknown)
    [IID_ICeeGen]
      function EmitString(
          // __in
          lpString:   LPWSTR;               // [IN] String to emit
          out RVA:    ULONG):               // [OUT] RVA for string emitted string
                      HRESULT; stdcall;

      function GetString(
          RVA:        ULONG;                // [IN] RVA for string to return
          // __out_opt
          out lpString: LPWSTR):            // [OUT] Returned string
                      HRESULT; stdcall;

      function AllocateMethodBuffer(
          cchBuffer:  ULONG;                // [IN] Length of buffer to create
          out lpBuffer: UCHAR;              // [OUT] Returned buffer
          out RVA: ULONG):                  // [OUT] RVA for method
                      HRESULT; stdcall;

      function GetMethodBuffer(
          RVA:        ULONG;                // [IN] RVA for method to return
          out lpBuffer: UCHAR):             // [OUT] Returned buffer
                      HRESULT; stdcall;

      function GetIMapTokenIface(
          out pIMapToken):
                      HRESULT; stdcall;

      function GenerateCeeFile: HRESULT; stdcall;

      function GetIlSection(
          out section: HCEESECTION):
                      HRESULT; stdcall;

      function GetStringSection(
          out section: HCEESECTION):
                      HRESULT; stdcall;

      function AddSectionReloc(
          section:    HCEESECTION;
          offset:     ULONG;
          relativeTo: HCEESECTION;
          relocType:  CeeSectionRelocType):
                      HRESULT; stdcall;

      // use these only if you have special section requirements not handled
      // by other APIs
      function GetSectionCreate(
          name: PAnsiChar;
          flags: DWORD;
          out section: HCEESECTION):
                      HRESULT; stdcall;

      function GetSectionDataLen(
          section: HCEESECTION;
          out dataLen: ULONG):
                      HRESULT; stdcall;

      function GetSectionBlock(
          section:    HCEESECTION;
          len:        ULONG;
          align:      ULONG = 1;
          ppBytes:    Pointer = nil):
                      HRESULT; stdcall;

      function TruncateSection(
          section:    HCEESECTION;
          len:        ULONG):
                      HRESULT; stdcall;

      function GenerateCeeMemoryImage(
          out ppImage: Pointer):
                      HRESULT; stdcall;

      function ComputePointer(
          section:    HCEESECTION;
          RVA:        ULONG;                // [IN] RVA for method to return
          out lpBuffer: UCHAR):             // [OUT] Returned buffer
                      HRESULT; stdcall;

  end;
  {$EXTERNALSYM ICeeGen}

  //*****************************************************************************
  //*****************************************************************************
  //
  // End of CeeGen declarations.
  //
  //*****************************************************************************

  //*****************************************************************************
  //*****************************************************************************
  //
  // CorModule interfaces for generating in-memory modules
  //
  //*****************************************************************************
  //*****************************************************************************

  ICorModuleInitializeFlags = (
      CORMODULE_MATCH             =   $00,   // find an existing module that matches interfaces supported
      CORMODULE_NEW               =   $01    // always create a new module and interfaces
  );
  {$EXTERNALSYM ICorModuleInitializeFlags}
  TICorModuleInitializeFlags = ICorModuleInitializeFlags;

  ICorModule = interface(IUnknown)
    [IID_ICorModule]
      function Initialize(
          flags:      DWORD;                // [IN] flags to control emitter returned
          const riidCeeGen: TIID;           // [IN] type of cee generator to initialize with
          const riidEmitter: TIID):         // [IN] type of emitter to initialize with
                      HRESULT; stdcall;

      function GetCeeGen(
          out pCeeGen: ICeeGen):            // [OUT] cee generator
                      HRESULT; stdcall;

      function GetMetaDataEmit(
          out pEmitter: IMetaDataEmit):     // [OUT] emitter
                      HRESULT; stdcall;
  end;
  {$EXTERNALSYM ICorModule}

  //*****************************************************************************
  //*****************************************************************************
  //
  // End of CorModule declarations.
  //
  //*****************************************************************************

  //**********************************************************************
  //**********************************************************************
  //--- IMetaDataTables
  //-------------------------------------
  // This API isn't big endian friendly since it indexes directly into the memory that
  // is stored in little endian format.

  IMetaDataTables = interface(IUnknown)
    [IID_IMetaDataTables]
      function GetStringHeapSize(
          out pcbStrings: ULONG):           // [OUT] Size of the string heap.
                      HRESULT; stdcall;

      function GetBlobHeapSize(
          out pcbBlobs: ULONG):             // [OUT] Size of the Blob heap.
                      HRESULT; stdcall;

      function GetGuidHeapSize(
          out pcbGuids: ULONG):             // [OUT] Size of the Guid heap.
                      HRESULT; stdcall;

      function GetUserStringHeapSize(
          out pcbBlobs: ULONG):             // [OUT] Size of the User String heap.
                      HRESULT; stdcall;

      function GetNumTables(
          out pcTables: ULONG):             // [OUT] Count of tables.
                      HRESULT; stdcall;

      function GetTableIndex(
          token:      ULONG;                // [IN] Token for which to get table index.
          out pixTbl: ULONG):               // [OUT] Put table index here.
                      HRESULT; stdcall;

      function GetTableInfo(
          ixTbl:      ULONG;                // [IN] Which table.
          out pcbRow: ULONG;                // [OUT] Size of a row, bytes.
          out pcRows: ULONG;                // [OUT] Number of rows.
          out pcCols: ULONG;                // [OUT] Number of columns in each row.
          out piKey:  ULONG;                // [OUT] Key column, or -1 if none.
          out ppName: LPCSTR):              // [OUT] Name of the table.
                      HRESULT; stdcall;

      function GetColumnInfo(
          ixTbl:      ULONG;                // [IN] Which Table
          ixCol:      ULONG;                // [IN] Which Column in the table
          out poCol:  ULONG;                // [OUT] Offset of the column in the row.
          out pcbCol: ULONG;                // [OUT] Size of a column, bytes.
          out pType:  ULONG;                // [OUT] Type of the column.
          out ppName: LPCSTR):              // [OUT] Name of the Column.
                      HRESULT; stdcall;

      function GetCodedTokenInfo(
          ixCdTkn:    ULONG;                // [IN] Which kind of coded token.
          out pcTokens: ULONG;              // [OUT] Count of tokens.
          out ppTokens: PULONG;             // [OUT] List of tokens.
          out ppName:  LPCSTR):             // [OUT] Name of the CodedToken.
                      HRESULT; stdcall;

      function GetRow(
          ixTbl:      ULONG;                // [IN] Which table.
          rid:        ULONG;                // [IN] Which row.
          out ppRow:  PVOID):               // [OUT] Put pointer to row here.
                      HRESULT; stdcall;

      function GetColumn(
          ixTbl:      ULONG;                // [IN] Which table.
          ixCol:      ULONG;                // [IN] Which column.
          rid:        ULONG;                // [IN] Which row.
          out pVal:   ULONG):               // [OUT] Put the column contents here.
                      HRESULT; stdcall;

      function GetString(
          ixString:   ULONG;                // [IN] Value from a string column.
          out ppString: LPCSTR):            // [OUT] Put a pointer to the string here.
                      HRESULT; stdcall;

      function GetBlob(
          ixBlob:     ULONG;                // [IN] Value from a blob column.
          out pcbData: ULONG;               // [OUT] Put size of the blob here.
          out ppData: PVOID):               // [OUT] Put a pointer to the blob here.
                      HRESULT; stdcall;

      function GetGuid(
          ixGuid:     ULONG;                // [IN] Value from a guid column.
          out ppGUID: PGuid):               // [OUT] Put a pointer to the GUID here.
                      HRESULT; stdcall;

      function GetUserString(
          ixUserString: ULONG;              // [IN] Value from a UserString column.
          out pcbData: ULONG;               // [OUT] Put size of the UserString here.
          out ppData: PVOID):               // [OUT] Put a pointer to the UserString here.
                      HRESULT; stdcall;

      function GetNextString(
          ixString:   ULONG;                // [IN] Value from a string column.
          out pNext:  ULONG):               // [OUT] Put the index of the next string here.
                      HRESULT; stdcall;

      function GetNextBlob(
          ixBlob:     ULONG;                // [IN] Value from a blob column.
          out pNext:  ULONG):               // [OUT] Put the index of the netxt blob here.
                      HRESULT; stdcall;

      function GetNextGuid(
          ixGuid:     ULONG;                // [IN] Value from a guid column.
          out pNext:  ULONG):               // [OUT] Put the index of the next guid here.
                      HRESULT; stdcall;

      function GetNextUserString(
          ixUserString: ULONG;              // [IN] Value from a UserString column.
          out pNext:  ULONG):               // [OUT] Put the index of the next user string here.
                      HRESULT; stdcall;

      // Interface is sealed.

  end;
  {$EXTERNALSYM IMetaDataTables}

  // This API isn't big endian friendly since it indexes directly into the memory that
  // is stored in little endian format.

  IMetaDataTables2 = interface(IMetaDataTables)
    [IID_IMetaDataTables2]
      function GetMetaDataStorage(          //@todo: name? - todo in sdk
          out ppvMd:  Pointer;              // [OUT] put pointer to MD section here (aka, 'BSJB').
          out pcbMd:  ULONG):               // [OUT] put size of the stream here.
                      HRESULT; stdcall;

      function GetMetaDataStreamInfo(       // Get info about the MD stream.
          ix:         ULONG;                // [IN] Stream ordinal desired.
          out ppchName: LPCSTR;             // [OUT] put pointer to stream name here.
          out ppv:    PVOID;                // [OUT] put pointer to MD stream here.
          out pcb:    ULONG):               // [OUT] put size of the stream here.
                      HRESULT; stdcall;

  end; // IMetaDataTables2
  {$EXTERNALSYM IMetaDataTables2}

function IsRidType(ix: ULONG): Boolean; inline;
{$EXTERNALSYM IsRidType}
function IsCodedTokenType(ix: ULONG): Boolean; inline;
{$EXTERNALSYM IsCodedTokenType}
function IsRidOrToken(ix: ULONG): Boolean; inline;
{$EXTERNALSYM IsRidOrToken}
function IsHeapType(ix: ULONG): Boolean; inline;
{$EXTERNALSYM IsHeapType}
function IsFixedType(ix: ULONG): Boolean; inline;
{$EXTERNALSYM IsFixedType}

type
  //**********************************************************************
  // End of IMetaDataTables.
  //**********************************************************************
  // Gets the dependancies of a native image. If these change, then
  // the native image cannot be used.
  //
  // IMetaDataImport::GetAssemblyRefProps() can be used to obtain information about
  // the mdAssemblyRefs.
  //*****************************************************************************

  CORCOMPILE_ASSEMBLY_SIGNATURE = record end;
  {$EXTERNALSYM CORCOMPILE_ASSEMBLY_SIGNATURE}
  CORCOMPILE_NGEN_SIGNATURE = TGuid;
  {$EXTERNALSYM CORCOMPILE_NGEN_SIGNATURE}

  INativeImageDependency = interface(IUnknown)
      // Get the referenced assembly
      function GetILAssemblyRef(
          out pAssemblyRef: mdAssemblyRef): // [OUT]
                      HRESULT; stdcall;

      // Get the post-policy assembly actually used
      function GetILAssemblyDef(
          out ppAssemblyDef: mdAssemblyRef; // [OUT]
          out pSign:  CORCOMPILE_ASSEMBLY_SIGNATURE): // [OUT]
                      HRESULT; stdcall;

      // Get the native image corresponding to GetILAssemblyDef() IF
      // there is a hard-bound (directly-referenced) native dependancy
      //
      // We do not need the configStrig because configStrings have to
      // be an exact part. Any partial matches are factored out into GetConfigMask()
      function GetNativeAssemblyDef(
          out pNativeSign: CORCOMPILE_NGEN_SIGNATURE): // [OUT] INVALID_NGEN_SIGNATURE if there is no hard-bound dependancy
                      HRESULT; stdcall;
  end;
  {$EXTERNALSYM INativeImageDependency}

  //*****************************************************************************
  //
  // Fusion uses IFusionNativeImageInfo to obtain (and cache) informaton
  // about a native image being installed into the native image cache.
  // This allows Fusion to bind directly to native images
  // without requiring (expensively) binding to the IL assembly first.
  //
  // IMetaDataAssemblyImport can be queried for this interface
  //
  //*****************************************************************************

  INativeImageInstallInfo = interface(IUnknown)
    [IID_INativeImageInstallInfo]
      // Signature of the ngen image
      // This matches the argument type of INativeImageDependency::GetNativeAssemblyDef

      function GetSignature(
          out pNgenSign: CORCOMPILE_NGEN_SIGNATURE): // [OUT]
                      HRESULT; stdcall;

      // Signature of the source IL assembly. This can be used to
      // verify that the IL image matches a candidate ngen image.
      // This matches the argument type of IAssemblyRuntimeSignature::CheckSignature
      //

      function GetILSignature(
          out pILSign: CORCOMPILE_ASSEMBLY_SIGNATURE): // [OUT]
                      HRESULT; stdcall;

      // Returns the equivalent of ISNAssemblySignature::GetSNAssemblySignature,
      // except for unsigned assemblies where the GetSNAssemblySignature will fail.
      // This can be used for matching the IL assembly in the GAC when the
      // native-image is generated/installed.
      //
      // Sets *pcbSig and returns ERROR_INSUFFICIENT_BUFFER for insufficient buffer.
      // Returns CORSEC_E_MISSING_STRONGNAME if the IL assembly is not strongly-named

      function GetILStrongSignature(
          pbSig:      PByte;                // [IN, OUT] Buffer to write signature
          pcbSig:     DWORD):               // [IN, OUT] Size of buffer, bytes written
                      HRESULT; stdcall;

      // Information about the contents/dependancies/assumptions of NativeImage
      // All of this information has to match for the current NativeImage to
      // be valid
      // Sets *pdwLength and returns ERROR_INSUFFICIENT_BUFFER for
      // insufficient szConfigString

      function GetConfigString(
          // __out_ecount_part_opt (*pdwLength, *pdwLength)
          szConfigString: LPWSTR;           // [OUT]
          //__inout
          var pdwLength: DWORD):            // [IN|OUT] - Number of WCHARs written including terminating NULL
                      HRESULT; stdcall;

      // A partial match is allowed for the current NativeImage to be valid

      function GetConfigMask(
          out pConfigMask: DWORD):         // [OUT]
                      HRESULT; stdcall;

      // Cache data that the CLR will need to determine if the NativeImage
      // can be used (after the GetConfigString checks are satisfied)
      // Sets *pdwBufferSize and returns ERROR_INSUFFICIENT_BUFFER for insufficient ppbBuffer

      function GetEvaluationDataToCache(
          ppbBuffer:  PByte;               // [OUT]
          var pdwBufferSize: DWORD):       // [IN|OUT] Total number of bytes written to *ppbBuffer
                      HRESULT; stdcall;

      //
      // Dependancy assemblies. The native image is only valid
      // if the dependancies have not changed.
      //

      function EnumDependencies(
          out phEnum: HCORENUM;            // [IN/OUT] - Pointer to the enum
          out rDeps: INativeImageDependency; // [OUT]
          cMax:       ULONG;               // [IN] Max dependancies to enumerate in this iteration
          out pdwCount: DWORD):            // [OUT] - Number of dependancies actually enumerated
                      HRESULT; stdcall;
  end;
  {$EXTERNALSYM INativeImageInstallInfo}

  //*****************************************************************************
  //
  // Runtime callback made by Fusion into the CLR to determine if the NativeAssembly
  // can be used. The pUnkBindSink argument of CAssemblyName::BindToObject() can
  // be queried for this interface
  //
  //*****************************************************************************

  IAssembly = interface(IUnknown)
  end;
  {$EXTERNALSYM IAssembly}

  INativeImageEvaluate = interface(IUnknown)
      // This will be called before the assemblies are actually loaded.
      //
      // Returns S_FALSE if the native-image cannot be used.

      function Evaluate(
          const pILAssembly: IAssembly;    // [IN] IL assembly in question
          const pNativeAssembly: IAssembly; // [IN] NGen image we are trying to use for pILAssembly
          pbCachedData: PByte;             // [IN] Data cached when the native-image was generated
          dwDataSize: DWORD):              // [IN] Size of the pbCachedData buffer
                      HRESULT; stdcall;
  end;
  {$EXTERNALSYM INativeImageEvaluate}

  //**********************************************************************

  //**********************************************************************
  //
  // Predefined CustomAttribute and structures for these custom value
  //
  //**********************************************************************

  CorNativeLinkType = (
      nltNone         = 1,    // none of the keywords are specified
      nltAnsi         = 2,    // ansi keyword specified
      nltUnicode      = 3,    // unicode keyword specified
      nltAuto         = 4,    // auto keyword specified
      nltOle          = 5,    // ole keyword specified
      nltMaxValue     = 7     // used so we can assert how many bits are required for this enum
  );
  {$EXTERNALSYM CorNativeLinkType}

  CorNativeLinkFlags = (
      nlfNone         = $00,     // no flags
      nlfLastError    = $01,     // setLastError keyword specified
      nlfNoMangle     = $02,     // nomangle keyword specified
      nlfMaxValue     = $03      // used so we can assert how many bits are required for this enum
  );
  {$EXTERNALSYM CorNativeLinkFlags}

  {$ALIGN 1}
  COR_NATIVE_LINK = record
      m_linkType: CorNativeLinkType; // see CorNativeLinkType above {below - from PSDK}
      m_flags:    CorNativeLinkFlags; // see CorNativeLinkFlags above {below - from PSDK}
      m_entryPoint: mdMemberRef; // member ref token giving entry point, format is lib:entrypoint
  end;
  {$EXTERNALSYM COR_NATIVE_LINK}
  {$ALIGN 8}

//*****************************************************************************
//*****************************************************************************
//
// I L   &   F I L E   F O R M A T   D E C L A R A T I O N S
//
//*****************************************************************************
//*****************************************************************************

// <STRIP>The following definitions will get moved into <windows.h> by RTM but are
// kept here for the Alpha's and Beta's.</STRIP>
//#ifndef _WINDOWS_UPDATES_
//#include <corhdr.h>
//#endif // <windows.h> updates

//*****************************************************************************
//*****************************************************************************
//
// D L L   P U B L I C   E N T R Y    P O I N T   D E C L A R A T I O N S
//
//*****************************************************************************
//*****************************************************************************

function _CorDllMain(hInst: HINST; dwReason: DWORD; lpReserved: LPVOID): BOOL; stdcall;
{$EXTERNALSYM _CorDllMain}
function _CorExeMain: Integer; stdcall;
{$EXTERNALSYM _CorExeMain}
function _CorExeMain2(
    pUnmappedPE:    PByte;              // -> memory mapped code
    cUnmappedPE:    DWORD;              // Size of memory mapped code
    pImageNameIn:   LPWSTR;             // -> Executable Name
    pLoadersFileName: LPWSTR;           // -> Loaders Name
    pCmdLine:       LPWSTR):            // -> Command Line
            Integer; stdcall;           // Executable exit code.
{$EXTERNALSYM _CorExeMain2}

function _CorValidateImage(var ImageBase: PVOID; FileName: LPCWSTR): HRESULT; stdcall;
{$EXTERNALSYM _CorValidateImage}
procedure _CorImageUnloading(ImageBase: PVOID); stdcall;
{$EXTERNALSYM _CorImageUnloading}

function CoInitializeEE(fFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM CoInitializeEE}
procedure CoUninitializeEE(fFlags: BOOL); stdcall;
{$EXTERNALSYM CoUninitializeEE}
procedure CoEEShutDownCOM; stdcall;
{$EXTERNALSYM CoEEShutDownCOM}

//*****************************************************************************
//*****************************************************************************
//
// D L L   P U B L I C   E N T R Y    P O I N T   D E C L A R A T I O N S
//
//*****************************************************************************
//*****************************************************************************

function        CoInitializeCor(fFlags: DWORD): HRESULT; stdcall;
{$EXTERNALSYM CoInitializeCor}
procedure       CoUninitializeCor; stdcall;
{$EXTERNALSYM CoUninitializeCor}

type
  TDestructorCallback = procedure (Param: PExceptionRecord); stdcall;
  {$EXTERNALSYM TDestructorCallback}

procedure AddDestructorCallback(code: Integer; callback: TDestructorCallback); stdcall;
{$EXTERNALSYM AddDestructorCallback}

//*****************************************************************************
//*****************************************************************************
//
// C O M +   s i g n a t u r e   s u p p o r t
//
//*****************************************************************************
//*****************************************************************************

const
  g_tkCorEncodeToken: array[0..3] of mdToken = (mdtTypeDef, mdtTypeRef, mdtTypeSpec, mdtBaseType);
  {$EXTERNALSYM g_tkCorEncodeToken}


  SIGN_MASK_ONEBYTE  = $ffffffc0;        // Mask the same size as the missing bits.
  {$EXTERNALSYM SIGN_MASK_ONEBYTE}
  SIGN_MASK_TWOBYTE  = $ffffe000;        // Mask the same size as the missing bits.
  {$EXTERNALSYM SIGN_MASK_TWOBYTE}
  SIGN_MASK_FOURBYTE = $f0000000;        // Mask the same size as the missing bits.
  {$EXTERNALSYM SIGN_MASK_FOURBYTE}

// return true if it is a primitive type, i.e. only need to store CorElementType
function CorIsPrimitiveType(elementtype: CorElementType): Boolean; inline;
{$EXTERNALSYM CorIsPrimitiveType}

// Return true if element type is a modifier, i.e. ELEMENT_TYPE_MODIFIER bits are
// turned on. For now, it is checking for ELEMENT_TYPE_PTR and ELEMENT_TYPE_BYREF
// as well. This will be removed when we turn on ELEMENT_TYPE_MODIFIER bits for
// these two enum members.
//
function CorIsModifierElementType(elementtype: CorElementType): Boolean; inline;
{$EXTERNALSYM CorIsModifierElementType}

// Given a compress byte (*pData), return the size of the uncompressed data.
function CorSigUncompressedDataSize(pData: PCCOR_SIGNATURE): ULONG; inline;
{$EXTERNALSYM CorSigUncompressedDataSize}

/////////////////////////////////////////////////////////////////////////////////////////////
//
// Given a compressed integer(*pData), expand the compressed int to *pDataOut.
// Return value is the number of bytes that the integer occupies in the compressed format
// It is caller's responsibility to ensure pDataOut has at least 4 bytes to be written to.
//
// This function returns -1 if pass in with an incorrectly compressed data, such as
// (*pBytes & 0xE0) == 0XE0.
/////////////////////////////////////////////////////////////////////////////////////////////
function CorSigUncompressBigData(var pData: PCCOR_SIGNATURE): ULONG; inline;          // [IN,OUT] compressed data
{$EXTERNALSYM CorSigUncompressBigData}

function CorSigUncompressData(var pData: PCCOR_SIGNATURE): ULONG; overload; inline;   // [IN,OUT] compressed data
{$EXTERNALSYM CorSigUncompressData}

function CorSigUncompressData(
    pData:      PCCOR_SIGNATURE;     // [IN] compressed data
    len:        DWORD;               // [IN] length of the signature
    var pDataOut: ULONG;             // [OUT] the expanded *pData
    out pDataLen: ULONG):            // [OUT] length of the expanded *pData
                 HRESULT; overload; inline;  // return S_OK or E_BADIMAGEFORMAT if the signature is bad
{$EXTERNALSYM CorSigUncompressData}

function CorSigUncompressData(
    pData:   PCCOR_SIGNATURE;              // [IN] compressed data
    out pDataOut: ULONG):                  // [OUT] the expanded *pData
             ULONG; overload; inline;      // return number of bytes of that compressed data occupied in pData
{$EXTERNALSYM CorSigUncompressData}

// uncompress a token
function CorSigUncompressToken(var pData: PCCOR_SIGNATURE): // [IN,OUT] compressed data
   mdToken; overload; inline;             // return the token.
{$EXTERNALSYM CorSigUncompressToken}

function CorSigUncompressToken(
    pData:   PCCOR_SIGNATURE;           // [IN] compressed data
    out pToken: mdToken):               // [OUT] the expanded *pData
             ULONG; overload; inline;   // return number of bytes of that compressed data occupied in pData
{$EXTERNALSYM CorSigUncompressToken}

function CorSigUncompressToken(
    pData:   PCCOR_SIGNATURE;           // [IN] compressed data
    dwLen:   DWORD;                     // [IN] Remaining length of sigature
    out pToken: mdToken;                // [OUT] the expanded *pData
    out dwTokenLength: DWORD):          // [OUT] The length of the token in the sigature
             HRESULT; overload; inline;
{$EXTERNALSYM CorSigUncompressToken}

function CorSigUncompressCallingConv(
    var pData:  PCCOR_SIGNATURE):       // [IN,OUT] compressed data
                ULONG; overload; inline;
{$EXTERNALSYM CorSigUncompressCallingConv}

function CorSigUncompressCallingConv(
    pData:      PCCOR_SIGNATURE;        // [IN] Signature
    dwLen:      DWORD;                  // [IN] Length of signature
    out data:   ULONG):                 // [OUT] compressed data
             HRESULT; overload; inline;
{$EXTERNALSYM CorSigUncompressCallingConv}

// uncompress a signed integer
function CorSigUncompressSignedInt(
    pData:   PCCOR_SIGNATURE;           // [IN] compressed data
    out pInt: Integer):                 // [OUT] the expanded *pInt
             ULONG; inline;             // return number of bytes of that compressed data occupied in pData
{$EXTERNALSYM CorSigUncompressSignedInt}

// uncompress encoded element type
function CorSigUncompressElementType(
    var pData: PCCOR_SIGNATURE):         // [IN,OUT] compressed data
           CorElementType; overload; inline;    //Element type
{$EXTERNALSYM CorSigUncompressElementType}

function CorSigUncompressElementType(
    pData: PCCOR_SIGNATURE;              // [IN] compressed data
    out pElementType: CorElementType):   // [OUT] the expanded *pData
           ULONG; overload; inline;      // return number of bytes of that compressed data occupied in pData
{$EXTERNALSYM CorSigUncompressElementType}

/////////////////////////////////////////////////////////////////////////////////////////////
//
// Given an uncompressed unsigned integer (iLen), Store it to pDataOut in a compressed format.
// Return value is the number of bytes that the integer occupies in the compressed format.
// It is caller's responsibilityt to ensure *pDataOut has at least 4 bytes to write to.
//
// Note that this function returns -1 if iLen is too big to be compressed. We currently can
// only represent to 0x1FFFFFFF.
//
/////////////////////////////////////////////////////////////////////////////////////////////
function CorSigCompressData(
    iLen:   ULONG;                  // [IN] given uncompressed data
    pDataOut: Pointer):             // [OUT] buffer where iLen will be compressed and stored.
            ULONG; inline;          // return number of bytes that compressed form of iLen will take
{$EXTERNALSYM CorSigCompressData}

// compress a token
// The least significant bit of the first compress byte will indicate the token type.
//
function CorSigCompressToken(
    tk:     mdToken;                // [IN] given token
    pDataOut: Pointer):             // [OUT] buffer where iLen will be compressed and stored.
            ULONG; inline;          // return number of bytes that compressed form of iLen will take
{$EXTERNALSYM CorSigCompressToken}

// compress a signed integer
// The least significant bit of the first compress byte will be the signed bit.
//
function CorSigCompressSignedInt(
    iData:  Integer;                // [IN] given integer
    pDataOut: Pointer):             // [OUT] buffer where iLen will be compressed and stored.
            ULONG; inline;          // return number of bytes that compressed form of iData will take
{$EXTERNALSYM CorSigCompressSignedInt}

// uncompress encoded element type
function CorSigCompressElementType(
    et:     CorElementType;         // [OUT] the expanded *pData
    pData:  Pointer):               // [IN] compressed data
            ULONG; inline;          // return number of bytes of that compressed data occupied in pData
{$EXTERNALSYM CorSigCompressElementType}

// Compress a pointer (used for internal element types only, never for persisted
// signatures).
function CorSigCompressPointer(
    pvPointer: Pointer;             // [IN] given uncompressed data
    pData:  Pointer):               // [OUT] buffer where iLen will be compressed and stored.
            ULONG; inline;          // return number of bytes of that compressed data occupied
{$EXTERNALSYM CorSigCompressPointer}

// Uncompress a pointer (see above for comments).
function CorSigUncompressPointer(
    pData:  PCCOR_SIGNATURE;        // [IN] compressed data
    out ppvPointer: Pointer):       // [OUT] the expanded *pData
            ULONG; inline;          // return number of bytes of that compressed data occupied
{$EXTERNALSYM CorSigUncompressPointer}

const
  mscoree = 'mscoree.dll';
  {$NODEFINE mscoree}

implementation

function IsRidType(ix: ULONG): Boolean;
begin
  Result := ix <= iRidMax;
end;

function IsCodedTokenType(ix: ULONG): Boolean;
begin
  Result := (ix >= iCodedToken) and (ix <= iCodedTokenMax);
end;

function IsRidOrToken(ix: ULONG): Boolean;
begin
  Result := ix <= iCodedTokenMax;
end;

function IsHeapType(ix: ULONG): Boolean;
begin
  Result := ix >= iSTRING;
end;

function IsFixedType(ix: ULONG): Boolean;
begin
  Result := (ix < iSTRING) and (ix > iCodedTokenMax);
end;

// return true if it is a primitive type, i.e. only need to store CorElementType
function CorIsPrimitiveType(elementtype: CorElementType): Boolean;
begin
  Result := (elementtype < ELEMENT_TYPE_PTR) or (elementtype = ELEMENT_TYPE_I) or (elementtype = ELEMENT_TYPE_U);
end;

// Return true if element type is a modifier, i.e. ELEMENT_TYPE_MODIFIER bits are
// turned on. For now, it is checking for ELEMENT_TYPE_PTR and ELEMENT_TYPE_BYREF
// as well. This will be removed when we turn on ELEMENT_TYPE_MODIFIER bits for
// these two enum members.
//
function CorIsModifierElementType(elementtype: CorElementType): Boolean;
begin
  if (elementtype = ELEMENT_TYPE_PTR) or (elementtype = ELEMENT_TYPE_BYREF) then
      Exit(True);
  Result := (elementtype and ELEMENT_TYPE_MODIFIER) <> 0;
end;

// Given a compress byte (*pData), return the size of the uncompressed data.
function CorSigUncompressedDataSize(pData: PCCOR_SIGNATURE): ULONG;
begin
  if (pData^ and $80) = 0 then
    Result := 1
  else if (pData^ and $C0) = $80 then
    Result := 2
  else
    Result := 4;
end;

/////////////////////////////////////////////////////////////////////////////////////////////
//
// Given a compressed integer(*pData), expand the compressed int to *pDataOut.
// Return value is the number of bytes that the integer occupies in the compressed format
// It is caller's responsibility to ensure pDataOut has at least 4 bytes to be written to.
//
// This function returns -1 if pass in with an incorrectly compressed data, such as
// (*pBytes & 0xE0) == 0XE0.
/////////////////////////////////////////////////////////////////////////////////////////////
function CorSigUncompressBigData(var pData: PCCOR_SIGNATURE): ULONG;             // [IN,OUT] compressed data
begin

  // 1 byte data is handled in CorSigUncompressData
  //  _ASSERTE(*pData & 0x80);

  // Medium.
  if (pData^ and $C0) = $80 then  // 10?? ????
  begin
    Result := ULONG((pData^ and $3f) shl 8); Inc(pData);
    Result := Result or pData^; Inc(pData);
  end else // 110? ????
  begin
    Result := ULONG((pData^ and $1f) shl 24); Inc(pData);
    Result := Result or (pData^ shl 16); Inc(pData);
    Result := Result or (pData^ shl 8); Inc(pData);
    Result := REsult or (pData^); Inc(pData);
  end;
end;

function CorSigUncompressData(var pData: PCCOR_SIGNATURE): ULONG; overload;             // [IN,OUT] compressed data
begin
  // Handle smallest data inline.
  if (pData^ and $80) = $00 then        // 0??? ????
  begin
    Result := pData^; Inc(pData);
    Exit;
  end;
  Result := CorSigUncompressBigData(pData);
end;

function CorSigUncompressData(
    pData:      PCCOR_SIGNATURE;     // [IN] compressed data
    len:        DWORD;               // [IN] length of the signature
    var pDataOut: ULONG;             // [OUT] the expanded *pData
    out pDataLen: ULONG):            // [OUT] length of the expanded *pData
                 HRESULT; overload;  // return S_OK or E_BADIMAGEFORMAT if the signature is bad
var
  pBytes: PByte;
begin
  Result := S_OK;
  pBytes := PByte(pData);

  // Smallest.
  if (pBytes^ and $80) = $00 then       // 0??? ????
  begin
    if len < 1 then
      Result := META_E_BAD_SIGNATURE
    else
    begin
      pDataOut := pBytes^;
      pDataLen := 1;
    end;
  end
  // Medium.
  else if (pBytes^ and $C0) = $80 then  // 10?? ????
  begin
    if len < 2 then
      Result := META_E_BAD_SIGNATURE
    else
    begin
      pDataOut := ULONG(((pBytes[0] and $3f) shl 8) or pBytes[1]);
      pDataLen := 2;
    end;
  end
  else if (pBytes^ and $E0) = $C0 then      // 110? ????
  begin
    if len < 4 then
      Result := META_E_BAD_SIGNATURE
    else
      pDataOut := ULONG(((pBytes[0] and $1f) shl 24) or (pBytes[1] shl 16) or (pBytes[2] shl 8) or pBytes[3]);
      pDataLen := 4;
  end
  else // We don't recognize this encoding
    Result := META_E_BAD_SIGNATURE;
end;

function CorSigUncompressData(
    pData:   PCCOR_SIGNATURE;              // [IN] compressed data
    out pDataOut: ULONG):                  // [OUT] the expanded *pData
             ULONG; overload;              // return number of bytes of that compressed data occupied in pData
begin
  Result := 0;

  // We don't know how big the signature is, so we'll just say that it's big enough
  if FAILED(CorSigUncompressData(pData, $ff, pDataOut, Result)) then
    Exit (ULONG(-1));
end;

// uncompress a token
function CorSigUncompressToken(var pData: PCCOR_SIGNATURE): // [IN,OUT] compressed data
   mdToken; overload;                                       // return the token.
var
  tkType: mdToken;
begin
  Result := CorSigUncompressData(pData);
  tkType := g_tkCorEncodeToken[Result and $3];
  Result := TokenFromRid(Result shr 2, tkType);
end;

function CorSigUncompressToken(
    pData:   PCCOR_SIGNATURE;           // [IN] compressed data
    out pToken: mdToken):               // [OUT] the expanded *pData
             ULONG; overload;           // return number of bytes of that compressed data occupied in pData
var
  tk, tkType: mdToken;
begin
  Result := CorSigUncompressData(pData, ULONG(tk));
  tkType := g_tkCorEncodeToken[tk and $3];
  tk := TokenFromRid(tk shr 2, tkType);
  pToken := tk;
end;

function CorSigUncompressToken(
    pData:   PCCOR_SIGNATURE;           // [IN] compressed data
    dwLen:   DWORD;                     // [IN] Remaining length of sigature
    out pToken: mdToken;                // [OUT] the expanded *pData
    out dwTokenLength: DWORD):          // [OUT] The length of the token in the sigature
             HRESULT; overload;
var
  tk, tkType: mdToken;
begin
  Result := CorSigUncompressData(pData, dwLen, ULONG(tk), dwTokenLength);
  if SUCCEEDED(Result) then
  begin
    tkType := g_tkCorEncodeToken[tk and $3];
    tk := TokenFromRid(tk shr 2, tkType);
    pToken := tk;
  end;
end;

function CorSigUncompressCallingConv(
    var pData:  PCCOR_SIGNATURE):       // [IN,OUT] compressed data
                ULONG; overload;
begin
  Result := pData^; Inc(pData);
end;

function CorSigUncompressCallingConv(
    pData:      PCCOR_SIGNATURE;        // [IN] Signature
    dwLen:      DWORD;                  // [IN] Length of signature
    out data:   ULONG):                 // [OUT] compressed data
             HRESULT; overload;
begin
  if dwLen > 0 then
  begin
    data := pData^;
    Result := S_OK;
  end else
    Result := META_E_BAD_SIGNATURE;
end;

// uncompress a signed integer
function CorSigUncompressSignedInt(
    pData:   PCCOR_SIGNATURE;           // [IN] compressed data
    out pInt: Integer):                 // [OUT] the expanded *pInt
             ULONG;                     // return number of bytes of that compressed data occupied in pData
var
  ulSigned, iData: ULONG;
begin
  Result := CorSigUncompressData(pData, iData);
  if Result = ULONG(-1) then
    Exit;
  ulSigned := iData and $1;
  iData := iData shr 1;
  if ulSigned <> 0 then
  begin
    if Result = 1 then
      iData := iData or SIGN_MASK_ONEBYTE
    else if Result = 2 then
      iData := iData or SIGN_MASK_TWOBYTE
    else
      iData := iData or SIGN_MASK_FOURBYTE;
  end;
  pInt := Integer(iData);
end;

// uncompress encoded element type
function CorSigUncompressElementType(
    var pData: PCCOR_SIGNATURE):         // [IN,OUT] compressed data
           CorElementType; overload;     //Element type
begin
  Result := CorElementType(pData^); Inc(pData);
end;

function CorSigUncompressElementType(
    pData: PCCOR_SIGNATURE;              // [IN] compressed data
    out pElementType: CorElementType):   // [OUT] the expanded *pData
           ULONG; overload;              // return number of bytes of that compressed data occupied in pData
begin
  pElementType := CorElementType(pData^ and $7f);
  Result := 1;
end;

/////////////////////////////////////////////////////////////////////////////////////////////
//
// Given an uncompressed unsigned integer (iLen), Store it to pDataOut in a compressed format.
// Return value is the number of bytes that the integer occupies in the compressed format.
// It is caller's responsibilityt to ensure *pDataOut has at least 4 bytes to write to.
//
// Note that this function returns -1 if iLen is too big to be compressed. We currently can
// only represent to 0x1FFFFFFF.
//
/////////////////////////////////////////////////////////////////////////////////////////////
function CorSigCompressData(
    iLen:   ULONG;                  // [IN] given uncompressed data
    pDataOut: Pointer):             // [OUT] buffer where iLen will be compressed and stored.
            ULONG;                  // return number of bytes that compressed form of iLen will take
var
  pBytes: PByte;
begin
  pBytes := pDataOut;

  if iLen <= $7F then
  begin
    pBytes[0] := BYTE(iLen);
    Exit(1);
  end;

  if iLen <= $3FFF then
  begin
    pBytes[0] := BYTE((iLen shr 8) or $80);
    pBytes[1] := BYTE(iLen and $ff);
    Exit(2);
  end;

  if iLen <= $1FFFFFFF then
  begin
    pBytes[0] := BYTE((iLen shr 24) or $C0);
    pBytes[1] := BYTE((iLen shr 16) and $ff);
    pBytes[2] := BYTE((iLen shr 8)  and $ff);
    pBytes[3] := BYTE(iLen and $ff);
    Exit(4);
  end;
  Result := ULONG(-1);
end;

// compress a token
// The least significant bit of the first compress byte will indicate the token type.
//
function CorSigCompressToken(
    tk:     mdToken;                // [IN] given token
    pDataOut: Pointer):             // [OUT] buffer where iLen will be compressed and stored.
            ULONG;                  // return number of bytes that compressed form of iLen will take
var
  lRid: RID;
  ulType: ULONG32;
begin
  lRid := RidFromToken(tk);
  ulType := TypeFromToken(tk);

  if lRid > $3FFFFFF then
    // token is too big to be compressed
    Exit(ULONG(-1));

  lRid := lRid shl 2;

  // TypeDef is encoded with low bits 00
  // TypeRef is encoded with low bits 01
  // TypeSpec is encoded with low bits 10
  // BaseType is encoded with low bit 11
  //
  if ulType = g_tkCorEncodeToken[1] then
    // make the last two bits 01
    lRid := lRid or $1
  else if ulType = g_tkCorEncodeToken[2] then
    // make last two bits 0
    lRid := lRid or $2
  else if ulType = g_tkCorEncodeToken[3] then
    lRid := lRid or $3;
  Result := CorSigCompressData(ULONG(lRid), pDataOut);
end;

// compress a signed integer
// The least significant bit of the first compress byte will be the signed bit.
//
function CorSigCompressSignedInt(
    iData:  Integer;                // [IN] given integer
    pDataOut: Pointer):             // [OUT] buffer where iLen will be compressed and stored.
            ULONG;                  // return number of bytes that compressed form of iData will take
var
  isSigned: ULONG;
begin
  isSigned := 0;

  if iData < 0 then
    isSigned := $1;

  if (iData and SIGN_MASK_ONEBYTE = 0) or (iData and SIGN_MASK_ONEBYTE = SIGN_MASK_ONEBYTE) then
    iData := iData and not SIGN_MASK_ONEBYTE
  else if (iData and SIGN_MASK_TWOBYTE = 0) or (iData and SIGN_MASK_TWOBYTE = SIGN_MASK_TWOBYTE) then
    iData := iData and not SIGN_MASK_TWOBYTE
  else if (iData and SIGN_MASK_FOURBYTE = 0) or (iData and SIGN_MASK_FOURBYTE = SIGN_MASK_FOURBYTE) then
    iData := iData and not SIGN_MASK_FOURBYTE
  else
    // out of compressable range
    Exit(ULONG(-1));
  iData := Integer((iData shl 1) or Integer(isSigned));
  Result := CorSigCompressData(ULONG(iData), pDataOut);
end;

// uncompress encoded element type
function CorSigCompressElementType(
    et:     CorElementType;         // [OUT] the expanded *pData
    pData:  Pointer):               // [IN] compressed data
            ULONG;                  // return number of bytes of that compressed data occupied in pData
begin
  PByte(pData)[0] := BYTE(et);
  Result := 1;
end;

// Compress a pointer (used for internal element types only, never for persisted
// signatures).
function CorSigCompressPointer(
    pvPointer: Pointer;             // [IN] given uncompressed data
    pData:  Pointer):               // [OUT] buffer where iLen will be compressed and stored.
            ULONG;                  // return number of bytes of that compressed data occupied
begin
  PPointer(pData)^ := pvPointer;
  Result := SizeOf(Pointer);
end;

// Uncompress a pointer (see above for comments).
function CorSigUncompressPointer(
    pData:  PCCOR_SIGNATURE;        // [IN] compressed data
    out ppvPointer: Pointer):       // [OUT] the expanded *pData
            ULONG;                  // return number of bytes of that compressed data occupied
begin
  ppvPointer := pData;
  Result := SizeOf(Pointer);
end;

function _CorDllMain; external mscoree name '_CorDllMain';
function _CorExeMain; external mscoree name '_CorExeMain';
function _CorExeMain2; external mscoree name '_CorExeMain2';
function _CorValidateImage; external mscoree name '_CorValidateImage';
procedure _CorImageUnloading; external mscoree name '_CorImageUnloading';

function CoInitializeEE; external mscoree name 'CoInitializeEE';
procedure CoUninitializeEE; external mscoree name 'CoUninitializeEE';
procedure CoEEShutDownCOM; external mscoree name 'CoEEShutDownCOM';
function  CoInitializeCor; external mscoree name 'CoInitializeCor';
procedure CoUninitializeCor; external mscoree name 'CoUninitializeCor';

procedure AddDestructorCallback; external mscoree name 'AddDestructorCallback';

end.

// EOF =======================================================================
