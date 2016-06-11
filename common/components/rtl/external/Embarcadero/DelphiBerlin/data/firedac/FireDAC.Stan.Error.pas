{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC error handling support             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Stan.Error;

interface

uses
  System.Classes, Data.DB, System.SysUtils,
  FireDAC.Stan.Intf;

type
  EFDException = class;
  TFDDBError = class;
  EFDDBEngineException = class;
  EFDDBArrayExecuteError = class;
  EFDExceptionClass = class of EFDException;
  TFDDBErrorClass = class of TFDDBError;
  EFDDBEngineExceptionClass = class of EFDDBEngineException;

  EFDException = class(EDatabaseError)
  private
    FFDCode: Integer;
    FFDObjName: String;
  protected
    procedure SetFDObjectName(const AValue: IFDStanObject);
    procedure LoadFromStorage(const AStorage: IFDStanStorage); virtual;
    procedure SaveToStorage(const AStorage: IFDStanStorage); virtual;
  public
    constructor Create; overload; virtual;
    constructor Create(AFDCode: Integer; const AMessage: String); overload;
    procedure Duplicate(var AValue: EFDException); virtual;
    property FDCode: Integer read FFDCode write FFDCode;
    property FDObjName: String read FFDObjName write FFDObjName;
  end;

  TFDCommandExceptionKind = (ekOther, ekNoDataFound, ekTooManyRows,
    ekRecordLocked, ekUKViolated, ekFKViolated, ekObjNotExists,
    ekUserPwdInvalid, ekUserPwdExpired, ekUserPwdWillExpire, ekCmdAborted,
    ekServerGone, ekServerOutput, ekArrExecMalfunc, ekInvalidParams);

  TFDDBError = class(TObject)
  private
    FMessage: string;
    FErrorCode: Integer;
    FLevel: Integer;
    FObjName: String;
    FKind: TFDCommandExceptionKind;
    FCommandTextOffset: Integer;
    FRowIndex: Integer;
  protected
    procedure Assign(ASrc: TFDDBError); virtual;
    procedure LoadFromStorage(const AStorage: IFDStanStorage); virtual;
    procedure SaveToStorage(const AStorage: IFDStanStorage); virtual;
  public
    constructor Create; overload; virtual;
    constructor Create(ALevel, AErrorCode: Integer; const AMessage,
      AObjName: String; AKind: TFDCommandExceptionKind; ACmdOffset, ARowIndex: Integer); overload; virtual;
    property ErrorCode: Integer read FErrorCode write FErrorCode;
    property Kind: TFDCommandExceptionKind read FKind write FKind;
    property Level: Integer read FLevel write FLevel;
    property Message: String read FMessage write FMessage;
    property ObjName: String read FObjName write FObjName;
    property CommandTextOffset: Integer read FCommandTextOffset write FCommandTextOffset;
    property RowIndex: Integer read FRowIndex write FRowIndex;
  end;

  EFDDBEngineException = class(EFDException)
  private
    FItems: TFDObjList;
    FParams: TStrings;
    FSQL: String;
    function GetErrors(AIndex: Integer): TFDDBError;
    function GetErrorCount: Integer;
    function GetKind: TFDCommandExceptionKind;
    function GetErrorCode: Integer;
    procedure SetParams(const AValue: TStrings);
  protected
    procedure SetSQLAndParams(const AValue: IFDMoniAdapter);
    procedure LoadFromStorage(const AStorage: IFDStanStorage); override;
    procedure SaveToStorage(const AStorage: IFDStanStorage); override;
    function GetErrorClass: TFDDBErrorClass; virtual;
    function AppendError: TFDDBError; overload;
  public
    constructor Create; overload; override;
    constructor Create(AADCode: Integer; const AMessage: String); overload;
    destructor Destroy; override;
    function AppendError(ALevel, AErrorCode: Integer;
      const AMessage, AObjName: String; AKind: TFDCommandExceptionKind;
      ACmdOffset, ARowIndex: Integer): TFDDBError; overload;
    procedure Duplicate(var AValue: EFDException); override;
    procedure Append(AItem: TFDDBError);
    procedure Remove(AItem: TFDDBError);
    procedure Clear;
    procedure Merge(AValue: EFDDBEngineException; AIndex: Integer);
    property ErrorCount: Integer read GetErrorCount;
    property Errors[Index: Integer]: TFDDBError read GetErrors; default;
    property ErrorCode: Integer read GetErrorCode;
    property Kind: TFDCommandExceptionKind read GetKind;
    property Params: TStrings read FParams write SetParams;
    property SQL: String read FSQL write FSQL;
  end;

  EFDDBArrayExecuteError = class(EFDException)
  private
    FTimes: Integer;
    FOffset: Integer;
    FAction: TFDErrorAction;
    FException: EFDDBEngineException;
    FRetryLevel: Integer;
  public
    constructor Create(ATimes, AOffset: Integer; AException: EFDDBEngineException;
      ARetryLevel: Integer); overload;
    property Times: Integer read FTimes;
    property Offset: Integer read FOffset;
    property Exception: EFDDBEngineException read FException;
    property RetryLevel: Integer read FRetryLevel;
    property Action: TFDErrorAction read FAction write FAction;
  end;

  TFDErrorEvent = procedure (ASender, AInitiator: TObject;
    var AException: Exception) of object;

procedure FDException(AObj: TObject; AEx: EFDException
  {$IFDEF FireDAC_Monitor}; ATracing: Boolean {$ENDIF}); overload;
function FDExceptionLayers(const ALayers: array of String): String;
function FDGetErrorMessage(ACode: Integer; const AArgs: array of const): String;
procedure FDException(AObj: TObject; const ALayers: array of String;
  ACode: Integer; const AArgs: array of const); overload;
procedure FDCapabilityNotSupported(AObj: TObject; const ALayers: array of String);

function FDDBEngineExceptionLoad(const AStorage: IFDStanStorage): TObject;
function FDDBEngineExceptionCreate(AClass: EFDDBEngineExceptionClass;
  ACode: Integer; const AArgs: array of const): EFDDBEngineException;
function FDExceptionLoad(const AStorage: IFDStanStorage): TObject;
procedure FDExceptionSave(AObject: TObject; const AStorage: IFDStanStorage);

implementation

uses
  System.Generics.Collections,
  System.Types,
  FireDAC.Stan.Consts, FireDAC.Stan.ResStrs, FireDAC.Stan.Util;

{-------------------------------------------------------------------------------}
{ Utilities                                                                     }
{-------------------------------------------------------------------------------}
procedure FDException(AObj: TObject; AEx: EFDException
  {$IFDEF FireDAC_Monitor}; ATracing: Boolean {$ENDIF});
var
  oHndlr: IFDStanErrorHandler;
  oMAIntf: IFDMoniAdapter;
  oEx: Exception;
  oObj: IFDStanObject;
begin
  if (AEx is EFDDBEngineException) and
     Supports(AObj, IFDMoniAdapter, oMAIntf) and
     (oMAIntf.SupportItems * [ikSQL, ikParam] = [ikSQL, ikParam]) then
    EFDDBEngineException(AEx).SetSQLAndParams(oMAIntf);
  if Supports(AObj, IFDStanObject, oObj) then
    AEx.SetFDObjectName(oObj);
  oEx := Exception(AEx);
  if Supports(AObj, IFDStanErrorHandler, oHndlr) then
    try
      oHndlr.HandleException(oObj, oEx);
    except
      on E: Exception do begin
        if (E <> oEx) and (oEx <> nil) then
          FDFree(oEx);
        raise;
      end;
    end;
  if oEx <> nil then begin
{$IFDEF FireDAC_Monitor}
    // The monitor client messages queue may be not empty. When an exception
    // is raised and an IDE is stopped, the queue remains not empty and
    // FDMonitor does not show error message. So, give the CPU to other threads.
    if ATracing then
      Sleep(50);
{$ENDIF}
    raise oEx;
  end;
end;

{-------------------------------------------------------------------------------}
function FDExceptionLayers(const ALayers: array of String): String;
var
  i: Integer;
begin
  Result := '[FireDAC]';
  for i := Low(ALayers) to High(ALayers) do
    Result := Result + '[' + ALayers[i] + ']';
end;

{-------------------------------------------------------------------------------}
function FDGetErrorMessage(ACode: Integer; const AArgs: array of const): String;

  function CheckCustomMessage(const AStdMessage: String): String;
  begin
    if TVarRec(AArgs[1]).VInteger = 1 then
      Result := AStdMessage
    else
{$IFDEF NEXTGEN}
      Result := String(TVarRec(AArgs[0]).VUnicodeString);
{$ELSE}
      Result := String(TVarRec(AArgs[0]).VAnsiString);
{$ENDIF}
  end;

begin
  case ACode of
  er_FD_DuplicatedName: Result := S_FD_DuplicatedName;
  er_FD_NameNotFound: Result := S_FD_NameNotFound;
  er_FD_ColTypeUndefined: Result := S_FD_ColTypeUndefined;
  er_FD_NoColsDefined: Result := S_FD_NoColsDefined;
  er_FD_CheckViolated: Result := CheckCustomMessage(S_FD_CheckViolated);
  er_FD_CantBeginEdit: Result := S_FD_CantBeginEdit;
  er_FD_CantCreateChildView: Result := S_FD_CantCreateChildView;
  er_FD_RowCantBeDeleted: Result := S_FD_RowCantBeDeleted;
  er_FD_ColMBBLob: Result := S_FD_ColMBBLob;
  er_FD_FixedLenDataMismatch: Result := S_FD_FixedLenDataMismatch;
  er_FD_RowNotInEditableState: Result := S_FD_RowNotInEditableState;
  er_FD_ColIsReadOnly: Result := S_FD_ColIsReadOnly;
  er_FD_RowCantBeInserted: Result := S_FD_RowCantBeInserted;
  er_FD_RowColMBNotNull: Result := S_FD_RowColMBNotNull;
  er_FD_DuplicateRows: Result := CheckCustomMessage(S_FD_DuplicateRows);
  er_FD_NoMasterRow: Result := CheckCustomMessage(S_FD_NoMasterRow);
  er_FD_HasChildRows: Result := CheckCustomMessage(S_FD_HasChildRows);
  er_FD_CantCompareRows: Result := S_FD_CantCompareRows;
  er_FD_ConvIsNotSupported: Result := S_FD_ConvIsNotSupported;
  er_FD_ColIsNotSearchable: Result := S_FD_ColIsNotSearchable;
  er_FD_RowMayHaveSingleParent: Result := S_FD_RowMayHaveSingleParent;
  er_FD_CantOperateInvObj: Result := S_FD_CantOperateInvObj;
  er_FD_CantSetParentRow: Result := S_FD_CantSetParentRow;
  er_FD_RowIsNotNested: Result := S_FD_RowIsNotNested;
  er_FD_ColumnIsNotRef: Result := S_FD_ColumnIsNotRef;
  er_FD_ColumnIsNotSetRef: Result := S_FD_ColumnIsNotSetRef;
  er_FD_OperCNBPerfInState: Result := S_FD_OperCNBPerfInState;
  er_FD_CantSetUpdReg: Result := S_FD_CantSetUpdReg;
  er_FD_TooManyAggs: Result := S_FD_TooManyAggs;
  er_FD_GrpLvlExceeds: Result := S_FD_GrpLvlExceeds;
  er_FD_VarLenDataMismatch: Result := S_FD_VarLenDataMismatch;
  er_FD_BadForeignKey: Result := S_FD_BadForeignKey;
  er_FD_BadUniqueKey: Result := S_FD_BadUniqueKey;
  er_FD_CantChngColType: Result := S_FD_CantChngColType;
  er_FD_BadRelation: Result := S_FD_BadRelation;
  er_FD_CantCreateParentView: Result := S_FD_CantCreateParentView;
  er_FD_CantChangeTableStruct: Result := S_FD_CantChangeTableStruct;
  er_FD_FoundCascadeLoop: Result := S_FD_FoundCascadeLoop;
  er_FD_RecLocked: Result := S_FD_RecLocked;
  er_FD_RecNotLocked: Result := S_FD_RecNotLocked;
  er_FD_TypeIncompat: Result := S_FD_TypeIncompat;
  er_FD_ValueOutOfRange: Result := S_FD_ValueOutOfRange;
  er_FD_CantMerge: Result := S_FD_CantMerge;

  er_FD_ColumnDoesnotFound: Result := S_FD_ColumnDoesnotFound;
  er_FD_ExprTermination: Result := S_FD_ExprTermination;
  er_FD_ExprMBAgg: Result := S_FD_ExprMBAgg;
  er_FD_ExprCantAgg: Result := S_FD_ExprCantAgg;
  er_FD_ExprTypeMis: Result := S_FD_ExprTypeMis;
  er_FD_ExprIncorrect: Result := S_FD_ExprIncorrect;
  er_FD_InvalidKeywordUse: Result := S_FD_InvalidKeywordUse;
  er_FD_ExprInvalidChar: Result := S_FD_ExprInvalidChar;
  er_FD_ExprNameError: Result := S_FD_ExprNameError;
  er_FD_ExprStringError: Result := S_FD_ExprStringError;
  er_FD_ExprNoLParen: Result := S_FD_ExprNoLParen;
  er_FD_ExprNoRParenOrComma: Result := S_FD_ExprNoRParenOrComma;
  er_FD_ExprNoRParen: Result := S_FD_ExprNoRParen;
  er_FD_ExprEmptyInList: Result := S_FD_ExprEmptyInList;
  er_FD_ExprExpected: Result := S_FD_ExprExpected;
  er_FD_ExprNoArith: Result := S_FD_ExprNoArith;
  er_FD_ExprBadScope: Result := S_FD_ExprBadScope;
  er_FD_ExprEmpty: Result := S_FD_ExprEmpty;
  er_FD_ExprEvalError: Result := S_FD_ExprEvalError;

  er_FD_DSNoBookmark: Result := S_FD_DSNoBookmark;
  er_FD_DSViewNotSorted: Result := S_FD_DSViewNotSorted;
  er_FD_DSNoAdapter: Result := S_FD_DSNoAdapter;
  er_FD_DSNoNestedMasterSource: Result := S_FD_DSNoNestedMasterSource;
  er_FD_DSCircularDataLink: Result := S_FD_DSCircularDataLink;
  er_FD_DSRefreshError: Result := S_FD_DSRefreshError;
  er_FD_DSNoDataTable: Result := S_FD_DSNoDataTable;
  er_FD_DSIndNotFound: Result := S_FD_DSIndNotFound;
  er_FD_DSAggNotFound: Result := S_FD_DSAggNotFound;
  er_FD_DSIndNotComplete: Result := S_FD_DSIndNotComplete;
  er_FD_DSAggNotComplete: Result := S_FD_DSAggNotComplete;
  er_FD_DSCantUnidir: Result := S_FD_DSCantUnidir;
  er_FD_DSIncompatBmkFields: Result := S_FD_DSIncompatBmkFields;
  er_FD_DSCantEdit: Result := S_FD_DSCantEdit;
  er_FD_DSCantInsert: Result := S_FD_DSCantInsert;
  er_FD_DSCantDelete: Result := S_FD_DSCantDelete;
  er_FD_DSFieldNotFound: Result := S_FD_DSFieldNotFound;
  er_FD_DSCantOffline: Result := S_FD_DSCantOffline;
  er_FD_DSCantOffCachedUpdates: Result := S_FD_DSCantOffCachedUpdates;

  er_FD_DefCircular: Result := S_FD_DefCircular;
  er_FD_DefRO: Result := S_FD_DefRO;
  er_FD_DefCantMakePers: Result := S_FD_DefCantMakePers;
  er_FD_DefAlreadyLoaded: Result := S_FD_DefAlreadyLoaded;
  er_FD_DefNotExists: Result := S_FD_DefNotExists;
  er_FD_DefDupName: Result := S_FD_DefDupName;

  er_FD_AccSrvNotFound: Result := S_FD_AccSrvNotFound;
  er_FD_AccCannotReleaseDrv: Result := S_FD_AccCannotReleaseDrv;
  er_FD_AccSrvNotDefined: Result := S_FD_AccSrvNotDefined;
  er_FD_AccSrvMBConnected: Result := S_FD_AccSrvMBConnected;
  er_FD_AccCapabilityNotSup: Result := S_FD_AccCapabilityNotSup;
  er_FD_AccTxMBActive: Result := S_FD_AccTxMBActive;
  er_FD_AccTxMBInActive: Result := S_FD_AccTxMBInActive;
  er_FD_AccCantChngCommandState: Result := S_FD_AccCantChngCommandState;
  er_FD_AccCommandMBFilled: Result := S_FD_AccCommandMBFilled;
  er_FD_AccEscapeEmptyName: Result := S_FD_AccEscapeEmptyName;
  er_FD_AccCmdMHRowSet: Result := S_FD_AccCmdMHRowSet;
  er_FD_AccCmdMBPrepared: Result := S_FD_AccCmdMBPrepared;
  er_FD_AccCantExecCmdWithRowSet: Result := S_FD_AccCantExecCmdWithRowSet;
  er_FD_AccCmdMBOpen4Fetch: Result := S_FD_AccCmdMBOpen4Fetch;
  er_FD_AccExactMismatch: Result := S_FD_AccExactMismatch;
  er_FD_AccMetaInfoMismatch: Result := S_FD_AccMetaInfoMismatch;
  {$IFDEF CPUX64}
  er_FD_AccCantLoadLibrary: Result := S_FD_AccCantLoadLibrary + Format(S_FD_AccCantLoadLibraryHint,['x64']);
  {$ELSE}
  er_FD_AccCantLoadLibrary: Result := S_FD_AccCantLoadLibrary + Format(S_FD_AccCantLoadLibraryHint,['x86']);
  {$ENDIF}
  er_FD_AccCantGetLibraryEntry: Result := S_FD_AccCantGetLibraryEntry;
  er_FD_AccSrvMBDisConnected: Result := S_FD_AccSrvMBDisConnected;
  er_FD_AccToManyLogins: Result := S_FD_AccToManyLogins;
  er_FD_AccDrvMngrMB: Result := S_FD_AccDrvMngrMB;
  er_FD_AccPrepMissed: Result := S_FD_AccPrepMissed;
  er_FD_AccPrepTooLongIdent: Result := S_FD_AccPrepTooLongIdent;
  er_FD_AccParamArrayMismatch: Result := S_FD_AccParamArrayMismatch;
  er_FD_AccAsyncOperInProgress: Result := S_FD_AccAsyncOperInProgress;
  er_FD_AccEscapeIsnotSupported: Result := S_FD_AccEscapeIsnotSupported;
  er_FD_AccMetaInfoReset: Result := S_FD_AccMetaInfoReset;
  er_FD_AccWhereIsEmpty: Result := S_FD_AccWhereIsEmpty;
  er_FD_AccUpdateTabUndefined: Result := S_FD_AccUpdateTabUndefined;
  er_FD_AccNameHasErrors: Result := S_FD_AccNameHasErrors;
  er_FD_AccEscapeBadSyntax: Result := S_FD_AccEscapeBadSyntax;
  er_FD_AccShutdownTO: Result := S_FD_AccShutdownTO;
  er_FD_AccParTypeUnknown: Result := S_FD_AccParTypeUnknown;
  er_FD_AccParDataMapNotSup: Result := S_FD_AccParDataMapNotSup;
  er_FD_AccColDataMapNotSup: Result := S_FD_AccColDataMapNotSup;
  er_FD_AccParDefChanged: Result := S_FD_AccParDefChanged;
  er_FD_AccMetaInfoNotDefined: Result := S_FD_AccMetaInfoNotDefined;
  er_FD_AccCantAssignTxIntf: Result := S_FD_AccCantAssignTxIntf;
  er_FD_AccParSetChanged: Result := S_FD_AccParSetChanged;
  er_FD_AccDataToLarge: Result := S_FD_AccDataToLarge;
  er_FD_AccDbNotExists: Result := S_FD_AccDbNotExists;
  er_FD_AccClassNotRegistered: Result := S_FD_AccClassNotRegistered;
  er_FD_AccSysClassNotRegistered: Result := S_FD_AccSysClassNotRegistered;
  er_FD_AccUnrecognizedDbFormat: Result := S_FD_AccUnrecognizedDbFormat;
  er_FD_AccNotValidPassword: Result := S_FD_AccNotValidPassword;
  er_FD_AccUnknownOleError: Result := S_FD_AccUnknownOleError;
  er_FD_AccUnsupParamObjValue: Result := S_FD_AccUnsupParamObjValue;
  er_FD_AccUnsupColumnType: Result := S_FD_AccUnsupColumnType;

  er_FD_SvcLinkMBSet: Result := S_FD_SvcLinkMBSet;
  er_FD_SvcMBActive: Result := S_FD_SvcMBActive;
  er_FD_SvcCannotUninstall: Result := S_FD_SvcCannotUninstall;

  er_FD_DAptRecordIsDeleted: Result := S_FD_DAptRecordIsDeleted;
  er_FD_DAptNoSelectCmd: Result := S_FD_DAptNoSelectCmd;
  er_FD_DAptApplyUpdateFailed: Result := S_FD_DAptApplyUpdateFailed;
  er_FD_DAptCantEdit: Result := S_FD_DAptCantEdit;
  er_FD_DAptCantInsert: Result := S_FD_DAptCantInsert;
  er_FD_DAptCantDelete: Result := S_FD_DAptCantDelete;

  er_FD_ClntSessMBSingle: Result := S_FD_ClntSessMBSingle;
  er_FD_ClntSessMBInactive: Result := S_FD_ClntSessMBInactive;
  er_FD_ClntSessMBActive: Result := S_FD_ClntSessMBActive;
  er_FD_ClntDbDupName: Result := S_FD_ClntDbDupName;
  er_FD_ClntDbMBInactive: Result := S_FD_ClntDbMBInactive;
  er_FD_ClntDbMBActive: Result := S_FD_ClntDbMBActive;
  er_FD_ClntDbLoginAborted: Result := S_FD_ClntDbLoginAborted;
  er_FD_ClntDbCantConnPooled: Result := S_FD_ClntDbCantConnPooled;
  er_FD_ClntDBNotFound: Result := S_FD_ClntDBNotFound;
  er_FD_ClntAdaptMBActive: Result := S_FD_ClntAdaptMBActive;
  er_FD_ClntAdaptMBInactive: Result := S_FD_ClntAdaptMBInactive;
  er_FD_ClntNotCachedUpdates: Result := S_FD_ClntNotCachedUpdates;
  er_FD_ClntDbNotDefined: Result := S_FD_ClntDbNotDefined;
  er_FD_ClntDbMBOnline: Result := S_FD_ClntDbMBOnline;
  er_FD_ClntTxMBActive: Result := S_FD_AccTxMBActive;
  er_FD_ClntCantShareAdapt: Result := S_FD_ClntCantShareAdapt;
  er_FD_ClntConnNotMatch: Result := S_FD_ClntConnNotMatch;
  er_FD_ClntPKNotFound: Result := S_FD_ClntPKNotFound;
  er_FD_ClntLocalSQLMisuse: Result := S_FD_ClntLocalSQLMisuse;
  er_FD_ClntWrongIndex: Result := S_FD_ClntWrongIndex;
  er_FD_ClntDSNameEmpty: Result := S_FD_ClntDSNameEmpty;
  er_FD_ClntDSNameNotUnique: Result := S_FD_ClntDSNameNotUnique;
  er_FD_ClntDataSetParamIncompat: Result := S_FD_ClntDataSetParamIncompat;

  er_FD_DPNoTxtFld: Result := S_FD_DPNoTxtFld;
  er_FD_DPNoSrcDS: Result := S_FD_DPNoSrcDS;
  er_FD_DPNoDestDS: Result := S_FD_DPNoDestDS;
  er_FD_DPNoTxtDest: Result := S_FD_DPNoTxtDest;
  er_FD_DPNoTxtSrc: Result := S_FD_DPNoTxtSrc;
  er_FD_DPBadFixedSize: Result := S_FD_DPBadFixedSize;
  er_FD_DPTxtFldDup: Result := S_FD_DPTxtFldDup;
  er_FD_DPBadTextFmt: Result := S_FD_DPBadTextFmt;
  er_FD_DPSrcUndefined: Result := S_FD_DPSrcUndefined;
  er_FD_DPDestNoKeyFields: Result := S_FD_DPDestNoKeyFields;
  er_FD_DPNoSQLTab: Result := S_FD_DPNoSQLTab;
  er_FD_DPNoSQLBatch: Result := S_FD_DPNoSQLBatch;
  er_FD_DPNoTxtFlds: Result := S_FD_DPNoTxtFlds;

  er_FD_StanTimeout: Result := S_FD_StanTimeout;
  er_FD_StanCantGetBlob: Result := S_FD_StanCantGetBlob;
  er_FD_StanParamOverflow: Result := S_FD_StanParamOverflow;
  er_FD_StanCantNonblocking: Result := S_FD_StanCantNonblocking;
  er_FD_StanMacroNotFound: Result := S_FD_StanMacroNotFound;
  er_FD_StanBadParRowIndex: Result := S_FD_StanBadParRowIndex;
  er_FD_StanPoolTooManyItems: Result := S_FD_StanPoolTooManyItems;
  er_FD_StanStrgInvBinFmt: Result := S_FD_StanStrgInvBinFmt;
  er_FD_StanStrgCantReadProp: Result := S_FD_StanStrgCantReadProp;
  er_FD_StanStrgCantReadObj: Result := S_FD_StanStrgCantReadObj;
  er_FD_StanStrgCantReadCDATA: Result := S_FD_StanStrgCantReadCDATA;
  er_FD_StanStrgDictOverflow: Result := S_FD_StanStrgDictOverflow;
  er_FD_StanStrgClassUnknown: Result := S_FD_StanStrgClassUnknown;
  er_FD_StanStrgUnknownFmt: Result := S_FD_StanStrgUnknownFmt;
  er_FD_StanStrgFileError: Result := S_FD_StanStrgFileError;
  er_FD_StanStrgInvDIntFmt: Result := S_FD_StanStrgInvDIntFmt;
  er_FD_StanStrgInvJSONFmt: Result := S_FD_StanStrgInvJSONFmt;

  er_FD_ScrCantExecHostCmd: Result := S_FD_ScrCantExecHostCmd;
  er_FD_ScrStrSize1: Result := S_FD_ScrStrSize1;
  er_FD_ScrStrNotAlphaNum: Result := S_FD_ScrStrNotAlphaNum;
  er_FD_ScrSetArgInvalid: Result := S_FD_ScrSetArgInvalid;
  er_FD_ScrInvalidSyntax: Result := S_FD_ScrInvalidSyntax;
  er_FD_ScrAccMustSpecVar: Result := S_FD_ScrAccMustSpecVar;
  er_FD_ScrDefReqValue: Result := S_FD_ScrDefReqValue;
  er_FD_ScrVarMissedCloseBrace: Result := S_FD_ScrVarMissedCloseBrace;
  er_FD_ScrVarUnsupType: Result := S_FD_ScrVarUnsupType;
  er_FD_ScrNotLogged: Result := S_FD_ScrNotLogged;
  er_FD_ScrNoCmds: Result := S_FD_ScrNoCmds;
  er_FD_ScrNoScript: Result := S_FD_ScrNoScript;

  er_FD_DBXParMBNotEmpty: Result := S_FD_DBXParMBNotEmpty;
  er_FD_DBXNoDriverCfg: Result := S_FD_DBXNoDriverCfg;

  er_FD_MySQLBadVersion: Result := S_FD_MySQLBadVersion;
  er_FD_MySQLCantSetPort: Result := S_FD_MySQLCantSetPort;
  er_FD_MySQLBadParams: Result := S_FD_MySQLBadParams;
  er_FD_MySQLCantInitEmbeddedServer: Result := S_FD_MySQLCantInitEmbeddedServer;

  er_FD_OdbcLongDataStream: Result := S_FD_OdbcLongDataStream;
  er_FD_OdbcVarDataTypeUnsup: Result := S_FD_OdbcVarDataTypeUnsup;

  er_FD_OraNoCursor: Result := S_FD_OraNoCursor;
  er_FD_OraCantSetCharset: Result := S_FD_OraCantSetCharset;
  er_FD_OraCantAssFILE: Result := S_FD_OraCantAssFILE;
  er_FD_OraNoCursorParams: Result := S_FD_OraNoCursorParams;
  er_FD_OraNotInstalled: Result := S_FD_OraNotInstalled;
  er_FD_OraBadVersion: Result := S_FD_OraBadVersion;
  er_FD_OraBadVarType: Result := S_FD_OraBadVarType;
  er_FD_OraTooLongGTRID: Result := S_FD_OraTooLongGTRID;
  er_FD_OraTooLongBQUAL: Result := S_FD_OraTooLongBQUAL;
  er_FD_OraTooLongTXName: Result := S_FD_OraTooLongTXName;
  er_FD_OraDBTNManyClBraces: Result := S_FD_OraDBTNManyClBraces;
  er_FD_OraNotPLSQLObj: Result := S_FD_OraNotPLSQLObj;
  er_FD_OraNotPackageProc: Result := S_FD_OraNotPackageProc;
  er_FD_OraBadTableType: Result := S_FD_OraBadTableType;
  er_FD_OraUnNamedRecParam: Result := S_FD_OraUnNamedRecParam;
  er_FD_OraCantConvNum: Result := S_FD_OraCantConvNum;
  er_FD_OraPipeAlertToMany: Result := S_FD_OraPipeAlertToMany;

  er_FD_IBTraceIsActive: Result := S_FD_IBTraceIsActive;
  er_FD_IBArrayDMLWithIntStr: Result := S_FD_IBArrayDMLWithIntStr;

  er_FD_PgProcNotFound: Result := S_FD_PgProcNotFound;
  er_FD_PgMultiDimArrNotSup: Result := S_FD_PgMultiDimArrNotSup;
  er_FD_PgUnsupArrValueTypeNotSup: Result := S_FD_PgUnsupArrValueTypeNotSup;
  er_FD_PgArrIndexOutOfBound: Result := S_FD_PgArrIndexOutOfBound;
  er_FD_PgCannotDescribeType: Result := S_FD_PgCannotDescribeType;
  er_FD_PgIsNotArray: Result := S_FD_PgIsNotArray;

  er_FD_SQLiteInitFailed: Result := S_FD_SQLiteInitFailed;
  er_FD_SQLiteDBNotFound: Result := S_FD_SQLiteDBNotFound;
  er_FD_SQLitePwdInvalid: Result := S_FD_SQLitePwdInvalid;
  er_FD_SQLiteVTabInvalidArgs: Result := S_FD_SQLiteVTabInvalidArgs;
  er_FD_SQLiteVTabDSNotFoundOrEmpty: Result := S_FD_SQLiteVTabDSNotFoundOrEmpty;
  er_FD_SQLiteVTabDSNotSupported: Result := S_FD_SQLiteVTabDSNotSupported;
  er_FD_SQLiteVTabDSSPNotFound: Result := S_FD_SQLiteVTabDSSPNotFound;
  er_FD_SQLiteVTabDSDataModFailed: Result := S_FD_SQLiteVTabDSDataModFailed;
  er_FD_SQLiteVTabDSRowidInvalid: Result := S_FD_SQLiteVTabDSRowidInvalid;
  er_FD_SQLiteVTabDSChangedOrFreed: Result := S_FD_SQLiteVTabDSChangedOrFreed;
  er_FD_SQLiteVTabDSNoRowExists: Result := S_FD_SQLiteVTabDSNoRowExists;
  er_FD_SQLiteVTabDSCursorInvalid: Result := S_FD_SQLiteVTabDSCursorInvalid;
  er_FD_SQLiteVTabCannotAttach: Result := S_FD_SQLiteVTabCannotAttach;
  er_FD_SQLiteVTabDataSetBusy: Result := S_FD_SQLiteVTabDataSetBusy;

  er_FD_ASADBToolNotFound: Result := S_FD_ASADBToolNotFound;

  er_FD_MSSQLFSNoTx: Result := S_FD_MSSQLFSNoTx;
  er_FD_MSSQLFSNoPath: Result := S_FD_MSSQLFSNoPath;
  er_FD_MSSQLFSIOError: Result := S_FD_MSSQLFSIOError;
  er_FD_MSSQLQNSubError: Result := S_FD_MSSQLQNSubError;

  er_FD_MongoError: Result := S_FD_MongoError;
  er_FD_MongoBadURI: Result := S_FD_MongoBadURI;
  er_FD_MongoDocReadOnly: Result := S_FD_MongoDocReadOnly;
  er_FD_MongoFailedInitBSON: Result := S_FD_MongoFailedInitBSON;
  er_FD_MongoBulkError: Result := S_FD_MongoBulkError;
  er_FD_MongoCursorError: Result := S_FD_MongoCursorError;
  er_FD_MongoExecuteError: Result := S_FD_MongoExecuteError;
  er_FD_MongoDBRefInvalid: Result := S_FD_MongoDBRefInvalid;
  er_FD_MongoDBRefNotFound: Result := S_FD_MongoDBRefNotFound;
  er_FD_MongoCannotOpenDataSet: Result := S_FD_MongoCannotOpenDataSet;
  er_FD_MongoFieldTypeMismatch: Result := S_FD_MongoFieldTypeMismatch;
  er_FD_MongoFieldIsNotFound: Result := S_FD_MongoFieldIsNotFound;
  er_FD_MongoAlertToMany: Result := S_FD_MongoAlertToMany;
  end;
end;

{-------------------------------------------------------------------------------}
procedure FDException(AObj: TObject; const ALayers: array of String;
  ACode: Integer; const AArgs: array of const);
var
  s, sMsg: String;
begin
  sMsg := FDGetErrorMessage(ACode, AArgs);
  s := FDExceptionLayers(ALayers) + '-' + IntToStr(ACode) + '. ';
  try
    s := s + Format(sMsg, AArgs);
  except
    s := s + sMsg;
  end;
  FDException(AObj, EFDException.Create(ACode, s)
    {$IFDEF FireDAC_Monitor}, False {$ENDIF});
end;

{-------------------------------------------------------------------------------}
procedure FDCapabilityNotSupported(AObj: TObject; const ALayers: array of String);
begin
  FDException(AObj, ALayers, er_FD_AccCapabilityNotSup, []);
end;

{-------------------------------------------------------------------------------}
function FDDBEngineExceptionCreate(AClass: EFDDBEngineExceptionClass; ACode: Integer;
  const AArgs: array of const): EFDDBEngineException;
var
  sMsg: String;
begin
  sMsg := FDGetErrorMessage(ACode, AArgs);
  try
    sMsg := Format(sMsg, AArgs);
  except
    // silent
  end;
  Result := AClass.Create(ACode, sMsg);
end;

{-------------------------------------------------------------------------------}
{ EFDException                                                                  }
{-------------------------------------------------------------------------------}
constructor EFDException.Create;
begin
  inherited Create('');
end;

{-------------------------------------------------------------------------------}
constructor EFDException.Create(AFDCode: Integer; const AMessage: String);
begin
  inherited Create(AMessage);
  FFDCode := AFDCode;
end;

{-------------------------------------------------------------------------------}
procedure EFDException.SetFDObjectName(const AValue: IFDStanObject);
var
  oObj: IFDStanObject;
begin
  oObj := AValue;
  FFDObjName := '';
  repeat
    if FFDObjName <> '' then
      FFDObjName := '.' + FFDObjName;
    FFDObjName := oObj.Name + FFDObjName;
    oObj := oObj.Parent;
  until oObj = nil;
end;

{-------------------------------------------------------------------------------}
procedure EFDException.Duplicate(var AValue: EFDException);
begin
  if AValue = nil then
    AValue := EFDExceptionClass(ClassType).Create;
  AValue.Message := Message;
  AValue.FDCode := FDCode;
  AValue.FDObjName := FDObjName;
end;

{-------------------------------------------------------------------------------}
procedure EFDException.LoadFromStorage(const AStorage: IFDStanStorage);
begin
  FDCode := AStorage.ReadInteger('FDCode', 0);
  Message := AStorage.ReadString('Message', '');
  if AStorage.StreamVersion >= 8 then
    FDObjName := AStorage.ReadString('FDObjName', '');
end;

{-------------------------------------------------------------------------------}
procedure EFDException.SaveToStorage(const AStorage: IFDStanStorage);
begin
  AStorage.WriteInteger('FDCode', FDCode, 0);
  AStorage.WriteString('Message', Message, '');
  if AStorage.StreamVersion >= 8 then
    AStorage.WriteString('FDObjName', FDObjName, '');
end;

{-------------------------------------------------------------------------------}
function FDExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EFDException.Create;
  EFDException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
procedure FDExceptionSave(AObject: TObject; const AStorage: IFDStanStorage);
begin
  EFDException(AObject).SaveToStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
{ TFDDBError                                                                    }
{-------------------------------------------------------------------------------}
constructor TFDDBError.Create;
begin
  inherited Create;
  FCommandTextOffset := -1;
  FRowIndex := -1;
end;

{-------------------------------------------------------------------------------}
constructor TFDDBError.Create(ALevel, AErrorCode: Integer;
  const AMessage, AObjName: String; AKind: TFDCommandExceptionKind;
  ACmdOffset, ARowIndex: Integer);
begin
  Create;
  FLevel := ALevel;
  FErrorCode := AErrorCode;
  FMessage := AMessage;
  FObjName := AObjName;
  FKind := AKind;
  FCommandTextOffset := ACmdOffset;
  FRowIndex := ARowIndex;
end;

{-------------------------------------------------------------------------------}
procedure TFDDBError.Assign(ASrc: TFDDBError);
begin
  FLevel := ASrc.Level;
  FErrorCode := ASrc.ErrorCode;
  FMessage := ASrc.Message;
  FObjName := ASrc.ObjName;
  FKind := ASrc.Kind;
  FCommandTextOffset := ASrc.CommandTextOffset;
  FRowIndex := ASrc.RowIndex;
end;

{-------------------------------------------------------------------------------}
procedure TFDDBError.LoadFromStorage(const AStorage: IFDStanStorage);
begin
  ErrorCode := AStorage.ReadInteger('ErrorCode', 0);
  Kind := TFDCommandExceptionKind(AStorage.ReadInteger('Kind', 0));
  Level := AStorage.ReadInteger('Level', 0);
  Message := AStorage.ReadString('Message', '');
  ObjName := AStorage.ReadString('ObjName', '');
  CommandTextOffset := AStorage.ReadInteger('CommandTextOffset', 0);
  RowIndex := AStorage.ReadInteger('RowIndex', 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBError.SaveToStorage(const AStorage: IFDStanStorage);
begin
  AStorage.WriteInteger('ErrorCode', ErrorCode, 0);
  AStorage.WriteInteger('Kind', Integer(Kind), 0);
  AStorage.WriteInteger('Level', Level, 0);
  AStorage.WriteString('Message', Message, '');
  AStorage.WriteString('ObjName', ObjName, '');
  AStorage.WriteInteger('CommandTextOffset', CommandTextOffset, 0);
  AStorage.WriteInteger('RowIndex', RowIndex, 0);
end;

{-------------------------------------------------------------------------------}
{ EFDDBEngineException                                                          }
{-------------------------------------------------------------------------------}
constructor EFDDBEngineException.Create;
begin
  inherited Create(0, '');
  FItems := TFDObjList.Create;
  FParams := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
constructor EFDDBEngineException.Create(AADCode: Integer;
  const AMessage: String);
begin
  inherited Create(AADCode, AMessage);
  FItems := TFDObjList.Create;
  FParams := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor EFDDBEngineException.Destroy;
begin
  Clear;
  FDFreeAndNil(FItems);
  FDFreeAndNil(FParams);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure EFDDBEngineException.SetSQLAndParams(const AValue: IFDMoniAdapter);
var
  i: Integer;
  sName: String;
  vValue: Variant;
  eKind: TFDMoniAdapterItemKind;
begin
  FParams.Clear;
  FSQL := '';
  if AValue <> nil then
    for i := 0 to AValue.ItemCount - 1 do begin
      AValue.GetItem(i, sName, vValue, eKind);
      if eKind = ikParam then
        FParams.Add(FDValToStr(sName, False) + '=' + FDValToStr(vValue, False))
      else if eKind = ikSQL then
        FSQL := AdjustLineBreaks(vValue, tlbsCRLF);
    end;
end;

{-------------------------------------------------------------------------------}
procedure EFDDBEngineException.SetParams(const AValue: TStrings);
begin
  FParams.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
function EFDDBEngineException.GetErrorClass: TFDDBErrorClass;
begin
  Result := TFDDBError;
end;

{-------------------------------------------------------------------------------}
procedure EFDDBEngineException.Duplicate(var AValue: EFDException);
var
  oItem: TFDDBError;
  i: Integer;
begin
  inherited Duplicate(AValue);
  EFDDBEngineException(AValue).FParams.SetStrings(FParams);
  EFDDBEngineException(AValue).FSQL := FSQL;
  for i := 0 to FItems.Count - 1 do begin
    oItem := EFDDBEngineException(AValue).AppendError;
    oItem.Assign(TFDDBError(FItems[i]));
  end;
end;

{-------------------------------------------------------------------------------}
function EFDDBEngineException.GetErrorCount: Integer;
begin
  Result := FItems.Count;
end;

{-------------------------------------------------------------------------------}
function EFDDBEngineException.GetErrors(AIndex: Integer): TFDDBError;
begin
  Result := TFDDBError(FItems[AIndex]);
end;

{-------------------------------------------------------------------------------}
function EFDDBEngineException.GetKind: TFDCommandExceptionKind;
var
  i: Integer;
begin
  Result := ekOther;
  for i := 0 to FItems.Count - 1 do
    if Errors[i].Kind <> ekOther then begin
      Result := Errors[i].Kind;
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
function EFDDBEngineException.GetErrorCode: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FItems.Count - 1 do
    if Errors[i].ErrorCode <> 0 then begin
      Result := Errors[i].ErrorCode;
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
function EFDDBEngineException.AppendError: TFDDBError;
begin
  Result := GetErrorClass.Create;
  Append(Result);
end;

{-------------------------------------------------------------------------------}
function EFDDBEngineException.AppendError(ALevel, AErrorCode: Integer;
  const AMessage, AObjName: String; AKind: TFDCommandExceptionKind;
  ACmdOffset, ARowIndex: Integer): TFDDBError;
begin
  Result := GetErrorClass.Create(ALevel, AErrorCode, AMessage, AObjName,
    AKind, ACmdOffset, ARowIndex);
  Append(Result);
end;

{-------------------------------------------------------------------------------}
procedure EFDDBEngineException.Append(AItem: TFDDBError);
begin
  FItems.Add(AItem);
end;

{-------------------------------------------------------------------------------}
procedure EFDDBEngineException.Remove(AItem: TFDDBError);
begin
  FItems.Remove(AItem);
end;

{-------------------------------------------------------------------------------}
procedure EFDDBEngineException.Merge(AValue: EFDDBEngineException; AIndex: Integer);
var
  i: Integer;
begin
  for i := AValue.ErrorCount - 1 downto 0 do begin
    FItems.Insert(AIndex, AValue[i]);
    AValue.FItems.Delete(i);
  end;
end;

{-------------------------------------------------------------------------------}
procedure EFDDBEngineException.Clear;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    FDFree(TFDDBError(FItems[i]));
  FItems.Clear;
end;

{-------------------------------------------------------------------------------}
procedure EFDDBEngineException.LoadFromStorage(const AStorage: IFDStanStorage);
var
  oErr: TFDDBError;
begin
  inherited LoadFromStorage(AStorage);
  if AStorage.StreamVersion >= 11 then
    AStorage.ReadObjectBegin('DBErrors', osFlatArray);
  while not AStorage.IsObjectEnd('DBError') do begin
    AStorage.ReadObjectBegin('DBError', osObject);
    try
      oErr := AppendError;
      oErr.LoadFromStorage(AStorage);
    finally
      AStorage.ReadObjectEnd('DBError', osObject);
    end;
  end;
  if AStorage.StreamVersion >= 11 then
    AStorage.ReadObjectEnd('DBErrors', osFlatArray);
end;

{-------------------------------------------------------------------------------}
procedure EFDDBEngineException.SaveToStorage(const AStorage: IFDStanStorage);
var
  i: Integer;
  oErr: TFDDBError;
begin
  inherited SaveToStorage(AStorage);
  if AStorage.StreamVersion >= 11 then
    AStorage.WriteObjectBegin('DBErrors', osFlatArray);
  for i := 0 to ErrorCount - 1 do begin
    AStorage.WriteObjectBegin('DBError', osObject);
    try
      oErr := Errors[i];
      oErr.SaveToStorage(AStorage);
    finally
      AStorage.WriteObjectEnd('DBError', osObject);
    end;
  end;
  if AStorage.StreamVersion >= 11 then
    AStorage.WriteObjectEnd('DBErrors', osFlatArray);
end;

{-------------------------------------------------------------------------------}
function FDDBEngineExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EFDDBEngineException.Create;
  EFDDBEngineException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
{ EFDDBArrayExecuteError                                                        }
{-------------------------------------------------------------------------------}
constructor EFDDBArrayExecuteError.Create(ATimes, AOffset: Integer;
  AException: EFDDBEngineException; ARetryLevel: Integer);
begin
  inherited Create(er_FD_AccArrayExecError, 'Array DML failed: ' + AException.Message);
  FTimes := ATimes;
  FOffset := AOffset;
  FException := AException;
  FAction := eaFail;
  FRetryLevel := ARetryLevel;
end;

{-------------------------------------------------------------------------------}
initialization
  FDStorageManager().RegisterClass(EFDException, 'Exception',
    @FDExceptionLoad, @FDExceptionSave);
  FDStorageManager().RegisterClass(EFDDBEngineException, 'DBEngineException',
    @FDDBEngineExceptionLoad, @FDExceptionSave);

end.
