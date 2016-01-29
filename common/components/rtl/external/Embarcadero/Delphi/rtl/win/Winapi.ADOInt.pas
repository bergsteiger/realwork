{*******************************************************}
{                                                       }
{          CodeGear Delphi Runtime Library              }
{                                                       }
{          File: adoint.pas                             }
{          Copyright (c) Microsoft Corporation          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{       ADO Interface Unit                              }
{*******************************************************}

unit Winapi.ADOInt;

// ************************************************************************  //
// Type Lib: C:\Program Files\Common Files\System\ado\msado15.dll (1)
// LIBID: {2A75196C-D9EB-4129-B803-931327F72D5C}
// LCID: 0
// Helpfile: C:\WINDOWS\help\ado270.chm
// HelpString: Microsoft ActiveX Data Objects 2.8 Library
// DepndLst:
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
// Errors:
//   Hint: TypeInfo 'Property' changed to 'Property_'
//   Hint: TypeInfo 'Record' changed to 'Record_'
//   Hint: Parameter 'Object' of _DynaCollection.Append changed to 'Object_'
//   Hint: Member 'Type' of 'Property' changed to 'Type_'
//   Hint: Parameter 'Type' of Command15.CreateParameter changed to 'Type_'
//   Hint: Parameter 'Type' of Fields.Append changed to 'Type_'
//   Hint: Parameter 'Type' of Fields20._Append changed to 'Type_'
//   Hint: Member 'Type' of 'Field20' changed to 'Type_'
//   Hint: Member 'Type' of '_Parameter' changed to 'Type_'
//   Hint: Member 'Type' of '_Stream' changed to 'Type_'
//   Hint: Member 'Type' of 'Field15' changed to 'Type_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$IFDEF WIN64}
{$ALIGN 8}
{$ELSE}
{$ALIGN 4}
{$ENDIF}
{$MINENUMSIZE 4}
{$DEFINE CG_EDITS} // Code in these blocks are hand edited from imported .tlb file by CodeGear.

interface

uses Winapi.Windows, Winapi.ActiveX;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ADODBMajorVersion = 2;
  ADODBMinorVersion = 8;

  LIBID_ADODB: TGUID = '{2A75196C-D9EB-4129-B803-931327F72D5C}';

  IID__Collection: TGUID = '{00000512-0000-0010-8000-00AA006D2EA4}';
  IID__DynaCollection: TGUID = '{00000513-0000-0010-8000-00AA006D2EA4}';
  IID__ADO: TGUID = '{00000534-0000-0010-8000-00AA006D2EA4}';
  IID_Properties: TGUID = '{00000504-0000-0010-8000-00AA006D2EA4}';
  IID_Property_: TGUID = '{00000503-0000-0010-8000-00AA006D2EA4}';
  IID_Error: TGUID = '{00000500-0000-0010-8000-00AA006D2EA4}';
  IID_Errors: TGUID = '{00000501-0000-0010-8000-00AA006D2EA4}';
  IID_Command15: TGUID = '{00000508-0000-0010-8000-00AA006D2EA4}';
  IID_Connection15: TGUID = '{00000515-0000-0010-8000-00AA006D2EA4}';
  IID__Connection: TGUID = '{00000550-0000-0010-8000-00AA006D2EA4}';
  IID_Recordset15: TGUID = '{0000050E-0000-0010-8000-00AA006D2EA4}';
  IID_Recordset20: TGUID = '{0000054F-0000-0010-8000-00AA006D2EA4}';
  IID_Recordset21: TGUID = '{00000555-0000-0010-8000-00AA006D2EA4}';
  IID__Recordset: TGUID = '{00000556-0000-0010-8000-00AA006D2EA4}';
  IID_Fields15: TGUID = '{00000506-0000-0010-8000-00AA006D2EA4}';
  IID_Fields20: TGUID = '{0000054D-0000-0010-8000-00AA006D2EA4}';
  IID_Fields: TGUID = '{00000564-0000-0010-8000-00AA006D2EA4}';
  IID_Field20: TGUID = '{0000054C-0000-0010-8000-00AA006D2EA4}';
  IID_Field: TGUID = '{00000569-0000-0010-8000-00AA006D2EA4}';
  IID__Parameter: TGUID = '{0000050C-0000-0010-8000-00AA006D2EA4}';
  IID_Parameters: TGUID = '{0000050D-0000-0010-8000-00AA006D2EA4}';
  IID_Command25: TGUID = '{0000054E-0000-0010-8000-00AA006D2EA4}';
  IID__Command: TGUID = '{B08400BD-F9D1-4D02-B856-71D5DBA123E9}';
  IID_ConnectionEventsVt: TGUID = '{00000402-0000-0010-8000-00AA006D2EA4}';
  IID_RecordsetEventsVt: TGUID = '{00000403-0000-0010-8000-00AA006D2EA4}';
  DIID_ConnectionEvents: TGUID = '{00000400-0000-0010-8000-00AA006D2EA4}';
  DIID_RecordsetEvents: TGUID = '{00000266-0000-0010-8000-00AA006D2EA4}';
  IID_ADOConnectionConstruction15: TGUID = '{00000516-0000-0010-8000-00AA006D2EA4}';
  IID_ADOConnectionConstruction: TGUID = '{00000551-0000-0010-8000-00AA006D2EA4}';
  CLASS_Connection: TGUID = '{00000514-0000-0010-8000-00AA006D2EA4}';
  IID__Record: TGUID = '{00000562-0000-0010-8000-00AA006D2EA4}';
  CLASS_Record_: TGUID = '{00000560-0000-0010-8000-00AA006D2EA4}';
  IID__Stream: TGUID = '{00000565-0000-0010-8000-00AA006D2EA4}';
  CLASS_Stream: TGUID = '{00000566-0000-0010-8000-00AA006D2EA4}';
  IID_ADORecordConstruction: TGUID = '{00000567-0000-0010-8000-00AA006D2EA4}';
  IID_ADOStreamConstruction: TGUID = '{00000568-0000-0010-8000-00AA006D2EA4}';
  IID_ADOCommandConstruction: TGUID = '{00000517-0000-0010-8000-00AA006D2EA4}';
  CLASS_Command: TGUID = '{00000507-0000-0010-8000-00AA006D2EA4}';
  CLASS_Recordset: TGUID = '{00000535-0000-0010-8000-00AA006D2EA4}';
  IID_ADORecordsetConstruction: TGUID = '{00000283-0000-0010-8000-00AA006D2EA4}';
  IID_Field15: TGUID = '{00000505-0000-0010-8000-00AA006D2EA4}';
  CLASS_Parameter: TGUID = '{0000050B-0000-0010-8000-00AA006D2EA4}';

{$IFDEF CG_EDITS}
  CLASS_DataSpace: TGUID = '{BD96C556-65A3-11D0-983A-00C04FC29E36}';
  CLASS_DataFactory: TGUID = '{9381D8F5-0288-11D0-9501-00AA00B911A5}';
  IID_IDataspace: TGUID = '{BD96C556-65A3-11D0-983A-00C04FC29E34}';

// *********************************************************************//
// Misc. Constants (not from Type Library)                              //
// *********************************************************************//

// ConnectionString Tags
const
  CT_USERID = 'USER ID=';     { Do not localize }
  CT_PROVIDER = 'PROVIDER=';  { Do not localize }
  CT_FILENAME = 'FILE NAME='; { Do not localize }

{$ENDIF}

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum CursorTypeEnum
type
  CursorTypeEnum = TOleEnum;
  {$EXTERNALSYM CursorTypeEnum}
const
  adOpenUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adOpenUnspecified}
  adOpenForwardOnly = $00000000;
  {$EXTERNALSYM adOpenForwardOnly}
  adOpenKeyset = $00000001;
  {$EXTERNALSYM adOpenKeyset}
  adOpenDynamic = $00000002;
  {$EXTERNALSYM adOpenDynamic}
  adOpenStatic = $00000003;
  {$EXTERNALSYM adOpenStatic}

// Constants for enum CursorOptionEnum
type
  CursorOptionEnum = TOleEnum;
  {$EXTERNALSYM CursorOptionEnum}
const
  adHoldRecords = $00000100;
  {$EXTERNALSYM adHoldRecords}
  adMovePrevious = $00000200;
  {$EXTERNALSYM adMovePrevious}
  adAddNew = $01000400;
  {$EXTERNALSYM adAddNew}
  adDelete = $01000800;
  {$EXTERNALSYM adDelete}
  adUpdate = $01008000;
  {$EXTERNALSYM adUpdate}
  adBookmark = $00002000;
  {$EXTERNALSYM adBookmark}
  adApproxPosition = $00004000;
  {$EXTERNALSYM adApproxPosition}
  adUpdateBatch = $00010000;
  {$EXTERNALSYM adUpdateBatch}
  adResync = $00020000;
  {$EXTERNALSYM adResync}
  adNotify = $00040000;
  {$EXTERNALSYM adNotify}
  adFind = $00080000;
  {$EXTERNALSYM adFind}
  adSeek = $00400000;
  {$EXTERNALSYM adSeek}
  adIndex = $00800000;
  {$EXTERNALSYM adIndex}

// Constants for enum LockTypeEnum
type
  LockTypeEnum = TOleEnum;
  {$EXTERNALSYM LockTypeEnum}
const
  adLockUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adLockUnspecified}
  adLockReadOnly = $00000001;
  {$EXTERNALSYM adLockReadOnly}
  adLockPessimistic = $00000002;
  {$EXTERNALSYM adLockPessimistic}
  adLockOptimistic = $00000003;
  {$EXTERNALSYM adLockOptimistic}
  adLockBatchOptimistic = $00000004;
  {$EXTERNALSYM adLockBatchOptimistic}

// Constants for enum ExecuteOptionEnum
type
  ExecuteOptionEnum = TOleEnum;
  {$EXTERNALSYM ExecuteOptionEnum}
const
  adOptionUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adOptionUnspecified}
  adAsyncExecute = $00000010;
  {$EXTERNALSYM adAsyncExecute}
  adAsyncFetch = $00000020;
  {$EXTERNALSYM adAsyncFetch}
  adAsyncFetchNonBlocking = $00000040;
  {$EXTERNALSYM adAsyncFetchNonBlocking}
  adExecuteNoRecords = $00000080;
  {$EXTERNALSYM adExecuteNoRecords}
  adExecuteStream = $00000400;
  {$EXTERNALSYM adExecuteStream}
  adExecuteRecord = $00000800;
  {$EXTERNALSYM adExecuteRecord}

// Constants for enum ConnectOptionEnum
type
  ConnectOptionEnum = TOleEnum;
  {$EXTERNALSYM ConnectOptionEnum}
const
  adConnectUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adConnectUnspecified}
  adAsyncConnect = $00000010;
  {$EXTERNALSYM adAsyncConnect}

// Constants for enum ObjectStateEnum
type
  ObjectStateEnum = TOleEnum;
  {$EXTERNALSYM ObjectStateEnum}
const
  adStateClosed = $00000000;
  {$EXTERNALSYM adStateClosed}
  adStateOpen = $00000001;
  {$EXTERNALSYM adStateOpen}
  adStateConnecting = $00000002;
  {$EXTERNALSYM adStateConnecting}
  adStateExecuting = $00000004;
  {$EXTERNALSYM adStateExecuting}
  adStateFetching = $00000008;
  {$EXTERNALSYM adStateFetching}

// Constants for enum CursorLocationEnum
type
  CursorLocationEnum = TOleEnum;
  {$EXTERNALSYM CursorLocationEnum}
const
  adUseNone = $00000001;
  {$EXTERNALSYM adUseNone}
  adUseServer = $00000002;
  {$EXTERNALSYM adUseServer}
  adUseClient = $00000003;
  {$EXTERNALSYM adUseClient}
  adUseClientBatch = $00000003;
  {$EXTERNALSYM adUseClientBatch}

// Constants for enum DataTypeEnum
type
  DataTypeEnum = TOleEnum;
  {$EXTERNALSYM DataTypeEnum}
const
  adEmpty = $00000000;
  {$EXTERNALSYM adEmpty}
  adTinyInt = $00000010;
  {$EXTERNALSYM adTinyInt}
  adSmallInt = $00000002;
  {$EXTERNALSYM adSmallInt}
  adInteger = $00000003;
  {$EXTERNALSYM adInteger}
  adBigInt = $00000014;
  {$EXTERNALSYM adBigInt}
  adUnsignedTinyInt = $00000011;
  {$EXTERNALSYM adUnsignedTinyInt}
  adUnsignedSmallInt = $00000012;
  {$EXTERNALSYM adUnsignedSmallInt}
  adUnsignedInt = $00000013;
  {$EXTERNALSYM adUnsignedInt}
  adUnsignedBigInt = $00000015;
  {$EXTERNALSYM adUnsignedBigInt}
  adSingle = $00000004;
  {$EXTERNALSYM adSingle}
  adDouble = $00000005;
  {$EXTERNALSYM adDouble}
  adCurrency = $00000006;
  {$EXTERNALSYM adCurrency}
  adDecimal = $0000000E;
  {$EXTERNALSYM adDecimal}
  adNumeric = $00000083;
  {$EXTERNALSYM adNumeric}
  adBoolean = $0000000B;
  {$EXTERNALSYM adBoolean}
  adError = $0000000A;
  {$EXTERNALSYM adError}
  adUserDefined = $00000084;
  {$EXTERNALSYM adUserDefined}
  adVariant = $0000000C;
  {$EXTERNALSYM adVariant}
  adIDispatch = $00000009;
  {$EXTERNALSYM adIDispatch}
  adIUnknown = $0000000D;
  {$EXTERNALSYM adIUnknown}
  adGUID = $00000048;
  {$EXTERNALSYM adGUID}
  adDate = $00000007;
  {$EXTERNALSYM adDate}
  adDBDate = $00000085;
  {$EXTERNALSYM adDBDate}
  adDBTime = $00000086;
  {$EXTERNALSYM adDBTime}
  adDBTimeStamp = $00000087;
  {$EXTERNALSYM adDBTimeStamp}
  adBSTR = $00000008;
  {$EXTERNALSYM adBSTR}
  adChar = $00000081;
  {$EXTERNALSYM adChar}
  adVarChar = $000000C8;
  {$EXTERNALSYM adVarChar}
  adLongVarChar = $000000C9;
  {$EXTERNALSYM adLongVarChar}
  adWChar = $00000082;
  {$EXTERNALSYM adWChar}
  adVarWChar = $000000CA;
  {$EXTERNALSYM adVarWChar}
  adLongVarWChar = $000000CB;
  {$EXTERNALSYM adLongVarWChar}
  adBinary = $00000080;
  {$EXTERNALSYM adBinary}
  adVarBinary = $000000CC;
  {$EXTERNALSYM adVarBinary}
  adLongVarBinary = $000000CD;
  {$EXTERNALSYM adLongVarBinary}
  adChapter = $00000088;
  {$EXTERNALSYM adChapter}
  adFileTime = $00000040;
  {$EXTERNALSYM adFileTime}
  adDBFileTime = $00000089;
  {$EXTERNALSYM adDBFileTime}
  adPropVariant = $0000008A;
  {$EXTERNALSYM adPropVariant}
  adVarNumeric = $0000008B;
  {$EXTERNALSYM adVarNumeric}
  adArray = $00002000;
  {$EXTERNALSYM adArray}

// Constants for enum FieldAttributeEnum
type
  FieldAttributeEnum = TOleEnum;
  {$EXTERNALSYM FieldAttributeEnum}
const
  adFldUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adFldUnspecified}
  adFldMayDefer = $00000002;
  {$EXTERNALSYM adFldMayDefer}
  adFldUpdatable = $00000004;
  {$EXTERNALSYM adFldUpdatable}
  adFldUnknownUpdatable = $00000008;
  {$EXTERNALSYM adFldUnknownUpdatable}
  adFldFixed = $00000010;
  {$EXTERNALSYM adFldFixed}
  adFldIsNullable = $00000020;
  {$EXTERNALSYM adFldIsNullable}
  adFldMayBeNull = $00000040;
  {$EXTERNALSYM adFldMayBeNull}
  adFldLong = $00000080;
  {$EXTERNALSYM adFldLong}
  adFldRowID = $00000100;
  {$EXTERNALSYM adFldRowID}
  adFldRowVersion = $00000200;
  {$EXTERNALSYM adFldRowVersion}
  adFldCacheDeferred = $00001000;
  {$EXTERNALSYM adFldCacheDeferred}
  adFldIsChapter = $00002000;
  {$EXTERNALSYM adFldIsChapter}
  adFldNegativeScale = $00004000;
  {$EXTERNALSYM adFldNegativeScale}
  adFldKeyColumn = $00008000;
  {$EXTERNALSYM adFldKeyColumn}
  adFldIsRowURL = $00010000;
  {$EXTERNALSYM adFldIsRowURL}
  adFldIsDefaultStream = $00020000;
  {$EXTERNALSYM adFldIsDefaultStream}
  adFldIsCollection = $00040000;
  {$EXTERNALSYM adFldIsCollection}

// Constants for enum EditModeEnum
type
  EditModeEnum = TOleEnum;
  {$EXTERNALSYM EditModeEnum}
const
  adEditNone = $00000000;
  {$EXTERNALSYM adEditNone}
  adEditInProgress = $00000001;
  {$EXTERNALSYM adEditInProgress}
  adEditAdd = $00000002;
  {$EXTERNALSYM adEditAdd}
  adEditDelete = $00000004;
  {$EXTERNALSYM adEditDelete}

