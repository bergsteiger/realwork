{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC ADO Local SQL adapter              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.ADO.LocalSQL;

interface

implementation

uses
  System.SysUtils, Winapi.OleDB, Winapi.ADOInt, Data.Win.ADODB,
  FireDAC.Stan.Factory,
  FireDAC.Phys.Intf;

type
  TFDADOLocalSQLAdapter = class (TFDObject, IFDPhysLocalSQLAdapter)
  private
    FDataSet: TCustomADODataSet;
    FTxSupported: Integer;
  protected
    // private
    function GetFeatures: TFDPhysLocalSQLAdapterFeatures;
    function GetCachedUpdates: Boolean;
    procedure SetCachedUpdates(const AValue: Boolean);
    function GetSavePoint: Int64;
    procedure SetSavePoint(const AValue: Int64);
    function GetIndexFieldNames: String;
    procedure SetIndexFieldNames(const AValue: String);
    function GetDataSet: TObject;
    procedure SetDataSet(ADataSet: TObject);
    function GetConn: NativeUInt;
    // public
    function ApplyUpdates(AMaxErrors: Integer = -1): Integer;
    procedure CommitUpdates;
    procedure CancelUpdates;
    procedure SetRange(const AStartValues, AEndValues: array of const;
      AStartExclusive: Boolean = False; AEndExclusive: Boolean = False);
    procedure CancelRange;
    function IsPKViolation(AExc: Exception): Boolean;
  end;

{-------------------------------------------------------------------------------}
{ TFDADOLocalSQLAdapter                                                         }
{-------------------------------------------------------------------------------}
// General

function TFDADOLocalSQLAdapter.GetFeatures: TFDPhysLocalSQLAdapterFeatures;

  procedure UpdateTxSup;
  begin
    if (FDataSet.Connection <> nil) and FDataSet.Connection.Connected and
       (FDataSet.Connection.Properties['Transaction DDL'].Value > DBPROPVAL_TC_NONE) then
      FTxSupported := 1
    else
      FTxSupported := 0;
  end;

begin
  Result := [afCachedUpdates, afIndexFieldNames, afFilters];
  if FTxSupported = -1 then
    UpdateTxSup;
  if FTxSupported <> 0 then
    Include(Result, afTransactions);
end;

{-------------------------------------------------------------------------------}
function TFDADOLocalSQLAdapter.GetDataSet: TObject;
begin
  Result := FDataSet;
end;

{-------------------------------------------------------------------------------}
procedure TFDADOLocalSQLAdapter.SetDataSet(ADataSet: TObject);
begin
  FDataSet := ADataSet as TCustomADODataSet;
  FTxSupported := -1;
end;

{-------------------------------------------------------------------------------}
function TFDADOLocalSQLAdapter.GetConn: NativeUInt;
begin
  Result := NativeUInt(FDataSet.Connection);
end;

{-------------------------------------------------------------------------------}
function TFDADOLocalSQLAdapter.IsPKViolation(AExc: Exception): Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
// Cached Updates management

function TFDADOLocalSQLAdapter.GetCachedUpdates: Boolean;
begin
  Result := (FDataSet.CursorLocation = clUseClient) and
    (FDataSet.CursorType in [ctKeySet, ctStatic]) and
    (FDataSet.LockType = ltBatchOptimistic);
end;

{-------------------------------------------------------------------------------}
procedure TFDADOLocalSQLAdapter.SetCachedUpdates(const AValue: Boolean);
begin
  if AValue then begin
    FDataSet.CursorLocation := clUseClient;
    FDataSet.CursorType := ctKeySet;
    FDataSet.LockType := ltBatchOptimistic;
  end
  else
    FDataSet.LockType := ltOptimistic;
end;

{-------------------------------------------------------------------------------}
function TFDADOLocalSQLAdapter.ApplyUpdates(AMaxErrors: Integer): Integer;
begin
  try
    Result := 0;
    FDataSet.UpdateBatch(arAll);
  except
    Result := 1;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDADOLocalSQLAdapter.CommitUpdates;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDADOLocalSQLAdapter.CancelUpdates;
begin
  FDataSet.CancelBatch(arAll);
end;

{-------------------------------------------------------------------------------}
function TFDADOLocalSQLAdapter.GetSavePoint: Int64;
begin
  // nothing
  Result := -1;
end;

{-------------------------------------------------------------------------------}
procedure TFDADOLocalSQLAdapter.SetSavePoint(const AValue: Int64);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
// Ranges

procedure TFDADOLocalSQLAdapter.SetRange(const AStartValues, AEndValues: array of const;
  AStartExclusive, AEndExclusive: Boolean);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDADOLocalSQLAdapter.CancelRange;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
// Indexes

type
  __TCustomADODataSet = class(TCustomADODataSet);

function TFDADOLocalSQLAdapter.GetIndexFieldNames: String;
begin
  Result := StringReplace(StringReplace(__TCustomADODataSet(FDataSet).IndexFieldNames,
    ' DESC', ':D', [rfReplaceAll]), ' ASC', ':A', [rfReplaceAll]);
end;

{-------------------------------------------------------------------------------}
procedure TFDADOLocalSQLAdapter.SetIndexFieldNames(const AValue: String);
begin
  __TCustomADODataSet(FDataSet).IndexFieldNames := StringReplace(StringReplace(AValue,
    ':D', ' DESC', [rfReplaceAll]), ':A', ' ASC', [rfReplaceAll]);
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDMultyInstanceFactory.Create(TFDADOLocalSQLAdapter,
    IFDPhysLocalSQLAdapter, 'TCustomADODataSet');

finalization
  FDReleaseFactory(oFact);

end.
