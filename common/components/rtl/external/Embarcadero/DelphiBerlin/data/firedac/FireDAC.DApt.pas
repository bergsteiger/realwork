{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{       FireDAC Data Adapter Layer implementation       }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.DApt;

interface

implementation

uses
  System.SysUtils, System.Classes, Data.DB, System.Generics.Collections, System.Types,
  FireDAC.DatS,
  FireDAC.Stan.Intf, FireDAC.Stan.Param, FireDAC.Stan.Factory, FireDAC.Stan.Util,
    FireDAC.Stan.Error, FireDAC.Stan.Consts, FireDAC.Stan.ResStrs, FireDAC.Stan.Option,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.DApt.Column;

type
  TFDDAptTableAdapter = class;
  TFDDAptTableAdapters = class;
  TFDDAptSchemaAdapter = class;

  TFDDAptUpdatesJournalProcessor = class(TObject)
  private
    FJournal: TFDDatSUpdatesJournal;
    FAdapters: TFDDAptTableAdapters;
    FAdapter: TFDDAptTableAdapter;
    FUpdateHandler: IFDDAptUpdateHandler;
    FOptions: IFDStanOptions;
{$IFDEF FireDAC_MONITOR}
    FMonitor: IFDMoniClient;
    function IsTracing: Boolean;
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const);
{$ENDIF}
    function GetLimitToTable: TFDDatSTable;
    function LookupTableAdapter(ATable: TFDDatSTable): IFDDAptTableAdapter;
  public
    constructor CreateForTableAdapter(ATableAdapter: TFDDAptTableAdapter);
    constructor CreateForSchemaAdapter(ASchemaAdapter: TFDDAptSchemaAdapter);
    destructor Destroy; override;
    function Process(AMaxErrors: Integer = -1): Integer;
    function Reconcile: Boolean;
    property LimitToTable: TFDDatSTable read GetLimitToTable;
{$IFDEF FireDAC_MONITOR}
    property Monitor: IFDMoniClient read FMonitor write FMonitor;
{$ENDIF}
    property Journal: TFDDatSUpdatesJournal read FJournal write FJournal;
    property UpdateHandler: IFDDAptUpdateHandler read FUpdateHandler
      write FUpdateHandler;
  end;

  TFDDAptUpdateCommandReason = (urSetSelect, urSetErrorHandler,
    urReset, urSetTransaction, urSetUpdateTransaction);

  TFDDAptTableAdapter = class(TFDObject, IUnknown, IFDStanObject,
    IFDStanErrorHandler, IFDPhysMappingHandler, IFDDAptTableAdapter)
  private
    FDatSTable: TFDDatSTable;
    FDatSTableName: String;
    FSourceRecordSetID: Integer;
    FSourceRecordSetName: String;
    FUpdateTableName: String;
    FColMappings: TFDDAptColumnMappings;
    FMetaInfoMergeMode: TFDPhysMetaInfoMergeMode;
    FMappings: TFDDAptTableAdapters;
    FDatSManager: TFDDatSManager;

    FGeneratedCommands: TFDActionRequests;
    FCommands: array of IFDPhysCommand;
    FBuffer: TFDBuffer;
    FErrorHandler: IFDStanErrorHandler;
    FUpdateHandler: IFDDAptUpdateHandler;
    FInUpdateRowHandler: Boolean;
    FTransaction: IFDPhysTransaction;
    FUpdateTransaction: IFDPhysTransaction;

    procedure ProcessUpdate(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      ARequest: TFDUpdateRequest; AUpdRowOptions: TFDUpdateRowOptions;
      AFillRowOptions: TFDPhysFillRowOptions; AColumn: Integer);
    function GetUpdateRowCommand(ARow: TFDDatSRow;
      AUpdRowOptions: TFDUpdateRowOptions; AUpdateRequest: TFDUpdateRequest;
      AFillRowOptions: TFDPhysFillRowOptions; AColumn: Integer; ACacheCommand: Boolean;
      var AFlags: TFDPhysCommandGeneratorFlags): IFDPhysCommand;
    procedure MergeRowFromParams(const ACommand: IFDPhysCommand;
      ABaseRow: TFDDatSRow; AFetchedParams: TFDParams; AClearRow: Boolean);
    procedure MergeRows(const ACommand: IFDPhysCommand;
      ABaseRow, AFetchedRow: TFDDatSRow; AClearRow: Boolean);
    procedure ParName2Col(ABaseRow: TFDDatSRow; const AName: String;
      var ACol: TFDDatSColumn; var ARow: TFDDatSRow; var AVersion: Integer);
    procedure ProcessRequest(const ACommand: IFDPhysCommand; ARow: TFDDatSRow;
      ARequest: TFDUpdateRequest; AUpdRowOptions: TFDUpdateRowOptions;
      AFillRowOptions: TFDPhysFillRowOptions; AWrapByTX: Boolean);
    procedure SetParamsFromRow(AParams: TFDParams; ARow: TFDDatSRow);
{$IFDEF FireDAC_MONITOR}
    function IsTracing: Boolean;
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const);
    function GetUpdateRequestName(ARequest: TFDUpdateRequest): String;
{$ENDIF}
    function SetCommand(AReq: TFDActionRequest; const ACmd: IFDPhysCommand): Boolean;
    procedure GetCommand(AReq: TFDActionRequest; out ACmd: IFDPhysCommand);
    procedure UpdateCommands(AReason: TFDDAptUpdateCommandReason);
    procedure CheckSelectCommand;
    function GetSchemaAdapter: TFDDAptSchemaAdapter;
    procedure InternalSetCommand(AReq: TFDActionRequest; const ACmd: IFDPhysCommand);
    procedure ReleaseDatSTable;
    procedure DetachDatSTable;
    procedure AcquireDatSTable(ATable: TFDDatSTable);
    procedure AttachDatSTable;
    function MatchRecordSet(const ATable: TFDPhysMappingName): Boolean;
    procedure GetConn(out AConn: IFDPhysConnection);
    procedure GetUpdTx(out ATx: IFDPhysTransaction);

  protected
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    // IFDStanObject
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);

    // IFDStanErrorHandler
    procedure HandleException(const AInitiator: IFDStanObject;
      var AException: Exception);

    // IFDPhysMappingHandler
    function MapRecordSet(const ATable: TFDPhysMappingName;
      var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
      var ADatSTable: TFDDatSTable): TFDPhysMappingResult;
    function MapRecordSetColumn(const ATable, AColumn: TFDPhysMappingName;
      var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
      var ADatSColumn: TFDDatSColumn): TFDPhysMappingResult;

    // IFDDAptTableAdapter
    function GetSourceRecordSetID: Integer;
    procedure SetSourceRecordSetID(const AValue: Integer);
    function GetSourceRecordSetName: String;
    procedure SetSourceRecordSetName(const AValue: String);
    function GetUpdateTableName: String;
    procedure SetUpdateTableName(const AValue: String);
    function GetDatSTableName: String;
    procedure SetDatSTableName(const AValue: String);
    function GetDatSTable: TFDDatSTable;
    procedure SetDatSTable(AValue: TFDDatSTable);
    function GetColumnMappings: TFDDAptColumnMappings;
    function GetMetaInfoMergeMode: TFDPhysMetaInfoMergeMode;
    procedure SetMetaInfoMergeMode(const AValue: TFDPhysMetaInfoMergeMode);
    function GetTableMappings: IFDDAptTableAdapters;
    function GetDatSManager: TFDDatSManager;
    procedure SetDatSManager(AValue: TFDDatSManager);

    function GetSelectCommand: IFDPhysCommand;
    procedure SetSelectCommand(const ACmd: IFDPhysCommand);
    function GetInsertCommand: IFDPhysCommand;
    procedure SetInsertCommand(const ACmd: IFDPhysCommand);
    function GetUpdateCommand: IFDPhysCommand;
    procedure SetUpdateCommand(const ACmd: IFDPhysCommand);
    function GetDeleteCommand: IFDPhysCommand;
    procedure SetDeleteCommand(const ACmd: IFDPhysCommand);
    function GetLockCommand: IFDPhysCommand;
    procedure SetLockCommand(const ACmd: IFDPhysCommand);
    function GetUnLockCommand: IFDPhysCommand;
    procedure SetUnLockCommand(const ACmd: IFDPhysCommand);
    function GetFetchRowCommand: IFDPhysCommand;
    procedure SetFetchRowCommand(const ACmd: IFDPhysCommand);
    function GetTransaction: IFDPhysTransaction;
    procedure SetTransaction(const AValue: IFDPhysTransaction);
    function GetUpdateTransaction: IFDPhysTransaction;
    procedure SetUpdateTransaction(const AValue: IFDPhysTransaction);

    function GetOptions: IFDStanOptions;
    function GetErrorHandler: IFDStanErrorHandler;
    procedure SetErrorHandler(const AValue: IFDStanErrorHandler);
    function GetUpdateHandler: IFDDAptUpdateHandler;
    procedure SetUpdateHandler(const AValue: IFDDAptUpdateHandler);

    function GetObj: TObject;

    function Define: TFDDatSTable;
    procedure Fetch(AAll: Boolean = False; ABlocked: Boolean = False); overload;
    function Update(AMaxErrors: Integer = -1): Integer; overload;
    function Reconcile: Boolean;
    procedure Reset;

    procedure Fetch(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      AColumn: Integer; AFillRowOptions: TFDPhysFillRowOptions); overload;
    procedure Update(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      AUpdRowOptions: TFDUpdateRowOptions = []; AForceRequest: TFDActionRequest = arFromRow); overload;
    procedure Lock(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      AUpdRowOptions: TFDUpdateRowOptions = []);
    procedure UnLock(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      AUpdRowOptions: TFDUpdateRowOptions = []);
    procedure FetchGenerators(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      AUpdRowOptions: TFDUpdateRowOptions = []);
  public
    constructor CreateForSchema(AMappings: TFDDAptTableAdapters);
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TFDDAptTableAdapters = class(TInterfacedObject, IUnknown,
    IFDDAptTableAdapters)
  private
    FItems: TFDObjList;
    FSchemaAdapter: TFDDAptSchemaAdapter;
    procedure Clear;
    function Find(const ATable: TFDPhysMappingName): Integer;
    procedure DatSManagerDetaching;
    procedure DatSManagerAttached;
  protected
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IFDDAptTableAdapters
    function GetCount: Integer;
    function GetItems(AIndex: Integer): IFDDAptTableAdapter;
    function Lookup(const ATable: TFDPhysMappingName): IFDDAptTableAdapter;
    function Add(const ASourceRecordSetName: String = '';
      const ADatSTableName: String = '';
      const AUpdateTableName: String = ''): IFDDAptTableAdapter; overload;
    procedure Add(const AAdapter: IFDDAptTableAdapter); overload;
    procedure Remove(const ATable: TFDPhysMappingName); overload;
    procedure Remove(const AAdapter: IFDDAptTableAdapter); overload;
  public
    constructor Create(ASchemaAdapter: TFDDAptSchemaAdapter);
    destructor Destroy; override;
  end;

  TFDDAptSchemaAdapter = class(TFDObject, IFDStanObject,
    IFDPhysMappingHandler, IFDDAptSchemaAdapter)
  private
    FDatSManager: TFDDatSManager;
    FAdapters: TFDDAptTableAdapters;

    FUpdateHandler: IFDDAptUpdateHandler;
    FErrorHandler: IFDStanErrorHandler;
    FTransaction: IFDPhysTransaction;
    FUpdateTransaction: IFDPhysTransaction;
    FOptions: IFDStanOptions;
    procedure AttachDatSManager(AManager: TFDDatSManager);
    procedure ReleaseDatSManager;
    procedure GetParentOptions(var AOpts: IFDStanOptions);
  protected
    // IFDStanObject
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);

    // IFDPhysMappingHandler
    function MapRecordSet(const ATable: TFDPhysMappingName;
      var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
      var ADatSTable: TFDDatSTable): TFDPhysMappingResult;
    function MapRecordSetColumn(const ATable, AColumn: TFDPhysMappingName;
      var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
      var ADatSColumn: TFDDatSColumn): TFDPhysMappingResult;

    // IFDDAptSchemaAdapter
    function GetErrorHandler: IFDStanErrorHandler;
    procedure SetErrorHandler(const AValue: IFDStanErrorHandler);
    function GetUpdateHandler: IFDDAptUpdateHandler;
    procedure SetUpdateHandler(const AValue: IFDDAptUpdateHandler);
    function GetDatSManager: TFDDatSManager;
    procedure SetDatSManager(AValue: TFDDatSManager);
    function GetTableAdapters: IFDDAptTableAdapters;
    function GetTransaction: IFDPhysTransaction;
    procedure SetTransaction(const AValue: IFDPhysTransaction);
    function GetUpdateTransaction: IFDPhysTransaction;
    procedure SetUpdateTransaction(const AValue: IFDPhysTransaction);
    function GetOptions: IFDStanOptions;
    function Reconcile: Boolean;
    function Update(AMaxErrors: Integer = -1): Integer;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
{ TFDDAptUpdatesJournalProcessor                                                }
{-------------------------------------------------------------------------------}
constructor TFDDAptUpdatesJournalProcessor.CreateForSchemaAdapter(
  ASchemaAdapter: TFDDAptSchemaAdapter);
{$IFDEF FireDAC_MONITOR}
var
  i: Integer;
  oAdapt: TFDDAptTableAdapter;
{$ENDIF}
begin
  inherited Create;
  FAdapters := ASchemaAdapter.FAdapters;
  FJournal := ASchemaAdapter.GetDatSManager.Updates;
  ASSERT(FJournal <> nil);
{$IFDEF FireDAC_MONITOR}
  for i := 0 to FAdapters.GetCount - 1 do begin
    oAdapt := TFDDAptTableAdapter(FAdapters.FItems.Items[i]);
    if (oAdapt.GetSelectCommand <> nil) and (oAdapt.GetSelectCommand.Connection <> nil) then begin
      FMonitor := oAdapt.GetSelectCommand.Connection.Monitor;
      if FMonitor <> nil then
        Break;
    end;
  end;
{$ENDIF}
  FUpdateHandler := ASchemaAdapter.GetUpdateHandler;
  FOptions := ASchemaAdapter.GetOptions;