// Constants for enum RecordStatusEnum
type
  RecordStatusEnum = TOleEnum;
  {$EXTERNALSYM RecordStatusEnum}
const
  adRecOK = $00000000;
  {$EXTERNALSYM adRecOK}
  adRecNew = $00000001;
  {$EXTERNALSYM adRecNew}
  adRecModified = $00000002;
  {$EXTERNALSYM adRecModified}
  adRecDeleted = $00000004;
  {$EXTERNALSYM adRecDeleted}
  adRecUnmodified = $00000008;
  {$EXTERNALSYM adRecUnmodified}
  adRecInvalid = $00000010;
  {$EXTERNALSYM adRecInvalid}
  adRecMultipleChanges = $00000040;
  {$EXTERNALSYM adRecMultipleChanges}
  adRecPendingChanges = $00000080;
  {$EXTERNALSYM adRecPendingChanges}
  adRecCanceled = $00000100;
  {$EXTERNALSYM adRecCanceled}
  adRecCantRelease = $00000400;
  {$EXTERNALSYM adRecCantRelease}
  adRecConcurrencyViolation = $00000800;
  {$EXTERNALSYM adRecConcurrencyViolation}
  adRecIntegrityViolation = $00001000;
  {$EXTERNALSYM adRecIntegrityViolation}
  adRecMaxChangesExceeded = $00002000;
  {$EXTERNALSYM adRecMaxChangesExceeded}
  adRecObjectOpen = $00004000;
  {$EXTERNALSYM adRecObjectOpen}
  adRecOutOfMemory = $00008000;
  {$EXTERNALSYM adRecOutOfMemory}
  adRecPermissionDenied = $00010000;
  {$EXTERNALSYM adRecPermissionDenied}
  adRecSchemaViolation = $00020000;
  {$EXTERNALSYM adRecSchemaViolation}
  adRecDBDeleted = $00040000;
  {$EXTERNALSYM adRecDBDeleted}

// Constants for enum GetRowsOptionEnum
type
  GetRowsOptionEnum = TOleEnum;
  {$EXTERNALSYM GetRowsOptionEnum}
const
  adGetRowsRest = $FFFFFFFF;
  {$EXTERNALSYM adGetRowsRest}

// Constants for enum PositionEnum
type
  PositionEnum = TOleEnum;
  {$EXTERNALSYM PositionEnum}
const
  adPosUnknown = $FFFFFFFF;
  {$EXTERNALSYM adPosUnknown}
  adPosBOF = $FFFFFFFE;
  {$EXTERNALSYM adPosBOF}
  adPosEOF = $FFFFFFFD;
  {$EXTERNALSYM adPosEOF}

// Constants for enum BookmarkEnum
type
  BookmarkEnum = TOleEnum;
  {$EXTERNALSYM BookmarkEnum}
const
  adBookmarkCurrent = $00000000;
  {$EXTERNALSYM adBookmarkCurrent}
  adBookmarkFirst = $00000001;
  {$EXTERNALSYM adBookmarkFirst}
  adBookmarkLast = $00000002;
  {$EXTERNALSYM adBookmarkLast}

// Constants for enum MarshalOptionsEnum
type
  MarshalOptionsEnum = TOleEnum;
  {$EXTERNALSYM MarshalOptionsEnum}
const
  adMarshalAll = $00000000;
  {$EXTERNALSYM adMarshalAll}
  adMarshalModifiedOnly = $00000001;
  {$EXTERNALSYM adMarshalModifiedOnly}

// Constants for enum AffectEnum
type
  AffectEnum = TOleEnum;
  {$EXTERNALSYM AffectEnum}
const
  adAffectCurrent = $00000001;
  {$EXTERNALSYM adAffectCurrent}
  adAffectGroup = $00000002;
  {$EXTERNALSYM adAffectGroup}
  adAffectAll = $00000003;
  {$EXTERNALSYM adAffectAll}
  adAffectAllChapters = $00000004;
  {$EXTERNALSYM adAffectAllChapters}

// Constants for enum ResyncEnum
type
  ResyncEnum = TOleEnum;
  {$EXTERNALSYM ResyncEnum}
const
  adResyncUnderlyingValues = $00000001;
  {$EXTERNALSYM adResyncUnderlyingValues}
  adResyncAllValues = $00000002;
  {$EXTERNALSYM adResyncAllValues}

// Constants for enum CompareEnum
type
  CompareEnum = TOleEnum;
  {$EXTERNALSYM CompareEnum}
const
  adCompareLessThan = $00000000;
  {$EXTERNALSYM adCompareLessThan}
  adCompareEqual = $00000001;
  {$EXTERNALSYM adCompareEqual}
  adCompareGreaterThan = $00000002;
  {$EXTERNALSYM adCompareGreaterThan}
  adCompareNotEqual = $00000003;
  {$EXTERNALSYM adCompareNotEqual}
  adCompareNotComparable = $00000004;
  {$EXTERNALSYM adCompareNotComparable}

// Constants for enum FilterGroupEnum
type
  FilterGroupEnum = TOleEnum;
  {$EXTERNALSYM FilterGroupEnum}
const
  adFilterNone = $00000000;
  {$EXTERNALSYM adFilterNone}
  adFilterPendingRecords = $00000001;
  {$EXTERNALSYM adFilterPendingRecords}
  adFilterAffectedRecords = $00000002;
  {$EXTERNALSYM adFilterAffectedRecords}
  adFilterFetchedRecords = $00000003;
  {$EXTERNALSYM adFilterFetchedRecords}
  adFilterPredicate = $00000004;
  {$EXTERNALSYM adFilterPredicate}
  adFilterConflictingRecords = $00000005;
  {$EXTERNALSYM adFilterConflictingRecords}

// Constants for enum SearchDirectionEnum
type
  SearchDirectionEnum = TOleEnum;
  {$EXTERNALSYM SearchDirectionEnum}
const
  adSearchForward = $00000001;
  {$EXTERNALSYM adSearchForward}
  adSearchBackward = $FFFFFFFF;
  {$EXTERNALSYM adSearchBackward}

// Constants for enum PersistFormatEnum
type
  PersistFormatEnum = TOleEnum;
  {$EXTERNALSYM PersistFormatEnum}
const
  adPersistADTG = $00000000;
  {$EXTERNALSYM adPersistADTG}
  adPersistXML = $00000001;
  {$EXTERNALSYM adPersistXML}

// Constants for enum StringFormatEnum
type
  StringFormatEnum = TOleEnum;
  {$EXTERNALSYM StringFormatEnum}
const
  adClipString = $00000002;
  {$EXTERNALSYM adClipString}

// Constants for enum ConnectPromptEnum
type
  ConnectPromptEnum = TOleEnum;
  {$EXTERNALSYM ConnectPromptEnum}
const
  adPromptAlways = $00000001;
  {$EXTERNALSYM adPromptAlways}
  adPromptComplete = $00000002;
  {$EXTERNALSYM adPromptComplete}
  adPromptCompleteRequired = $00000003;
  {$EXTERNALSYM adPromptCompleteRequired}
  adPromptNever = $00000004;
  {$EXTERNALSYM adPromptNever}

// Constants for enum ConnectModeEnum
type
  ConnectModeEnum = TOleEnum;
  {$EXTERNALSYM ConnectModeEnum}
const
  adModeUnknown = $00000000;
  {$EXTERNALSYM adModeUnknown}
  adModeRead = $00000001;
  {$EXTERNALSYM adModeRead}
  adModeWrite = $00000002;
  {$EXTERNALSYM adModeWrite}
  adModeReadWrite = $00000003;
  {$EXTERNALSYM adModeReadWrite}
  adModeShareDenyRead = $00000004;
  {$EXTERNALSYM adModeShareDenyRead}
  adModeShareDenyWrite = $00000008;
  {$EXTERNALSYM adModeShareDenyWrite}
  adModeShareExclusive = $0000000C;
  {$EXTERNALSYM adModeShareExclusive}
  adModeShareDenyNone = $00000010;
  {$EXTERNALSYM adModeShareDenyNone}
  adModeRecursive = $00400000;
  {$EXTERNALSYM adModeRecursive}

// Constants for enum RecordCreateOptionsEnum
type
  RecordCreateOptionsEnum = TOleEnum;
  {$EXTERNALSYM RecordCreateOptionsEnum}
const
  adCreateCollection = $00002000;
  {$EXTERNALSYM adCreateCollection}
  adCreateStructDoc = $80000000;
  {$EXTERNALSYM adCreateStructDoc}
  adCreateNonCollection = $00000000;
  {$EXTERNALSYM adCreateNonCollection}
  adOpenIfExists = $02000000;
  {$EXTERNALSYM adOpenIfExists}
  adCreateOverwrite = $04000000;
  {$EXTERNALSYM adCreateOverwrite}
  adFailIfNotExists = $FFFFFFFF;
  {$EXTERNALSYM adFailIfNotExists}

// Constants for enum RecordOpenOptionsEnum
type
  RecordOpenOptionsEnum = TOleEnum;
  {$EXTERNALSYM RecordOpenOptionsEnum}
const
  adOpenRecordUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adOpenRecordUnspecified}
  adOpenSource = $00800000;
  {$EXTERNALSYM adOpenSource}
  adOpenOutput = $00800000;
  {$EXTERNALSYM adOpenOutput}
  adOpenAsync = $00001000;
  {$EXTERNALSYM adOpenAsync}
  adDelayFetchStream = $00004000;
  {$EXTERNALSYM adDelayFetchStream}
  adDelayFetchFields = $00008000;
  {$EXTERNALSYM adDelayFetchFields}
  adOpenExecuteCommand = $00010000;
  {$EXTERNALSYM adOpenExecuteCommand}

// Constants for enum IsolationLevelEnum
type
  IsolationLevelEnum = TOleEnum;
  {$EXTERNALSYM IsolationLevelEnum}
const
  adXactUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adXactUnspecified}
  adXactChaos = $00000010;
  {$EXTERNALSYM adXactChaos}
  adXactReadUncommitted = $00000100;
  {$EXTERNALSYM adXactReadUncommitted}
  adXactBrowse = $00000100;
  {$EXTERNALSYM adXactBrowse}
  adXactCursorStability = $00001000;
  {$EXTERNALSYM adXactCursorStability}
  adXactReadCommitted = $00001000;
  {$EXTERNALSYM adXactReadCommitted}
  adXactRepeatableRead = $00010000;
  {$EXTERNALSYM adXactRepeatableRead}
  adXactSerializable = $00100000;
  {$EXTERNALSYM adXactSerializable}
  adXactIsolated = $00100000;
  {$EXTERNALSYM adXactIsolated}

// Constants for enum XactAttributeEnum
type
  XactAttributeEnum = TOleEnum;
  {$EXTERNALSYM XactAttributeEnum}
const
  adXactCommitRetaining = $00020000;
  {$EXTERNALSYM adXactCommitRetaining}
  adXactAbortRetaining = $00040000;
  {$EXTERNALSYM adXactAbortRetaining}
  adXactAsyncPhaseOne = $00080000;
  {$EXTERNALSYM adXactAsyncPhaseOne}
  adXactSyncPhaseOne = $00100000;
  {$EXTERNALSYM adXactSyncPhaseOne}

// Constants for enum PropertyAttributesEnum
type
  PropertyAttributesEnum = TOleEnum;
  {$EXTERNALSYM PropertyAttributesEnum}
const
  adPropNotSupported = $00000000;
  {$EXTERNALSYM adPropNotSupported}
  adPropRequired = $00000001;
  {$EXTERNALSYM adPropRequired}
  adPropOptional = $00000002;
  {$EXTERNALSYM adPropOptional}
  adPropRead = $00000200;
  {$EXTERNALSYM adPropRead}
  adPropWrite = $00000400;
  {$EXTERNALSYM adPropWrite}

// Constants for enum ErrorValueEnum
type
  ErrorValueEnum = TOleEnum;
  {$EXTERNALSYM ErrorValueEnum}
const
  adErrProviderFailed = $00000BB8;
  {$EXTERNALSYM adErrProviderFailed}
  adErrInvalidArgument = $00000BB9;
  {$EXTERNALSYM adErrInvalidArgument}
  adErrOpeningFile = $00000BBA;
  {$EXTERNALSYM adErrOpeningFile}
  adErrReadFile = $00000BBB;
  {$EXTERNALSYM adErrReadFile}
  adErrWriteFile = $00000BBC;
  {$EXTERNALSYM adErrWriteFile}
  adErrNoCurrentRecord = $00000BCD;
  {$EXTERNALSYM adErrNoCurrentRecord}
  adErrIllegalOperation = $00000C93;
  {$EXTERNALSYM adErrIllegalOperation}
  adErrCantChangeProvider = $00000C94;
  {$EXTERNALSYM adErrCantChangeProvider}
  adErrInTransaction = $00000CAE;
  {$EXTERNALSYM adErrInTransaction}
  adErrFeatureNotAvailable = $00000CB3;
  {$EXTERNALSYM adErrFeatureNotAvailable}
  adErrItemNotFound = $00000CC1;
  {$EXTERNALSYM adErrItemNotFound}
  adErrObjectInCollection = $00000D27;
  {$EXTERNALSYM adErrObjectInCollection}
  adErrObjectNotSet = $00000D5C;
  {$EXTERNALSYM adErrObjectNotSet}
  adErrDataConversion = $00000D5D;
  {$EXTERNALSYM adErrDataConversion}
  adErrObjectClosed = $00000E78;
  {$EXTERNALSYM adErrObjectClosed}
  adErrObjectOpen = $00000E79;
  {$EXTERNALSYM adErrObjectOpen}
  adErrProviderNotFound = $00000E7A;
  {$EXTERNALSYM adErrProviderNotFound}
  adErrBoundToCommand = $00000E7B;
  {$EXTERNALSYM adErrBoundToCommand}
  adErrInvalidParamInfo = $00000E7C;
  {$EXTERNALSYM adErrInvalidParamInfo}
  adErrInvalidConnection = $00000E7D;
  {$EXTERNALSYM adErrInvalidConnection}
  adErrNotReentrant = $00000E7E;
  {$EXTERNALSYM adErrNotReentrant}
  adErrStillExecuting = $00000E7F;
  {$EXTERNALSYM adErrStillExecuting}
  adErrOperationCancelled = $00000E80;
  {$EXTERNALSYM adErrOperationCancelled}
  adErrStillConnecting = $00000E81;
  {$EXTERNALSYM adErrStillConnecting}
  adErrInvalidTransaction = $00000E82;
  {$EXTERNALSYM adErrInvalidTransaction}
  adErrNotExecuting = $00000E83;
  {$EXTERNALSYM adErrNotExecuting}
  adErrUnsafeOperation = $00000E84;
  {$EXTERNALSYM adErrUnsafeOperation}
  adwrnSecurityDialog = $00000E85;
  {$EXTERNALSYM adwrnSecurityDialog}
  adwrnSecurityDialogHeader = $00000E86;
  {$EXTERNALSYM adwrnSecurityDialogHeader}
  adErrIntegrityViolation = $00000E87;
  {$EXTERNALSYM adErrIntegrityViolation}
  adErrPermissionDenied = $00000E88;
  {$EXTERNALSYM adErrPermissionDenied}
  adErrDataOverflow = $00000E89;
  {$EXTERNALSYM adErrDataOverflow}
  adErrSchemaViolation = $00000E8A;
  {$EXTERNALSYM adErrSchemaViolation}
  adErrSignMismatch = $00000E8B;
  {$EXTERNALSYM adErrSignMismatch}
  adErrCantConvertvalue = $00000E8C;
  {$EXTERNALSYM adErrCantConvertvalue}
  adErrCantCreate = $00000E8D;
  {$EXTERNALSYM adErrCantCreate}
  adErrColumnNotOnThisRow = $00000E8E;
  {$EXTERNALSYM adErrColumnNotOnThisRow}
  adErrURLDoesNotExist = $00000E8F;
  {$EXTERNALSYM adErrURLDoesNotExist}
  adErrTreePermissionDenied = $00000E90;
  {$EXTERNALSYM adErrTreePermissionDenied}
  adErrInvalidURL = $00000E91;
  {$EXTERNALSYM adErrInvalidURL}
  adErrResourceLocked = $00000E92;
  {$EXTERNALSYM adErrResourceLocked}
  adErrResourceExists = $00000E93;
  {$EXTERNALSYM adErrResourceExists}
  adErrCannotComplete = $00000E94;
  {$EXTERNALSYM adErrCannotComplete}
  adErrVolumeNotFound = $00000E95;
  {$EXTERNALSYM adErrVolumeNotFound}
  adErrOutOfSpace = $00000E96;
  {$EXTERNALSYM adErrOutOfSpace}
  adErrResourceOutOfScope = $00000E97;
  {$EXTERNALSYM adErrResourceOutOfScope}
  adErrUnavailable = $00000E98;
  {$EXTERNALSYM adErrUnavailable}
  adErrURLNamedRowDoesNotExist = $00000E99;
  {$EXTERNALSYM adErrURLNamedRowDoesNotExist}
  adErrDelResOutOfScope = $00000E9A;
  {$EXTERNALSYM adErrDelResOutOfScope}
  adErrPropInvalidColumn = $00000E9B;
  {$EXTERNALSYM adErrPropInvalidColumn}
  adErrPropInvalidOption = $00000E9C;
  {$EXTERNALSYM adErrPropInvalidOption}
  adErrPropInvalidValue = $00000E9D;
  {$EXTERNALSYM adErrPropInvalidValue}
  adErrPropConflicting = $00000E9E;
  {$EXTERNALSYM adErrPropConflicting}
  adErrPropNotAllSettable = $00000E9F;
  {$EXTERNALSYM adErrPropNotAllSettable}
  adErrPropNotSet = $00000EA0;
  {$EXTERNALSYM adErrPropNotSet}
  adErrPropNotSettable = $00000EA1;
  {$EXTERNALSYM adErrPropNotSettable}
  adErrPropNotSupported = $00000EA2;
  {$EXTERNALSYM adErrPropNotSupported}
  adErrCatalogNotSet = $00000EA3;
  {$EXTERNALSYM adErrCatalogNotSet}
  adErrCantChangeConnection = $00000EA4;
  {$EXTERNALSYM adErrCantChangeConnection}
  adErrFieldsUpdateFailed = $00000EA5;
  {$EXTERNALSYM adErrFieldsUpdateFailed}
  adErrDenyNotSupported = $00000EA6;
  {$EXTERNALSYM adErrDenyNotSupported}
  adErrDenyTypeNotSupported = $00000EA7;
  {$EXTERNALSYM adErrDenyTypeNotSupported}
  adErrProviderNotSpecified = $00000EA9;
  {$EXTERNALSYM adErrProviderNotSpecified}
  adErrConnectionStringTooLong = $00000EAA;
  {$EXTERNALSYM adErrConnectionStringTooLong}

