{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC Data Adapter Column mapping          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.DApt.Column;

interface

uses
  System.Classes,
  FireDAC.DatS,
  FireDAC.Phys.Intf;

type
  TFDDAptColumnMapping = class(TCollectionItem)
  private
    FDatSColumnName: String;
    FSourceColumnID: Integer;
    FSourceColumnName: String;
    FUpdateColumnName: String;
    procedure SetSourceColumnName(const AValue: String);
    procedure SetSourceColumnID(const AValue: Integer);
    function GetUpdateColumnName: String;
    function GetDatSColumnName: String;
    function GetDatSColumn: TFDDatSColumn;
    function MatchRecordSetColumn(const AColumn: TFDPhysMappingName): Boolean;
  protected
    function GetDisplayName: String; override;
  public
    constructor Create(ACollection: TCollection); override;
    property DatSColumn: TFDDatSColumn read GetDatSColumn;
  published
    property SourceColumnName: String read FSourceColumnName write SetSourceColumnName;
    property SourceColumnID: Integer read FSourceColumnID write SetSourceColumnID default -1;
    property UpdateColumnName: String read GetUpdateColumnName write FUpdateColumnName;
    property DatSColumnName: String read GetDatSColumnName write FDatSColumnName;
  end;

  TFDDAptColumnMappings = class(TCollection)
  private
    FDatSTable: TFDDatSTable;
    FOwner: TPersistent;
    function Find(const AColumn: TFDPhysMappingName): Integer;
    function GetItems(AIndex: Integer): TFDDAptColumnMapping;
    procedure SetItems(AIndex: Integer; const Value: TFDDAptColumnMapping);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent); overload;
    destructor Destroy; override;
    procedure SetOwner(AOwner: TPersistent);
    function Lookup(const AColumn: TFDPhysMappingName): TFDDAptColumnMapping;
    function Add(const ASourceColumnName: String = '';
      const ADatSColumnName: String = '';
      const AUpdateColumnName: String = ''): TFDDAptColumnMapping;
    procedure Remove(const AColumn: TFDPhysMappingName);
    property Items[AIndex: Integer]: TFDDAptColumnMapping read GetItems write SetItems; default;
    property DatSTable: TFDDatSTable read FDatSTable write FDatSTable;
  end;

procedure FDGetRecordSetColumnInfo(AColMap: TFDDAptColumnMapping;
  var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
  var ADatSColumn: TFDDatSColumn);

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Util;

{-------------------------------------------------------------------------------}
{ TFDDAptColumnMapping                                                          }
{-------------------------------------------------------------------------------}
constructor TFDDAptColumnMapping.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FSourceColumnID := -1;
end;

{-------------------------------------------------------------------------------}
function TFDDAptColumnMapping.GetDisplayName: String;
begin
  if SourceColumnName <> '' then
    Result := SourceColumnName
  else if SourceColumnID <> -1 then
    Result := Format('[%d]', [SourceColumnID]);
  if (Result <> '') and (DatSColumnName <> '') then
    Result := Result + ' -> ' + DatSColumnName;
  if Result = '' then
    Result := inherited GetDisplayName;
end;

{-------------------------------------------------------------------------------}
function TFDDAptColumnMapping.GetDatSColumn: TFDDatSColumn;
var
  i: Integer;
  oCols: TFDDatSColumnList;
begin
  if (GetDatSColumnName <> '') and (TFDDAptColumnMappings(Collection).DatSTable <> nil) then begin
    oCols := TFDDAptColumnMappings(Collection).DatSTable.Columns;
    i := oCols.IndexOfName(GetDatSColumnName);
    if i <> -1 then
      Result := oCols.ItemsI[i]
    else
      Result := nil;
  end
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDDAptColumnMapping.GetDatSColumnName: String;
begin
  Result := FDatSColumnName;
  if Result = '' then
    Result := FSourceColumnName;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptColumnMapping.SetSourceColumnID(const AValue: Integer);
begin
  FSourceColumnID := AValue;
  if AValue >= 0 then
    FSourceColumnName := '';
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptColumnMapping.SetSourceColumnName(const AValue: String);
begin
  FSourceColumnName := AValue;
  if AValue <> '' then
    FSourceColumnID := -1;