end;

{-------------------------------------------------------------------------------}
constructor TFDDAptUpdatesJournalProcessor.CreateForTableAdapter(
  ATableAdapter: TFDDAptTableAdapter);
var
  oTab: TFDDatSTable;
{$IFDEF FireDAC_MONITOR}
  oConn: IFDPhysConnection;
{$ENDIF}
  oCmd: IFDPhysCommand;
begin
  inherited Create;
  FAdapter := ATableAdapter;
  oTab := ATableAdapter.GetDatSTable;
  if oTab <> nil then
    if oTab.UpdatesRegistry then
      FJournal := oTab.Updates
    else if (oTab.Manager <> nil) and oTab.Manager.UpdatesRegistry then
      FJournal := oTab.Manager.Updates;
  ASSERT(FJournal <> nil);
{$IFDEF FireDAC_MONITOR}
  ATableAdapter.GetConn(oConn);
  if oConn <> nil then
    FMonitor := oConn.Monitor;
{$ENDIF}
  FUpdateHandler := ATableAdapter.GetUpdateHandler;
  ATableAdapter.GetCommand(arSelect, oCmd);
  if oCmd <> nil then
    FOptions := oCmd.Options;
end;

{-------------------------------------------------------------------------------}
destructor TFDDAptUpdatesJournalProcessor.Destroy;
begin
  FOptions := nil;
  FAdapter := nil;
  FAdapters := nil;
  FJournal := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDDAptUpdatesJournalProcessor.GetLimitToTable: TFDDatSTable;
begin
  if FAdapter <> nil then
    Result := FAdapter.GetDatSTable
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDDAptUpdatesJournalProcessor.LookupTableAdapter(ATable: TFDDatSTable): IFDDAptTableAdapter;
begin
  if FAdapter <> nil then begin
    ASSERT(FAdapter.GetDatSTable = ATable);
    Result := FAdapter as IFDDAptTableAdapter;
  end
  else if FAdapters <> nil then
    Result := FAdapters.Lookup(TFDPhysMappingName.Create(ATable.Name, nkDatS))
  else
    Result := nil;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
function TFDDAptUpdatesJournalProcessor.IsTracing: Boolean;
begin
  Result := (FMonitor <> nil) and FMonitor.Tracing;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptUpdatesJournalProcessor.Trace(AKind: TFDMoniEventKind;
  AStep: TFDMoniEventStep; const AMsg: String; const AArgs: array of const);
begin
  if IsTracing then
    FMonitor.Notify(AKind, AStep, Self, AMsg, AArgs);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDDAptUpdatesJournalProcessor.Process(AMaxErrors: Integer): Integer;
var
  eAction: TFDErrorAction;
  oRow, oNextRow: TFDDatSRow;
  oTabAdapter: IFDDAptTableAdapter;
  oWait: IFDGUIxWaitCursor;
  lShowCrs: Boolean;

  function UpdateNoLocking(AUpdOpts: TFDUpdateRowOptions): TFDErrorAction;
  begin
    try
      Result := eaApplied;
      oTabAdapter.Update(oRow, Result, AUpdOpts);
    except
      Result := eaFail;
    end;
  end;

  function UpdateLocking(AUpdOpts, ALockOpts, AUnlockOpts: TFDUpdateRowOptions): TFDErrorAction;
  var
    eTmpAction, ePrevAction: TFDErrorAction;
  begin
    ePrevAction := eaRetry; // impossible output value
    try
      Result := eaApplied;
      oTabAdapter.Lock(oRow, Result, ALockOpts);
      try
        if Result = eaApplied then begin
          oTabAdapter.Update(oRow, Result, AUpdOpts);
          ePrevAction := Result;
        end;
      finally
        if Result <> eaApplied then begin
          AUnlockOpts := AUnlockOpts + [uoCancelUnlock];
          if oRow.RowState = rsDeleted then
            AUnlockOpts := AUnlockOpts - [uoNoSrvRecord];
          eTmpAction := eaApplied;
          oTabAdapter.UnLock(oRow, eTmpAction, AUnlockOpts);
        end
        else
          oTabAdapter.UnLock(oRow, Result, AUnlockOpts);
        if ePrevAction <> eaRetry then
          Result := ePrevAction;
      end;
    except
      Result := eaFail;
    end;
  end;

begin
{$IFDEF FireDAC_MONITOR}
  if IsTracing then
    if LimitToTable <> nil then
      Trace(ekAdaptUpdate, esStart, 'Process',
        ['LimitToTable', LimitToTable.SourceName])
    else
      Trace(ekAdaptUpdate, esStart, 'Process', []);
  try
{$ENDIF}
    lShowCrs := (FOptions <> nil) and not FOptions.ResourceOptions.ActualSilentMode;
    if lShowCrs then begin
      FDCreateInterface(IFDGUIxWaitCursor, oWait);
      oWait.StartWait;
    end;
    Journal.Lock;
    try
      Result := 0;
      oRow := Journal.FirstChange(LimitToTable);
      while oRow <> nil do begin
        oNextRow := Journal.NextChange(oRow, LimitToTable);
        oTabAdapter := LookupTableAdapter(oRow.Table);
        if oTabAdapter <> nil then begin
          try
            case oRow.RowState of
            rsInserted: eAction := UpdateNoLocking([uoNoSrvRecord]);
            rsDeleted:  eAction := UpdateLocking([], [uoDeferredLock], [uoNoSrvRecord]);
            rsModified: eAction := UpdateLocking([], [uoDeferredLock], []);
            else        eAction := eaSkip;
            end;
          except
            eAction := eaFail;
          end;
          if eAction = eaFail then begin
            Inc(Result);
            if (AMaxErrors <> -1) and (Result > AMaxErrors) then
              Exit;
          end;
        end;
        oRow := oNextRow;
      end;
    finally
      Journal.Unlock;
      if lShowCrs then
        oWait.StopWait;
    end;
{$IFDEF FireDAC_MONITOR}
  finally
    if IsTracing then
      if LimitToTable <> nil then
        Trace(ekAdaptUpdate, esEnd, 'Process',
          ['LimitToTable', LimitToTable.SourceName])
      else
        Trace(ekAdaptUpdate, esEnd, 'Process', []);
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TFDDAptUpdatesJournalProcessor.Reconcile: Boolean;
var
  oRow, oNextRow: TFDDatSRow;
  eAction: TFDDAptReconcileAction;
  oTabAdapter: IFDDAptTableAdapter;
  eErrAction: TFDErrorAction;
  oWait: IFDGUIxWaitCursor;
  lShowCrs: Boolean;
  lAutoCommit: Boolean;
begin
{$IFDEF FireDAC_MONITOR}
  if IsTracing then
    if LimitToTable <> nil then
      Trace(ekAdaptUpdate, esStart, 'Reconcile',
        ['LimitToTable', LimitToTable.SourceName])
    else
      Trace(ekAdaptUpdate, esStart, 'Reconcile', []);
  try
{$ENDIF}
    lShowCrs := (FOptions <> nil) and not FOptions.ResourceOptions.ActualSilentMode;
    lAutoCommit := (FOptions <> nil) and FOptions.UpdateOptions.AutoCommitUpdates;
    if lShowCrs then begin
      FDCreateInterface(IFDGUIxWaitCursor, oWait);
      oWait.StartWait;
    end;
    if Journal <> nil then
      Journal.Lock;
    try
      if (Journal = nil) or not Assigned(FUpdateHandler) then begin
        if lAutoCommit and (Journal <> nil) then
          Journal.AcceptChanges(LimitToTable);
        Result := True;
        Exit;
      end;
      oRow := Journal.FirstChange(LimitToTable);
      while oRow <> nil do begin
        oNextRow := Journal.NextChange(oRow, LimitToTable);
        oTabAdapter := LookupTableAdapter(oRow.Table);

        if (oTabAdapter <> nil) and oRow.HasErrors then begin
          if lShowCrs then
            oWait.PushWait;
          try
            eAction := raSkip;
            FUpdateHandler.ReconcileRow(oRow, eAction);
          finally
            if lShowCrs then
              oWait.PopWait;
          end;
          case eAction of
          raSkip:
            ;
          raAbort:
            Break;
          raMerge:
            begin
              oRow.ClearErrors;
              oRow.AcceptChanges;
            end;
          raCorrect:
            oRow.ClearErrors;
          raCancel:
            begin
              oRow.ClearErrors;
              oRow.RejectChanges;
            end;
          raRefresh:
            begin
              oRow.ClearErrors;
              eErrAction := eaApplied;
              oTabAdapter.Fetch(oRow, eErrAction, -1,
                [foClear] + FDGetFillRowOptions(oTabAdapter.Options.FetchOptions));
            end;
          end;
        end
        else if lAutoCommit then
          oRow.AcceptChanges;

        oRow := oNextRow;
      end;
      Result := not Journal.HasChanges(LimitToTable);
    finally
      if Journal <> nil then
        Journal.Unlock;
      if lShowCrs then
        oWait.StopWait;
    end;
{$IFDEF FireDAC_MONITOR}
  finally
    if IsTracing then
      if LimitToTable <> nil then
        Trace(ekAdaptUpdate, esEnd, 'Reconcile',
          ['LimitToTable', LimitToTable.SourceName])
      else
        Trace(ekAdaptUpdate, esEnd, 'Reconcile', []);
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{ TFDDAptTableAdapterMappingHandler                                             }
{-------------------------------------------------------------------------------}
type
  TFDDAptTableAdapterMappingHandler = class(TInterfacedObject, IFDPhysMappingHandler)
  private
    FTableAdapter: TFDDAptTableAdapter;
  protected
    // IFDPhysMappingHandler
    function MapRecordSet(const ATable: TFDPhysMappingName;
      var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
      var ADatSTable: TFDDatSTable): TFDPhysMappingResult;
    function MapRecordSetColumn(const ATable, AColumn: TFDPhysMappingName;
      var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
      var ADatSColumn: TFDDatSColumn): TFDPhysMappingResult;
  public
    constructor Create(ATableAdapter: TFDDAptTableAdapter);
  end;