// Constants for enum ParameterAttributesEnum
type
  ParameterAttributesEnum = TOleEnum;
  {$EXTERNALSYM ParameterAttributesEnum}
const
  adParamSigned = $00000010;
  {$EXTERNALSYM adParamSigned}
  adParamNullable = $00000040;
  {$EXTERNALSYM adParamNullable}
  adParamLong = $00000080;
  {$EXTERNALSYM adParamLong}

// Constants for enum ParameterDirectionEnum
type
  ParameterDirectionEnum = TOleEnum;
  {$EXTERNALSYM ParameterDirectionEnum}
const
  adParamUnknown = $00000000;
  {$EXTERNALSYM adParamUnknown}
  adParamInput = $00000001;
  {$EXTERNALSYM adParamInput}
  adParamOutput = $00000002;
  {$EXTERNALSYM adParamOutput}
  adParamInputOutput = $00000003;
  {$EXTERNALSYM adParamInputOutput}
  adParamReturnValue = $00000004;
  {$EXTERNALSYM adParamReturnValue}

// Constants for enum CommandTypeEnum
type
  CommandTypeEnum = TOleEnum;
  {$EXTERNALSYM CommandTypeEnum}
const
  adCmdUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adCmdUnspecified}
  adCmdUnknown = $00000008;
  {$EXTERNALSYM adCmdUnknown}
  adCmdText = $00000001;
  {$EXTERNALSYM adCmdText}
  adCmdTable = $00000002;
  {$EXTERNALSYM adCmdTable}
  adCmdStoredProc = $00000004;
  {$EXTERNALSYM adCmdStoredProc}
  adCmdFile = $00000100;
  {$EXTERNALSYM adCmdFile}
  adCmdTableDirect = $00000200;
  {$EXTERNALSYM adCmdTableDirect}

// Constants for enum EventStatusEnum
type
  EventStatusEnum = TOleEnum;
  {$EXTERNALSYM EventStatusEnum}
const
  adStatusOK = $00000001;
  {$EXTERNALSYM adStatusOK}
  adStatusErrorsOccurred = $00000002;
  {$EXTERNALSYM adStatusErrorsOccurred}
  adStatusCantDeny = $00000003;
  {$EXTERNALSYM adStatusCantDeny}
  adStatusCancel = $00000004;
  {$EXTERNALSYM adStatusCancel}
  adStatusUnwantedEvent = $00000005;
  {$EXTERNALSYM adStatusUnwantedEvent}

// Constants for enum EventReasonEnum
type
  EventReasonEnum = TOleEnum;
  {$EXTERNALSYM EventReasonEnum}
const
  adRsnAddNew = $00000001;
  {$EXTERNALSYM adRsnAddNew}
  adRsnDelete = $00000002;
  {$EXTERNALSYM adRsnDelete}
  adRsnUpdate = $00000003;
  {$EXTERNALSYM adRsnUpdate}
  adRsnUndoUpdate = $00000004;
  {$EXTERNALSYM adRsnUndoUpdate}
  adRsnUndoAddNew = $00000005;
  {$EXTERNALSYM adRsnUndoAddNew}
  adRsnUndoDelete = $00000006;
  {$EXTERNALSYM adRsnUndoDelete}
  adRsnRequery = $00000007;
  {$EXTERNALSYM adRsnRequery}
  adRsnResynch = $00000008;
  {$EXTERNALSYM adRsnResynch}
  adRsnClose = $00000009;
  {$EXTERNALSYM adRsnClose}
  adRsnMove = $0000000A;
  {$EXTERNALSYM adRsnMove}
  adRsnFirstChange = $0000000B;
  {$EXTERNALSYM adRsnFirstChange}
  adRsnMoveFirst = $0000000C;
  {$EXTERNALSYM adRsnMoveFirst}
  adRsnMoveNext = $0000000D;
  {$EXTERNALSYM adRsnMoveNext}
  adRsnMovePrevious = $0000000E;
  {$EXTERNALSYM adRsnMovePrevious}
  adRsnMoveLast = $0000000F;
  {$EXTERNALSYM adRsnMoveLast}

// Constants for enum SchemaEnum
type
  SchemaEnum = TOleEnum;
  {$EXTERNALSYM SchemaEnum}
const
  adSchemaProviderSpecific = $FFFFFFFF;
  {$EXTERNALSYM adSchemaProviderSpecific}
  adSchemaAsserts = $00000000;
  {$EXTERNALSYM adSchemaAsserts}
  adSchemaCatalogs = $00000001;
  {$EXTERNALSYM adSchemaCatalogs}
  adSchemaCharacterSets = $00000002;
  {$EXTERNALSYM adSchemaCharacterSets}
  adSchemaCollations = $00000003;
  {$EXTERNALSYM adSchemaCollations}
  adSchemaColumns = $00000004;
  {$EXTERNALSYM adSchemaColumns}
  adSchemaCheckConstraints = $00000005;
  {$EXTERNALSYM adSchemaCheckConstraints}
  adSchemaConstraintColumnUsage = $00000006;
  {$EXTERNALSYM adSchemaConstraintColumnUsage}
  adSchemaConstraintTableUsage = $00000007;
  {$EXTERNALSYM adSchemaConstraintTableUsage}
  adSchemaKeyColumnUsage = $00000008;
  {$EXTERNALSYM adSchemaKeyColumnUsage}
  adSchemaReferentialContraints = $00000009;
  {$EXTERNALSYM adSchemaReferentialContraints}
  adSchemaReferentialConstraints = $00000009;
  {$EXTERNALSYM adSchemaReferentialConstraints}
  adSchemaTableConstraints = $0000000A;
  {$EXTERNALSYM adSchemaTableConstraints}
  adSchemaColumnsDomainUsage = $0000000B;
  {$EXTERNALSYM adSchemaColumnsDomainUsage}
  adSchemaIndexes = $0000000C;
  {$EXTERNALSYM adSchemaIndexes}
  adSchemaColumnPrivileges = $0000000D;
  {$EXTERNALSYM adSchemaColumnPrivileges}
  adSchemaTablePrivileges = $0000000E;
  {$EXTERNALSYM adSchemaTablePrivileges}
  adSchemaUsagePrivileges = $0000000F;
  {$EXTERNALSYM adSchemaUsagePrivileges}
  adSchemaProcedures = $00000010;
  {$EXTERNALSYM adSchemaProcedures}
  adSchemaSchemata = $00000011;
  {$EXTERNALSYM adSchemaSchemata}
  adSchemaSQLLanguages = $00000012;
  {$EXTERNALSYM adSchemaSQLLanguages}
  adSchemaStatistics = $00000013;
  {$EXTERNALSYM adSchemaStatistics}
  adSchemaTables = $00000014;
  {$EXTERNALSYM adSchemaTables}
  adSchemaTranslations = $00000015;
  {$EXTERNALSYM adSchemaTranslations}
  adSchemaProviderTypes = $00000016;
  {$EXTERNALSYM adSchemaProviderTypes}
  adSchemaViews = $00000017;
  {$EXTERNALSYM adSchemaViews}
  adSchemaViewColumnUsage = $00000018;
  {$EXTERNALSYM adSchemaViewColumnUsage}
  adSchemaViewTableUsage = $00000019;
  {$EXTERNALSYM adSchemaViewTableUsage}
  adSchemaProcedureParameters = $0000001A;
  {$EXTERNALSYM adSchemaProcedureParameters}
  adSchemaForeignKeys = $0000001B;
  {$EXTERNALSYM adSchemaForeignKeys}
  adSchemaPrimaryKeys = $0000001C;
  {$EXTERNALSYM adSchemaPrimaryKeys}
  adSchemaProcedureColumns = $0000001D;
  {$EXTERNALSYM adSchemaProcedureColumns}
  adSchemaDBInfoKeywords = $0000001E;
  {$EXTERNALSYM adSchemaDBInfoKeywords}
  adSchemaDBInfoLiterals = $0000001F;
  {$EXTERNALSYM adSchemaDBInfoLiterals}
  adSchemaCubes = $00000020;
  {$EXTERNALSYM adSchemaCubes}
  adSchemaDimensions = $00000021;
  {$EXTERNALSYM adSchemaDimensions}
  adSchemaHierarchies = $00000022;
  {$EXTERNALSYM adSchemaHierarchies}
  adSchemaLevels = $00000023;
  {$EXTERNALSYM adSchemaLevels}
  adSchemaMeasures = $00000024;
  {$EXTERNALSYM adSchemaMeasures}
  adSchemaProperties = $00000025;
  {$EXTERNALSYM adSchemaProperties}
  adSchemaMembers = $00000026;
  {$EXTERNALSYM adSchemaMembers}
  adSchemaTrustees = $00000027;
  {$EXTERNALSYM adSchemaTrustees}
  adSchemaFunctions = $00000028;
  {$EXTERNALSYM adSchemaFunctions}
  adSchemaActions = $00000029;
  {$EXTERNALSYM adSchemaActions}
  adSchemaCommands = $0000002A;
  {$EXTERNALSYM adSchemaCommands}
  adSchemaSets = $0000002B;
  {$EXTERNALSYM adSchemaSets}

// Constants for enum FieldStatusEnum
type
  FieldStatusEnum = TOleEnum;
  {$EXTERNALSYM FieldStatusEnum}
const
  adFieldOK = $00000000;
  {$EXTERNALSYM adFieldOK}
  adFieldCantConvertValue = $00000002;
  {$EXTERNALSYM adFieldCantConvertValue}
  adFieldIsNull = $00000003;
  {$EXTERNALSYM adFieldIsNull}
  adFieldTruncated = $00000004;
  {$EXTERNALSYM adFieldTruncated}
  adFieldSignMismatch = $00000005;
  {$EXTERNALSYM adFieldSignMismatch}
  adFieldDataOverflow = $00000006;
  {$EXTERNALSYM adFieldDataOverflow}
  adFieldCantCreate = $00000007;
  {$EXTERNALSYM adFieldCantCreate}
  adFieldUnavailable = $00000008;
  {$EXTERNALSYM adFieldUnavailable}
  adFieldPermissionDenied = $00000009;
  {$EXTERNALSYM adFieldPermissionDenied}
  adFieldIntegrityViolation = $0000000A;
  {$EXTERNALSYM adFieldIntegrityViolation}
  adFieldSchemaViolation = $0000000B;
  {$EXTERNALSYM adFieldSchemaViolation}
  adFieldBadStatus = $0000000C;
  {$EXTERNALSYM adFieldBadStatus}
  adFieldDefault = $0000000D;
  {$EXTERNALSYM adFieldDefault}
  adFieldIgnore = $0000000F;
  {$EXTERNALSYM adFieldIgnore}
  adFieldDoesNotExist = $00000010;
  {$EXTERNALSYM adFieldDoesNotExist}
  adFieldInvalidURL = $00000011;
  {$EXTERNALSYM adFieldInvalidURL}
  adFieldResourceLocked = $00000012;
  {$EXTERNALSYM adFieldResourceLocked}
  adFieldResourceExists = $00000013;
  {$EXTERNALSYM adFieldResourceExists}
  adFieldCannotComplete = $00000014;
  {$EXTERNALSYM adFieldCannotComplete}
  adFieldVolumeNotFound = $00000015;
  {$EXTERNALSYM adFieldVolumeNotFound}
  adFieldOutOfSpace = $00000016;
  {$EXTERNALSYM adFieldOutOfSpace}
  adFieldCannotDeleteSource = $00000017;
  {$EXTERNALSYM adFieldCannotDeleteSource}
  adFieldReadOnly = $00000018;
  {$EXTERNALSYM adFieldReadOnly}
  adFieldResourceOutOfScope = $00000019;
  {$EXTERNALSYM adFieldResourceOutOfScope}
  adFieldAlreadyExists = $0000001A;
  {$EXTERNALSYM adFieldAlreadyExists}
  adFieldPendingInsert = $00010000;
  {$EXTERNALSYM adFieldPendingInsert}
  adFieldPendingDelete = $00020000;
  {$EXTERNALSYM adFieldPendingDelete}
  adFieldPendingChange = $00040000;
  {$EXTERNALSYM adFieldPendingChange}
  adFieldPendingUnknown = $00080000;
  {$EXTERNALSYM adFieldPendingUnknown}
  adFieldPendingUnknownDelete = $00100000;
  {$EXTERNALSYM adFieldPendingUnknownDelete}

// Constants for enum SeekEnum
type
  SeekEnum = TOleEnum;
  {$EXTERNALSYM SeekEnum}
const
  adSeekFirstEQ = $00000001;
  {$EXTERNALSYM adSeekFirstEQ}
  adSeekLastEQ = $00000002;
  {$EXTERNALSYM adSeekLastEQ}
  adSeekAfterEQ = $00000004;
  {$EXTERNALSYM adSeekAfterEQ}
  adSeekAfter = $00000008;
  {$EXTERNALSYM adSeekAfter}
  adSeekBeforeEQ = $00000010;
  {$EXTERNALSYM adSeekBeforeEQ}
  adSeekBefore = $00000020;
  {$EXTERNALSYM adSeekBefore}

// Constants for enum ADCPROP_UPDATECRITERIA_ENUM
type
  ADCPROP_UPDATECRITERIA_ENUM = TOleEnum;
  {$EXTERNALSYM ADCPROP_UPDATECRITERIA_ENUM}
const
  adCriteriaKey = $00000000;
  {$EXTERNALSYM adCriteriaKey}
  adCriteriaAllCols = $00000001;
  {$EXTERNALSYM adCriteriaAllCols}
  adCriteriaUpdCols = $00000002;
  {$EXTERNALSYM adCriteriaUpdCols}
  adCriteriaTimeStamp = $00000003;
  {$EXTERNALSYM adCriteriaTimeStamp}

// Constants for enum ADCPROP_ASYNCTHREADPRIORITY_ENUM
type
  ADCPROP_ASYNCTHREADPRIORITY_ENUM = TOleEnum;
  {$EXTERNALSYM ADCPROP_ASYNCTHREADPRIORITY_ENUM}
const
  adPriorityLowest = $00000001;
  {$EXTERNALSYM adPriorityLowest}
  adPriorityBelowNormal = $00000002;
  {$EXTERNALSYM adPriorityBelowNormal}
  adPriorityNormal = $00000003;
  {$EXTERNALSYM adPriorityNormal}
  adPriorityAboveNormal = $00000004;
  {$EXTERNALSYM adPriorityAboveNormal}
  adPriorityHighest = $00000005;
  {$EXTERNALSYM adPriorityHighest}

// Constants for enum ADCPROP_AUTORECALC_ENUM
type
  ADCPROP_AUTORECALC_ENUM = TOleEnum;
  {$EXTERNALSYM ADCPROP_AUTORECALC_ENUM}
const
  adRecalcUpFront = $00000000;
  {$EXTERNALSYM adRecalcUpFront}
  adRecalcAlways = $00000001;
  {$EXTERNALSYM adRecalcAlways}

// Constants for enum ADCPROP_UPDATERESYNC_ENUM
type
  ADCPROP_UPDATERESYNC_ENUM = TOleEnum;
  {$EXTERNALSYM ADCPROP_UPDATERESYNC_ENUM}
const
  adResyncNone = $00000000;
  {$EXTERNALSYM adResyncNone}
  adResyncAutoIncrement = $00000001;
  {$EXTERNALSYM adResyncAutoIncrement}
  adResyncConflicts = $00000002;
  {$EXTERNALSYM adResyncConflicts}
  adResyncUpdates = $00000004;
  {$EXTERNALSYM adResyncUpdates}
  adResyncInserts = $00000008;
  {$EXTERNALSYM adResyncInserts}
  adResyncAll = $0000000F;
  {$EXTERNALSYM adResyncAll}

