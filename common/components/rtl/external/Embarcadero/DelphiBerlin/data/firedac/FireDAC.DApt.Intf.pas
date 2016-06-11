{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC Data Adapter Layer API             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.DApt.Intf;

interface

uses
  System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Column;

type
  IFDDAptTableAdapter = interface;
  IFDDAptTableAdapters = interface;
  IFDDAptSchemaAdapter = interface;
  EFDDAptRowUpdateException = class;

  {-----------------------------------------------------------------------------}
  TFDDAptReconcileAction = (raSkip, raAbort, raMerge, raCorrect, raCancel, raRefresh);

  IFDDAptUpdateHandler = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2301}']
    procedure ReconcileRow(ARow: TFDDatSRow; var Action: TFDDAptReconcileAction);
    procedure UpdateRow(ARow: TFDDatSRow; ARequest: TFDUpdateRequest;
      AUpdRowOptions: TFDUpdateRowOptions; var AAction: TFDErrorAction);
  end;

  {-----------------------------------------------------------------------------}
  // DatSTable adapter. It maps SELECT command to DatSTable and back
  // to INSERT / UPDATE / DELETE commands. Major capabilities are:
  // - fetch data from SelectCommand into DatSTable
  // - post updates from DatSTable rows to database
  // - reconcile row post errors

  IFDDAptTableAdapter = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2304}']
    // private
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

    // public
    function Define: TFDDatSTable;
    procedure Fetch(AAll: Boolean = False; ABlocked: Boolean = False); overload;
    function Update(AMaxErrors: Integer = -1): Integer; overload;
    function Reconcile: Boolean;
    procedure Reset;

    procedure Fetch(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      AColumn: Integer; ARowOptions: TFDPhysFillRowOptions); overload;
    procedure Update(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      AUpdRowOptions: TFDUpdateRowOptions = [];
      AForceRequest: TFDActionRequest = arFromRow); overload;
    procedure Lock(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      AUpdRowOptions: TFDUpdateRowOptions = []);
    procedure UnLock(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      AUpdRowOptions: TFDUpdateRowOptions = []);
    procedure FetchGenerators(ARow: TFDDatSRow; var AAction: TFDErrorAction;
      AUpdRowOptions: TFDUpdateRowOptions = []);

    property SourceRecordSetID: Integer read GetSourceRecordSetID write SetSourceRecordSetID;
    property SourceRecordSetName: String read GetSourceRecordSetName write SetSourceRecordSetName;
    property UpdateTableName: String read GetUpdateTableName write SetUpdateTableName;
    property DatSTableName: String read GetDatSTableName write SetDatSTableName;
    property DatSTable: TFDDatSTable read GetDatSTable write SetDatSTable;
    property ColumnMappings: TFDDAptColumnMappings read GetColumnMappings;
    property MetaInfoMergeMode: TFDPhysMetaInfoMergeMode read GetMetaInfoMergeMode
      write SetMetaInfoMergeMode;
    property TableMappings: IFDDAptTableAdapters read GetTableMappings;
    property DatSManager: TFDDatSManager read GetDatSManager write SetDatSManager;

    property SelectCommand: IFDPhysCommand read GetSelectCommand write SetSelectCommand;
    property InsertCommand: IFDPhysCommand read GetInsertCommand write SetInsertCommand;
    property UpdateCommand: IFDPhysCommand read GetUpdateCommand write SetUpdateCommand;
    property DeleteCommand: IFDPhysCommand read GetDeleteCommand write SetDeleteCommand;
    property LockCommand: IFDPhysCommand read GetLockCommand write SetLockCommand;
    property UnLockCommand: IFDPhysCommand read GetUnLockCommand write SetUnLockCommand;
    property FetchRowCommand: IFDPhysCommand read GetFetchRowCommand write SetFetchRowCommand;

    property Options: IFDStanOptions read GetOptions;
    property Transaction: IFDPhysTransaction read GetTransaction write SetTransaction;
    property UpdateTransaction: IFDPhysTransaction read GetUpdateTransaction write SetUpdateTransaction;
    property ErrorHandler: IFDStanErrorHandler read GetErrorHandler write SetErrorHandler;
    property UpdateHandler: IFDDAptUpdateHandler read GetUpdateHandler write SetUpdateHandler;
  end;

  IFDDAptTableAdapters = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2305}']
    // private
    function GetItems(AIndex: Integer): IFDDAptTableAdapter;
    function GetCount: Integer;
    // public
    function Lookup(const ATable: TFDPhysMappingName): IFDDAptTableAdapter;
    function Add(const ASourceRecordSetName: String = ''; const ADatSTableName: String = '';
      const AUpdateTableName: String = ''): IFDDAptTableAdapter; overload;
    procedure Add(const AAdapter: IFDDAptTableAdapter); overload;
    procedure Remove(const ATable: TFDPhysMappingName); overload;
    procedure Remove(const AAdapter: IFDDAptTableAdapter); overload;
    property Items[AIndex: Integer]: IFDDAptTableAdapter read GetItems;
    property Count: Integer read GetCount;
  end;

  {-----------------------------------------------------------------------------}
  // DatSManager adapter. It maps multiple result sets to IFDDAptTableAdapter's.
  // Major capabilities are:
  // - manage collection of IFDDAptTableAdapter
  // - manage updates posting from several IFDDAptTableAdapter's to database
  // - manage row post errors reconciling for several IFDDAptTableAdapter's

  IFDDAptSchemaAdapter = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2306}']
    // private
    function GetErrorHandler: IFDStanErrorHandler;
    procedure SetErrorHandler(const AValue: IFDStanErrorHandler);
    function GetDatSManager: TFDDatSManager;
    procedure SetDatSManager(AValue: TFDDatSManager);
    function GetTableAdapters: IFDDAptTableAdapters;
    function GetUpdateHandler: IFDDAptUpdateHandler;
    procedure SetUpdateHandler(const AValue: IFDDAptUpdateHandler);
    function GetTransaction: IFDPhysTransaction;
    procedure SetTransaction(const AValue: IFDPhysTransaction);
    function GetUpdateTransaction: IFDPhysTransaction;
    procedure SetUpdateTransaction(const AValue: IFDPhysTransaction);
    function GetOptions: IFDStanOptions;

    // public
    function Update(AMaxErrors: Integer = -1): Integer;
    function Reconcile: Boolean;

    property DatSManager: TFDDatSManager read GetDatSManager write SetDatSManager;
    property TableAdapters: IFDDAptTableAdapters read GetTableAdapters;

    property Options: IFDStanOptions read GetOptions;
    property Transaction: IFDPhysTransaction read GetTransaction write SetTransaction;
    property UpdateTransaction: IFDPhysTransaction read GetUpdateTransaction write SetUpdateTransaction;
    property ErrorHandler: IFDStanErrorHandler read GetErrorHandler write SetErrorHandler;
    property UpdateHandler: IFDDAptUpdateHandler read GetUpdateHandler write SetUpdateHandler;
  end;

  {-----------------------------------------------------------------------------}
  EFDDAptRowUpdateException = class(EFDException)
  private
    FAction: TFDErrorAction;
    FRequest: TFDUpdateRequest;
    FRow: TFDDatSRow;
    FException: Exception;
  public
    constructor Create(ARequest: TFDUpdateRequest; ARow: TFDDatSRow;
      AAction: TFDErrorAction; AException: Exception); overload;
    property Exception: Exception read FException;
    property Request: TFDUpdateRequest read FRequest;
    property Row: TFDDatSRow read FRow;
    property Action: TFDErrorAction read FAction write FAction;
  end;

implementation

{-------------------------------------------------------------------------------}
{ EFDDAptRowUpdateException                                                     }
{-------------------------------------------------------------------------------}
constructor EFDDAptRowUpdateException.Create(ARequest: TFDUpdateRequest;
  ARow: TFDDatSRow; AAction: TFDErrorAction; AException: Exception);
begin
  inherited Create(0, '');
  FRequest := ARequest;
  FRow := ARow;
  FAction := AAction;
  FException := AException;
end;

end.

