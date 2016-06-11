{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{             FireDAC DBX Migration Helpers             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$WARN SYMBOL_DEPRECATED OFF}

unit FireDAC.DBX.Migrate;

interface

uses
  System.Classes, Data.DB,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Comp.Client;

type
          
  TFDDBXProcParamList = TDataSet;

  /// <summary>Emulates DBX TTransactionDesc.</summary>
  TFDDBXTransactionDesc = record
    TransactionID: LongWord;
    GlobalID: LongWord;
    IsolationLevel: TFDTxIsolation;
  end;

  /// <summary>Emulates DBX TDBXTransaction.</summary>
  TFDDBXTransaction = class(TObject)
  private
    [Weak] FConnection: TFDCustomConnection;
    FSerialID: LongWord;
  public
    property Connection: TFDCustomConnection read FConnection;
  end;

  /// <summary>TFDDBXConnectionAdminHelper is a helper class that emulates DBX
  /// IConnectionAdmin.</summary>
  TFDDBXConnectionAdminHelper = class helper for TFDCustomManager
    /// <summary> The GetDriverParams method emulates DBX IConnectionAdmin.GetDriverParams.
    ///  Use IFDPhysDriverMetadata.GetConnParams instead. </summary>
    function GetDriverParams(const DriverName: string; Params: TStrings): Integer;
      deprecated 'Use IFDPhysDriverMetadata.GetConnParams instead';
    /// <summary> The GetDriverLibNames method emulates DBX IConnectionAdmin.GetDriverLibNames.
    ///  Use TFDPhysXxxxDriverLink instead. </summary>
    procedure GetDriverLibNames(const DriverName: string;
      var LibraryName, VendorLibrary: string);
      deprecated 'Use TFDPhysXxxxDriverLink instead';
  end;

  /// <summary>The TFDDBXConnectionHelper is a helper class that emulates DBX
  /// TSQLConnection.</summary>
  TFDDBXConnectionHelper = class helper for TFDCustomConnection
    /// <summary> The GetFieldNames method emulates DBX TSQLConnection.GetFieldNames.
    ///  Use TFDConnection.GetFieldNames method instead. </summary>
    procedure GetFieldNames(const TableName: string; List: TStrings); overload;
      deprecated 'Use TFDConnection.GetFieldNames instead';
    /// <summary> The GetFieldNames method emulates DBX TSQLConnection.GetFieldNames.
    ///  Use TFDConnection.GetFieldNames method instead. </summary>
    procedure GetFieldNames(const TableName: string; SchemaName: string; List: TStrings); overload;
      deprecated 'Use TFDConnection.GetFieldNames instead';
    /// <summary> The GetIndexNames method emulates DBX TSQLConnection.GetIndexNames.
    ///  Use TFDConnection.GetIndexNames method instead. </summary>
    procedure GetIndexNames(const TableName: string; List: TStrings); overload;
      deprecated 'Use TFDConnection.GetIndexNames instead';
    /// <summary> The GetIndexNames method emulates DBX TSQLConnection.GetIndexNames.
    ///  Use TFDConnection.GetIndexNames method instead. </summary>
    procedure GetIndexNames(const TableName, SchemaName: string; List: TStrings); overload;
      deprecated 'Use TFDConnection.GetIndexNames instead';
    /// <summary> The GetProcedureNames method emulates DBX TSQLConnection.GetProcedureNames.
    ///  Use TFDConnection.GetStoredProcNames method instead. </summary>
    procedure GetProcedureNames(List: TStrings); overload;
      deprecated 'Use TFDConnection.GetStoredProcNames instead';
    /// <summary> The GetProcedureNames method emulates DBX TSQLConnection.GetProcedureNames.
    ///  Use TFDConnection.GetStoredProcNames method instead. </summary>
    procedure GetProcedureNames(const PackageName: string; List: TStrings); overload;
      deprecated 'Use TFDConnection.GetStoredProcNames instead';
    /// <summary> The GetProcedureNames method emulates DBX TSQLConnection.GetProcedureNames.
    ///  Use TFDConnection.GetStoredProcNames method instead. </summary>
    procedure GetProcedureNames(const PackageName, SchemaName: string; List: TStrings); overload;
      deprecated 'Use TFDConnection.GetStoredProcNames instead';
    /// <summary> The GetPackageNames method emulates DBX TSQLConnection.GetPackageNames.
    ///  Use TFDConnection.GetPackageNames method instead. </summary>
    procedure GetPackageNames(List: TStrings); overload;
      deprecated 'Use TFDConnection.GetPackageNames instead';
    /// <summary> The GetSchemaNames method emulates DBX TSQLConnection.GetSchemaNames.
    ///  Use TFDConnection.GetSchemaNames method instead. </summary>
    procedure GetSchemaNames(List: TStrings); overload;
      deprecated 'Use TFDConnection.GetSchemaNames instead';
    /// <summary> The GetProcedureParams method emulates DBX TSQLConnection.GetProcedureParams.
    ///  Use TFDMetaInfoQuery with MetaInfoKind=mkProcArgs instead. </summary>
    procedure GetProcedureParams(ProcedureName : string; List: TFDDBXProcParamList); overload;
      deprecated 'Use TFDMetaInfoQuery with MetaInfoKind=mkProcArgs instead';
    /// <summary> The GetProcedureParams method emulates DBX TSQLConnection.GetProcedureParams.
    ///  Use TFDMetaInfoQuery with MetaInfoKind=mkProcArgs instead. </summary>
    procedure GetProcedureParams(ProcedureName, PackageName: string; List: TFDDBXProcParamList); overload;
      deprecated 'Use TFDMetaInfoQuery with MetaInfoKind=mkProcArgs instead';
    /// <summary> The GetProcedureParams method emulates DBX TSQLConnection.GetProcedureParams.
    ///  Use TFDMetaInfoQuery with MetaInfoKind=mkProcArgs instead. </summary>
    procedure GetProcedureParams(ProcedureName, PackageName, SchemaName: string; List: TFDDBXProcParamList); overload;
      deprecated 'Use TFDMetaInfoQuery with MetaInfoKind=mkProcArgs instead';
    /// <summary> The GetTableNames method emulates DBX TSQLConnection.GetTableNames.
    ///  Use TFDConnection.GetTableNames method instead. </summary>
    procedure GetTableNames(List: TStrings; SystemTables: Boolean = False); overload;
      deprecated 'Use TFDConnection.GetTableNames instead';
    /// <summary> The GetTableNames method emulates DBX TSQLConnection.GetTableNames.
    ///  Use TFDConnection.GetTableNames method instead. </summary>
    procedure GetTableNames(List: TStrings; SchemaName: string; SystemTables: Boolean = False); overload;
      deprecated 'Use TFDConnection.GetTableNames instead';

    /// <summary> The GetLoginUsername method emulates DBX TSQLConnection.GetLoginUsername.
    ///  Use TFDConnection.CurrentSchema or TFDConnection.Params.UserName properties instead. </summary>
    function GetLoginUsername: string;
      deprecated 'Use TFDConnection.CurrentSchema or TFDConnection.Params.UserName instead';

{$IFNDEF NEXTGEN}
    /// <summary> The StartTransaction method emulates DBX TSQLConnection.StartTransaction.
    ///  Use TFDConnection.StartTransaction method instead. </summary>
    procedure StartTransaction(TransDesc: TFDDBXTransactionDesc); overload;
      deprecated 'Use TFDConnection.StartTransaction instead';
{$ENDIF}
    /// <summary> The BeginTransaction method emulates DBX TSQLConnection.BeginTransaction.
    ///  Use TFDConnection.StartTransaction method instead. </summary>
    function  BeginTransaction: TFDDBXTransaction; overload;
      deprecated 'Use TFDConnection.StartTransaction instead';
    /// <summary> The BeginTransaction method emulates DBX TSQLConnection.BeginTransaction.
    ///  Use TFDConnection.StartTransaction method instead. </summary>
    function  BeginTransaction(Isolation: TFDTxIsolation): TFDDBXTransaction; overload;
      deprecated 'Use TFDConnection.StartTransaction instead';
    /// <summary> The CommitFreeAndNil method emulates DBX TSQLConnection.CommitFreeAndNil.
    ///  Use TFDConnection.Commit method instead. </summary>
    procedure CommitFreeAndNil(var Transaction: TFDDBXTransaction);
      deprecated 'Use TFDConnection.Commit instead';
{$IFNDEF NEXTGEN}
    /// <summary> The Commit method emulates DBX TSQLConnection.Commit.
    ///  Use TFDConnection.Commit method instead. </summary>
    procedure Commit(TransDesc: TFDDBXTransactionDesc); overload;
      deprecated 'Use TFDConnection.Commit instead';
{$ENDIF}
    /// <summary> The RollbackFreeAndNil method emulates DBX TSQLConnection.RollbackFreeAndNil.
    ///  Use TFDConnection.Rollback method instead. </summary>
    procedure RollbackFreeAndNil(var Transaction: TFDDBXTransaction);
      deprecated 'Use TFDConnection.Rollback instead';
    /// <summary> The RollbackIncompleteFreeAndNil method emulates DBX TSQLConnection.RollbackIncompleteFreeAndNil.
    ///  Use TFDConnection.Rollback method instead. </summary>
    procedure RollbackIncompleteFreeAndNil(var Transaction: TFDDBXTransaction);
      deprecated 'Use TFDConnection.Rollback instead';
{$IFNDEF NEXTGEN}
    /// <summary> The Rollback method emulates DBX TSQLConnection.Rollback.
    ///  Use TFDConnection.Rollback method instead. </summary>
    procedure Rollback(TransDesc: TFDDBXTransactionDesc); overload;
      deprecated 'Use TFDConnection.Rollback instead';
{$ENDIF}
    /// <summary> The HasTransaction method emulates DBX TSQLConnection.HasTransaction.
    ///  Use TFDConnection.InTransaction method instead. </summary>
    function HasTransaction(Transaction:  TFDDBXTransaction): Boolean;
      deprecated 'Use TFDConnection.InTransaction instead';
  end;

  /// <summary>Emulates DBX TCustomSQLDataSet.</summary>
  TFDDBXDataSetHelper = class helper for TFDRDBMSDataSet
  private
    function GetCommandText: string;
      deprecated 'Use TFDQuery.SQL or TFDStoredProc.StoredProcName instead';
    function GetCommandType: TSQLCommandType;
      deprecated 'Use TFDQuery or TFDStoredProc instead';
    function GetDbxCommandType: string;
      deprecated 'Use TFDQuery or TFDStoredProc instead';
    function GetNumericMapping: Boolean;
      deprecated 'Use TFDQuery or TFDStoredProc FormatOptions instead';
    procedure SetCommandText(const Value: string);
      deprecated 'Use TFDQuery.SQL or TFDStoredProc.StoredProcName instead';
    procedure SetCommandType(const Value: TSQLCommandType);
      deprecated 'Use TFDQuery or TFDStoredProc instead';
    procedure SetDbxCommandType(const Value: string);
      deprecated 'Use TFDQuery or TFDStoredProc instead';
    procedure SetNumericMapping(const Value: Boolean);
      deprecated 'Use TFDQuery or TFDStoredProc FormatOptions instead';
  public
    /// <summary> The GetKeyFieldNames method emulates DBX TCustomSQLDataSet.GetKeyFieldNames.
    ///  Use TFDDataSet.IndexDefs or Indexes properties instead. </summary>
    function GetKeyFieldNames(List: TStrings): Integer;
      deprecated 'Use TFDDataSet.IndexDefs or Indexes instead';
    /// <summary> The GetQuoteChar method emulates DBX TCustomSQLDataSet.GetQuoteChar.
    ///  Use TFDConnection.ConnectionMetaDataIntf.NameQuoteChar property instead. </summary>
    function GetQuoteChar: string;
      deprecated 'Use TFDConnection.ConnectionMetaDataIntf.NameQuoteChar instead';
    /// <summary> The CommandType property emulates DBX TCustomSQLDataSet.CommandType.
    ///  Use TFDQuery or TFDStoredProc instead. </summary>
    property CommandType: TSQLCommandType read GetCommandType write SetCommandType;
    /// <summary> The DbxCommandType property emulates DBX TCustomSQLDataSet.DbxCommandType.
    ///  Use TFDQuery or TFDStoredProc instead. </summary>
    property DbxCommandType: string read GetDbxCommandType write SetDbxCommandType;
    /// <summary> The CommandText property emulates DBX TCustomSQLDataSet.CommandText.
    ///  Use TFDQuery.SQL or TFDStoredProc.StoredProcName properties instead. </summary>
    property CommandText: string read GetCommandText write SetCommandText;
    /// <summary> The NumericMapping property emulates DBX TCustomSQLDataSet.NumericMapping.
    ///  Use TFDQuery or TFDStoredProc FormatOptions property instead. </summary>
    property NumericMapping: Boolean read GetNumericMapping write SetNumericMapping default False;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Error, FireDAC.Stan.Intf,
  FireDAC.DatS,
  FireDAC.Phys.Intf;

{-------------------------------------------------------------------------------}
{ TFDDBXConnectionAdminHelper                                                   }
{-------------------------------------------------------------------------------}
function TFDDBXConnectionAdminHelper.GetDriverParams(const DriverName: string;
  Params: TStrings): Integer;
var
  oManMeta: IFDPhysManagerMetadata;
  oDrvMeta: IFDPhysDriverMetadata;
  oTab: TFDDatSTable;
  i: Integer;
begin
  FDPhysManager.CreateMetadata(oManMeta);
  oManMeta.CreateDriverMetadata(DriverName, oDrvMeta);
  oTab := oDrvMeta.GetConnParams(Params);
  try
    for i := 0 to oTab.Rows.Count - 1 do
      Params.Add(oTab.Rows[i].GetData('Name') + '=' + oTab.Rows[i].GetData('DefVal'));
  finally
    FDFree(oTab);
  end;
  Result := Params.Count;
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionAdminHelper.GetDriverLibNames(
  const DriverName: string; var LibraryName, VendorLibrary: string);
begin
          
end;

{-------------------------------------------------------------------------------}
{ TFDDBXConnectionHelper                                                        }
{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetFieldNames(const TableName: string;
  List: TStrings);
begin
  GetFieldNames(TableName, '', List);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetFieldNames(const TableName: string;
  SchemaName: string; List: TStrings);
begin
  GetFieldNames('', SchemaName, TableName, '', List);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetIndexNames(const TableName: string;
  List: TStrings);
begin
  GetIndexNames(TableName, '', List);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetIndexNames(const TableName,
  SchemaName: string; List: TStrings);
begin
  GetIndexNames('', SchemaName, TableName, '', List);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetProcedureNames(List: TStrings);
begin
  GetProcedureNames('', '', List);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetProcedureNames(const PackageName: string;
  List: TStrings);
begin
  GetProcedureNames(PackageName, '', List);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetProcedureNames(const PackageName,
  SchemaName: string; List: TStrings);
begin
  GetStoredProcNames('', SchemaName, PackageName, '', List, [osMy, osOther], True);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetPackageNames(List: TStrings);
begin
  GetPackageNames('', '', '', List, [osMy, osOther], True);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetSchemaNames(List: TStrings);
begin
  GetSchemaNames('', '', List);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetProcedureParams(ProcedureName: string;
  List: TFDDBXProcParamList);
begin
          
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetProcedureParams(ProcedureName, PackageName,
  SchemaName: string; List: TFDDBXProcParamList);
begin
          
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetProcedureParams(ProcedureName,
  PackageName: string; List: TFDDBXProcParamList);
begin
          
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetTableNames(List: TStrings;
  SystemTables: Boolean);
begin
  GetTableNames(List, '', SystemTables);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.GetTableNames(List: TStrings;
  SchemaName: string; SystemTables: Boolean);
var
  eScopes: TFDPhysObjectScopes;
begin
  eScopes := [osMy, osOther];
  if SystemTables then
    Include(eScopes, osSystem);
  GetTableNames('', SchemaName, '', List, eScopes,
    [tkSynonym, tkTable, tkView, tkTempTable, tkLocalTable], True);
end;

{-------------------------------------------------------------------------------}
function TFDDBXConnectionHelper.GetLoginUsername: string;
begin
  Result := Params.UserName;
end;

{-------------------------------------------------------------------------------}
{$IFNDEF NEXTGEN}
procedure TFDDBXConnectionHelper.StartTransaction(
  TransDesc: TFDDBXTransactionDesc);
begin
  TxOptions.Isolation := TransDesc.IsolationLevel;
  StartTransaction();
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDDBXConnectionHelper.BeginTransaction: TFDDBXTransaction;
begin
  Result := BeginTransaction(xiReadCommitted);
end;

{-------------------------------------------------------------------------------}
function TFDDBXConnectionHelper.BeginTransaction(
  Isolation: TFDTxIsolation): TFDDBXTransaction;
begin
  TxOptions.Isolation := Isolation;
  StartTransaction();
  Result := TFDDBXTransaction.Create;
  Result.FConnection := Self;
  Result.FSerialID := ConnectionIntf.Transaction.SerialID;
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.CommitFreeAndNil(
  var Transaction: TFDDBXTransaction);
begin
  Commit;
  FDFreeAndNil(Transaction);
end;

{-------------------------------------------------------------------------------}
{$IFNDEF NEXTGEN}
procedure TFDDBXConnectionHelper.Commit(TransDesc: TFDDBXTransactionDesc);
begin
  Commit;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.RollbackFreeAndNil(
  var Transaction: TFDDBXTransaction);
begin
  Rollback;
  FDFreeAndNil(Transaction);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXConnectionHelper.RollbackIncompleteFreeAndNil(
  var Transaction: TFDDBXTransaction);
begin
  if HasTransaction(Transaction) then
    RollbackFreeAndNil(Transaction);
  Transaction := nil;
end;

{-------------------------------------------------------------------------------}
{$IFNDEF NEXTGEN}
procedure TFDDBXConnectionHelper.Rollback(TransDesc: TFDDBXTransactionDesc);
begin
  Rollback;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDDBXConnectionHelper.HasTransaction(
  Transaction: TFDDBXTransaction): Boolean;
begin
  Result := InTransaction and
    (ConnectionIntf.Transaction.TopSerialID <= Transaction.FSerialID) and
    (ConnectionIntf.Transaction.SerialID >= Transaction.FSerialID);
end;

{-------------------------------------------------------------------------------}
{ TFDDBXDataSetHelper                                                           }
{-------------------------------------------------------------------------------}
const
  DbxSQL                = 'Dbx.SQL';
  DbxStoredProcedure    = 'Dbx.StoredProcedure';
  DbxTable              = 'Dbx.Table';
  DSServerMethod        = 'DataSnap.ServerMethod';

function TFDDBXDataSetHelper.GetCommandText: string;
begin
  Result := PSGetCommandText;
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXDataSetHelper.SetCommandText(const Value: string);
begin
  if Command <> nil then
    Command.CommandText.Text := Value;
end;

{-------------------------------------------------------------------------------}
function TFDDBXDataSetHelper.GetCommandType: TSQLCommandType;
begin
  Result := PSGetCommandType;
  if Result = ctUnknown then
    Result := ctQuery;
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXDataSetHelper.SetCommandType(const Value: TSQLCommandType);
begin
  case Value of
  ctQuery:         Command.CommandKind := skUnknown;
  ctTable:         FDCapabilityNotSupported(Self, [S_FD_LComp, S_FD_LComp_PClnt]);
  ctStoredProc:    Command.CommandKind := skStoredProc;
  ctServerMethod:  Command.CommandKind := skStoredProc;
  else             Command.CommandKind := skUnknown;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDBXDataSetHelper.GetDbxCommandType: string;
begin
  case GetCommandType of
  ctQuery:         Result := DbxSQL;
  ctTable:         Result := DbxTable;
  ctStoredProc:    Result := DbxStoredProcedure;
  ctServerMethod:  Result := DSServerMethod;
  else             Result := DbxSQL;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXDataSetHelper.SetDbxCommandType(const Value: string);
var
  eType: TPSCommandType;
begin
  if Value = DbxStoredProcedure then
    eType := ctStoredProc
  else if Value = DSServerMethod then
    eType := ctServerMethod
  else if Value = DbxTable then
    eType := ctTable
  else
    eType := ctQuery;
  CommandType := eType;
end;

{-------------------------------------------------------------------------------}
function TFDDBXDataSetHelper.GetNumericMapping: Boolean;
begin
  Result := (FormatOptions.MaxBcdPrecision = 0) and (FormatOptions.MaxBcdScale = 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDDBXDataSetHelper.SetNumericMapping(const Value: Boolean);
begin
  if Value then begin
    FormatOptions.MaxBcdPrecision := 0;
    FormatOptions.MaxBcdScale := 0;
    FormatOptions.OwnMapRules := True;
    FormatOptions.MapRules.Add(dtCurrency, dtFmtBCD);
  end
  else begin
    FormatOptions.MaxBcdPrecision := 18;
    FormatOptions.MaxBcdScale := 4;
    FormatOptions.OwnMapRules := False;
    FormatOptions.MapRules.Clear;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDBXDataSetHelper.GetKeyFieldNames(List: TStrings): Integer;
var
  i: Integer;
begin
  Result := IndexDefs.Count;
  List.BeginUpdate;
  try
    List.Clear;
    for i := 0 to Result - 1 do
      List.Add(IndexDefs[i].Fields);
  finally
    List.EndUpdate;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDBXDataSetHelper.GetQuoteChar: string;
begin
  Result := PSGetQuoteChar;
end;

end.