// Constants for enum MoveRecordOptionsEnum
type
  MoveRecordOptionsEnum = TOleEnum;
  {$EXTERNALSYM MoveRecordOptionsEnum}
const
  adMoveUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adMoveUnspecified}
  adMoveOverWrite = $00000001;
  {$EXTERNALSYM adMoveOverWrite}
  adMoveDontUpdateLinks = $00000002;
  {$EXTERNALSYM adMoveDontUpdateLinks}
  adMoveAllowEmulation = $00000004;
  {$EXTERNALSYM adMoveAllowEmulation}

// Constants for enum CopyRecordOptionsEnum
type
  CopyRecordOptionsEnum = TOleEnum;
  {$EXTERNALSYM CopyRecordOptionsEnum}
const
  adCopyUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adCopyUnspecified}
  adCopyOverWrite = $00000001;
  {$EXTERNALSYM adCopyOverWrite}
  adCopyAllowEmulation = $00000004;
  {$EXTERNALSYM adCopyAllowEmulation}
  adCopyNonRecursive = $00000002;
  {$EXTERNALSYM adCopyNonRecursive}

// Constants for enum StreamTypeEnum
type
  StreamTypeEnum = TOleEnum;
  {$EXTERNALSYM StreamTypeEnum}
const
  adTypeBinary = $00000001;
  {$EXTERNALSYM adTypeBinary}
  adTypeText = $00000002;
  {$EXTERNALSYM adTypeText}

// Constants for enum LineSeparatorEnum
type
  LineSeparatorEnum = TOleEnum;
  {$EXTERNALSYM LineSeparatorEnum}
const
  adLF = $0000000A;
  {$EXTERNALSYM adLF}
  adCR = $0000000D;
  {$EXTERNALSYM adCR}
  adCRLF = $FFFFFFFF;
  {$EXTERNALSYM adCRLF}

// Constants for enum StreamOpenOptionsEnum
type
  StreamOpenOptionsEnum = TOleEnum;
  {$EXTERNALSYM StreamOpenOptionsEnum}
const
  adOpenStreamUnspecified = $FFFFFFFF;
  {$EXTERNALSYM adOpenStreamUnspecified}
  adOpenStreamAsync = $00000001;
  {$EXTERNALSYM adOpenStreamAsync}
  adOpenStreamFromRecord = $00000004;
  {$EXTERNALSYM adOpenStreamFromRecord}

// Constants for enum StreamWriteEnum
type
  StreamWriteEnum = TOleEnum;
  {$EXTERNALSYM StreamWriteEnum}
const
  adWriteChar = $00000000;
  {$EXTERNALSYM adWriteChar}
  adWriteLine = $00000001;
  {$EXTERNALSYM adWriteLine}
  stWriteChar = $00000000;
  {$EXTERNALSYM stWriteChar}
  stWriteLine = $00000001;
  {$EXTERNALSYM stWriteLine}

// Constants for enum SaveOptionsEnum
type
  SaveOptionsEnum = TOleEnum;
  {$EXTERNALSYM SaveOptionsEnum}
const
  adSaveCreateNotExist = $00000001;
  {$EXTERNALSYM adSaveCreateNotExist}
  adSaveCreateOverWrite = $00000002;
  {$EXTERNALSYM adSaveCreateOverWrite}

// Constants for enum FieldEnum
type
  FieldEnum = TOleEnum;
  {$EXTERNALSYM FieldEnum}
const
  adDefaultStream = $FFFFFFFF;
  {$EXTERNALSYM adDefaultStream}
  adRecordURL = $FFFFFFFE;
  {$EXTERNALSYM adRecordURL}

// Constants for enum StreamReadEnum
type
  StreamReadEnum = TOleEnum;
  {$EXTERNALSYM StreamReadEnum}
const
  adReadAll = $FFFFFFFF;
  {$EXTERNALSYM adReadAll}
  adReadLine = $FFFFFFFE;
  {$EXTERNALSYM adReadLine}

// Constants for enum RecordTypeEnum
type
  RecordTypeEnum = TOleEnum;
  {$EXTERNALSYM RecordTypeEnum}
const
  adSimpleRecord = $00000000;
  {$EXTERNALSYM adSimpleRecord}
  adCollectionRecord = $00000001;
  {$EXTERNALSYM adCollectionRecord}
  adStructDoc = $00000002;
  {$EXTERNALSYM adStructDoc}

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//

  _Collection = interface;
  _CollectionDisp = dispinterface;

  _DynaCollection = interface;
  _DynaCollectionDisp = dispinterface;

  _ADO = interface;
  _ADODisp = dispinterface;

  Properties = interface;
  PropertiesDisp = dispinterface;

  Property_ = interface;
  Property_Disp = dispinterface;

  Error = interface;
  ErrorDisp = dispinterface;

  Errors = interface;
  ErrorsDisp = dispinterface;

  Command15 = interface;
  Command15Disp = dispinterface;

  Connection15 = interface;
  Connection15Disp = dispinterface;

  _Connection = interface;
  _ConnectionDisp = dispinterface;

  Recordset15 = interface;
  Recordset15Disp = dispinterface;

  Recordset20 = interface;
  Recordset20Disp = dispinterface;
  
  Recordset21 = interface;
  Recordset21Disp = dispinterface;

  _Recordset = interface;
  _RecordsetDisp = dispinterface;

  Fields15 = interface;
  Fields15Disp = dispinterface;

  Fields20 = interface;
  Fields20Disp = dispinterface;

  Fields = interface;
  FieldsDisp = dispinterface;

  Field20 = interface;
  Field20Disp = dispinterface;

  Field = interface;
  FieldDisp = dispinterface;

  _Parameter = interface;
  _ParameterDisp = dispinterface;

  Parameters = interface;
  ParametersDisp = dispinterface;

  Command25 = interface;
  Command25Disp = dispinterface;

  _Command = interface;
  _CommandDisp = dispinterface;

  ConnectionEventsVt = interface;
  RecordsetEventsVt = interface;

  ConnectionEvents = dispinterface;
  RecordsetEvents = dispinterface;

  ADOConnectionConstruction15 = interface;
  ADOConnectionConstruction = interface;

  _Record = interface;
  _RecordDisp = dispinterface;

  _Stream = interface;
  _StreamDisp = dispinterface;

  ADORecordConstruction = interface;
  ADOStreamConstruction = interface;
  ADOCommandConstruction = interface;
  ADORecordsetConstruction = interface;

  Field15 = interface;
  Field15Disp = dispinterface;

{$IFDEF CG_EDITS}
  IDataspace = interface;
  IDataspaceDisp = dispinterface;
{$ENDIF}

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Connection = _Connection;
  Record_ = _Record;
  Stream = _Stream;
  Command = _Command;
  Recordset = _Recordset;
  Parameter = _Parameter;
{$IFDEF CG_EDITS}
  DataSpace = IDataspace;
{$ENDIF}


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}

  PositionEnum_Param = NativeUInt;
  {$EXTERNALSYM PositionEnum_Param}
  SearchDirection = SearchDirectionEnum;
  {$EXTERNALSYM SearchDirection}
  ADO_LONGPTR = LONG_PTR;
  {$EXTERNALSYM ADO_LONGPTR}
  
// *********************************************************************//
// Interface: _Collection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000512-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _Collection = interface(IDispatch)
    ['{00000512-0000-0010-8000-00AA006D2EA4}']
    function Get_Count: Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    procedure Refresh; safecall;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  _CollectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000512-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _CollectionDisp = dispinterface
    ['{00000512-0000-0010-8000-00AA006D2EA4}']
    property Count: Integer readonly dispid 1;
    function _NewEnum: IUnknown; dispid -4;
    procedure Refresh; dispid 2;
  end;

// *********************************************************************//
// Interface: _DynaCollection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000513-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _DynaCollection = interface(_Collection)
    ['{00000513-0000-0010-8000-00AA006D2EA4}']
    procedure Append(const Object_: IDispatch); safecall;
    procedure Delete(Index: OleVariant); safecall;
  end;

// *********************************************************************//
// DispIntf:  _DynaCollectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000513-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _DynaCollectionDisp = dispinterface
    ['{00000513-0000-0010-8000-00AA006D2EA4}']
    procedure Append(const Object_: IDispatch); dispid 1610809344;
    procedure Delete(Index: OleVariant); dispid 1610809345;
    property Count: Integer readonly dispid 1;
    function _NewEnum: IUnknown; dispid -4;
    procedure Refresh; dispid 2;
  end;

// *********************************************************************//
// Interface: _ADO
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000534-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _ADO = interface(IDispatch)
    ['{00000534-0000-0010-8000-00AA006D2EA4}']
    function Get_Properties: Properties; safecall;
    property Properties: Properties read Get_Properties;
  end;

// *********************************************************************//
// DispIntf:  _ADODisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000534-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _ADODisp = dispinterface
    ['{00000534-0000-0010-8000-00AA006D2EA4}']
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: Properties
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000504-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Properties = interface(_Collection)
    ['{00000504-0000-0010-8000-00AA006D2EA4}']
    function Get_Item(Index: OleVariant): Property_; safecall;
    property Item[Index: OleVariant]: Property_ read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  PropertiesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000504-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  PropertiesDisp = dispinterface
    ['{00000504-0000-0010-8000-00AA006D2EA4}']
    property Item[Index: OleVariant]: Property_ readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
    function _NewEnum: IUnknown; dispid -4;
    procedure Refresh; dispid 2;
  end;

// *********************************************************************//
// Interface: Property_
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000503-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Property_ = interface(IDispatch)
    ['{00000503-0000-0010-8000-00AA006D2EA4}']
    function Get_Value: OleVariant; safecall;
    procedure Set_Value(pval: OleVariant); safecall;
    function Get_Name: WideString; safecall;
    function Get_Type_: DataTypeEnum; safecall;
    function Get_Attributes: Integer; safecall;
    procedure Set_Attributes(plAttributes: Integer); safecall;
    property Value: OleVariant read Get_Value write Set_Value;
    property Name: WideString read Get_Name;
    property Type_: DataTypeEnum read Get_Type_;
    property Attributes: Integer read Get_Attributes write Set_Attributes;
  end;

// *********************************************************************//
// DispIntf:  Property_Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000503-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Property_Disp = dispinterface
    ['{00000503-0000-0010-8000-00AA006D2EA4}']
    property Value: OleVariant dispid 0;
    property Name: WideString readonly dispid 1610743810;
    property Type_: DataTypeEnum readonly dispid 1610743811;
    property Attributes: Integer dispid 1610743812;
  end;

// *********************************************************************//
// Interface: Error
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000500-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Error = interface(IDispatch)
    ['{00000500-0000-0010-8000-00AA006D2EA4}']
    function Get_Number: Integer; safecall;
    function Get_Source: WideString; safecall;
    function Get_Description: WideString; safecall;
    function Get_HelpFile: WideString; safecall;
    function Get_HelpContext: Integer; safecall;
    function Get_SQLState: WideString; safecall;
    function Get_NativeError: Integer; safecall;
    property Number: Integer read Get_Number;
    property Source: WideString read Get_Source;
    property Description: WideString read Get_Description;
    property HelpFile: WideString read Get_HelpFile;
    property HelpContext: Integer read Get_HelpContext;
    property SQLState: WideString read Get_SQLState;
    property NativeError: Integer read Get_NativeError;
  end;

// *********************************************************************//
// DispIntf:  ErrorDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000500-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ErrorDisp = dispinterface
    ['{00000500-0000-0010-8000-00AA006D2EA4}']
    property Number: Integer readonly dispid 1;
    property Source: WideString readonly dispid 2;
    property Description: WideString readonly dispid 0;
    property HelpFile: WideString readonly dispid 3;
    property HelpContext: Integer readonly dispid 4;
    property SQLState: WideString readonly dispid 5;
    property NativeError: Integer readonly dispid 6;
  end;

// *********************************************************************//
// Interface: Errors
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000501-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Errors = interface(_Collection)
    ['{00000501-0000-0010-8000-00AA006D2EA4}']
    function Get_Item(Index: OleVariant): Error; safecall;
    procedure Clear; safecall;
    property Item[Index: OleVariant]: Error read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  ErrorsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000501-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ErrorsDisp = dispinterface
    ['{00000501-0000-0010-8000-00AA006D2EA4}']
    property Item[Index: OleVariant]: Error readonly dispid 0; default;
    procedure Clear; dispid 1610809345;
    property Count: Integer readonly dispid 1;
    function _NewEnum: IUnknown; dispid -4;
    procedure Refresh; dispid 2;
  end;

// *********************************************************************//
// Interface: Command15
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000508-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Command15 = interface(_ADO)
    ['{00000508-0000-0010-8000-00AA006D2EA4}']
    function Get_ActiveConnection: _Connection; safecall;
    procedure Set_ActiveConnection(const ppvObject: _Connection); safecall;
    procedure _Set_ActiveConnection(ppvObject: OleVariant); safecall;
    function Get_CommandText: WideString; safecall;
    procedure Set_CommandText(const pbstr: WideString); safecall;
    function Get_CommandTimeout: Integer; safecall;
    procedure Set_CommandTimeout(pl: Integer); safecall;
    function Get_Prepared: WordBool; safecall;
    procedure Set_Prepared(pfPrepared: WordBool); safecall;
    function Execute(out RecordsAffected: OleVariant; const Parameters: OleVariant; Options: Integer): _Recordset; safecall;
    function CreateParameter(const Name: WideString; Type_: DataTypeEnum; 
      Direction: ParameterDirectionEnum; Size: ADO_LONGPTR; Value: OleVariant): _Parameter; safecall;
    function Get_Parameters: Parameters; safecall;
    procedure Set_CommandType(plCmdType: CommandTypeEnum); safecall;
    function Get_CommandType: CommandTypeEnum; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pbstrName: WideString); safecall;
    property CommandText: WideString read Get_CommandText write Set_CommandText;
    property CommandTimeout: Integer read Get_CommandTimeout write Set_CommandTimeout;
    property Prepared: WordBool read Get_Prepared write Set_Prepared;
    property Parameters: Parameters read Get_Parameters;
    property CommandType: CommandTypeEnum read Get_CommandType write Set_CommandType;
    property Name: WideString read Get_Name write Set_Name;
  end;