{-------------------------------------------------------------------------------}
constructor TFDDAptTableAdapterMappingHandler.Create(ATableAdapter: TFDDAptTableAdapter);
begin
  inherited Create;
  FTableAdapter := ATableAdapter;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapterMappingHandler.MapRecordSet(const ATable: TFDPhysMappingName;
  var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
  var ADatSTable: TFDDatSTable): TFDPhysMappingResult;
begin
  Result := FTableAdapter.MapRecordSet(ATable, ASourceID, ASourceName, ADatSName,
    AUpdateName, ADatSTable);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapterMappingHandler.MapRecordSetColumn(const ATable, AColumn: TFDPhysMappingName;
  var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
  var ADatSColumn: TFDDatSColumn): TFDPhysMappingResult;
begin
  Result := FTableAdapter.MapRecordSetColumn(ATable, AColumn, ASourceID, ASourceName, ADatSName,
    AUpdateName, ADatSColumn);
end;

{-------------------------------------------------------------------------------}
{ TFDDAptTableAdapter                                                           }
{-------------------------------------------------------------------------------}
constructor TFDDAptTableAdapter.CreateForSchema(AMappings: TFDDAptTableAdapters);
begin
  inherited Create;
  FMappings := AMappings;
  if FMappings <> nil then
    FMappings.FItems.Add(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.Initialize;
begin
  inherited Initialize;
  FBuffer := TFDBuffer.Create;
  FColMappings := TFDDAptColumnMappings.Create(nil);
  SetLength(FCommands, Integer(arFetchGenerators) - Integer(arSelect) + 1);
  FSourceRecordSetID := -1;
  FMappings := nil;
end;

{-------------------------------------------------------------------------------}
destructor TFDDAptTableAdapter.Destroy;
begin
  ReleaseDatSTable;
  SetDatSManager(nil);
  FDFreeAndNil(FBuffer);
  SetLength(FCommands, 0);
  FDFreeAndNil(FColMappings);
  FErrorHandler := nil;
  FUpdateHandler := nil;
  if FMappings <> nil then begin
    FMappings.FItems.Remove(Self);
    FMappings := nil;
  end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter._AddRef: Integer;
begin
  Result := FDAddRef;
  if FMappings <> nil then
    FMappings._AddRef;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter._Release: Integer;
begin
  Result := FDDecRef;
  if FMappings <> nil then
    Result := FMappings._Release
  else if Result = 0 then
    FDFree(Self);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetObj: TObject;
begin
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetSchemaAdapter: TFDDAptSchemaAdapter;
begin
  if FMappings <> nil then
    Result := FMappings.FSchemaAdapter
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetTableMappings: IFDDAptTableAdapters;
begin
  if FMappings <> nil then
    Result := FMappings as IFDDAptTableAdapters
  else
    Result := nil;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
// Tracing

function TFDDAptTableAdapter.IsTracing: Boolean;
var
  oConn: IFDPhysConnection;
begin
  GetConn(oConn);
  Result := (oConn <> nil) and oConn.Tracing;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.Trace(AKind: TFDMoniEventKind;
  AStep: TFDMoniEventStep; const AMsg: String; const AArgs: array of const);
var
  oConn: IFDPhysConnection;
begin
  GetConn(oConn);
  if (oConn <> nil) and oConn.Tracing then
    oConn.Monitor.Notify(AKind, AStep, Self, AMsg, AArgs);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetName: TComponentName;
begin
  Result := GetSourceRecordSetName + ': ' + ClassName + '($' +
    IntToHex(Integer(Self), 8) + ')';
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetParent: IFDStanObject;
begin
  if (FMappings = nil) or (FMappings.FSchemaAdapter = nil) then
    Result := nil
  else
    Result := FMappings.FSchemaAdapter as IFDStanObject;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.AfterReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.BeforeReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetOwner(const AOwner: TObject;
  const ARole: TComponentName);
begin
  // nothing
                                                                                  
end;

{-------------------------------------------------------------------------------}
// Get/Set props

function TFDDAptTableAdapter.GetOptions: IFDStanOptions;
var
  oCmd: IFDPhysCommand;
begin
  oCmd := GetSelectCommand;
  if oCmd = nil then
    Result := nil
  else
    Result := oCmd.Options;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetColumnMappings: TFDDAptColumnMappings;
begin
  Result := FColMappings;
  Result.DatSTable := GetDatSTable;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetSourceRecordSetID: Integer;
begin
  Result := FSourceRecordSetID;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetSourceRecordSetID(const AValue: Integer);
begin
  if FSourceRecordSetID <> AValue then begin
    FSourceRecordSetID := AValue;
    if AValue >= 0 then
      FSourceRecordSetName := '';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetSourceRecordSetName: String;
var
  oCmd: IFDPhysCommand;
begin
  Result := FSourceRecordSetName;
  oCmd := GetSelectCommand;
  if (Result = '') and (oCmd <> nil) then
    Result := oCmd.SourceObjectName;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetSourceRecordSetName(const AValue: String);
begin
  if FSourceRecordSetName <> AValue then begin
    FSourceRecordSetName := AValue;
    if AValue <> '' then
      FSourceRecordSetID := -1;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetUpdateTableName: String;
var
  oCmd: IFDPhysCommand;
begin
  Result := FUpdateTableName;
  oCmd := GetSelectCommand;
  if (Result = '') and (oCmd <> nil) then
    Result := (GetSelectCommand.Options.UpdateOptions as TFDBottomUpdateOptions).UpdateTableName;
  if (Result = '') and (FDatSTable <> nil) then
    Result := FDatSTable.ActualOriginName;
  if Result = '' then
    Result := GetSourceRecordSetName;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetUpdateTableName(const AValue: String);
begin
  FUpdateTableName := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetDatSTableName: String;
begin
  Result := FDatSTableName;
  if (Result = '') and (FDatSTable <> nil) then
    Result := FDatSTable.Name;
  if Result = '' then
    Result := GetSourceRecordSetName;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.ReleaseDatSTable;
begin
  if FDatSTable <> nil then begin
    FDatSTable.RemRef;
    FDatSTable := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.DetachDatSTable;
var
  oTab: TFDDatSTable;
begin
  // Here was call the GetDatSTable, but it leads to TFDDatSTable leak
  // in case, when (FDatSTable = nil) and (GetDatSTableName <> '').
  // Because table will be removed from oTab.Manager.Tables, but
  // TFDDAptTableAdapter ReleaseDatSTable releases only FDatSTable.
  oTab := FDatSTable;
  if (oTab <> nil) and (oTab.Manager <> nil) and
     (oTab.Manager = FMappings.FSchemaAdapter.GetDatSManager) then
    oTab.Manager.Tables.Remove(oTab, True);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.AcquireDatSTable(ATable: TFDDatSTable);
begin
  if FDatSTable <> ATable then begin
    ReleaseDatSTable;
    if ATable <> nil then
      ATable.AddRef;
    FDatSTable := ATable;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.AttachDatSTable;
var
  oTab: TFDDatSTable;
  oMan: TFDDatSManager;
begin
  oTab := GetDatSTable;
  oMan := FMappings.FSchemaAdapter.GetDatSManager;
  if (oTab <> nil) and (oTab.Manager <> oMan) then begin
    if oTab.Manager <> nil then
      oTab.Manager.Tables.Remove(oTab, True);
    if oMan <> nil then
      oMan.Tables.Add(oTab);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetDatSTableName(const AValue: String);
begin
  if FDatSTableName <> AValue then begin
    FDatSTableName := AValue;
    ReleaseDatSTable;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetDatSTable: TFDDatSTable;
var
  i: Integer;
  oTabs: TFDDatSTableList;
  sName: String;
begin
  if FDatSTable <> nil then
    Result := FDatSTable
  else begin
    Result := nil;
    if GetSchemaAdapter <> nil then begin
      sName := GetDatSTableName;
      if sName <> '' then begin
        oTabs := GetSchemaAdapter.GetDatSManager.Tables;
        i := oTabs.IndexOfName(sName);
        if i <> -1 then
          Result := oTabs.ItemsI[i];
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetDatSTable(AValue: TFDDatSTable);
begin
  if FDatSTable <> AValue then begin
    AcquireDatSTable(AValue);
    FDatSTableName := '';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetMetaInfoMergeMode: TFDPhysMetaInfoMergeMode;
begin
  Result := FMetaInfoMergeMode;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetMetaInfoMergeMode(const AValue: TFDPhysMetaInfoMergeMode);
begin
  FMetaInfoMergeMode := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetDatSManager: TFDDatSManager;
begin
  if GetSchemaAdapter <> nil then
    Result := GetSchemaAdapter.GetDatSManager
  else
    Result := FDatSManager;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetDatSManager(AValue: TFDDatSManager);
begin
  if FDatSManager <> AValue then begin
    SetDatSTable(nil);
    if FDatSManager <> nil then
      FDatSManager.RemRef;
    FDatSManager := AValue;
    if FDatSManager <> nil then
      FDatSManager.AddRef;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.GetCommand(AReq: TFDActionRequest; out ACmd: IFDPhysCommand);
begin
  ACmd := FCommands[Integer(AReq) - Integer(arSelect)];
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetSelectCommand: IFDPhysCommand;
begin
  GetCommand(arSelect, Result);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetDeleteCommand: IFDPhysCommand;
begin
  GetCommand(arDelete, Result);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetFetchRowCommand: IFDPhysCommand;
begin
  GetCommand(arFetchRow, Result);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetInsertCommand: IFDPhysCommand;
begin
  GetCommand(arInsert, Result);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetLockCommand: IFDPhysCommand;
begin
  GetCommand(arLock, Result);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetUnlockCommand: IFDPhysCommand;
begin
  GetCommand(arUnlock, Result);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetUpdateCommand: IFDPhysCommand;
begin
  GetCommand(arUpdate, Result);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.UpdateCommands(AReason: TFDDAptUpdateCommandReason);
var
  i: Integer;
  oCmd: IFDPhysCommand;
begin
  if (FGeneratedCommands = []) and (AReason = urSetSelect) then
    Exit;
  for i := 0 to Length(FCommands) - 1 do begin
    oCmd := FCommands[i];
    if TFDActionRequest(i + Integer(arSelect)) in FGeneratedCommands then begin
      Exclude(FGeneratedCommands, TFDActionRequest(i + Integer(arSelect)));
      if oCmd <> nil then
        FCommands[i] := nil;
    end
    else if oCmd <> nil then
      case AReason of
      urSetSelect:
        ;
      urSetErrorHandler:
        begin
          oCmd.ErrorHandler := GetErrorHandler;
          oCmd.MappingHandler := TFDDAptTableAdapterMappingHandler.Create(Self) as
            IFDPhysMappingHandler;
        end;
      urReset:
        oCmd.Disconnect;
      urSetTransaction:
        if (TFDActionRequest(i + Integer(arSelect)) = arSelect) and
           (oCmd.Transaction <> GetTransaction) then begin
          oCmd.Disconnect;
          oCmd.Transaction := GetTransaction;
        end;
      urSetUpdateTransaction:
        if (TFDActionRequest(i + Integer(arSelect)) <> arSelect) and
           (oCmd.Transaction <> GetUpdateTransaction) then begin
          oCmd.Disconnect;
          oCmd.Transaction := GetUpdateTransaction;
        end;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.InternalSetCommand(AReq: TFDActionRequest; const ACmd: IFDPhysCommand);
begin
  if Length(FCommands) <> 0 then
    FCommands[Integer(AReq) - Integer(arSelect)] := ACmd;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.SetCommand(AReq: TFDActionRequest; const ACmd: IFDPhysCommand): Boolean;
var
  oCmd: IFDPhysCommand;
begin
  Result := False;
  GetCommand(AReq, oCmd);
  if oCmd <> ACmd then begin
    if oCmd <> nil then begin
      oCmd.ErrorHandler := nil;
      oCmd.MappingHandler := nil;
    end;
    InternalSetCommand(AReq, ACmd);
    if ACmd <> nil then begin
      ACmd.ErrorHandler := GetErrorHandler;
      ACmd.MappingHandler := TFDDAptTableAdapterMappingHandler.Create(Self) as
        IFDPhysMappingHandler;
      Exclude(FGeneratedCommands, AReq);
    end
    else
      Include(FGeneratedCommands, AReq);
    Result := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.GetConn(out AConn: IFDPhysConnection);
var
  oCmd: IFDPhysCommand;
begin
  oCmd := GetSelectCommand;
  if oCmd <> nil then
    AConn := oCmd.Connection
  else
    AConn := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.GetUpdTx(out ATx: IFDPhysTransaction);
var
  oCmd: IFDPhysCommand;
  oConn: IFDPhysConnection;
begin
  ATx := GetUpdateTransaction;
  if ATx = nil then begin
    ATx := GetTransaction;
    if ATx = nil then begin
      oCmd := GetSelectCommand;
      if oCmd <> nil then begin
        ATx := oCmd.Transaction;
        if ATx = nil then begin
          oConn := oCmd.Connection;
          if oConn <> nil then
            ATx := oConn.Transaction;
        end;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetSelectCommand(const ACmd: IFDPhysCommand);
begin
  if SetCommand(arSelect, ACmd) then
    UpdateCommands(urSetSelect);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetDeleteCommand(const ACmd: IFDPhysCommand);
begin
  SetCommand(arDelete, ACmd);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetFetchRowCommand(const ACmd: IFDPhysCommand);
begin
  SetCommand(arFetchRow, ACmd);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetInsertCommand(const ACmd: IFDPhysCommand);
begin
  SetCommand(arInsert, ACmd);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetLockCommand(const ACmd: IFDPhysCommand);
begin
  SetCommand(arLock, ACmd);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetUnlockCommand(const ACmd: IFDPhysCommand);
begin
  SetCommand(arUnlock, ACmd);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetUpdateCommand(const ACmd: IFDPhysCommand);
begin
  SetCommand(arUpdate, ACmd);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.CheckSelectCommand;
begin
  if GetSelectCommand = nil then
    FDException(Self, [S_FD_LDApt], er_FD_DAptNoSelectCmd, []);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetTransaction: IFDPhysTransaction;
var
  oManAdapt: TFDDAptSchemaAdapter;
begin
  if FTransaction <> nil then
    Result := FTransaction
  else begin
    oManAdapt := GetSchemaAdapter;
    if oManAdapt <> nil then
      Result := oManAdapt.GetTransaction
    else
      Result := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetTransaction(const AValue: IFDPhysTransaction);
begin
  if FTransaction <> AValue then begin
    FTransaction := AValue;
    UpdateCommands(urSetTransaction);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetUpdateTransaction: IFDPhysTransaction;
var
  oManAdapt: TFDDAptSchemaAdapter;
begin
  if FUpdateTransaction <> nil then
    Result := FUpdateTransaction
  else begin
    oManAdapt := GetSchemaAdapter;
    if oManAdapt <> nil then
      Result := oManAdapt.GetUpdateTransaction
    else
      Result := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetUpdateTransaction(const AValue: IFDPhysTransaction);
begin
  if FUpdateTransaction <> AValue then begin
    FUpdateTransaction := AValue;
    UpdateCommands(urSetUpdateTransaction);
  end;
end;

{-------------------------------------------------------------------------------}
// Exception handling

procedure TFDDAptTableAdapter.HandleException(const AInitiator: IFDStanObject;
  var AException: Exception);
begin
{$IFDEF FireDAC_MONITOR}
  if not (AException is EFDDBEngineException) and IsTracing then
    Trace(ekError, esProgress, AException.Message, []);
{$ENDIF}
  if Assigned(GetErrorHandler()) then
    GetErrorHandler().HandleException(AInitiator, AException);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetErrorHandler: IFDStanErrorHandler;
var
  oManAdapt: TFDDAptSchemaAdapter;
begin
  if FErrorHandler <> nil then
    Result := FErrorHandler
  else begin
    oManAdapt := GetSchemaAdapter;
    if oManAdapt <> nil then
      Result := oManAdapt.GetErrorHandler
    else
      Result := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetErrorHandler(const AValue: IFDStanErrorHandler);
begin
  FErrorHandler := AValue;
  UpdateCommands(urSetErrorHandler);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetUpdateHandler: IFDDAptUpdateHandler;
var
  oManAdapt: TFDDAptSchemaAdapter;
begin
  if FUpdateHandler <> nil then
    Result := FUpdateHandler
  else begin
    oManAdapt := GetSchemaAdapter;
    if oManAdapt <> nil then
      Result := oManAdapt.GetUpdateHandler
    else
      Result := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetUpdateHandler(const AValue: IFDDAptUpdateHandler);
begin
  FUpdateHandler := AValue;
end;

{-------------------------------------------------------------------------------}
// Mapping handling

function TFDDAptTableAdapter.MatchRecordSet(const ATable: TFDPhysMappingName): Boolean;
var
  oTab: TFDDatSTable;
begin
  case ATable.FKind of
  nkID:
    Result := GetSourceRecordSetID = ATable.FID;
  nkSource:
    Result := {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
      (ATable.FName, GetSourceRecordSetName) = 0;
  nkDatS:
    Result := {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
      (ATable.FName, GetDatSTableName) = 0;
  nkObj:
    begin
      oTab := TFDDatSTable(ATable.FObj);
      Result :=
        (GetDatSTable <> nil) and (GetDatSTable = oTab) or
        (GetSourceRecordSetID <> -1) and (GetSourceRecordSetID = oTab.SourceID) or
        (GetSourceRecordSetName <> '') and (
          {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
          (GetSourceRecordSetName, oTab.SourceName) = 0) or
        (GetDatSTableName <> '') and (
          {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
          (GetDatSTableName, oTab.Name) = 0);
    end;
  nkDefault:
    Result := True;
  else
    Result := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure FDGetRecordSetInfo(const AAdapter: IFDDAptTableAdapter;
  var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
  var ADatSTable: TFDDatSTable);
var
  oTab: TFDDatSTable;
  sName: String;
begin
  if AAdapter.SourceRecordSetID <> -1 then
    ASourceID := AAdapter.SourceRecordSetID;
  sName := AAdapter.SourceRecordSetName;
  if sName <> '' then
    ASourceName := sName;
  sName := AAdapter.DatSTableName;
  if sName <> '' then
    ADatSName := sName;
  sName := AAdapter.UpdateTableName;
  if sName <> '' then
    AUpdateName := sName;
  oTab := AAdapter.DatSTable;
  if oTab <> nil then
    ADatSTable := oTab;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.MapRecordSet(const ATable: TFDPhysMappingName;
  var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
  var ADatSTable: TFDDatSTable): TFDPhysMappingResult;
begin
  if MatchRecordSet(ATable) then begin
    Result := mrMapped;
    FDGetRecordSetInfo(Self as IFDDAptTableAdapter, ASourceID,
      ASourceName, ADatSName, AUpdateName, ADatSTable);
  end
  else if (GetSchemaAdapter <> nil) and (ATable.FKind <> nkDefault) then
    Result := GetSchemaAdapter.MapRecordSet(ATable, ASourceID,
      ASourceName, ADatSName, AUpdateName, ADatSTable)
  else
    Result := mrNotMapped;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.MapRecordSetColumn(const ATable, AColumn: TFDPhysMappingName;
  var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
  var ADatSColumn: TFDDatSColumn): TFDPhysMappingResult;
var
  oColMap: TFDDAptColumnMapping;
begin
  Result := mrNotMapped;
  if MatchRecordSet(ATable) then
    if (GetColumnMappings = nil) or (GetColumnMappings.Count = 0) then
      Result := mrDefault
    else begin
      oColMap := GetColumnMappings.Lookup(AColumn);
      if oColMap <> nil then begin
        Result := mrMapped;
        FDGetRecordSetColumnInfo(oColMap, ASourceID, ASourceName, ADatSName,
          AUpdateName, ADatSColumn);
      end;
    end
  else if GetSchemaAdapter <> nil then
    Result := GetSchemaAdapter.MapRecordSetColumn(ATable, AColumn,
      ASourceID, ASourceName, ADatSName, AUpdateName, ADatSColumn);
end;

{-------------------------------------------------------------------------------}
// Command generation

procedure TFDDAptTableAdapter.ParName2Col(ABaseRow: TFDDatSRow; const AName: String;
  var ACol: TFDDatSColumn; var ARow: TFDDatSRow; var AVersion: Integer);
var
  i, i1, iCol, iKind, iUCNameLen: Integer;
  sUCName: String;
begin
  sUCName := UpperCase(AName);
  iUCNameLen := Length(sUCName);
  if StrLIComp(PChar(sUCName), PChar('NEW_P$_'), 7) = 0 then begin
    iKind := 1;
    AVersion := 1;
    i := 6;
  end
  else if StrLComp(PChar(sUCName), PChar('OLD_P$_'), 7) = 0 then begin
    iKind := 1;
    AVersion := -1;
    i := 6;
  end
  else if StrLComp(PChar(sUCName), PChar('NEW_'), 4) = 0 then begin
    iKind := 2;
    AVersion := 1;
    i := 6;
  end
  else if StrLComp(PChar(sUCName), PChar('OLD_'), 4) = 0 then begin
    iKind := 2;
    AVersion := -1;
    i := 6;
  end
  else begin
    iKind := 0;
    AVersion := 0;
    i := 1;
  end;
  ACol := nil;
  ARow := nil;
  if iKind = 1 then begin
    while (i + 2 <= iUCNameLen) and (sUCName[i] <> '#') and (sUCName[i] = '$') and (sUCName[i + 1] = '_') do begin
      Inc(i, 2);
      i1 := i;
      while (i <= iUCNameLen) and (sUCName[i] >= '0') and (sUCName[i] <= '9') do
        Inc(i);
      iCol := StrToInt(Copy(sUCName, i1, i - i1));
      if (ACol = nil) and (ARow = nil) then begin
        ARow := ABaseRow;
        ACol := ARow.Table.Columns[iCol];
      end
      else begin
        if ARow <> nil then
          ARow := ARow.NestedRow[ACol.Index];
        ACol := ACol.NestedTable.Columns[iCol];
      end;
    end;
  end
  else if iKind = 2 then begin
    ARow := ABaseRow;
    // See comment in TFDPhysCommandGenerator.AddColumnParam
    i := Pos('$#', sUCName);
    if i = 0 then
      i := MAXINT;
    ACol := ARow.Table.Columns.ColumnByName(Copy(sUCName, 5, i - 5));
  end
  else if iKind = 0 then begin
    ARow := ABaseRow;
    i := ARow.Table.Columns.IndexOfName(sUCName);
    if i <> -1 then
      ACol := ARow.Table.Columns[i];
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.SetParamsFromRow(AParams: TFDParams; ARow: TFDDatSRow);
var
  i, j, iVersion: Integer;
  eRowVersion: TFDDatSRowVersion;
  oPar: TFDParam;
  oCol, oRefCol: TFDDatSColumn;
  oRow: TFDDatSRow;
  pBuff: Pointer;
  iLen, iFldSize: LongWord;
  iFldPrec, iFldScale: Integer;
  eFldType: TFieldType;
  oFmtOpts: TFDFormatOptions;
begin
  oFmtOpts := GetOptions.FormatOptions;
  for i := 0 to AParams.Count - 1 do begin
    oPar := AParams[I];
    if oPar.ParamType in [ptUnknown, ptInput, ptInputOutput] then begin
      ParName2Col(ARow, oPar.Name, oCol, oRow, iVersion);
      if oCol <> nil then begin
        if oCol.DataType = dtArrayRef then
          oRefCol := oCol.NestedTable.Columns[0]
        else
          oRefCol := oCol;
        oFmtOpts.ColumnDef2FieldDef(oRefCol.DataType, oRefCol.Size,
          oRefCol.Precision, oRefCol.Scale, oRefCol.Attributes, eFldType,
          iFldSize, iFldPrec, iFldScale);
        if (oPar.DataType = ftUnknown) or (oPar.DataType <> eFldType) then begin
          oPar.DataType := eFldType;
          if oPar.FDDataType = dtUnknown then
            oPar.FDDataType := oRefCol.DataType;
          oPar.Precision := iFldPrec;
          oPar.NumericScale := iFldScale;
          oPar.Size := iFldSize;
        end;
        case iVersion of
        -1:  eRowVersion := rvOriginal;
         1:  eRowVersion := rvCurrent;
        else eRowVersion := rvDefault;
        end;
        if oRow = nil then
          oPar.SetData(nil, 0, -1)
        else if oCol.DataType = dtArrayRef then begin
          oRow := oRow.NestedRow[oCol.Index];
          oPar.ArrayType := atTable;
          oPar.ArraySize := oRow.Table.Columns.Count - 1;
          oPar.DataTypeName := oCol.SourceDataTypeName;
          for j := 0 to oPar.ArraySize - 1 do begin
            oRow.GetData(j, eRowVersion, pBuff, 0, iLen, False);
            oPar.SetData(pBuff, iLen, j);
          end;
        end
        else begin
          oRow.GetData(oCol.Index, eRowVersion, pBuff, 0, iLen, False);
          oPar.SetData(pBuff, iLen, -1);
        end;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.MergeRows(const ACommand: IFDPhysCommand;
  ABaseRow, AFetchedRow: TFDDatSRow; AClearRow: Boolean);
var
  i, iBaseCol: Integer;
  oBaseCols, oFetchedCols: TFDDatSColumnList;
  pBuff: Pointer;
  iLen: LongWord;
  lRefreshing, lLoadingData, lCtrlEditing: Boolean;
  rState: TFDDatSLoadState;
begin
  lRefreshing := (ABaseRow.RowState = rsUnchanged);
  lLoadingData := False;
  lCtrlEditing := not (ABaseRow.RowState in [rsDetached, rsForceWrite]) or AClearRow;
  ABaseRow.Table.BeginLoadData(rState, lmRefreshing);
  try
    try
      oBaseCols := ABaseRow.Table.Columns;
      oFetchedCols := AFetchedRow.Table.Columns;
      for i := 0 to oFetchedCols.Count - 1 do begin
        iBaseCol := oBaseCols.IndexOfSourceName(oFetchedCols[i].SourceName);
        if iBaseCol <> -1 then begin
          if not lLoadingData then begin
            lLoadingData := True;
            if lCtrlEditing then begin
              ABaseRow.BeginEdit;
              if AClearRow then
                ABaseRow.Erase;
            end;
          end;
          if oBaseCols.ItemsI[iBaseCol].DataType = oFetchedCols.ItemsI[i].DataType then begin
            pBuff := nil;
            iLen := 0;
            AFetchedRow.GetData(i, rvDefault, pBuff, 0, iLen, False);
            ABaseRow.SetData(iBaseCol, pBuff, iLen);
          end
          else
            ABaseRow.SetData(iBaseCol, AFetchedRow.GetData(i, rvDefault));
          if caAutoInc in oBaseCols.ItemsI[iBaseCol].ActualAttributes then
            ACommand.Connection.SaveLastAutoGenValue(AFetchedRow.GetData(i, rvDefault));
        end;
      end;
      if lLoadingData and lCtrlEditing then begin
        ABaseRow.EndEdit;
        if lRefreshing then
          ABaseRow.AcceptChanges(False);
      end;
    except
      if lLoadingData and lCtrlEditing then
        ABaseRow.CancelEdit;
      raise;
    end;
  finally
    ABaseRow.Table.EndLoadData(rState);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.MergeRowFromParams(const ACommand: IFDPhysCommand;
  ABaseRow: TFDDatSRow; AFetchedParams: TFDParams; AClearRow: Boolean);
var
  i: Integer;
  oCol: TFDDatSColumn;
  oRow: TFDDatSRow;
  iVersion: Integer;
  lRefreshing, lLoadingData, lCtrlEditing: Boolean;
  rState: TFDDatSLoadState;
begin
  lRefreshing := (ABaseRow.RowState = rsUnchanged);
  lLoadingData := False;
  lCtrlEditing := not (ABaseRow.RowState in [rsDetached, rsForceWrite]) or AClearRow;
  ABaseRow.Table.BeginLoadData(rState, lmRefreshing);
  try
    try
      for i := 0 to AFetchedParams.Count - 1 do
        if AFetchedParams[i].ParamType in [ptOutput, ptInputOutput] then begin
          oCol := nil;
          oRow := nil;
          iVersion := -1;
          ParName2Col(ABaseRow, AFetchedParams[i].Name, oCol, oRow, iVersion);
          if (oRow <> nil) and (oCol <> nil) and (iVersion = 1) then begin
            if not lLoadingData then begin
              lLoadingData := True;
              if lCtrlEditing then begin
                ABaseRow.BeginEdit;
                if AClearRow then
                  ABaseRow.Erase;
              end;
            end;
            oRow.SetData(oCol.Index, AFetchedParams[i].Value);
            if caAutoInc in oCol.ActualAttributes then
              ACommand.Connection.SaveLastAutoGenValue(AFetchedParams[i].Value);
          end;
        end;
      if lLoadingData and lCtrlEditing then begin
        ABaseRow.EndEdit;
        if lRefreshing then
          ABaseRow.AcceptChanges(False);
      end;
    except
      if lLoadingData and lCtrlEditing then
        ABaseRow.CancelEdit;
      raise;
    end;
  finally
    ABaseRow.Table.EndLoadData(rState);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.ProcessRequest(const ACommand: IFDPhysCommand;
  ARow: TFDDatSRow; ARequest: TFDUpdateRequest; AUpdRowOptions: TFDUpdateRowOptions;
  AFillRowOptions: TFDPhysFillRowOptions; AWrapByTX: Boolean);
var
  oTab: TFDDatSTable;
  lOpen, lClearErrorHandler: Boolean;

  procedure ErrorRecordIsDeleted(ARowsCount: Integer);
  const
    SOper: array[TFDUpdateRequest] of String = ('Insert', 'Update',
      'Delete', 'Lock', 'Unlock', 'Fetch', 'UpdateHBlobs', 'DeleteAll',
      'FetchGenerators');
  var
    s, sReasons: String;
  begin
    s := LowerCase(SOper[ARequest]);
    if s[Length(s)] = 'e' then
      s := s + 'd'
    else
      s := s + 'ed';
    if ACommand.Connection.Messages <> nil then
      sReasons := ACommand.Connection.Messages.Errors[0].Message
    else
      sReasons := S_FD_DAptRecordIsDeletedReasons;
    FDException(Self, [S_FD_LDApt], er_FD_DAptRecordIsDeleted,
      [SOper[ARequest], s, ARowsCount, sReasons]);
  end;

begin
{$IFDEF FireDAC_MONITOR}
  if IsTracing then
    if ARow <> nil then
      Trace(ekAdaptUpdate, esStart, 'ProcessRequest',
        ['ARow.Table.Name', ARow.Table.SourceName])
    else
      Trace(ekAdaptUpdate, esStart, 'ProcessRequest', []);
  try
{$ENDIF}
    if ACommand.ErrorHandler = nil then begin
      lClearErrorHandler := True;
      ACommand.ErrorHandler := Self as IFDStanErrorHandler;
    end
    else
      lClearErrorHandler := False;
    try
      try
        ACommand.CloseAll;
        if ACommand.CommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs] then begin
          if ACommand.State = csInactive then
            ACommand.Prepare;
          SetParamsFromRow(ACommand.Params, ARow);
        end
        else begin
          SetParamsFromRow(ACommand.Params, ARow);
          if ACommand.State = csInactive then
            ACommand.Prepare;
        end;
        if GetSelectCommand <> nil then
          ACommand.SourceRecordSetName := GetSelectCommand.SourceRecordSetName;
        lOpen := (ACommand.CommandKind in [skSelect, skSelectForLock, skSelectForUnLock,
          skStoredProcWithCrs]);
        while ACommand.State <> csInactive do begin
          if lOpen then begin
            ACommand.Open;
            if ACommand.State <> csOpen then
              Break;
            oTab := TFDDatSTable.Create;
            try
              ACommand.Define(oTab, mmReset);
              ACommand.Fetch(oTab, True);
              if ARequest = arLock then begin
                // Dont compare server side SELECT item values with client
                // columns values - there always will be rounding errors.
                // Instead use correct UpdateMode to build WHERE and lets
                // server perform a comparision.
                if oTab.Rows.Count <> 1 then
                  if ACommand.Options.UpdateOptions.CountUpdatedRecords then
                    ErrorRecordIsDeleted(oTab.Rows.Count);
              end
              else if ARequest in [arFetchRow, arInsert, arUpdate, arFetchGenerators] then begin
                if oTab.Rows.Count <> 1 then
                  if ACommand.Options.UpdateOptions.CountUpdatedRecords then
                    ErrorRecordIsDeleted(oTab.Rows.Count);
                if oTab.Rows.Count > 0 then
                  MergeRows(ACommand, ARow, oTab.Rows[0], foClear in AFillRowOptions);
              end;
            finally
              FDFree(oTab);
            end;
          end
          else begin
            ACommand.Execute;
            if ACommand.RowsAffectedReal and (ACommand.RowsAffected <> 1) and
               ACommand.Options.UpdateOptions.CountUpdatedRecords then
              ErrorRecordIsDeleted(ACommand.RowsAffected);
            if ARequest in [arInsert, arUpdate, arFetchRow, arUpdateHBlobs] then
              MergeRowFromParams(ACommand, ARow, ACommand.Params, foClear in AFillRowOptions);
          end;
          ACommand.NextRecordSet := True;
          lOpen := True;
        end;
      except
        on E: EFDDBEngineException do begin
          if (ARequest in [arInsert, arUpdate, arDelete, arLock, arUnlock,
                           arUpdateHBlobs, arFetchGenerators]) and
             (E.Kind <> ekServerGone) then
            ARow.RowError := E;
          if E.Kind in [ekNoDataFound, ekTooManyRows] then begin
            if ACommand.Options.UpdateOptions.CountUpdatedRecords then
              ErrorRecordIsDeleted(ACommand.RowsAffected);
          end
          else
            raise;
        end;
        on E: EFDException do begin
          if ARequest in [arInsert, arUpdate, arDelete, arLock, arUnlock,
                          arUpdateHBlobs, arFetchGenerators] then
            ARow.RowError := E;
          raise;
        end;
      end;
    finally
      ACommand.CloseAll;
      if lClearErrorHandler then
        ACommand.ErrorHandler := nil;
    end;
{$IFDEF FireDAC_MONITOR}
  finally
    if IsTracing then
      if ARow <> nil then
        Trace(ekAdaptUpdate, esEnd, 'ProcessRequest',
          ['ARow.Table.Name', ARow.Table.SourceName])
      else
        Trace(ekAdaptUpdate, esEnd, 'ProcessRequest', []);
  end;
{$ENDIF}
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetUpdateRequestName(ARequest: TFDUpdateRequest): String;
begin
  case ARequest of
  arLock:            Result := 'Lock';
  arUnLock:          Result := 'UnLock';
  arInsert:          Result := 'Insert';
  arDelete:          Result := 'Delete';
  arUpdate:          Result := 'Update';
  arUpdateHBlobs:    Result := 'UpdateHBlobs';
  arFetchRow:        Result := 'FetchRow';
  arFetchGenerators: Result := 'FetchGenerators';
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.GetUpdateRowCommand(ARow: TFDDatSRow;
  AUpdRowOptions: TFDUpdateRowOptions; AUpdateRequest: TFDUpdateRequest;
  AFillRowOptions: TFDPhysFillRowOptions; AColumn: Integer; ACacheCommand: Boolean;
  var AFlags: TFDPhysCommandGeneratorFlags): IFDPhysCommand;
var
  oConn: IFDPhysConnection;
  oTx: IFDPhysTransaction;
{$IFDEF FireDAC_MONITOR}
  oObjIntf: IFDStanObject;
{$ENDIF}
  eCommandKind: TFDPhysCommandKind;
  oCmdGen: IFDPhysCommandGenerator;
  oConnMeta: IFDPhysConnectionMetadata;
  oMeta: IFDPhysConnectionMetadata;
  oRes: TFDResourceOptions;
  oFtch: TFDFetchOptions;
  oUpd: TFDUpdateOptions;
  oTmpParams, oResParams: TFDParams;
  i: Integer;
  oPar: TFDParam;
begin
  GetConn(oConn);
  oConn.CreateMetadata(oMeta);
  if (AUpdateRequest = arUnlock) and not oMeta.IsFileBased then
    Exit;
  GetUpdTx(oTx);
  oConn.CreateCommand(Result);
  Result.Transaction := oTx;
{$IFDEF FireDAC_MONITOR}
  Supports(Result, IFDStanObject, oObjIntf);
  oObjIntf.SetOwner(Self, GetUpdateRequestName(AUpdateRequest));
{$ENDIF}
  oRes := Result.Options.ResourceOptions;
  oFtch := Result.Options.FetchOptions;
  oUpd := Result.Options.UpdateOptions;
  oRes.ParamCreate := False;
  oRes.MacroCreate := False;
  Result.Params.BindMode := pbByNumber;

  oConn.CreateCommandGenerator(oCmdGen, GetSelectCommand);
  oCmdGen.Options := GetOptions;
  oCmdGen.Table := ARow.Table;
  oCmdGen.Row := ARow;
  oCmdGen.Params := Result.Params;
  oCmdGen.MappingHandler := TFDDAptTableAdapterMappingHandler.Create(Self) as
    IFDPhysMappingHandler;
  if AColumn <> -1 then
    oCmdGen.Column := ARow.Table.Columns[AColumn]
  else
    oCmdGen.Column := nil;
  oCmdGen.UpdateRowOptions := AUpdRowOptions;
  oCmdGen.FillRowOptions := AFillRowOptions;
  case AUpdateRequest of
  arInsert:          Result.CommandText := oCmdGen.GenerateInsert;
  arUpdate:          Result.CommandText := oCmdGen.GenerateUpdate;
  arDelete:          Result.CommandText := oCmdGen.GenerateDelete;
  arLock:            Result.CommandText := oCmdGen.GenerateLock;
  arUnlock:          Result.CommandText := oCmdGen.GenerateUnLock;
  arUpdateHBlobs:    Result.CommandText := oCmdGen.GenerateUpdateHBlobs;
  arFetchRow:        Result.CommandText := oCmdGen.GenerateSelect([foAfterIns, foAfterUpd] * AFillRowOptions = []);
  arFetchGenerators: Result.CommandText := oCmdGen.GenerateFetchGenerators;
  end;
  eCommandKind := oCmdGen.CommandKind;
  AFlags := oCmdGen.Flags;

  if Result.CommandText = '' then begin
    Result := nil;
    Exit;
  end;

  if (gfInlineView in AFlags) and (GetSelectCommand.Params.Count > 0) then begin
    oTmpParams := TFDParams.Create;
    try
      oResParams := Result.Params;
      oTmpParams.Assign(oResParams);
      oResParams.Assign(GetSelectCommand.Params);
      for i := 0 to oTmpParams.Count - 1 do begin
        oPar := oResParams.Add;
        oPar.Assign(oTmpParams[i]);
        oPar.Position := oPar.Position + (oResParams.Count - i - 1);
      end;
    finally
      FDFree(oTmpParams);
    end;
  end;

  Result.CommandKind := eCommandKind;
  Result.Options.FormatOptions.Assign(GetOptions.FormatOptions);
  Result.Options.FetchOptions.Assign(GetOptions.FetchOptions);
  Result.Options.UpdateOptions.Assign(GetOptions.UpdateOptions);
  Result.Options.ResourceOptions.Assign(GetOptions.ResourceOptions);

  if oRes.CmdExecMode = amAsync then
    oRes.CmdExecMode := amBlocking;
  if (AUpdateRequest = arLock) and
     (oUpd.LockMode = lmPessimistic) and not oUpd.LockWait then begin
    oConn.CreateMetadata(oConnMeta);
    if not oConnMeta.LockNoWait and oConnMeta.AsyncAbortSupported then
      oRes.CmdExecTimeout := 1000
    else
      oRes.CmdExecTimeout := $FFFFFFFF;
  end;
  oRes.ParamCreate := False;
  oRes.ParamExpand := True;
  oRes.MacroCreate := False;
  oRes.MacroExpand := False;
  oRes.EscapeExpand := False;
  if not ACacheCommand then
    oRes.DirectExecute := True;

  oFtch.Mode := fmExactRecsMax;
  oFtch.RecsMax := 1;
  oFtch.Items := [];
  if foBlobs in AFillRowOptions then
    oFtch.Items := oFtch.Items + [fiBlobs];
  if foDetails in AFillRowOptions then
    oFtch.Items := oFtch.Items + [fiDetails];
  oFtch.Cache := [];
  oFtch.AutoClose := True;
  oFtch.AutoFetchAll := afAll;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.ProcessUpdate(ARow: TFDDatSRow; var AAction: TFDErrorAction;
  ARequest: TFDUpdateRequest; AUpdRowOptions: TFDUpdateRowOptions;
  AFillRowOptions: TFDPhysFillRowOptions; AColumn: Integer);
var
  oConn: IFDPhysConnection;
  oTx: IFDPhysTransaction;
  iLockID: LongWord;
  lEndTX, lSavepoint: Boolean;
  oCmd: IFDPhysCommand;
  oMeta: IFDPhysConnectionMetadata;
  eFillOpts: TFDPhysFillRowOptions;
  lCacheUpdateCommand: Boolean;
  eCmdFlags: TFDPhysCommandGeneratorFlags;
  oUpdOpts: TFDUpdateOptions;
  oExc: Exception;
{$IFDEF FireDAC_MONITOR}
  sCaller, sTabName: String;
{$ENDIF}
  lCustomFetchRow: Boolean;
begin
  try
    CheckSelectCommand;
  except
    AAction := eaExitFailure;
    raise;
  end;

  AAction := eaApplied;
  oUpdOpts := GetOptions.UpdateOptions;
  if not oUpdOpts.CheckRequest(ARequest, AUpdRowOptions, False) then
    Exit;

  eCmdFlags := [];
  lCacheUpdateCommand := False;
  oCmd := nil;
  iLockID := $FFFFFFFF;
  GetConn(oConn);
  GetUpdTx(oTx);
  oConn.CreateMetadata(oMeta);
  AAction := eaDefault;

{$IFDEF FireDAC_MONITOR}
  sCaller := GetUpdateRequestName(ARequest);
  sTabName := '';
  if IsTracing then
    if ARow <> nil then begin
      sTabName := ARow.Table.SourceName;
      Trace(ekAdaptUpdate, esStart, sCaller, ['ARow.Table.Name', sTabName]);
    end
    else
      Trace(ekAdaptUpdate, esStart, sCaller, []);
{$ENDIF}
  oTX.LockAutoStop;
  try
    // get existing command
    if not (ARequest in FGeneratedCommands) then
      GetCommand(ARequest, oCmd);
    if oCmd = nil then begin
      lCacheUpdateCommand :=
        (ARequest = arFetchGenerators) or
        (oUpdOpts.LockMode = lmNone) and not oUpdOpts.UpdateChangedFields and (
          (ARequest = arInsert) or
          (ARequest = arUpdate) and (oUpdOpts.UpdateMode = upWhereKeyOnly) or
          (ARequest = arDelete) and (oUpdOpts.UpdateMode = upWhereKeyOnly));
      if lCacheUpdateCommand then
        GetCommand(ARequest, oCmd)
      else begin
        InternalSetCommand(ARequest, nil);
        oCmd := nil;
      end;
    end;

    repeat
      try
        if not FInUpdateRowHandler and (GetUpdateHandler <> nil) then begin
          FInUpdateRowHandler := True;
          try
            GetUpdateHandler.UpdateRow(ARow, ARequest, AUpdRowOptions, AAction);
            if AAction <> eaDefault then
              lCacheUpdateCommand := False;
          finally
            FInUpdateRowHandler := False;
          end;
        end;
        if AAction in [eaRetry, eaDefault] then begin
          AAction := eaDefault;

          // build command if required
          if oCmd = nil then
            case ARequest of
            arLock:
              begin
                if oUpdOpts.LockMode <> lmNone then begin
                  if (oUpdOpts.LockMode = lmPessimistic) and oMeta.TxSupported and not oTx.Active then
                    iLockID := oTx.StartTransaction;
                  if not (uoNoSrvRecord in AUpdRowOptions) and (ARow.DBLockID = 0) then
                    oCmd := GetUpdateRowCommand(ARow, AUpdRowOptions, arLock,
                      [foData, foBlobs, foDetails, foUpdatable], -1, lCacheUpdateCommand,
                      eCmdFlags);
                end;
              end;
            arUnLock:
              begin
                if (oUpdOpts.LockMode <> lmNone) and not (uoNoSrvRecord in AUpdRowOptions) and
                   (ARow.DBLockID <> 0) then
                  oCmd := GetUpdateRowCommand(ARow, AUpdRowOptions, arUnLock,
                    [foData, foBlobs, foDetails, foUpdatable, foAfterUpd], -1, lCacheUpdateCommand,
                    eCmdFlags);
              end;
            arInsert:
              begin
                if not oUpdOpts.EnableInsert then
                  FDException(Self, [S_FD_LDApt], er_FD_DAptCantInsert, []);
                oCmd := GetUpdateRowCommand(ARow, AUpdRowOptions, arInsert,
                  [], -1, lCacheUpdateCommand, eCmdFlags);
                if gfFetchGenerator in eCmdFlags then begin
                  ProcessUpdate(ARow, AAction, arFetchGenerators,
                    AUpdRowOptions + [uoDeferredGenGet], [], -1);
                  if not (AAction in [eaApplied, eaDefault]) then
                    oCmd := nil;
                end;
              end;
            arDelete:
              begin
                if not oUpdOpts.EnableDelete then
                  FDException(Self, [S_FD_LDApt], er_FD_DAptCantDelete, []);
                oCmd := GetUpdateRowCommand(ARow, AUpdRowOptions, arDelete,
                  [], -1, lCacheUpdateCommand, eCmdFlags);
              end;
            arUpdate:
              begin
                if not oUpdOpts.EnableUpdate then
                  FDException(Self, [S_FD_LDApt], er_FD_DAptCantEdit, []);
                oCmd := GetUpdateRowCommand(ARow, AUpdRowOptions, arUpdate,
                  [], -1, lCacheUpdateCommand, eCmdFlags);
              end;
            arUpdateHBlobs:
              begin
                if not oUpdOpts.EnableInsert then
                  FDException(Self, [S_FD_LDApt], er_FD_DAptCantInsert, []);
                oCmd := GetUpdateRowCommand(ARow, AUpdRowOptions, arUpdateHBlobs,
                  [], -1, lCacheUpdateCommand, eCmdFlags);
              end;
            arFetchRow:
              begin
                if ARow.RowState in [rsInserted, rsDeleted, rsModified, rsUnchanged] then
                  oCmd := GetUpdateRowCommand(ARow, AUpdRowOptions, arFetchRow,
                    AFillRowOptions, AColumn, lCacheUpdateCommand, eCmdFlags);
              end;
            arFetchGenerators:
              begin
                if not oMeta.GeneratorSupported then
                  oCmd := nil
                else
                  oCmd := GetUpdateRowCommand(ARow, AUpdRowOptions, arFetchGenerators,
                    [], -1, lCacheUpdateCommand, eCmdFlags);
              end;
            end;
          if (oCmd = nil) and (AAction = eaDefault) then
            if ARequest in [arDelete, arInsert] then
              AAction := eaFail
            else
              AAction := eaApplied;

          // process command if required
          if oCmd <> nil then begin
            // When transaction is active, DBMS has atomic transactions (PostgreSQL) and
            // a command fails, then full transaction is marked as "invalid" and no
            // more actions are possible - only Rollback. With pessimistic locking, if
            // Post has failed, then user cannot change a data and do another Post. To
            // unify behaviour with other DBMS's, FireDAC surrounds editing commands into
            // savepoints.
            lSavepoint := oTx.Active and oMeta.TxAtomic and
               (oMeta.TxNested or oMeta.TxSavepoints);
            if lSavepoint then
              oTx.StartTransaction;
            try
              ProcessRequest(oCmd, ARow, ARequest, AUpdRowOptions, AFillRowOptions,
                (ARequest in [arUpdate, arDelete]) and (oUpdOpts.LockMode <> lmNone));
              if lSavepoint then
                oTx.Commit;
            except
              if lSavepoint or (iLockID <> $FFFFFFFF) then
                oTx.Rollback;
              raise;
            end;
          end;
        end;

        // post process
        if ARequest = arLock then begin
          if ((AAction = eaApplied) and (oCmd = nil) or
              (AAction = eaDefault) and (oCmd <> nil)) and
             (oUpdOpts.LockMode <> lmNone) and (ARow.DBLockID = 0) then
            ARow.DBLock(iLockID);
          AAction := eaApplied;
        end
        else if ARequest = arUnLock then begin
          lEndTX := False;
          if (AAction = eaApplied) and (oCmd = nil) or
             (AAction = eaDefault) and (oCmd <> nil) then begin
            if (oUpdOpts.LockMode <> lmNone) and (ARow.DBLockID <> 0) then begin
              lEndTX := (oTx.SerialID = ARow.DBLockID);
              ARow.DBUnlock;
            end;
            if uoImmediateUpd in AUpdRowOptions then
              if uoCancelUnlock in AUpdRowOptions then
                ARow.RejectChanges
              else
                ARow.AcceptChanges;
          end;
          if (oUpdOpts.LockMode = lmPessimistic) and oTx.Active and lEndTX then
            if uoCancelUnlock in AUpdRowOptions then
              oTx.Rollback
            else
              oTx.Commit;
          AAction := eaApplied;
        end
        else if (ARequest in [arInsert, arUpdate]) then begin
          if oCmd <> nil then begin
            lCustomFetchRow := not (arFetchRow in FGeneratedCommands) and (GetFetchRowCommand <> nil);
            if not lCustomFetchRow and not oMeta.InlineRefresh and (oUpdOpts.RefreshMode <> rmManual) or
               lCustomFetchRow and (oUpdOpts.RefreshMode = rmAll) then begin
              eFillOpts := FDGetFillRowOptions(GetOptions.FetchOptions);
              if ARequest = arInsert then
                Include(eFillOpts, foAfterIns)
              else if ARequest = arUpdate then
                Include(eFillOpts, foAfterUpd);
              if gfIdentityInsert in eCmdFlags then
                Include(eFillOpts, foNoIdentity);
              Fetch(ARow, AAction, -1, eFillOpts);
            end;
            if (ARequest = arInsert) and (gfHasHBlob in eCmdFlags) and
               (oMeta.InsertHBlobMode = hmUpdateAfterInsert) then
              ProcessUpdate(ARow, AAction, arUpdateHBlobs,
                AUpdRowOptions - [uoNoSrvRecord], [], -1)
            else
              AAction := eaApplied;
            if (ARequest = arInsert) and
               ((AAction = eaApplied) or (AAction = eaDefault)) then
              if uoImmediateUpd in AUpdRowOptions then
                ARow.AcceptChanges;
          end;
        end
        else
          AAction := eaApplied;

      except
        // handle exception
        on E: EFDException do begin
          if Assigned(GetErrorHandler()) then begin
            oExc := EFDDAptRowUpdateException.Create(ARequest, ARow, AAction, E);
            try
              GetErrorHandler().HandleException(nil, oExc);
              if oExc <> nil then
                AAction := EFDDAptRowUpdateException(oExc).Action;
            finally
              FDFree(oExc);
            end;
          end
          else
            AAction := eaDefault;

          // if refreshing record is not found, then remove it
          if (ARequest = arFetchRow) and (AAction = eaDefault) and
             ([foClear, foData] * AFillRowOptions = [foClear, foData]) and
             (E.FDCode = er_FD_DAptRecordIsDeleted) and oUpdOpts.RefreshDelete then begin
            FDFreeAndNil(ARow);
            AAction := eaExitFailure;
          end;

          if AAction = eaDefault then
            AAction := eaFail;
          if AAction = eaFail then
            raise;
        end;
      end;

    until AAction <> eaRetry;

    if AAction = eaFail then
      FDException(Self, [S_FD_LDApt], er_FD_DAptApplyUpdateFailed, []);
    if lCacheUpdateCommand then begin
      InternalSetCommand(ARequest, oCmd);
      if oCmd <> nil then
        Include(FGeneratedCommands, ARequest)
      else
        Exclude(FGeneratedCommands, ARequest);
    end;
  finally
    oTX.UnlockAutoStop(
      not ((ARequest = arUnlock) and (uoCancelUnlock in AUpdRowOptions)) and
      (AAction in [eaSkip, eaApplied, eaDefault, eaExitSuccess]) and (ExceptObject = nil),
      not ((ARequest = arLock) and (oUpdOpts.LockMode = lmPessimistic)));
{$IFDEF FireDAC_MONITOR}
    if IsTracing then
      if ARow <> nil then
        Trace(ekAdaptUpdate, esEnd, sCaller, ['ARow.Table.Name', sTabName])
      else
        Trace(ekAdaptUpdate, esEnd, sCaller, []);
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.Update(ARow: TFDDatSRow; var AAction: TFDErrorAction;
  AUpdRowOptions: TFDUpdateRowOptions; AForceRequest: TFDActionRequest);
var
  iKind: TFDUpdateRequest;
begin
  ASSERT(ARow <> nil);
  case AForceRequest of
  arNone:
    Exit;
  arFromRow:
    case ARow.RowState of
    rsInserted: iKind := arInsert;
    rsDeleted:  iKind := arDelete;
    rsModified: iKind := arUpdate;
    else        Exit;
    end;
  else
    iKind := AForceRequest;
  end;
  ProcessUpdate(ARow, AAction, iKind, AUpdRowOptions, [], -1);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.Lock(ARow: TFDDatSRow; var AAction: TFDErrorAction;
  AUpdRowOptions: TFDUpdateRowOptions);
begin
  ASSERT(ARow <> nil);
  ProcessUpdate(ARow, AAction, arLock, AUpdRowOptions, [], -1);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.UnLock(ARow: TFDDatSRow; var AAction: TFDErrorAction;
  AUpdRowOptions: TFDUpdateRowOptions);
begin
  ASSERT(ARow <> nil);
  ProcessUpdate(ARow, AAction, arUnlock, AUpdRowOptions, [], -1);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.FetchGenerators(ARow: TFDDatSRow;
  var AAction: TFDErrorAction; AUpdRowOptions: TFDUpdateRowOptions);
begin
  ASSERT(ARow <> nil);
  ProcessUpdate(ARow, AAction, arFetchGenerators, AUpdRowOptions, [], -1);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.Fetch(ARow: TFDDatSRow; var AAction: TFDErrorAction;
  AColumn: Integer; AFillRowOptions: TFDPhysFillRowOptions);
begin
  ASSERT(ARow <> nil);
  ProcessUpdate(ARow, AAction, arFetchRow, [], AFillRowOptions, AColumn);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.Define: TFDDatSTable;
var
  lCreated: Boolean;
begin
  CheckSelectCommand;
  if GetDatSManager = nil then
    Result := GetSelectCommand.Define(GetDatSTable, GetMetaInfoMergeMode)
  else
    Result := GetSelectCommand.Define(GetDatSManager, GetDatSTable, GetMetaInfoMergeMode);
  lCreated := (Result <> nil) and (GetDatSTable = nil);
  if lCreated then
    AcquireDatSTable(Result);
  try
    if GetSelectCommand.State = csPrepared then
      GetSelectCommand.Open;
  except
    if lCreated then
      ReleaseDatSTable;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.Fetch(AAll: Boolean = False; ABlocked: Boolean = False);
begin
  CheckSelectCommand;
  GetSelectCommand.Fetch(GetDatSTable, AAll, ABlocked);
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.Reconcile: Boolean;
var
  oPrc: TFDDAptUpdatesJournalProcessor;
begin
  CheckSelectCommand;
  oPrc := TFDDAptUpdatesJournalProcessor.CreateForTableAdapter(Self);
  try
    Result := oPrc.Reconcile;
  finally
    FDFree(oPrc);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapter.Update(AMaxErrors: Integer = -1): Integer;
var
  oTX: IFDPhysTransaction;
  oPrc: TFDDAptUpdatesJournalProcessor;
begin
  CheckSelectCommand;
  GetUpdTx(oTX);
  oTX.LockAutoStop;
  oPrc := TFDDAptUpdatesJournalProcessor.CreateForTableAdapter(Self);
  Result := 0;
  try
    Result := oPrc.Process(AMaxErrors);
  finally
    FDFree(oPrc);
    oTX.UnlockAutoStop(
      ((AMaxErrors = -1) or (Result <= AMaxErrors)) and (ExceptObject = nil),
      True);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapter.Reset;
begin
  UpdateCommands(urReset);
  FBuffer.Release;
end;

{-------------------------------------------------------------------------------}
{ TFDDAptTableAdapters                                                          }
{-------------------------------------------------------------------------------}
constructor TFDDAptTableAdapters.Create(ASchemaAdapter: TFDDAptSchemaAdapter);
begin
  inherited Create;
  FSchemaAdapter := ASchemaAdapter;
  FItems := TFDObjList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDDAptTableAdapters.Destroy;
begin
  Clear;
  FDFreeAndNil(FItems);
  FSchemaAdapter := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapters._AddRef: Integer;
begin
  if FSchemaAdapter <> nil then
    Result := FSchemaAdapter._AddRef
  else
    Result := -1;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapters._Release: Integer;
begin
  if FSchemaAdapter <> nil then
    Result := FSchemaAdapter._Release
  else
    Result := -1;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapters.Clear;
var
  i: Integer;
begin
  for i := FItems.Count - 1 downto 0 do
    FDFree(TFDDAptTableAdapter(FItems.Items[i]));
  FItems.Clear;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapters.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapters.Find(const ATable: TFDPhysMappingName): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FItems.Count - 1 do
    if TFDDAptTableAdapter(FItems.Items[i]).MatchRecordSet(ATable) then begin
      Result := i;
      Exit;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapters.GetItems(AIndex: Integer): IFDDAptTableAdapter;
begin
  Result := TFDDAptTableAdapter(FItems.Items[AIndex]) as IFDDAptTableAdapter;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapters.Add(const ASourceRecordSetName: String = '';
  const ADatSTableName: String = ''; const AUpdateTableName: String = ''): IFDDAptTableAdapter;
begin
  Result := TFDDAptTableAdapter.CreateForSchema(Self) as IFDDAptTableAdapter;
  Result.SourceRecordSetName := ASourceRecordSetName;
  Result.DatSTableName := ADatSTableName;
  Result.UpdateTableName := AUpdateTableName;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapters.Add(const AAdapter: IFDDAptTableAdapter);
var
  oAdapt: TFDDAptTableAdapter;
begin
  if AAdapter.TableMappings <> nil then
    AAdapter.TableMappings.Remove(AAdapter);
  oAdapt := AAdapter.GetObj as TFDDAptTableAdapter;
  FItems.Add(oAdapt);
  oAdapt.FMappings := Self;
  oAdapt.AttachDatSTable;
  FSchemaAdapter.FDAddRef(oAdapt.RefCount);
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapters.DatSManagerDetaching;
var
  i: Integer;
  oAdapt: TFDDAptTableAdapter;
begin
  for i := 0 to FItems.Count - 1 do begin
    oAdapt := TFDDAptTableAdapter(FItems.Items[i]);
    oAdapt.DetachDatSTable;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapters.DatSManagerAttached;
var
  i: Integer;
  oAdapt: TFDDAptTableAdapter;
begin
  for i := 0 to FItems.Count - 1 do begin
    oAdapt := TFDDAptTableAdapter(FItems.Items[i]);
    oAdapt.AttachDatSTable;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapters.Remove(const ATable: TFDPhysMappingName);
var
  i: Integer;
begin
  i := Find(ATable);
  if i <> -1 then
    Remove(GetItems(i));
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptTableAdapters.Remove(const AAdapter: IFDDAptTableAdapter);
var
  i: Integer;
  oAdapt: TFDDAptTableAdapter;
begin
  oAdapt := AAdapter.GetObj as TFDDAptTableAdapter;
  i := FItems.Remove(oAdapt);
  if i >= 0 then begin
    oAdapt.DetachDatSTable;
    FSchemaAdapter.FDDecRef(oAdapt.RefCount);
    oAdapt.FMappings := nil;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptTableAdapters.Lookup(const ATable: TFDPhysMappingName): IFDDAptTableAdapter;
var
  i: Integer;
begin
  i := Find(ATable);
  if i <> -1 then
    Result := GetItems(i)
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
{ TFDDAptSchemaAdapter                                                          }
{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.Initialize;
begin
  inherited Initialize;
  FAdapters := TFDDAptTableAdapters.Create(Self);
end;

{-------------------------------------------------------------------------------}
destructor TFDDAptSchemaAdapter.Destroy;
begin
  ReleaseDatSManager;
  FDFreeAndNil(FAdapters);
  FErrorHandler := nil;
  FUpdateHandler := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.GetName: TComponentName;
begin
  Result := ClassName + '($' + IntToHex(Integer(Self), 8) + ')';
  if FDatSManager <> nil then
    Result := FDatSManager.Name + ': ' + Result;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.GetParent: IFDStanObject;
begin
  Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.AfterReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.BeforeReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.SetOwner(const AOwner: TObject;
  const ARole: TComponentName);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.GetErrorHandler: IFDStanErrorHandler;
begin
  Result := FErrorHandler;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.SetErrorHandler(const AValue: IFDStanErrorHandler);
var
  i: Integer;
begin
  if FErrorHandler <> AValue then begin
    FErrorHandler := AValue;
    for i := 0 to FAdapters.GetCount - 1 do
      TFDDAptTableAdapter(FAdapters.FItems.Items[i]).UpdateCommands(urSetErrorHandler);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.GetUpdateHandler: IFDDAptUpdateHandler;
begin
  Result := FUpdateHandler;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.SetUpdateHandler(const AValue: IFDDAptUpdateHandler);
begin
  FUpdateHandler := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.GetTransaction: IFDPhysTransaction;
begin
  Result := FTransaction;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.SetTransaction(const AValue: IFDPhysTransaction);
var
  i: Integer;
begin
  if FTransaction <> AValue then begin
    FTransaction := AValue;
    for i := 0 to FAdapters.GetCount - 1 do
      TFDDAptTableAdapter(FAdapters.FItems.Items[i]).UpdateCommands(urSetTransaction);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.GetUpdateTransaction: IFDPhysTransaction;
begin
  Result := FUpdateTransaction;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.SetUpdateTransaction(const AValue: IFDPhysTransaction);
var
  i: Integer;
begin
  if FUpdateTransaction <> AValue then begin
    FUpdateTransaction := AValue;
    for i := 0 to FAdapters.GetCount - 1 do
      TFDDAptTableAdapter(FAdapters.FItems.Items[i]).UpdateCommands(urSetUpdateTransaction);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.GetParentOptions(var AOpts: IFDStanOptions);
begin
  AOpts := FDPhysManager.Options;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.GetOptions: IFDStanOptions;
begin
  if FOptions = nil then
    FOptions := TFDOptionsContainer.Create(nil, TFDFetchOptions,
      TFDBottomUpdateOptions, TFDBottomResourceOptions, GetParentOptions);
  Result := FOptions;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.MapRecordSet(const ATable: TFDPhysMappingName;
  var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
  var ADatSTable: TFDDatSTable): TFDPhysMappingResult;
var
  oTabAdapt: IFDDAptTableAdapter;
begin
  oTabAdapt := GetTableAdapters.Lookup(ATable);
  if oTabAdapt = nil then
    Result := mrNotMapped
  else begin
    Result := mrMapped;
    FDGetRecordSetInfo(oTabAdapt, ASourceID, ASourceName, ADatSName,
      AUpdateName, ADatSTable);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.MapRecordSetColumn(const ATable, AColumn: TFDPhysMappingName;
  var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
  var ADatSColumn: TFDDatSColumn): TFDPhysMappingResult;
var
  oTabAdapt: IFDDAptTableAdapter;
  oColMap: TFDDAptColumnMapping;
begin
  Result := mrNotMapped;
  oTabAdapt := GetTableAdapters.Lookup(ATable);
  if oTabAdapt <> nil then
    if (oTabAdapt.ColumnMappings = nil) or (oTabAdapt.ColumnMappings.Count = 0) then
      Result := mrDefault
    else begin
      oColMap := oTabAdapt.ColumnMappings.Lookup(AColumn);
      if oColMap <> nil then begin
        Result := mrMapped;
        FDGetRecordSetColumnInfo(oColMap, ASourceID, ASourceName, ADatSName,
          AUpdateName, ADatSColumn);
      end;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.ReleaseDatSManager;
begin
  if FDatSManager <> nil then begin
    FAdapters.DatSManagerDetaching;
    FDatSManager.RemRef;
    FDatSManager := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.AttachDatSManager(AManager: TFDDatSManager);
begin
  if FDatSManager <> AManager then begin
    ReleaseDatSManager;
    FDatSManager := AManager;
    if AManager <> nil then begin
      AManager.AddRef;
      FAdapters.DatSManagerAttached;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.GetDatSManager: TFDDatSManager;
var
  oMgr: TFDDatSManager;
begin
  if FDatSManager = nil then begin
    oMgr := TFDDatSManager.Create;
    oMgr.CountRef(0);
    oMgr.UpdatesRegistry := True;
    AttachDatSManager(oMgr);
  end;
  Result := FDatSManager;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptSchemaAdapter.SetDatSManager(AValue: TFDDatSManager);
begin
  if FDatSManager <> AValue then
    AttachDatSManager(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.GetTableAdapters: IFDDAptTableAdapters;
begin
  Result := FAdapters as IFDDAptTableAdapters;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.Reconcile: Boolean;
var
  oPrc: TFDDAptUpdatesJournalProcessor;
begin
  oPrc := TFDDAptUpdatesJournalProcessor.CreateForSchemaAdapter(Self);
  try
    Result := oPrc.Reconcile;
  finally
    FDFree(oPrc);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptSchemaAdapter.Update(AMaxErrors: Integer = -1): Integer;
var
  oPrc: TFDDAptUpdatesJournalProcessor;
begin
  oPrc := TFDDAptUpdatesJournalProcessor.CreateForSchemaAdapter(Self);
  try
    Result := oPrc.Process(AMaxErrors);
  finally
    FDFree(oPrc);
  end;
end;

{-------------------------------------------------------------------------------}
var
  oFact1,
  oFact2: TFDFactory;

initialization
  oFact1 := TFDMultyInstanceFactory.Create(TFDDAptTableAdapter, IFDDAptTableAdapter);
  oFact2 := TFDMultyInstanceFactory.Create(TFDDAptSchemaAdapter, IFDDAptSchemaAdapter);

finalization
  FDReleaseFactory(oFact1);
  FDReleaseFactory(oFact2);

end.
