{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC CDS Local SQL adapter              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.CDS.LocalSQL;

interface

implementation

uses
  System.SysUtils, Datasnap.DBClient,
  FireDAC.Stan.Factory,
  FireDAC.Phys.Intf;

type
  TFDCDSLocalSQLAdapter = class (TFDObject, IFDPhysLocalSQLAdapter)
  private
    FDataSet: TCustomClientDataSet;
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
{ TFDCDSLocalSQLAdapter                                                         }
{-------------------------------------------------------------------------------}
// General

function TFDCDSLocalSQLAdapter.GetFeatures: TFDPhysLocalSQLAdapterFeatures;
begin
  Result := [afCachedUpdates, afSavePoints, afIndexFieldNames, afRanges, afFilters];
end;

{-------------------------------------------------------------------------------}
function TFDCDSLocalSQLAdapter.GetDataSet: TObject;
begin
  Result := FDataSet;
end;

{-------------------------------------------------------------------------------}
procedure TFDCDSLocalSQLAdapter.SetDataSet(ADataSet: TObject);
begin
  FDataSet := ADataSet as TCustomClientDataSet;
end;

{-------------------------------------------------------------------------------}
function TFDCDSLocalSQLAdapter.GetConn: NativeUInt;
begin
  Result := NativeUInt(Pointer(FDataSet.AppServer));
end;

{-------------------------------------------------------------------------------}
function TFDCDSLocalSQLAdapter.IsPKViolation(AExc: Exception): Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
// Cached Updates management

function TFDCDSLocalSQLAdapter.GetCachedUpdates: Boolean;
begin
  Result := FDataSet.LogChanges;
end;

{-------------------------------------------------------------------------------}
procedure TFDCDSLocalSQLAdapter.SetCachedUpdates(const AValue: Boolean);
begin
  FDataSet.LogChanges := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDCDSLocalSQLAdapter.ApplyUpdates(AMaxErrors: Integer): Integer;
begin
  Result := FDataSet.ApplyUpdates(AMaxErrors);
end;

{-------------------------------------------------------------------------------}
procedure TFDCDSLocalSQLAdapter.CommitUpdates;
begin
  FDataSet.MergeChangeLog;
end;

{-------------------------------------------------------------------------------}
procedure TFDCDSLocalSQLAdapter.CancelUpdates;
begin
  FDataSet.CancelUpdates;
end;

{-------------------------------------------------------------------------------}
function TFDCDSLocalSQLAdapter.GetSavePoint: Int64;
begin
  Result := FDataSet.SavePoint;
end;

{-------------------------------------------------------------------------------}
procedure TFDCDSLocalSQLAdapter.SetSavePoint(const AValue: Int64);
begin
  FDataSet.SavePoint := AValue;
end;

{-------------------------------------------------------------------------------}
// Ranges

procedure TFDCDSLocalSQLAdapter.SetRange(const AStartValues, AEndValues: array of const;
  AStartExclusive, AEndExclusive: Boolean);
var
  i: Integer;
begin
  FDataSet.SetRangeStart;
  FDataSet.KeyExclusive := AStartExclusive;
  for i := 0 to High(AStartValues) do
    FDataSet.IndexFields[i].AssignValue(AStartValues[i]);
  FDataSet.SetRangeEnd;
  FDataSet.KeyExclusive := AEndExclusive;
  for i := 0 to High(AEndValues) do
    FDataSet.IndexFields[i].AssignValue(AEndValues[i]);
  FDataSet.ApplyRange;
end;

{-------------------------------------------------------------------------------}
procedure TFDCDSLocalSQLAdapter.CancelRange;
begin
  FDataSet.CancelRange;
end;

{-------------------------------------------------------------------------------}
// Indexes

function TFDCDSLocalSQLAdapter.GetIndexFieldNames: String;
begin
  Result := FDataSet.IndexFieldNames;
end;

{-------------------------------------------------------------------------------}
procedure TFDCDSLocalSQLAdapter.SetIndexFieldNames(const AValue: String);
begin
  FDataSet.IndexFieldNames := StringReplace(AValue, ':A', '', [rfReplaceAll]);
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDMultyInstanceFactory.Create(TFDCDSLocalSQLAdapter,
    IFDPhysLocalSQLAdapter, 'TCustomClientDataSet');

finalization
  FDReleaseFactory(oFact);

end.