// *********************************************************************//
// DispIntf:  Command15Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000508-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Command15Disp = dispinterface
    ['{00000508-0000-0010-8000-00AA006D2EA4}']
    function ActiveConnection: _Connection; dispid 1;
    property CommandText: WideString dispid 2;
    property CommandTimeout: Integer dispid 3;
    property Prepared: WordBool dispid 4;
    function Execute(out RecordsAffected: OleVariant; var Parameters: OleVariant; Options: Integer): _Recordset; dispid 5;
    function CreateParameter(const Name: WideString; Type_: DataTypeEnum; 
                             Direction: ParameterDirectionEnum; Size: ADO_LONGPTR; Value: OleVariant): _Parameter; dispid 6;
    property Parameters: Parameters readonly dispid 0;
    property CommandType: CommandTypeEnum dispid 7;
    property Name: WideString dispid 8;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: Connection15
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {00000515-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Connection15 = interface(_ADO)
    ['{00000515-0000-0010-8000-00AA006D2EA4}']
    function Get_ConnectionString: WideString; safecall;
    procedure Set_ConnectionString(const pbstr: WideString); safecall;
    function Get_CommandTimeout: Integer; safecall;
    procedure Set_CommandTimeout(plTimeout: Integer); safecall;
    function Get_ConnectionTimeout: Integer; safecall;
    procedure Set_ConnectionTimeout(plTimeout: Integer); safecall;
    function Get_Version: WideString; safecall;
    procedure Close; safecall;
    function Execute(const CommandText: WideString; out RecordsAffected: OleVariant;
      Options: Integer): _Recordset; safecall;
    function BeginTrans: Integer; safecall;
    procedure CommitTrans; safecall;
    procedure RollbackTrans; safecall;
    procedure Open(const ConnectionString: WideString; const UserID: WideString; 
      const Password: WideString; Options: Integer); safecall;
    function Get_Errors: Errors; safecall;
    function Get_DefaultDatabase: WideString; safecall;
    procedure Set_DefaultDatabase(const pbstr: WideString); safecall;
    function Get_IsolationLevel: IsolationLevelEnum; safecall;
    procedure Set_IsolationLevel(Level: IsolationLevelEnum); safecall;
    function Get_Attributes: Integer; safecall;
    procedure Set_Attributes(plAttr: Integer); safecall;
    function Get_CursorLocation: CursorLocationEnum; safecall;
    procedure Set_CursorLocation(plCursorLoc: CursorLocationEnum); safecall;
    function Get_Mode: ConnectModeEnum; safecall;
    procedure Set_Mode(plMode: ConnectModeEnum); safecall;
    function Get_Provider: WideString; safecall;
    procedure Set_Provider(const pbstr: WideString); safecall;
    function Get_State: Integer; safecall;
    function OpenSchema(Schema: SchemaEnum; Restrictions: OleVariant; SchemaID: OleVariant): _Recordset; safecall;
    property ConnectionString: WideString read Get_ConnectionString write Set_ConnectionString;
    property CommandTimeout: Integer read Get_CommandTimeout write Set_CommandTimeout;
    property ConnectionTimeout: Integer read Get_ConnectionTimeout write Set_ConnectionTimeout;
    property Version: WideString read Get_Version;
    property Errors: Errors read Get_Errors;
    property DefaultDatabase: WideString read Get_DefaultDatabase write Set_DefaultDatabase;
    property IsolationLevel: IsolationLevelEnum read Get_IsolationLevel write Set_IsolationLevel;
    property Attributes: Integer read Get_Attributes write Set_Attributes;
    property CursorLocation: CursorLocationEnum read Get_CursorLocation write Set_CursorLocation;
    property Mode: ConnectModeEnum read Get_Mode write Set_Mode;
    property Provider: WideString read Get_Provider write Set_Provider;
    property State: Integer read Get_State;
  end;

// *********************************************************************//
// DispIntf:  Connection15Disp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {00000515-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Connection15Disp = dispinterface
    ['{00000515-0000-0010-8000-00AA006D2EA4}']
    property ConnectionString: WideString dispid 0;
    property CommandTimeout: Integer dispid 2;
    property ConnectionTimeout: Integer dispid 3;
    property Version: WideString readonly dispid 4;
    procedure Close; dispid 5;
    function Execute(const CommandText: WideString; out RecordsAffected: OleVariant; 
      Options: Integer): _Recordset; dispid 6;
    function BeginTrans: Integer; dispid 7;
    procedure CommitTrans; dispid 8;
    procedure RollbackTrans; dispid 9;
    procedure Open(const ConnectionString: WideString; const UserID: WideString; 
      const Password: WideString; Options: Integer); dispid 10;
    property Errors: Errors readonly dispid 11;
    property DefaultDatabase: WideString dispid 12;
    property IsolationLevel: IsolationLevelEnum dispid 13;
    property Attributes: Integer dispid 14;
    property CursorLocation: CursorLocationEnum dispid 15;
    property Mode: ConnectModeEnum dispid 16;
    property Provider: WideString dispid 17;
    property State: Integer readonly dispid 18;
    function OpenSchema(Schema: SchemaEnum; Restrictions: OleVariant; SchemaID: OleVariant): _Recordset; dispid 19;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: _Connection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {00000550-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _Connection = interface(Connection15)
    ['{00000550-0000-0010-8000-00AA006D2EA4}']
    procedure Cancel; safecall;
  end;

// *********************************************************************//
// DispIntf:  _ConnectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {00000550-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _ConnectionDisp = dispinterface
    ['{00000550-0000-0010-8000-00AA006D2EA4}']
    procedure Cancel; dispid 21;
    property ConnectionString: WideString dispid 0;
    property CommandTimeout: Integer dispid 2;
    property ConnectionTimeout: Integer dispid 3;
    property Version: WideString readonly dispid 4;
    procedure Close; dispid 5;
    function Execute(const CommandText: WideString; out RecordsAffected: OleVariant; 
      Options: Integer): _Recordset; dispid 6;
    function BeginTrans: Integer; dispid 7;
    procedure CommitTrans; dispid 8;
    procedure RollbackTrans; dispid 9;
    procedure Open(const ConnectionString: WideString; const UserID: WideString; 
      const Password: WideString; Options: Integer); dispid 10;
    property Errors: Errors readonly dispid 11;
    property DefaultDatabase: WideString dispid 12;
    property IsolationLevel: IsolationLevelEnum dispid 13;
    property Attributes: Integer dispid 14;
    property CursorLocation: CursorLocationEnum dispid 15;
    property Mode: ConnectModeEnum dispid 16;
    property Provider: WideString dispid 17;
    property State: Integer readonly dispid 18;
    function OpenSchema(Schema: SchemaEnum; Restrictions: OleVariant; SchemaID: OleVariant): _Recordset; dispid 19;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: Recordset15
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000050E-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Recordset15 = interface(_ADO)
    ['{0000050E-0000-0010-8000-00AA006D2EA4}']
    function Get_AbsolutePosition: PositionEnum_Param; safecall;
    procedure Set_AbsolutePosition(pl: PositionEnum_Param); safecall;
    procedure _Set_ActiveConnection(const pvar: IDispatch); safecall;
    procedure Set_ActiveConnection(pvar: OleVariant); safecall;
    function Get_ActiveConnection: OleVariant; safecall;
    function Get_BOF: WordBool; safecall;
    function Get_Bookmark: OleVariant; safecall;
    procedure Set_Bookmark(pvBookmark: OleVariant); safecall;
    function Get_CacheSize: Integer; safecall;
    procedure Set_CacheSize(pl: Integer); safecall;
    function Get_CursorType: CursorTypeEnum; safecall;
    procedure Set_CursorType(plCursorType: CursorTypeEnum); safecall;
    function Get_EOF: WordBool; safecall;
    function Get_Fields: Fields; safecall;
    function Get_LockType: LockTypeEnum; safecall;
    procedure Set_LockType(plLockType: LockTypeEnum); safecall;
    function Get_MaxRecords: ADO_LONGPTR; safecall;
    procedure Set_MaxRecords(plMaxRecords: ADO_LONGPTR); safecall;
    function Get_RecordCount: ADO_LONGPTR; safecall;
    procedure _Set_Source(const pvSource: IDispatch); safecall;
    procedure Set_Source(const pvSource: WideString); safecall;
    function Get_Source: OleVariant; safecall;
    procedure AddNew(FieldList: OleVariant; Values: OleVariant); safecall;
    procedure CancelUpdate; safecall;
    procedure Close; safecall;
    procedure Delete(AffectRecords: AffectEnum); safecall;
    function GetRows(Rows: Integer; Start: OleVariant; Fields: OleVariant): OleVariant; safecall;
    procedure Move(NumRecords: ADO_LONGPTR; Start: OleVariant); safecall;
    procedure MoveNext; safecall;
    procedure MovePrevious; safecall;
    procedure MoveFirst; safecall;
    procedure MoveLast; safecall;
    procedure Open(Source: OleVariant; ActiveConnection: OleVariant; CursorType: CursorTypeEnum; 
      LockType: LockTypeEnum; Options: Integer); safecall;
    procedure Requery(Options: Integer); safecall;
    procedure _xResync(AffectRecords: AffectEnum); safecall;
    procedure Update(Fields: OleVariant; Values: OleVariant); safecall;
    function Get_AbsolutePage: PositionEnum_Param; safecall;
    procedure Set_AbsolutePage(pl: PositionEnum_Param); safecall;
    function Get_EditMode: EditModeEnum; safecall;
    function Get_Filter: OleVariant; safecall;
    procedure Set_Filter(Criteria: OleVariant); safecall;
    function Get_PageCount: ADO_LONGPTR; safecall;
    function Get_PageSize: Integer; safecall;
    procedure Set_PageSize(pl: Integer); safecall;
    function Get_Sort: WideString; safecall;
    procedure Set_Sort(const Criteria: WideString); safecall;
    function Get_Status: Integer; safecall;
    function Get_State: Integer; safecall;
    function _xClone: _Recordset; safecall;
    procedure UpdateBatch(AffectRecords: AffectEnum); safecall;
    procedure CancelBatch(AffectRecords: AffectEnum); safecall;
    function Get_CursorLocation: CursorLocationEnum; safecall;
    procedure Set_CursorLocation(plCursorLoc: CursorLocationEnum); safecall;
    function NextRecordset(out RecordsAffected: OleVariant): _Recordset; safecall;
    function Supports(CursorOptions: CursorOptionEnum): WordBool; safecall;
    function Get_Collect(Index: OleVariant): OleVariant; safecall;
    procedure Set_Collect(Index: OleVariant; pvar: OleVariant); safecall;
    function Get_MarshalOptions: MarshalOptionsEnum; safecall;
    procedure Set_MarshalOptions(peMarshal: MarshalOptionsEnum); safecall;
    procedure Find(const Criteria: WideString; SkipRecords: ADO_LONGPTR; 
      SearchDirection: SearchDirectionEnum; Start: OleVariant); safecall;
    property AbsolutePosition: PositionEnum_Param read Get_AbsolutePosition write Set_AbsolutePosition;
    property BOF: WordBool read Get_BOF;
    property Bookmark: OleVariant read Get_Bookmark write Set_Bookmark;
    property CacheSize: Integer read Get_CacheSize write Set_CacheSize;
    property CursorType: CursorTypeEnum read Get_CursorType write Set_CursorType;
    property EOF: WordBool read Get_EOF;
    property Fields: Fields read Get_Fields;
    property LockType: LockTypeEnum read Get_LockType write Set_LockType;
    property MaxRecords: ADO_LONGPTR read Get_MaxRecords write Set_MaxRecords;
    property RecordCount: ADO_LONGPTR read Get_RecordCount;
    property AbsolutePage: PositionEnum_Param read Get_AbsolutePage write Set_AbsolutePage;
    property EditMode: EditModeEnum read Get_EditMode;
    property Filter: OleVariant read Get_Filter write Set_Filter;
    property PageCount: ADO_LONGPTR read Get_PageCount;
    property PageSize: Integer read Get_PageSize write Set_PageSize;
    property Sort: WideString read Get_Sort write Set_Sort;
    property Status: Integer read Get_Status;
    property State: Integer read Get_State;
    property CursorLocation: CursorLocationEnum read Get_CursorLocation write Set_CursorLocation;
    property Collect[Index: OleVariant]: OleVariant read Get_Collect write Set_Collect;
    property MarshalOptions: MarshalOptionsEnum read Get_MarshalOptions write Set_MarshalOptions;
  end;

// *********************************************************************//
// DispIntf:  Recordset15Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000050E-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Recordset15Disp = dispinterface
    ['{0000050E-0000-0010-8000-00AA006D2EA4}']
    property AbsolutePosition: PositionEnum_Param dispid 1000;
    function ActiveConnection: IDispatch; dispid 1001;
    property BOF: WordBool readonly dispid 1002;
    property Bookmark: OleVariant dispid 1003;
    property CacheSize: Integer dispid 1004;
    property CursorType: CursorTypeEnum dispid 1005;
    property EOF: WordBool readonly dispid 1006;
    property Fields: Fields readonly dispid 0;
    property LockType: LockTypeEnum dispid 1008;
    property MaxRecords: ADO_LONGPTR dispid 1009;
    property RecordCount: ADO_LONGPTR readonly dispid 1010;
    function Source: IDispatch; dispid 1011;
    procedure AddNew(FieldList: OleVariant; Values: OleVariant); dispid 1012;
    procedure CancelUpdate; dispid 1013;
    procedure Close; dispid 1014;
    procedure Delete(AffectRecords: AffectEnum); dispid 1015;
    function GetRows(Rows: Integer; Start: OleVariant; Fields: OleVariant): OleVariant; dispid 1016;
    procedure Move(NumRecords: ADO_LONGPTR; Start: OleVariant); dispid 1017;
    procedure MoveNext; dispid 1018;
    procedure MovePrevious; dispid 1019;
    procedure MoveFirst; dispid 1020;
    procedure MoveLast; dispid 1021;
    procedure Open(Source: OleVariant; ActiveConnection: OleVariant; CursorType: CursorTypeEnum; 
      LockType: LockTypeEnum; Options: Integer); dispid 1022;
    procedure Requery(Options: Integer); dispid 1023;
    procedure _xResync(AffectRecords: AffectEnum); dispid 1610809378;
    procedure Update(Fields: OleVariant; Values: OleVariant); dispid 1025;
    property AbsolutePage: PositionEnum_Param dispid 1047;
    property EditMode: EditModeEnum readonly dispid 1026;
    property Filter: OleVariant dispid 1030;
    property PageCount: ADO_LONGPTR readonly dispid 1050;
    property PageSize: Integer dispid 1048;
    property Sort: WideString dispid 1031;
    property Status: Integer readonly dispid 1029;
    property State: Integer readonly dispid 1054;
    function _xClone: _Recordset; dispid 1610809392;
    procedure UpdateBatch(AffectRecords: AffectEnum); dispid 1035;
    procedure CancelBatch(AffectRecords: AffectEnum); dispid 1049;
    property CursorLocation: CursorLocationEnum dispid 1051;
    function NextRecordset(out RecordsAffected: OleVariant): _Recordset; dispid 1052;
    function Supports(CursorOptions: CursorOptionEnum): WordBool; dispid 1036;
    property Collect[Index: OleVariant]: OleVariant dispid -8;
    property MarshalOptions: MarshalOptionsEnum dispid 1053;
    procedure Find(const Criteria: WideString; SkipRecords: ADO_LONGPTR; 
      SearchDirection: SearchDirectionEnum; Start: OleVariant); dispid 1058;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: Recordset20
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000054F-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Recordset20 = interface(Recordset15)
    ['{0000054F-0000-0010-8000-00AA006D2EA4}']
    procedure Cancel; safecall;
    function Get_DataSource: IUnknown; safecall;
    procedure _Set_DataSource(const ppunkDataSource: IUnknown); safecall;
    procedure _xSave(const FileName: WideString; PersistFormat: PersistFormatEnum); safecall;
    function Get_ActiveCommand: IDispatch; safecall;
    procedure Set_StayInSync(pbStayInSync: WordBool); safecall;
    function Get_StayInSync: WordBool; safecall;
    function GetString(StringFormat: StringFormatEnum; NumRows: Integer; 
                       const ColumnDelimeter: WideString; const RowDelimeter: WideString; 
      const NullExpr: WideString): WideString; safecall;
    function Get_DataMember: WideString; safecall;
    procedure Set_DataMember(const pbstrDataMember: WideString); safecall;
    function CompareBookmarks(Bookmark1: OleVariant; Bookmark2: OleVariant): CompareEnum; safecall;
    function Clone(LockType: LockTypeEnum): _Recordset; safecall;
    procedure Resync(AffectRecords: AffectEnum; ResyncValues: ResyncEnum); safecall;
    property DataSource: IUnknown read Get_DataSource write _Set_DataSource;
    property ActiveCommand: IDispatch read Get_ActiveCommand;
    property StayInSync: WordBool read Get_StayInSync write Set_StayInSync;
    property DataMember: WideString read Get_DataMember write Set_DataMember;
  end;

// *********************************************************************//
// DispIntf:  Recordset20Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000054F-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Recordset20Disp = dispinterface
    ['{0000054F-0000-0010-8000-00AA006D2EA4}']
    procedure Cancel; dispid 1055;
    property DataSource: IUnknown dispid 1056;
    procedure _xSave(const FileName: WideString; PersistFormat: PersistFormatEnum); dispid 1610874883;
    property ActiveCommand: IDispatch readonly dispid 1061;
    property StayInSync: WordBool dispid 1063;
    function GetString(StringFormat: StringFormatEnum; NumRows: Integer; 
                       const ColumnDelimeter: WideString; const RowDelimeter: WideString; 
      const NullExpr: WideString): WideString; dispid 1062;
    property DataMember: WideString dispid 1064;
    function CompareBookmarks(Bookmark1: OleVariant; Bookmark2: OleVariant): CompareEnum; dispid 1065;
    function Clone(LockType: LockTypeEnum): _Recordset; dispid 1034;
    procedure Resync(AffectRecords: AffectEnum; ResyncValues: ResyncEnum); dispid 1024;
    property AbsolutePosition: PositionEnum_Param dispid 1000;
    function ActiveConnection: IDispatch; dispid 1001;
    property BOF: WordBool readonly dispid 1002;
    property Bookmark: OleVariant dispid 1003;
    property CacheSize: Integer dispid 1004;
    property CursorType: CursorTypeEnum dispid 1005;
    property EOF: WordBool readonly dispid 1006;
    property Fields: Fields readonly dispid 0;
    property LockType: LockTypeEnum dispid 1008;
    property MaxRecords: ADO_LONGPTR dispid 1009;
    property RecordCount: ADO_LONGPTR readonly dispid 1010;
    function Source: IDispatch; dispid 1011;
    procedure AddNew(FieldList: OleVariant; Values: OleVariant); dispid 1012;
    procedure CancelUpdate; dispid 1013;
    procedure Close; dispid 1014;
    procedure Delete(AffectRecords: AffectEnum); dispid 1015;
    function GetRows(Rows: Integer; Start: OleVariant; Fields: OleVariant): OleVariant; dispid 1016;
    procedure Move(NumRecords: ADO_LONGPTR; Start: OleVariant); dispid 1017;
    procedure MoveNext; dispid 1018;
    procedure MovePrevious; dispid 1019;
    procedure MoveFirst; dispid 1020;
    procedure MoveLast; dispid 1021;
    procedure Open(Source: OleVariant; ActiveConnection: OleVariant; CursorType: CursorTypeEnum; 
      LockType: LockTypeEnum; Options: Integer); dispid 1022;
    procedure Requery(Options: Integer); dispid 1023;
    procedure _xResync(AffectRecords: AffectEnum); dispid 1610809378;
    procedure Update(Fields: OleVariant; Values: OleVariant); dispid 1025;
    property AbsolutePage: PositionEnum_Param dispid 1047;
    property EditMode: EditModeEnum readonly dispid 1026;
    property Filter: OleVariant dispid 1030;
    property PageCount: ADO_LONGPTR readonly dispid 1050;
    property PageSize: Integer dispid 1048;
    property Sort: WideString dispid 1031;
    property Status: Integer readonly dispid 1029;
    property State: Integer readonly dispid 1054;
    function _xClone: _Recordset; dispid 1610809392;
    procedure UpdateBatch(AffectRecords: AffectEnum); dispid 1035;
    procedure CancelBatch(AffectRecords: AffectEnum); dispid 1049;
    property CursorLocation: CursorLocationEnum dispid 1051;
    function NextRecordset(out RecordsAffected: OleVariant): _Recordset; dispid 1052;
    function Supports(CursorOptions: CursorOptionEnum): WordBool; dispid 1036;
    property Collect[Index: OleVariant]: OleVariant dispid -8;
    property MarshalOptions: MarshalOptionsEnum dispid 1053;
    procedure Find(const Criteria: WideString; SkipRecords: ADO_LONGPTR; 
      SearchDirection: SearchDirectionEnum; Start: OleVariant); dispid 1058;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: Recordset21
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000555-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Recordset21 = interface(Recordset20)
    ['{00000555-0000-0010-8000-00AA006D2EA4}']
    procedure Seek(KeyValues: OleVariant; SeekOption: SeekEnum); safecall;
    procedure Set_Index(const pbstrIndex: WideString); safecall;
    function Get_Index: WideString; safecall;
    property Index: WideString read Get_Index write Set_Index;
  end;

// *********************************************************************//
// DispIntf:  Recordset21Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000555-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Recordset21Disp = dispinterface
    ['{00000555-0000-0010-8000-00AA006D2EA4}']
    procedure Seek(KeyValues: OleVariant; SeekOption: SeekEnum); dispid 1066;
    property Index: WideString dispid 1067;
    procedure Cancel; dispid 1055;
    property DataSource: IUnknown dispid 1056;
    procedure _xSave(const FileName: WideString; PersistFormat: PersistFormatEnum); dispid 1610874883;
    property ActiveCommand: IDispatch readonly dispid 1061;
    property StayInSync: WordBool dispid 1063;
    function GetString(StringFormat: StringFormatEnum; NumRows: Integer; 
                       const ColumnDelimeter: WideString; const RowDelimeter: WideString; 
                       const NullExpr: WideString): WideString; dispid 1062;
    property DataMember: WideString dispid 1064;
    function CompareBookmarks(Bookmark1: OleVariant; Bookmark2: OleVariant): CompareEnum; dispid 1065;
    function Clone(LockType: LockTypeEnum): _Recordset; dispid 1034;
    procedure Resync(AffectRecords: AffectEnum; ResyncValues: ResyncEnum); dispid 1024;
    property AbsolutePosition: PositionEnum_Param dispid 1000;
    function ActiveConnection: IDispatch; dispid 1001;
    property BOF: WordBool readonly dispid 1002;
    property Bookmark: OleVariant dispid 1003;
    property CacheSize: Integer dispid 1004;
    property CursorType: CursorTypeEnum dispid 1005;
    property EOF: WordBool readonly dispid 1006;
    property Fields: Fields readonly dispid 0;
    property LockType: LockTypeEnum dispid 1008;
    property MaxRecords: ADO_LONGPTR dispid 1009;
    property RecordCount: ADO_LONGPTR readonly dispid 1010;
    function Source: IDispatch; dispid 1011;
    procedure AddNew(FieldList: OleVariant; Values: OleVariant); dispid 1012;
    procedure CancelUpdate; dispid 1013;
    procedure Close; dispid 1014;
    procedure Delete(AffectRecords: AffectEnum); dispid 1015;
    function GetRows(Rows: Integer; Start: OleVariant; Fields: OleVariant): OleVariant; dispid 1016;
    procedure Move(NumRecords: ADO_LONGPTR; Start: OleVariant); dispid 1017;
    procedure MoveNext; dispid 1018;
    procedure MovePrevious; dispid 1019;
    procedure MoveFirst; dispid 1020;
    procedure MoveLast; dispid 1021;
    procedure Open(Source: OleVariant; ActiveConnection: OleVariant; CursorType: CursorTypeEnum; 
                   LockType: LockTypeEnum; Options: Integer); dispid 1022;
    procedure Requery(Options: Integer); dispid 1023;
    procedure _xResync(AffectRecords: AffectEnum); dispid 1610809378;
    procedure Update(Fields: OleVariant; Values: OleVariant); dispid 1025;
    property AbsolutePage: PositionEnum_Param dispid 1047;
    property EditMode: EditModeEnum readonly dispid 1026;
    property Filter: OleVariant dispid 1030;
    property PageCount: ADO_LONGPTR readonly dispid 1050;
    property PageSize: Integer dispid 1048;
    property Sort: WideString dispid 1031;
    property Status: Integer readonly dispid 1029;
    property State: Integer readonly dispid 1054;
    function _xClone: _Recordset; dispid 1610809392;
    procedure UpdateBatch(AffectRecords: AffectEnum); dispid 1035;
    procedure CancelBatch(AffectRecords: AffectEnum); dispid 1049;
    property CursorLocation: CursorLocationEnum dispid 1051;
    function NextRecordset(out RecordsAffected: OleVariant): _Recordset; dispid 1052;
    function Supports(CursorOptions: CursorOptionEnum): WordBool; dispid 1036;
    property Collect[Index: OleVariant]: OleVariant dispid -8;
    property MarshalOptions: MarshalOptionsEnum dispid 1053;
    procedure Find(const Criteria: WideString; SkipRecords: ADO_LONGPTR; 
                   SearchDirection: SearchDirectionEnum; Start: OleVariant); dispid 1058;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: _Recordset
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000556-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _Recordset = interface(Recordset21)
    ['{00000556-0000-0010-8000-00AA006D2EA4}']
    procedure Save(Destination: OleVariant; PersistFormat: PersistFormatEnum); safecall;
  end;

// *********************************************************************//
// DispIntf:  _RecordsetDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000556-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _RecordsetDisp = dispinterface
    ['{00000556-0000-0010-8000-00AA006D2EA4}']
    procedure Save(Destination: OleVariant; PersistFormat: PersistFormatEnum); dispid 1057;
    procedure Seek(KeyValues: OleVariant; SeekOption: SeekEnum); dispid 1066;
    property Index: WideString dispid 1067;
    procedure Cancel; dispid 1055;
    property DataSource: IUnknown dispid 1056;
    procedure _xSave(const FileName: WideString; PersistFormat: PersistFormatEnum); dispid 1610874883;
    property ActiveCommand: IDispatch readonly dispid 1061;
    property StayInSync: WordBool dispid 1063;
    function GetString(StringFormat: StringFormatEnum; NumRows: Integer; 
                       const ColumnDelimeter: WideString; const RowDelimeter: WideString; 
      const NullExpr: WideString): WideString; dispid 1062;
    property DataMember: WideString dispid 1064;
    function CompareBookmarks(Bookmark1: OleVariant; Bookmark2: OleVariant): CompareEnum; dispid 1065;
    function Clone(LockType: LockTypeEnum): _Recordset; dispid 1034;
    procedure Resync(AffectRecords: AffectEnum; ResyncValues: ResyncEnum); dispid 1024;
    property AbsolutePosition: PositionEnum_Param dispid 1000;
    function ActiveConnection: IDispatch; dispid 1001;
    property BOF: WordBool readonly dispid 1002;
    property Bookmark: OleVariant dispid 1003;
    property CacheSize: Integer dispid 1004;
    property CursorType: CursorTypeEnum dispid 1005;
    property EOF: WordBool readonly dispid 1006;
    property Fields: Fields readonly dispid 0;
    property LockType: LockTypeEnum dispid 1008;
    property MaxRecords: ADO_LONGPTR dispid 1009;
    property RecordCount: ADO_LONGPTR readonly dispid 1010;
    function Source: IDispatch; dispid 1011;
    procedure AddNew(FieldList: OleVariant; Values: OleVariant); dispid 1012;
    procedure CancelUpdate; dispid 1013;
    procedure Close; dispid 1014;
    procedure Delete(AffectRecords: AffectEnum); dispid 1015;
    function GetRows(Rows: Integer; Start: OleVariant; Fields: OleVariant): OleVariant; dispid 1016;
    procedure Move(NumRecords: ADO_LONGPTR; Start: OleVariant); dispid 1017;
    procedure MoveNext; dispid 1018;
    procedure MovePrevious; dispid 1019;
    procedure MoveFirst; dispid 1020;
    procedure MoveLast; dispid 1021;
    procedure Open(Source: OleVariant; ActiveConnection: OleVariant; CursorType: CursorTypeEnum; 
      LockType: LockTypeEnum; Options: Integer); dispid 1022;
    procedure Requery(Options: Integer); dispid 1023;
    procedure _xResync(AffectRecords: AffectEnum); dispid 1610809378;
    procedure Update(Fields: OleVariant; Values: OleVariant); dispid 1025;
    property AbsolutePage: PositionEnum_Param dispid 1047;
    property EditMode: EditModeEnum readonly dispid 1026;
    property Filter: OleVariant dispid 1030;
    property PageCount: ADO_LONGPTR readonly dispid 1050;
    property PageSize: Integer dispid 1048;
    property Sort: WideString dispid 1031;
    property Status: Integer readonly dispid 1029;
    property State: Integer readonly dispid 1054;
    function _xClone: _Recordset; dispid 1610809392;
    procedure UpdateBatch(AffectRecords: AffectEnum); dispid 1035;
    procedure CancelBatch(AffectRecords: AffectEnum); dispid 1049;
    property CursorLocation: CursorLocationEnum dispid 1051;
    function NextRecordset(out RecordsAffected: OleVariant): _Recordset; dispid 1052;
    function Supports(CursorOptions: CursorOptionEnum): WordBool; dispid 1036;
    property Collect[Index: OleVariant]: OleVariant dispid -8;
    property MarshalOptions: MarshalOptionsEnum dispid 1053;
    procedure Find(const Criteria: WideString; SkipRecords: ADO_LONGPTR; 
      SearchDirection: SearchDirectionEnum; Start: OleVariant); dispid 1058;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: Fields15
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000506-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Fields15 = interface(_Collection)
    ['{00000506-0000-0010-8000-00AA006D2EA4}']
    function Get_Item(Index: OleVariant): Field; safecall;
    property Item[Index: OleVariant]: Field read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  Fields15Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000506-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Fields15Disp = dispinterface
    ['{00000506-0000-0010-8000-00AA006D2EA4}']
    property Item[Index: OleVariant]: Field readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
    function _NewEnum: IUnknown; dispid -4;
    procedure Refresh; dispid 2;
  end;

// *********************************************************************//
// Interface: Fields20
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000054D-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Fields20 = interface(Fields15)
    ['{0000054D-0000-0010-8000-00AA006D2EA4}']
    procedure _Append(const Name: WideString; Type_: DataTypeEnum; DefinedSize: ADO_LONGPTR; 
                      Attrib: FieldAttributeEnum); safecall;
    procedure Delete(Index: OleVariant); safecall;
  end;

// *********************************************************************//
// DispIntf:  Fields20Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000054D-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Fields20Disp = dispinterface
    ['{0000054D-0000-0010-8000-00AA006D2EA4}']
    procedure _Append(const Name: WideString; Type_: DataTypeEnum; DefinedSize: ADO_LONGPTR; 
                      Attrib: FieldAttributeEnum); dispid 1610874880;
    procedure Delete(Index: OleVariant); dispid 4;
    property Item[Index: OleVariant]: Field readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
    function _NewEnum: IUnknown; dispid -4;
    procedure Refresh; dispid 2;
  end;

// *********************************************************************//
// Interface: Fields
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000564-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Fields = interface(Fields20)
    ['{00000564-0000-0010-8000-00AA006D2EA4}']
    procedure Append(const Name: WideString; Type_: DataTypeEnum; DefinedSize: ADO_LONGPTR; 
                     Attrib: FieldAttributeEnum; FieldValue: OleVariant); safecall;
    procedure Update; safecall;
    procedure Resync(ResyncValues: ResyncEnum); safecall;
    procedure CancelUpdate; safecall;
  end;

// *********************************************************************//
// DispIntf:  FieldsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000564-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  FieldsDisp = dispinterface
    ['{00000564-0000-0010-8000-00AA006D2EA4}']
    procedure Append(const Name: WideString; Type_: DataTypeEnum; DefinedSize: ADO_LONGPTR; 
                     Attrib: FieldAttributeEnum; FieldValue: OleVariant); dispid 3;
    procedure Update; dispid 5;
    procedure Resync(ResyncValues: ResyncEnum); dispid 6;
    procedure CancelUpdate; dispid 7;
    procedure _Append(const Name: WideString; Type_: DataTypeEnum; DefinedSize: ADO_LONGPTR; 
                      Attrib: FieldAttributeEnum); dispid 1610874880;
    procedure Delete(Index: OleVariant); dispid 4;
    property Item[Index: OleVariant]: Field readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
    function _NewEnum: IUnknown; dispid -4;
    procedure Refresh; dispid 2;
  end;

// *********************************************************************//
// Interface: Field20
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000054C-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Field20 = interface(_ADO)
    ['{0000054C-0000-0010-8000-00AA006D2EA4}']
    function Get_ActualSize: ADO_LONGPTR; safecall;
    function Get_Attributes: Integer; safecall;
    function Get_DefinedSize: ADO_LONGPTR; safecall;
    function Get_Name: WideString; safecall;
    function Get_Type_: DataTypeEnum; safecall;
    function Get_Value: OleVariant; safecall;
    procedure Set_Value(pvar: OleVariant); safecall;
    function Get_Precision: Byte; safecall;
    function Get_NumericScale: Byte; safecall;
    procedure AppendChunk(Data: OleVariant); safecall;
    function GetChunk(Length: Integer): OleVariant; safecall;
    function Get_OriginalValue: OleVariant; safecall;
    function Get_UnderlyingValue: OleVariant; safecall;
    function Get_DataFormat: IUnknown; safecall;
    procedure _Set_DataFormat(const ppiDF: IUnknown); safecall;
    procedure Set_Precision(pbPrecision: Byte); safecall;
    procedure Set_NumericScale(pbNumericScale: Byte); safecall;
    procedure Set_Type_(pDataType: DataTypeEnum); safecall;
    procedure Set_DefinedSize(pl: ADO_LONGPTR); safecall;
    procedure Set_Attributes(pl: Integer); safecall;
    property ActualSize: ADO_LONGPTR read Get_ActualSize;
    property Attributes: Integer read Get_Attributes write Set_Attributes;
    property DefinedSize: ADO_LONGPTR read Get_DefinedSize write Set_DefinedSize;
    property Name: WideString read Get_Name;
    property Type_: DataTypeEnum read Get_Type_ write Set_Type_;
    property Value: OleVariant read Get_Value write Set_Value;
    property Precision: Byte read Get_Precision write Set_Precision;
    property NumericScale: Byte read Get_NumericScale write Set_NumericScale;
    property OriginalValue: OleVariant read Get_OriginalValue;
    property UnderlyingValue: OleVariant read Get_UnderlyingValue;
    property DataFormat: IUnknown read Get_DataFormat write _Set_DataFormat;
  end;

// *********************************************************************//
// DispIntf:  Field20Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000054C-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Field20Disp = dispinterface
    ['{0000054C-0000-0010-8000-00AA006D2EA4}']
    property ActualSize: ADO_LONGPTR readonly dispid 1109;
    property Attributes: Integer dispid 1114;
    property DefinedSize: ADO_LONGPTR dispid 1103;
    property Name: WideString readonly dispid 1100;
    property Type_: DataTypeEnum dispid 1102;
    property Value: OleVariant dispid 0;
    property Precision: Byte dispid 1112;
    property NumericScale: Byte dispid 1113;
    procedure AppendChunk(Data: OleVariant); dispid 1107;
    function GetChunk(Length: Integer): OleVariant; dispid 1108;
    property OriginalValue: OleVariant readonly dispid 1104;
    property UnderlyingValue: OleVariant readonly dispid 1105;
    property DataFormat: IUnknown dispid 1115;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: Field
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000569-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Field = interface(Field20)
    ['{00000569-0000-0010-8000-00AA006D2EA4}']
    function Get_Status: Integer; safecall;
    property Status: Integer read Get_Status;
  end;

// *********************************************************************//
// DispIntf:  FieldDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000569-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  FieldDisp = dispinterface
    ['{00000569-0000-0010-8000-00AA006D2EA4}']
    property Status: Integer readonly dispid 1116;
    property ActualSize: ADO_LONGPTR readonly dispid 1109;
    property Attributes: Integer dispid 1114;
    property DefinedSize: ADO_LONGPTR dispid 1103;
    property Name: WideString readonly dispid 1100;
    property Type_: DataTypeEnum dispid 1102;
    property Value: OleVariant dispid 0;
    property Precision: Byte dispid 1112;
    property NumericScale: Byte dispid 1113;
    procedure AppendChunk(Data: OleVariant); dispid 1107;
    function GetChunk(Length: Integer): OleVariant; dispid 1108;
    property OriginalValue: OleVariant readonly dispid 1104;
    property UnderlyingValue: OleVariant readonly dispid 1105;
    property DataFormat: IUnknown dispid 1115;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: _Parameter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000050C-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _Parameter = interface(_ADO)
    ['{0000050C-0000-0010-8000-00AA006D2EA4}']
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pbstr: WideString); safecall;
    function Get_Value: OleVariant; safecall;
    procedure Set_Value(pvar: OleVariant); safecall;
    function Get_Type_: DataTypeEnum; safecall;
    procedure Set_Type_(psDataType: DataTypeEnum); safecall;
    procedure Set_Direction(plParmDirection: ParameterDirectionEnum); safecall;
    function Get_Direction: ParameterDirectionEnum; safecall;
    procedure Set_Precision(pbPrecision: Byte); safecall;
    function Get_Precision: Byte; safecall;
    procedure Set_NumericScale(pbScale: Byte); safecall;
    function Get_NumericScale: Byte; safecall;
    procedure Set_Size(pl: ADO_LONGPTR); safecall;
    function Get_Size: ADO_LONGPTR; safecall;
    procedure AppendChunk(Val: OleVariant); safecall;
    function Get_Attributes: Integer; safecall;
    procedure Set_Attributes(plParmAttribs: Integer); safecall;
    property Name: WideString read Get_Name write Set_Name;
    property Value: OleVariant read Get_Value write Set_Value;
    property Type_: DataTypeEnum read Get_Type_ write Set_Type_;
    property Direction: ParameterDirectionEnum read Get_Direction write Set_Direction;
    property Precision: Byte read Get_Precision write Set_Precision;
    property NumericScale: Byte read Get_NumericScale write Set_NumericScale;
    property Size: ADO_LONGPTR read Get_Size write Set_Size;
    property Attributes: Integer read Get_Attributes write Set_Attributes;
  end;

// *********************************************************************//
// DispIntf:  _ParameterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000050C-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _ParameterDisp = dispinterface
    ['{0000050C-0000-0010-8000-00AA006D2EA4}']
    property Name: WideString dispid 1;
    property Value: OleVariant dispid 0;
    property Type_: DataTypeEnum dispid 2;
    property Direction: ParameterDirectionEnum dispid 3;
    property Precision: Byte dispid 4;
    property NumericScale: Byte dispid 5;
    property Size: ADO_LONGPTR dispid 6;
    procedure AppendChunk(Val: OleVariant); dispid 7;
    property Attributes: Integer dispid 8;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: Parameters
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000050D-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Parameters = interface(_DynaCollection)
    ['{0000050D-0000-0010-8000-00AA006D2EA4}']
    function Get_Item(Index: OleVariant): _Parameter; safecall;
    property Item[Index: OleVariant]: _Parameter read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  ParametersDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000050D-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ParametersDisp = dispinterface
    ['{0000050D-0000-0010-8000-00AA006D2EA4}']
    property Item[Index: OleVariant]: _Parameter readonly dispid 0; default;
    procedure Append(const Object_: IDispatch); dispid 1610809344;
    procedure Delete(Index: OleVariant); dispid 1610809345;
    property Count: Integer readonly dispid 1;
    function _NewEnum: IUnknown; dispid -4;
    procedure Refresh; dispid 2;
  end;

// *********************************************************************//
// Interface: Command25
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000054E-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Command25 = interface(Command15)
    ['{0000054E-0000-0010-8000-00AA006D2EA4}']
    function Get_State: Integer; safecall;
    procedure Cancel; safecall;
    property State: Integer read Get_State;
  end;

// *********************************************************************//
// DispIntf:  Command25Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0000054E-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Command25Disp = dispinterface
    ['{0000054E-0000-0010-8000-00AA006D2EA4}']
    property State: Integer readonly dispid 9;
    procedure Cancel; dispid 10;
    function ActiveConnection: _Connection; dispid 1;
    property CommandText: WideString dispid 2;
    property CommandTimeout: Integer dispid 3;
    property Prepared: WordBool dispid 4;
    function Execute(out RecordsAffected: OleVariant; var Parameters: OleVariant; Options: Integer): _Recordset; dispid 5;
    function CreateParameter(const Name: WideString; Type_: DataTypeEnum; 
                             Direction: ParameterDirectionEnum; Size: ADO_LONGPTR; Value: OleVariant): _Parameter; dispid 6;
    property Parameters: Parameters readonly dispid 0;
    property CommandType: CommandTypeEnum dispid 7;
    property Name: WideString dispid 8;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: _Command
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B08400BD-F9D1-4D02-B856-71D5DBA123E9}
// *********************************************************************//
  _Command = interface(Command25)
    ['{B08400BD-F9D1-4D02-B856-71D5DBA123E9}']
    procedure _Set_CommandStream(const pvStream: IUnknown); safecall;
    function Get_CommandStream: OleVariant; safecall;
    procedure Set_Dialect(const pbstrDialect: WideString); safecall;
    function Get_Dialect: WideString; safecall;
    procedure Set_NamedParameters(pfNamedParameters: WordBool); safecall;
    function Get_NamedParameters: WordBool; safecall;
    property Dialect: WideString read Get_Dialect write Set_Dialect;
    property NamedParameters: WordBool read Get_NamedParameters write Set_NamedParameters;
  end;