end;

{-------------------------------------------------------------------------------}
function TFDDAptColumnMapping.GetUpdateColumnName: String;
begin
  Result := FUpdateColumnName;
  if Result = '' then
    Result := FSourceColumnName;
end;

{-------------------------------------------------------------------------------}
function TFDDAptColumnMapping.MatchRecordSetColumn(const AColumn: TFDPhysMappingName): Boolean;
var
  oCol: TFDDatSColumn;
begin
  case AColumn.FKind of
  nkID:
    Result := SourceColumnID = AColumn.FID;
  nkSource:
    Result := {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
      (AColumn.FName, SourceColumnName) = 0;
  nkDatS:
    Result := {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
      (AColumn.FName, DatSColumnName) = 0;
  nkObj:
    begin
      oCol := TFDDatSColumn(AColumn.FObj);
      Result :=
        (DatSColumn <> nil) and (DatSColumn = oCol) or
        (SourceColumnID <> -1) and (SourceColumnID = oCol.SourceID) or
        (SourceColumnName <> '') and (
          {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
          (SourceColumnName, oCol.SourceName) = 0) or
        (DatSColumnName <> '') and (
          {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
          (DatSColumnName, oCol.Name) = 0);
    end;
  else
    Result := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure FDGetRecordSetColumnInfo(AColMap: TFDDAptColumnMapping;
  var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
  var ADatSColumn: TFDDatSColumn);
begin
  if AColMap.SourceColumnID <> -1 then
    ASourceID := AColMap.SourceColumnID;
  if AColMap.SourceColumnName <> '' then
    ASourceName := AColMap.SourceColumnName;
  if AColMap.DatSColumnName <> '' then
    ADatSName := AColMap.DatSColumnName;
  if AColMap.UpdateColumnName <> '' then
    AUpdateName := AColMap.UpdateColumnName;
  if AColMap.DatSColumn <> nil then
    ADatSColumn := AColMap.DatSColumn;
end;

{-------------------------------------------------------------------------------}
{ TFDDAptColumnMappings                                                         }
{-------------------------------------------------------------------------------}
constructor TFDDAptColumnMappings.Create(AOwner: TPersistent);
begin
  inherited Create(TFDDAptColumnMapping);
  FOwner := AOwner;
end;

{-------------------------------------------------------------------------------}
destructor TFDDAptColumnMappings.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptColumnMappings.SetOwner(AOwner: TPersistent);
begin
  FOwner := AOwner;
end;

{-------------------------------------------------------------------------------}
function TFDDAptColumnMappings.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{-------------------------------------------------------------------------------}
function TFDDAptColumnMappings.GetItems(AIndex: Integer): TFDDAptColumnMapping;
begin
  Result := inherited Items[AIndex] as TFDDAptColumnMapping;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptColumnMappings.SetItems(AIndex: Integer; const Value: TFDDAptColumnMapping);
begin
  inherited Items[AIndex] := Value;
end;

{-------------------------------------------------------------------------------}
function TFDDAptColumnMappings.Add(const ASourceColumnName: String = '';
  const ADatSColumnName: String = ''; const AUpdateColumnName: String = ''): TFDDAptColumnMapping;
begin
  Result := inherited Add as TFDDAptColumnMapping;
  Result.SourceColumnName := ASourceColumnName;
  Result.DatSColumnName := ADatSColumnName;
  Result.UpdateColumnName := AUpdateColumnName;
end;

{-------------------------------------------------------------------------------}
function TFDDAptColumnMappings.Find(const AColumn: TFDPhysMappingName): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if Items[i].MatchRecordSetColumn(AColumn) then begin
      Result := i;
      Exit;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDDAptColumnMappings.Lookup(const AColumn: TFDPhysMappingName): TFDDAptColumnMapping;
var
  i: Integer;
begin
  i := Find(AColumn);
  if i <> -1 then
    Result := Items[i]
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDDAptColumnMappings.Remove(const AColumn: TFDPhysMappingName);
var
  i: Integer;
begin
  i := Find(AColumn);
  if i <> -1 then
    Delete(i);
end;

end.
