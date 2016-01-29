{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Vcl.Bind.Grid"'}    {Do not Localize}
unit Vcl.Bind.Grid;

interface

uses System.SysUtils, System.Classes, Data.Bind.Components, Data.Bind.Grid, System.Bindings.Outputs,
  Generics.Collections, Vcl.Grids;

implementation

type

  TBaseLinkGridToDataSourceControlManager = class(TInterfacedObject, ILinkGridToDataSourceControlManager)
  private
    FCustomGrid: TDrawGrid;
    FDefaultColumnWidth: Integer;
    function AddColumn(
      const ADescription: TCreateColumnDescription): Integer; overload;
    function DescribeColumn(
      AIndex: Integer; const ADescription: TCreateColumnDescription): TLinkGridColumnDescription; overload;
    procedure UpdateColumn(AIndex: Integer;
      const ACreateDescription: TCreateColumnDescription); overload;
  protected
    function CreateColumn(
      const ADescription: TCreateColumnDescription; AGrid: TDrawGrid): Integer; virtual;
    function CreateColumnDescription(
      AIndex: Integer; ADescription: TCreateColumnDescription): TLinkGridColumnDescription; virtual; abstract;
    procedure ApplyDescription(const ADescription: TCreateColumnDescription;
      AColumn: Integer); virtual;
    function GetDefaultColumnWidth: Integer;
    procedure SetDefaultColumnWidth(AWidth: Integer);
    procedure BeginUpdate;
    procedure EndUpdate;
    function CanAddColumn(AColumn: TBaseLinkGridToDataSourceColumn): Boolean; overload;
    function CanAddColumn(ADataSource: TBaseLinkingBindSource; const AMemberName: string): Boolean; overload;
    procedure ClearColumns; virtual;
    function DescribeColumn(AIndex: Integer; AColumn: TBaseLinkGridToDataSourceColumn): TLinkGridColumnDescription; overload;
    function DescribeColumn(AIndex: Integer; ADataSource: TBaseLinkingBindSource; const AMemberName: string): TLinkGridColumnDescription; overload;
    function AddColumn(AColumn: TBaseLinkGridToDataSourceColumn): Integer; overload;
    function AddColumn(ADataSource: TBaseLinkingBindSource; const AMemberName: string): Integer; overload;
    procedure UpdateColumn(AIndex: Integer; AColumn: TBaseLinkGridToDataSourceColumn); overload;
    procedure UpdateColumn(AIndex: Integer; ADataSource: TBaseLinkingBindSource; const AMemberName: string); overload;
    function GetColumnStyles: TArray<string>;
  public
    constructor Create(ACustomGrid: TDrawGrid);
  end;

  TLinkStringGridToDataSourceControlManager = class(TBaseLinkGridToDataSourceControlManager)
  private
    FStringGrid: TStringGrid;
  protected
    function CreateColumnDescription(AIndex: Integer;
      ADescription: TCreateColumnDescription): TLinkGridColumnDescription; override;
    procedure ApplyDescription(const ADescription: TCreateColumnDescription;
      AColumn: Integer); override;
    procedure ClearColumns; override;
  public
    constructor Create(AStringGrid: TStringGrid);

  end;


  TBaseLinkGridToDataSourceColumnFactory = class(TLinkGridToDataSourceColumnFactory)
  public
    function UsesUnits: TArray<string>; override;
    function FrameworkExt: string; override;

  end;

  TLinkStringGridToDataSourceColumnFactory = class(TBaseLinkGridToDataSourceColumnFactory)
  public
    function GridClasses: TArray<TComponentClass>; override;
    function Supports(AIntf: TGuid; AGrid: TComponent): Boolean; override;
    function CreateFactory(AIntf: TGuid;
     AGrid: TComponent): IInterface; override;
  end;

{ TBaseLinkGridToDataSourceControlManager }

function TBaseLinkGridToDataSourceControlManager.AddColumn(
  ADataSource: TBaseLinkingBindSource; const AMemberName: string): Integer;
var
  LDescription: TCreateColumnDescription;
begin
  LDescription := TCreateColumnDescription.Create(ADataSource, AMemberName);
  Result := AddColumn(LDescription);
end;

procedure TBaseLinkGridToDataSourceControlManager.BeginUpdate;
begin
  // FMX only
  // Self.FCustomGrid.BeginUpdate;
end;

function TBaseLinkGridToDataSourceControlManager.DescribeColumn(
  AIndex: Integer; AColumn: TBaseLinkGridToDataSourceColumn): TLinkGridColumnDescription;
begin
  Result := DescribeColumn(AIndex, TCreateColumnDescription.Create(AColumn as TLinkGridToDataSourceColumn));
end;

function TBaseLinkGridToDataSourceControlManager.DescribeColumn(
  AIndex: Integer; ADataSource: TBaseLinkingBindSource; const AMemberName: string): TLinkGridColumnDescription;
begin
  Result := DescribeColumn(AIndex, TCreateColumnDescription.Create(ADataSource, AMemberName));
end;


function TBaseLinkGridToDataSourceControlManager.AddColumn(
  AColumn: TBaseLinkGridToDataSourceColumn): Integer;
begin
  Result := AddColumn(TCreateColumnDescription.Create(AColumn as TLinkGridToDataSourceColumn));
end;


procedure TBaseLinkGridToDataSourceControlManager.UpdateColumn(AIndex: Integer;
  const ACreateDescription: TCreateColumnDescription);
var
  LColumn: Integer;
begin
  LColumn := AIndex;
  if (LColumn >= 0) and (LColumn < FCustomGrid.ColCount)  then
  begin
    if ACreateDescription.Width <> -1 then
      FCustomGrid.ColWidths[LColumn] := ACreateDescription.Width
    else
      FCustomGrid.ColWidths[LColumn] := GetDefaultColumnWidth;
    ApplyDescription(ACreateDescription, LColumn);
  end;
end;

procedure TBaseLinkGridToDataSourceControlManager.UpdateColumn(AIndex: Integer;
  AColumn: TBaseLinkGridToDataSourceColumn);
var
  LCreateDescription: TCreateColumnDescription;
begin
  LCreateDescription := TCreateColumnDescription.Create(AColumn as TLinkGridToDataSourceColumn);
  UpdateColumn(AIndex, LCreateDescription);
end;

procedure TBaseLinkGridToDataSourceControlManager.UpdateColumn(AIndex: Integer;
  ADataSource: TBaseLinkingBindSource; const AMemberName: string);
var
  LCreateDescription: TCreateColumnDescription;
begin
  LCreateDescription := TCreateColumnDescription.Create(ADataSource, AMemberName);
  UpdateColumn(AIndex, LCreateDescription);
end;

function TBaseLinkGridToDataSourceControlManager.AddColumn(
  const ADescription: TCreateColumnDescription): Integer;
var
  LColumn: Integer;
begin
  LColumn := CreateColumn(ADescription, FCustomGrid);
  if ADescription.Width <> -1 then
    FCustomGrid.ColWidths[LColumn] := ADescription.Width
  else
    FCustomGrid.ColWidths[LColumn] := GetDefaultColumnWidth;
  ApplyDescription(ADescription, LColumn);
  Result := LColumn;
end;

procedure TBaseLinkGridToDataSourceControlManager.ApplyDescription(const ADescription: TCreateColumnDescription;
  AColumn: Integer);
begin
 //
end;

function TBaseLinkGridToDataSourceControlManager.CreateColumn(
  const ADescription: TCreateColumnDescription; AGrid: TDrawGrid): Integer;
begin
  if AGrid.Tag > 0 then  // Use tag to keep track of whether grid has columns or not.  Otherwise, no way to tell.
    if AGrid.Tag > AGrid.FixedCols then
      AGrid.ColCount := AGrid.Tag + 1;
  Result := AGrid.Tag;
  AGrid.Tag := AGrid.Tag + 1;
end;

function TBaseLinkGridToDataSourceControlManager.DescribeColumn(
  AIndex: Integer; const ADescription: TCreateColumnDescription): TLinkGridColumnDescription;
begin
  Result := CreateColumnDescription(AIndex, ADescription);
end;


function TBaseLinkGridToDataSourceControlManager.GetColumnStyles: TArray<string>;
begin
  Result := nil;
end;

function TBaseLinkGridToDataSourceControlManager.GetDefaultColumnWidth: Integer;
begin
  Result := FDefaultColumnWidth;
end;

procedure TBaseLinkGridToDataSourceControlManager.SetDefaultColumnWidth(
  AWidth: Integer);
begin
  FDefaultColumnWidth := AWidth;
end;

procedure TBaseLinkGridToDataSourceControlManager.EndUpdate;
begin
  // FMX Only
  //FCustomGrid.EndUpdate;
end;

function TBaseLinkGridToDataSourceControlManager.CanAddColumn(
  AColumn: TBaseLinkGridToDataSourceColumn): Boolean;
begin
  Result := True;
end;

function TBaseLinkGridToDataSourceControlManager.CanAddColumn(
  ADataSource: TBaseLinkingBindSource; const AMemberName: string): Boolean;
begin
  Result := True;
end;

procedure TBaseLinkGridToDataSourceControlManager.ClearColumns;
begin
  FCustomGrid.Tag := 0;
end;

constructor TBaseLinkGridToDataSourceControlManager.Create(ACustomGrid: TDrawGrid);
begin
  FCustomGrid := ACustomGrid;
  FDefaultColumnWidth := 64;
end;

{ TLinkStringGridToDataSourceColumnFactory }


function TLinkStringGridToDataSourceColumnFactory.CreateFactory(AIntf: TGuid;
  AGrid: TComponent): IInterface;
begin
  Result := TLinkStringGridToDataSourceControlManager.Create(TStringGrid(AGrid));
end;

function TLinkStringGridToDataSourceColumnFactory.GridClasses: TArray<TComponentClass>;
begin
  Result := TArray<TComponentClass>.Create(TStringGrid);
end;

function TLinkStringGridToDataSourceColumnFactory.Supports(AIntf: TGuid;
  AGrid: TComponent): Boolean;
begin
  Result := False;
  if AIntf = ILinkGridToDataSourceControlManager then
    if AGrid.InheritsFrom(TStringGrid) then
      Result := True;
end;


{ TBaseLinkGridToDataSourceColumnFactory }

function TBaseLinkGridToDataSourceColumnFactory.FrameworkExt: string;
const
  sDfm = 'dfm';
begin
  Result := sDfm;
end;

function TBaseLinkGridToDataSourceColumnFactory.UsesUnits: TArray<string>;
begin
  Result := TArray<string>.Create('Vcl.Bind.Grid'); // Do not localize
end;

{ TLinkStringGridToDataSourceControlManager }

procedure TLinkStringGridToDataSourceControlManager.ApplyDescription(
  const ADescription: TCreateColumnDescription; AColumn: Integer);
begin
  FStringGrid.Cells[AColumn, 0] := ADescription.Header;
end;

procedure TLinkStringGridToDataSourceControlManager.ClearColumns;
var
  I: Integer;
begin
  inherited;
  if csDestroying in FStringGrid.ComponentState then
    Exit;
  // Clear data so that data doesn't show up later when add columns
  for I := 0 to FStringGrid.RowCount - 1 do
    FStringGrid.Rows[I].Clear;
  FStringGrid.ColCount := FCustomGrid.FixedCols;
  FStringGrid.RowCount := FCustomGrid.FixedRows + 1
end;

constructor TLinkStringGridToDataSourceControlManager.Create(
  AStringGrid: TStringGrid);
begin
  FStringGrid := AStringGrid;
  inherited Create(AStringGrid);
end;

const
//  sUnknown = '''(unknown)''';
  sBlob = '''(blob)''';
  sSelf = 'Self';
  sSelectedText = 'SelectedText(Self)';

function TLinkStringGridToDataSourceControlManager.CreateColumnDescription(
  AIndex: Integer; ADescription: TCreateColumnDescription): TLinkGridColumnDescription;
var
  LColumn: TLinkGridColumnDescription;
  FPairsList: TList<TLinkGridColumnExpressionPair>;
  LPair: TLinkGridColumnExpressionPair;
  LFormatColumnExpressions: TArray<TLinkGridColumnExpressionPair>;
  LFormatCellExpressions: TArray<TLinkGridColumnExpressionPair>;
  LParseCellExpressions: TArray<TLinkGridColumnExpressionPair>;
  LCellExpression: String;
  LMemberName: string;
  LMemberType: TScopeMemberType;
  LMemberGetter: string;
  LMemberSetter: string;
  LSelectedText: string;
begin
  LMemberName := ADescription.MemberName;
  LMemberType := ADescription.MemberType;
  LMemberGetter := ADescription.MemberGetter;
  LMemberSetter := ADescription.MemberSetter;
  FPairsList := TList<TLinkGridColumnExpressionPair>.Create;
  try
    FPairsList.Clear;
    LFormatColumnExpressions := FPairsList.ToArray;

    if LMemberGetter = '' then
      LCellExpression := ''
    else
    begin
      case LMemberType of
// Support unknown types such as TField of type ftAggregate
//        mtUnknown:
//        begin
//          LCellExpression := sUnknown
//        end;
        mtObject,
        mtBitmap:
        begin
          LCellExpression := sBlob
        end;
      else
        LCellExpression := LMemberGetter;
        Assert(LCellExpression <> '');
      end;
    end;
    if ADescription.CustomFormat <> '' then
      LCellExpression := Format(ADescription.CustomFormat, [LCellExpression]);
    FPairsList.Clear;
    if LCellExpression <> '' then
    begin
      LPair := TLinkGridColumnExpressionPair.Create(
        Format('Cells[%d]', [AIndex]), LCellExpression);
      FPairsList.Add(LPair);
      LFormatCellExpressions := FPairsList.ToArray;
    end;


    if ADescription.ReadOnly then
      // No parse expression if read only
      LCellExpression := ''
    else
    begin
      if (LMemberSetter = '')   then
        LCellExpression := ''
      else
      begin
        case LMemberType of
// Support unknown types such as TField of type ftAggregate
//          mtUnknown:
//            LCellExpression := '';
          mtObject,
          mtBitmap:
            LCellExpression := '';
        else
          LCellExpression := LMemberSetter;
          Assert(LCellExpression <> '');
        end;
      end;
    end;
    FPairsList.Clear;
    if LCellExpression <> '' then
    begin
      if ADescription.CustomParse <> '' then
        LSelectedText := Format(ADescription.CustomParse, [sSelectedText])
      else
        LSelectedText := sSelectedText;

      LPair := TLinkGridColumnExpressionPair.Create(
      LSelectedText, LCellExpression);   // do not localize
      FPairsList.Add(LPair);
    end;
    LParseCellExpressions := FPairsList.ToArray;

    LColumn := TLinkGridColumnDescription.Create(nil, '',
     AIndex, '', ADescription.MemberName, ADescription.ColumnStyle,
     LFormatColumnExpressions, LFormatCellExpressions, LParseCellExpressions);


    Result := LColumn;
  finally
    FPairsList.Free;
  end;

end;


initialization
  RegisterLinkGridToDataSourceColumnFactory([TLinkStringGridToDataSourceColumnFactory]);
finalization
  UnregisterLinkGridToDataSourceColumnFactory([TLinkStringGridToDataSourceColumnFactory]);

end.