// *********************************************************************//
// DispIntf:  _CommandDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B08400BD-F9D1-4D02-B856-71D5DBA123E9}
// *********************************************************************//
  _CommandDisp = dispinterface
    ['{B08400BD-F9D1-4D02-B856-71D5DBA123E9}']
    function CommandStream: IUnknown; dispid 11;
    property Dialect: WideString dispid 12;
    property NamedParameters: WordBool dispid 13;
    property State: Integer readonly dispid 9;
    procedure Cancel; dispid 10;
    function ActiveConnection: _Connection; dispid 1;
    property CommandText: WideString dispid 2;
    property CommandTimeout: Integer dispid 3;
    property Prepared: WordBool dispid 4;
    function Execute(out RecordsAffected: OleVariant; var Parameters: OleVariant; Options: Integer): _Recordset; dispid 5;
    function CreateParameter(const Name: WideString; Type_: DataTypeEnum; 
                             Direction: ParameterDirectionEnum; Size: ADO_LONGPTR; Value: OleVariant): _Parameter; dispid 6;
    property Parameters: Parameters readonly dispid 0;
    property CommandType: CommandTypeEnum dispid 7;
    property Name: WideString dispid 8;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: ConnectionEventsVt
// Flags:     (16) Hidden
// GUID:      {00000402-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ConnectionEventsVt = interface(IUnknown)
    ['{00000402-0000-0010-8000-00AA006D2EA4}']
{$IFDEF CG_EDITS} // Use safecall
    procedure InfoMessage(const pError: Error; var adStatus: EventStatusEnum;
      const pConnection: _Connection); safecall;
    procedure BeginTransComplete(TransactionLevel: Integer; const pError: Error;
      var adStatus: EventStatusEnum; const pConnection: _Connection); safecall;
    procedure CommitTransComplete(const pError: Error; var adStatus: EventStatusEnum;
      const pConnection: _Connection); safecall;
    procedure RollbackTransComplete(const pError: Error; var adStatus: EventStatusEnum;
      const pConnection: _Connection); safecall;
    procedure WillExecute(var Source: WideString; var CursorType: CursorTypeEnum;
      var LockType: LockTypeEnum; var Options: Integer;
      var adStatus: EventStatusEnum; const pCommand: _Command;
      const pRecordset: _Recordset; const pConnection: _Connection); safecall;
    procedure ExecuteComplete(RecordsAffected: Integer; const pError: Error;
      var adStatus: EventStatusEnum; const pCommand: _Command;
      const pRecordset: _Recordset; const pConnection: _Connection); safecall;
    procedure WillConnect(var ConnectionString: WideString; var UserID: WideString;
      var Password: WideString; var Options: Integer;
      var adStatus: EventStatusEnum; const pConnection: _Connection); safecall;
    procedure ConnectComplete(const pError: Error; var adStatus: EventStatusEnum;
      const pConnection: _Connection); safecall;
    procedure Disconnect(var adStatus: EventStatusEnum; const pConnection: _Connection); safecall;
{$ELSE}
    function InfoMessage(const pError: Error; var adStatus: EventStatusEnum; 
                         const pConnection: _Connection): HResult; stdcall;
    function BeginTransComplete(TransactionLevel: Integer; const pError: Error; 
                                var adStatus: EventStatusEnum; const pConnection: _Connection): HResult; stdcall;
    function CommitTransComplete(const pError: Error; var adStatus: EventStatusEnum; 
                                 const pConnection: _Connection): HResult; stdcall;
    function RollbackTransComplete(const pError: Error; var adStatus: EventStatusEnum; 
                                   const pConnection: _Connection): HResult; stdcall;
    function WillExecute(var Source: WideString; var CursorType: CursorTypeEnum; 
                         var LockType: LockTypeEnum; var Options: Integer; 
                         var adStatus: EventStatusEnum; const pCommand: _Command; 
                         const pRecordset: _Recordset; const pConnection: _Connection): HResult; stdcall;
    function ExecuteComplete(RecordsAffected: Integer; const pError: Error; 
                             var adStatus: EventStatusEnum; const pCommand: _Command; 
                             const pRecordset: _Recordset; const pConnection: _Connection): HResult; stdcall;
    function WillConnect(var ConnectionString: WideString; var UserID: WideString; 
                         var Password: WideString; var Options: Integer; 
                         var adStatus: EventStatusEnum; const pConnection: _Connection): HResult; stdcall;
    function ConnectComplete(const pError: Error; var adStatus: EventStatusEnum; 
                             const pConnection: _Connection): HResult; stdcall;
    function Disconnect(var adStatus: EventStatusEnum; const pConnection: _Connection): HResult; stdcall;
{$ENDIF}
  end;

// *********************************************************************//
// Interface: RecordsetEventsVt
// Flags:     (16) Hidden
// GUID:      {00000403-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  RecordsetEventsVt = interface(IUnknown)
    ['{00000403-0000-0010-8000-00AA006D2EA4}']
{$IFDEF CG_EDITS} // Use safecall
    procedure WillChangeField(cFields: Integer; Fields: OleVariant;
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); safecall;
    procedure FieldChangeComplete(cFields: Integer; Fields: OleVariant;
      const pError: Error; var adStatus: EventStatusEnum;
      const pRecordset: _Recordset); safecall;
    procedure WillChangeRecord(adReason: EventReasonEnum;
      cRecords: Integer; var adStatus: EventStatusEnum;
      const pRecordset: _Recordset); safecall;
    procedure RecordChangeComplete(adReason: EventReasonEnum;
      cRecords: Integer; const pError: Error;
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); safecall;
    procedure WillChangeRecordset(adReason: EventReasonEnum;
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); safecall;
    procedure RecordsetChangeComplete(adReason: EventReasonEnum;
      const pError: Error; var adStatus: EventStatusEnum;
      const pRecordset: _Recordset); safecall;
    procedure WillMove(adReason: EventReasonEnum;
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); safecall;
    procedure MoveComplete(adReason: EventReasonEnum; const pError: Error;
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); safecall;
    procedure EndOfRecordset(var fMoreData: WordBool;
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); safecall;
    procedure FetchProgress(Progress, MaxProgress: Integer;
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); safecall;
    procedure FetchComplete(const pError: Error;
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); safecall;
{$ELSE}
    function WillChangeField(cFields: Integer; Fields: OleVariant; var adStatus: EventStatusEnum; 
                             const pRecordset: _Recordset): HResult; stdcall;
    function FieldChangeComplete(cFields: Integer; Fields: OleVariant; const pError: Error; 
                                 var adStatus: EventStatusEnum; const pRecordset: _Recordset): HResult; stdcall;
    function WillChangeRecord(adReason: EventReasonEnum; cRecords: Integer; 
                              var adStatus: EventStatusEnum; const pRecordset: _Recordset): HResult; stdcall;
    function RecordChangeComplete(adReason: EventReasonEnum; cRecords: Integer; 
                                  const pError: Error; var adStatus: EventStatusEnum; 
                                  const pRecordset: _Recordset): HResult; stdcall;
    function WillChangeRecordset(adReason: EventReasonEnum; var adStatus: EventStatusEnum; 
                                 const pRecordset: _Recordset): HResult; stdcall;
    function RecordsetChangeComplete(adReason: EventReasonEnum; const pError: Error; 
                                     var adStatus: EventStatusEnum; const pRecordset: _Recordset): HResult; stdcall;
    function WillMove(adReason: EventReasonEnum; var adStatus: EventStatusEnum; 
                      const pRecordset: _Recordset): HResult; stdcall;
    function MoveComplete(adReason: EventReasonEnum; const pError: Error; 
                          var adStatus: EventStatusEnum; const pRecordset: _Recordset): HResult; stdcall;
    function EndOfRecordset(var fMoreData: WordBool; var adStatus: EventStatusEnum; 
                            const pRecordset: _Recordset): HResult; stdcall;
    function FetchProgress(Progress: Integer; MaxProgress: Integer; var adStatus: EventStatusEnum; 
                           const pRecordset: _Recordset): HResult; stdcall;
    function FetchComplete(const pError: Error; var adStatus: EventStatusEnum; 
                           const pRecordset: _Recordset): HResult; stdcall;
{$ENDIF}
  end;

// *********************************************************************//
// DispIntf:  ConnectionEvents
// Flags:     (4096) Dispatchable
// GUID:      {00000400-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ConnectionEvents = dispinterface
    ['{00000400-0000-0010-8000-00AA006D2EA4}']
    procedure InfoMessage(const pError: Error; var adStatus: EventStatusEnum; 
      const pConnection: _Connection); dispid 0;
    procedure BeginTransComplete(TransactionLevel: Integer; const pError: Error; 
      var adStatus: EventStatusEnum; const pConnection: _Connection); dispid 1;
    procedure CommitTransComplete(const pError: Error; var adStatus: EventStatusEnum; 
      const pConnection: _Connection); dispid 3;
    procedure RollbackTransComplete(const pError: Error; var adStatus: EventStatusEnum; 
      const pConnection: _Connection); dispid 2;
    procedure WillExecute(var Source: WideString; var CursorType: CursorTypeEnum; 
                          var LockType: LockTypeEnum; var Options: Integer; 
                          var adStatus: EventStatusEnum; const pCommand: _Command; 
      const pRecordset: _Recordset; const pConnection: _Connection); dispid 4;
    procedure ExecuteComplete(RecordsAffected: Integer; const pError: Error; 
                              var adStatus: EventStatusEnum; const pCommand: _Command; 
      const pRecordset: _Recordset; const pConnection: _Connection); dispid 5;
    procedure WillConnect(var ConnectionString: WideString; var UserID: WideString; 
                          var Password: WideString; var Options: Integer; 
      var adStatus: EventStatusEnum; const pConnection: _Connection); dispid 6;
    procedure ConnectComplete(const pError: Error; var adStatus: EventStatusEnum; 
      const pConnection: _Connection); dispid 7;
    procedure Disconnect(var adStatus: EventStatusEnum; const pConnection: _Connection); dispid 8;
  end;

// *********************************************************************//
// DispIntf:  RecordsetEvents
// Flags:     (4096) Dispatchable
// GUID:      {00000266-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  RecordsetEvents = dispinterface
    ['{00000266-0000-0010-8000-00AA006D2EA4}']
    procedure WillChangeField(cFields: Integer; Fields: OleVariant; var adStatus: EventStatusEnum; 
      const pRecordset: _Recordset); dispid 9;
    procedure FieldChangeComplete(cFields: Integer; Fields: OleVariant; const pError: Error; 
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); dispid 10;
    procedure WillChangeRecord(adReason: EventReasonEnum; cRecords: Integer; 
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); dispid 11;
    procedure RecordChangeComplete(adReason: EventReasonEnum; cRecords: Integer; 
                                   const pError: Error; var adStatus: EventStatusEnum; 
      const pRecordset: _Recordset); dispid 12;
    procedure WillChangeRecordset(adReason: EventReasonEnum; var adStatus: EventStatusEnum; 
      const pRecordset: _Recordset); dispid 13;
    procedure RecordsetChangeComplete(adReason: EventReasonEnum; const pError: Error; 
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); dispid 14;
    procedure WillMove(adReason: EventReasonEnum; var adStatus: EventStatusEnum; 
      const pRecordset: _Recordset); dispid 15;
    procedure MoveComplete(adReason: EventReasonEnum; const pError: Error; 
      var adStatus: EventStatusEnum; const pRecordset: _Recordset); dispid 16;
    procedure EndOfRecordset(var fMoreData: WordBool; var adStatus: EventStatusEnum; 
      const pRecordset: _Recordset); dispid 17;
    procedure FetchProgress(Progress: Integer; MaxProgress: Integer; var adStatus: EventStatusEnum; 
      const pRecordset: _Recordset); dispid 18;
    procedure FetchComplete(const pError: Error; var adStatus: EventStatusEnum;
      const pRecordset: _Recordset); dispid 19;
  end;

// *********************************************************************//
// Interface: ADOConnectionConstruction15
// Flags:     (512) Restricted
// GUID:      {00000516-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ADOConnectionConstruction15 = interface(IUnknown)
    ['{00000516-0000-0010-8000-00AA006D2EA4}']
{$IFDEF CG_EDITS}  // Use safecall
    function Get_DSO: IUnknown; safecall;
    function Get_Session: IUnknown; safecall;
    procedure WrapDSOandSession(const pDSO: IUnknown; const pSession: IUnknown); safecall;
{$ELSE}
    function Get_DSO(out ppDSO: IUnknown): HResult; stdcall;
    function Get_Session(out ppSession: IUnknown): HResult; stdcall;
    function WrapDSOandSession(const pDSO: IUnknown; const pSession: IUnknown): HResult; stdcall;
{$ENDIF}
  end;

// *********************************************************************//
// Interface: ADOConnectionConstruction
// Flags:     (512) Restricted
// GUID:      {00000551-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ADOConnectionConstruction = interface(ADOConnectionConstruction15)
    ['{00000551-0000-0010-8000-00AA006D2EA4}']
  end;

// *********************************************************************//
// Interface: _Record
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {00000562-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _Record = interface(_ADO)
    ['{00000562-0000-0010-8000-00AA006D2EA4}']
    function Get_ActiveConnection: OleVariant; safecall;
    procedure Set_ActiveConnection(const pvar: WideString); safecall;
    procedure _Set_ActiveConnection(const pvar: _Connection); safecall;
    function Get_State: ObjectStateEnum; safecall;
    function Get_Source: OleVariant; safecall;
    procedure Set_Source(const pvar: WideString); safecall;
    procedure _Set_Source(const pvar: IDispatch); safecall;
    function Get_Mode: ConnectModeEnum; safecall;
    procedure Set_Mode(pMode: ConnectModeEnum); safecall;
    function Get_ParentURL: WideString; safecall;
    function MoveRecord(const Source: WideString; const Destination: WideString; 
                        const UserName: WideString; const Password: WideString; 
                        Options: MoveRecordOptionsEnum; Async: WordBool): WideString; safecall;
    function CopyRecord(const Source: WideString; const Destination: WideString; 
                        const UserName: WideString; const Password: WideString; 
                        Options: CopyRecordOptionsEnum; Async: WordBool): WideString; safecall;
    procedure DeleteRecord(const Source: WideString; Async: WordBool); safecall;
    procedure Open(Source: OleVariant; ActiveConnection: OleVariant; Mode: ConnectModeEnum; 
                   CreateOptions: RecordCreateOptionsEnum; Options: RecordOpenOptionsEnum; 
                   const UserName: WideString; const Password: WideString); safecall;
    procedure Close; safecall;
    function Get_Fields: Fields; safecall;
    function Get_RecordType: RecordTypeEnum; safecall;
    function GetChildren: _Recordset; safecall;
    procedure Cancel; safecall;
    property State: ObjectStateEnum read Get_State;
    property Mode: ConnectModeEnum read Get_Mode write Set_Mode;
    property ParentURL: WideString read Get_ParentURL;
    property Fields: Fields read Get_Fields;
    property RecordType: RecordTypeEnum read Get_RecordType;
  end;

// *********************************************************************//
// DispIntf:  _RecordDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {00000562-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _RecordDisp = dispinterface
    ['{00000562-0000-0010-8000-00AA006D2EA4}']
    function ActiveConnection: OleVariant; dispid 1;
    property State: ObjectStateEnum readonly dispid 2;
    function Source: OleVariant; dispid 3;
    property Mode: ConnectModeEnum dispid 4;
    property ParentURL: WideString readonly dispid 5;
    function MoveRecord(const Source: WideString; const Destination: WideString; 
                        const UserName: WideString; const Password: WideString; 
                        Options: MoveRecordOptionsEnum; Async: WordBool): WideString; dispid 6;
    function CopyRecord(const Source: WideString; const Destination: WideString; 
                        const UserName: WideString; const Password: WideString; 
                        Options: CopyRecordOptionsEnum; Async: WordBool): WideString; dispid 7;
    procedure DeleteRecord(const Source: WideString; Async: WordBool); dispid 8;
    procedure Open(Source: OleVariant; ActiveConnection: OleVariant; Mode: ConnectModeEnum; 
                   CreateOptions: RecordCreateOptionsEnum; Options: RecordOpenOptionsEnum; 
                   const UserName: WideString; const Password: WideString); dispid 9;
    procedure Close; dispid 10;
    property Fields: Fields readonly dispid 0;
    property RecordType: RecordTypeEnum readonly dispid 11;
    function GetChildren: _Recordset; dispid 12;
    procedure Cancel; dispid 13;
    property Properties: Properties readonly dispid 500;
  end;

// *********************************************************************//
// Interface: _Stream
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {00000565-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _Stream = interface(IDispatch)
    ['{00000565-0000-0010-8000-00AA006D2EA4}']
    function Get_Size: ADO_LONGPTR; safecall;
    function Get_EOS: WordBool; safecall;
    function Get_Position: ADO_LONGPTR; safecall;
    procedure Set_Position(pPos: ADO_LONGPTR); safecall;
    function Get_Type_: StreamTypeEnum; safecall;
    procedure Set_Type_(ptype: StreamTypeEnum); safecall;
    function Get_LineSeparator: LineSeparatorEnum; safecall;
    procedure Set_LineSeparator(pLS: LineSeparatorEnum); safecall;
    function Get_State: ObjectStateEnum; safecall;
    function Get_Mode: ConnectModeEnum; safecall;
    procedure Set_Mode(pMode: ConnectModeEnum); safecall;
    function Get_Charset: WideString; safecall;
    procedure Set_Charset(const pbstrCharset: WideString); safecall;
    function Read(NumBytes: Integer): OleVariant; safecall;
    procedure Open(Source: OleVariant; Mode: ConnectModeEnum; Options: StreamOpenOptionsEnum; 
                   const UserName: WideString; const Password: WideString); safecall;
    procedure Close; safecall;
    procedure SkipLine; safecall;
    procedure Write(Buffer: OleVariant); safecall;
    procedure SetEOS; safecall;
    procedure CopyTo(const DestStream: _Stream; CharNumber: ADO_LONGPTR); safecall;
    procedure Flush; safecall;
    procedure SaveToFile(const FileName: WideString; Options: SaveOptionsEnum); safecall;
    procedure LoadFromFile(const FileName: WideString); safecall;
    function ReadText(NumChars: Integer): WideString; safecall;
    procedure WriteText(const Data: WideString; Options: StreamWriteEnum); safecall;
    procedure Cancel; safecall;
    property Size: ADO_LONGPTR read Get_Size;
    property EOS: WordBool read Get_EOS;
    property Position: ADO_LONGPTR read Get_Position write Set_Position;
    property Type_: StreamTypeEnum read Get_Type_ write Set_Type_;
    property LineSeparator: LineSeparatorEnum read Get_LineSeparator write Set_LineSeparator;
    property State: ObjectStateEnum read Get_State;
    property Mode: ConnectModeEnum read Get_Mode write Set_Mode;
    property Charset: WideString read Get_Charset write Set_Charset;
  end;

// *********************************************************************//
// DispIntf:  _StreamDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {00000565-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  _StreamDisp = dispinterface
    ['{00000565-0000-0010-8000-00AA006D2EA4}']
    property Size: ADO_LONGPTR readonly dispid 1;
    property EOS: WordBool readonly dispid 2;
    property Position: ADO_LONGPTR dispid 3;
    property Type_: StreamTypeEnum dispid 4;
    property LineSeparator: LineSeparatorEnum dispid 5;
    property State: ObjectStateEnum readonly dispid 6;
    property Mode: ConnectModeEnum dispid 7;
    property Charset: WideString dispid 8;
    function Read(NumBytes: Integer): OleVariant; dispid 9;
    procedure Open(Source: OleVariant; Mode: ConnectModeEnum; Options: StreamOpenOptionsEnum; 
                   const UserName: WideString; const Password: WideString); dispid 10;
    procedure Close; dispid 11;
    procedure SkipLine; dispid 12;
    procedure Write(Buffer: OleVariant); dispid 13;
    procedure SetEOS; dispid 14;
    procedure CopyTo(const DestStream: _Stream; CharNumber: ADO_LONGPTR); dispid 15;
    procedure Flush; dispid 16;
    procedure SaveToFile(const FileName: WideString; Options: SaveOptionsEnum); dispid 17;
    procedure LoadFromFile(const FileName: WideString); dispid 18;
    function ReadText(NumChars: Integer): WideString; dispid 19;
    procedure WriteText(const Data: WideString; Options: StreamWriteEnum); dispid 20;
    procedure Cancel; dispid 21;
  end;

// *********************************************************************//
// Interface: ADORecordConstruction
// Flags:     (4608) Restricted Dispatchable
// GUID:      {00000567-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ADORecordConstruction = interface(IDispatch)
    ['{00000567-0000-0010-8000-00AA006D2EA4}']
    function Get_Row(out ppRow: IUnknown): HResult; stdcall;
    function Set_Row(const ppRow: IUnknown): HResult; stdcall;
    function Set_ParentRow(const Param1: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ADOStreamConstruction
// Flags:     (4608) Restricted Dispatchable
// GUID:      {00000568-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ADOStreamConstruction = interface(IDispatch)
    ['{00000568-0000-0010-8000-00AA006D2EA4}']
    function Get_Stream(out ppStm: IUnknown): HResult; stdcall;
    function Set_Stream(const ppStm: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ADOCommandConstruction
// Flags:     (512) Restricted
// GUID:      {00000517-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ADOCommandConstruction = interface(IUnknown)
    ['{00000517-0000-0010-8000-00AA006D2EA4}']
{$IFDEF CG_EDITS} // Use safecall
    function Get_OLEDBCommand: IUnknown; safecall;
    procedure Set_OLEDBCommand(const ppOLEDBCommand: IUnknown); safecall;
    property OLEDBCommand: IUnknown read Get_OLEDBCommand write Set_OLEDBCommand;
{$ELSE}
    function Get_OLEDBCommand(out ppOLEDBCommand: IUnknown): HResult; stdcall;
    function Set_OLEDBCommand(const ppOLEDBCommand: IUnknown): HResult; stdcall;
{$ENDIF}
  end;

// *********************************************************************//
// Interface: ADORecordsetConstruction
// Flags:     (4608) Restricted Dispatchable
// GUID:      {00000283-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  ADORecordsetConstruction = interface(IDispatch)
    ['{00000283-0000-0010-8000-00AA006D2EA4}']
{$IFDEF CG_EDITS} // Use safecall
    function Get_Rowset: IUnknown; safecall;
    procedure Set_Rowset(const ppRowset: IUnknown); safecall;
    function Get_Chapter: ADO_LONGPTR; safecall;
    procedure Set_Chapter(plChapter: ADO_LONGPTR); safecall;
    function Get_RowPosition: IUnknown; safecall;
    procedure Set_RowPosition(const ppRowPos: IUnknown); safecall;
    property Rowset: IUnknown read Get_Rowset write Set_Rowset;
    property Chapter: ADO_LONGPTR read Get_Chapter write Set_Chapter;
    property RowPosition: IUnknown read Get_RowPosition write Set_RowPosition;
{$ELSE}
    function Get_Rowset(out ppRowset: IUnknown): HResult; stdcall;
    function Set_Rowset(const ppRowset: IUnknown): HResult; stdcall;
    function Get_Chapter(out plChapter: ADO_LONGPTR): HResult; stdcall;
    function Set_Chapter(plChapter: ADO_LONGPTR): HResult; stdcall;
    function Get_RowPosition(out ppRowPos: IUnknown): HResult; stdcall;
    function Set_RowPosition(const ppRowPos: IUnknown): HResult; stdcall;
{$ENDIF}
  end;

// *********************************************************************//
// Interface: Field15
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000505-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Field15 = interface(_ADO)
    ['{00000505-0000-0010-8000-00AA006D2EA4}']
    function Get_ActualSize: ADO_LONGPTR; safecall;
    function Get_Attributes: Integer; safecall;
    function Get_DefinedSize: ADO_LONGPTR; safecall;
    function Get_Name: WideString; safecall;
    function Get_Type_: DataTypeEnum; safecall;
    function Get_Value: OleVariant; safecall;
    procedure Set_Value(pvar: OleVariant); safecall;
    function Get_Precision: Byte; safecall;
    function Get_NumericScale: Byte; safecall;
    procedure AppendChunk(Data: OleVariant); safecall;
    function GetChunk(Length: Integer): OleVariant; safecall;
    function Get_OriginalValue: OleVariant; safecall;
    function Get_UnderlyingValue: OleVariant; safecall;
    property ActualSize: ADO_LONGPTR read Get_ActualSize;
    property Attributes: Integer read Get_Attributes;
    property DefinedSize: ADO_LONGPTR read Get_DefinedSize;
    property Name: WideString read Get_Name;
    property Type_: DataTypeEnum read Get_Type_;
    property Value: OleVariant read Get_Value write Set_Value;
    property Precision: Byte read Get_Precision;
    property NumericScale: Byte read Get_NumericScale;
    property OriginalValue: OleVariant read Get_OriginalValue;
    property UnderlyingValue: OleVariant read Get_UnderlyingValue;
  end;

// *********************************************************************//
// DispIntf:  Field15Disp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00000505-0000-0010-8000-00AA006D2EA4}
// *********************************************************************//
  Field15Disp = dispinterface
    ['{00000505-0000-0010-8000-00AA006D2EA4}']
    property ActualSize: ADO_LONGPTR readonly dispid 1109;
    property Attributes: Integer readonly dispid 1114;
    property DefinedSize: ADO_LONGPTR readonly dispid 1103;
    property Name: WideString readonly dispid 1100;
    property Type_: DataTypeEnum readonly dispid 1102;
    property Value: OleVariant dispid 0;
    property Precision: Byte readonly dispid 1112;
    property NumericScale: Byte readonly dispid 1113;
    procedure AppendChunk(Data: OleVariant); dispid 1107;
    function GetChunk(Length: Integer): OleVariant; dispid 1108;
    property OriginalValue: OleVariant readonly dispid 1104;
    property UnderlyingValue: OleVariant readonly dispid 1105;
    property Properties: Properties readonly dispid 500;
  end;

{$IFDEF CG_EDITS}
// *********************************************************************//
// Interface: IDataspace
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BD96C556-65A3-11D0-983A-00C04FC29E34}
// *********************************************************************//
  IDataspace = interface(IDispatch)
    ['{BD96C556-65A3-11D0-983A-00C04FC29E34}']
    function  CreateObject(const bstrProgid: WideString;
      const bstrConnection: WideString): OleVariant; safecall;
    function  Get_InternetTimeout: Integer; safecall;
    procedure Set_InternetTimeout(plInetTimeout: Integer); safecall;
    property InternetTimeout: Integer read Get_InternetTimeout write Set_InternetTimeout;
  end;

// *********************************************************************//
// DispIntf:  IDataspaceDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {BD96C556-65A3-11D0-983A-00C04FC29E34}
// *********************************************************************//
  IDataspaceDisp = dispinterface
    ['{BD96C556-65A3-11D0-983A-00C04FC29E34}']
    function  CreateObject(const bstrProgid: WideString;
      const bstrConnection: WideString): OleVariant; dispid 1;
    property InternetTimeout: Integer dispid 222;
  end;
{$ENDIF}

// *********************************************************************//
// The Class CoConnection provides a Create and CreateRemote method to          
// create instances of the default interface _Connection exposed by              
// the CoClass Connection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoConnection = class
    class function Create: _Connection;
    class function CreateRemote(const MachineName: string): _Connection;
  end;

// *********************************************************************//
// The Class CoRecord_ provides a Create and CreateRemote method to          
// create instances of the default interface _Record exposed by              
// the CoClass Record_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRecord_ = class
    class function Create: _Record;
    class function CreateRemote(const MachineName: string): _Record;
  end;

// *********************************************************************//
// The Class CoStream provides a Create and CreateRemote method to          
// create instances of the default interface _Stream exposed by              
// the CoClass Stream. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoStream = class
    class function Create: _Stream;
    class function CreateRemote(const MachineName: string): _Stream;
  end;

// *********************************************************************//
// The Class CoCommand provides a Create and CreateRemote method to          
// create instances of the default interface _Command exposed by              
// the CoClass Command. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCommand = class
    class function Create: _Command;
    class function CreateRemote(const MachineName: string): _Command;
  end;

// *********************************************************************//
// The Class CoRecordset provides a Create and CreateRemote method to          
// create instances of the default interface _Recordset exposed by              
// the CoClass Recordset. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRecordset = class
    class function Create: _Recordset;
    class function CreateRemote(const MachineName: string): _Recordset;
  end;

// *********************************************************************//
// The Class CoParameter provides a Create and CreateRemote method to          
// create instances of the default interface _Parameter exposed by              
// the CoClass Parameter. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoParameter = class
    class function Create: _Parameter;
    class function CreateRemote(const MachineName: string): _Parameter;
  end;

implementation

uses System.Win.ComObj;

class function CoConnection.Create: _Connection;
begin
  Result := CreateComObject(CLASS_Connection) as _Connection;
end;

class function CoConnection.CreateRemote(const MachineName: string): _Connection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Connection) as _Connection;
end;

class function CoRecord_.Create: _Record;
begin
  Result := CreateComObject(CLASS_Record_) as _Record;
end;

class function CoRecord_.CreateRemote(const MachineName: string): _Record;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Record_) as _Record;
end;

class function CoStream.Create: _Stream;
begin
  Result := CreateComObject(CLASS_Stream) as _Stream;
end;

class function CoStream.CreateRemote(const MachineName: string): _Stream;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Stream) as _Stream;
end;

class function CoCommand.Create: _Command;
begin
  Result := CreateComObject(CLASS_Command) as _Command;
end;

class function CoCommand.CreateRemote(const MachineName: string): _Command;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Command) as _Command;
end;

class function CoRecordset.Create: _Recordset;
begin
  Result := CreateComObject(CLASS_Recordset) as _Recordset;
end;

class function CoRecordset.CreateRemote(const MachineName: string): _Recordset;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Recordset) as _Recordset;
end;

class function CoParameter.Create: _Parameter;
begin
  Result := CreateComObject(CLASS_Parameter) as _Parameter;
end;

class function CoParameter.CreateRemote(const MachineName: string): _Parameter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Parameter) as _Parameter;
end;

end.
