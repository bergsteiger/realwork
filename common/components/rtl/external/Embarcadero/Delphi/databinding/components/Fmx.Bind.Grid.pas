{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Fmx.Bind.Grid"'}    {Do not Localize}
unit Fmx.Bind.Grid;

interface

uses System.SysUtils, System.Classes, Data.Bind.Components, Data.Bind.Grid, FMX.Types, FMX.Edit, System.Bindings.Outputs,
  FMX.Grid, Generics.Collections;

implementation

type

  TBaseLinkGridToDataSourceControlManager = class(TInterfacedObject, ILinkGridToDataSourceControlManager)
  private
    FCustomGrid: TCustomGrid;
    FDefaultColumnWidth: Integer;
    function AddColumn(
      const ADescription: TCreateColumnDescription): Integer; overload;
    function DescribeColumn(
      AIndex: Integer; const ADescription: TCreateColumnDescription): TLinkGridColumnDescription; overload;
    procedure UpdateColumn(AIndex: Integer;
      const ACreateDescription: TCreateColumnDescription); overload;
  protected
    function FormatCellDataExpression(AIndex: Integer): string; virtual; abstract;
    function SupportsMemberType(AMemberType: TScopeMemberType; var ALiteralExpression: string): Boolean; virtual;
    function CreateColumn(
      const ADescription: TCreateColumnDescription; AGrid: TCustomGrid): TColumn; virtual;
    function CreateColumnDescription(
      AIndex: Integer; ADescription: TCreateColumnDescription): TLinkGridColumnDescription; virtual;
    function GetColumnClass(
       ADescription: TCreateColumnDescription): TComponentClass; virtual;
  protected
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetDefaultColumnWidth: Integer;
    procedure SetDefaultColumnWidth(AWidth: Integer);
    function CanAddColumn(AColumn: TBaseLinkGridToDataSourceColumn): Boolean; overload;
    function CanAddColumn(ADataSource: TBaseLinkingBindSource; const AMemberName: string): Boolean; overload;
    procedure ClearColumns;
    function DescribeColumn(AIndex: Integer; AColumn: TBaseLinkGridToDataSourceColumn): TLinkGridColumnDescription; overload;
    function DescribeColumn(AIndex: Integer; ADataSource: TBaseLinkingBindSource; const AMemberName: string): TLinkGridColumnDescription; overload;
    function AddColumn(AColumn: TBaseLinkGridToDataSourceColumn): Integer; overload;
    function AddColumn(ADataSource: TBaseLinkingBindSource; const AMemberName: string): Integer; overload;
    procedure UpdateColumn(AIndex: Integer; AColumn: TBaseLinkGridToDataSourceColumn); overload;
    procedure UpdateColumn(AIndex: Integer; ADataSource: TBaseLinkingBindSource; const AMemberName: string); overload;
  public
    constructor Create(ACustomGrid: TCustomGrid);
  end;

  TLinkStringGridToDataSourceControlManager = class(TBaseLinkGridToDataSourceControlManager)
  private
    FStringGrid: TStringGrid;
  protected
    function FormatCellDataExpression(AIndex: Integer): string; override;
    function SupportsMemberType(AMemberType: TScopeMemberType; var ALiteralExpression: string): Boolean; override;
  public
    constructor Create(AStringGrid: TStringGrid);

  end;

  TLinkGridToDataSourceControlManager = class(TBaseLinkGridToDataSourceControlManager)
  private
    FGrid: TGrid;
  protected
    function GetColumnClass(
       ADescription: TCreateColumnDescription): TComponentClass; override;
    function CreateColumn(
      const ADescription: TCreateColumnDescription; AGrid: TCustomGrid): TColumn; override;
    function FormatCellDataExpression(AIndex: Integer): string; override;
    function SupportsMemberType(AMemberType: TScopeMemberType; var ALiteralExpression: string): Boolean; override;
  public
    constructor Create(AGrid: TGrid);
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

  TLinkTGridToDataSourceColumnFactory = class(TBaseLinkGridToDataSourceColumnFactory)
  public
    function GridClasses: TArray<TComponentClass>; override;
    function Supports(AIntf: TGuid; AGrid: TComponent): Boolean; override;
    function CreateFactory(AIntf: TGuid;
     AGrid: TComponent): IInterface; override;
    function GetColumnStyles: TArray<string>; override;
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
  Self.FCustomGrid.BeginUpdate;
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

procedure TBaseLinkGridToDataSourceControlManager.UpdateColumn(
  AIndex: Integer; const ACreateDescription: TCreateColumnDescription);
var
  LColumn: TColumn;
begin
  LColumn := FCustomGrid.Columns[AIndex];
  if LColumn <> nil then
  begin
    LColumn.Header := ACreateDescription.Header;
    if ACreateDescription.Width <> -1 then
      LColumn.Width := ACreateDescription.Width
    else
      LColumn.Width := GetDefaultColumnWidth;
    LColumn.Visible := ACreateDescription.Visible;
    LColumn.ReadOnly := ACreateDescription.ReadOnly;
  end;
end;

procedure TBaseLinkGridToDataSourceControlManager.UpdateColumn(
  AIndex: Integer; AColumn: TBaseLinkGridToDataSourceColumn);
var
  LCreateDescription: TCreateColumnDescription;
begin
  LCreateDescription := TCreateColumnDescription.Create(AColumn as TLinkGridToDataSourceColumn);
  UpdateColumn(AIndex, LCreateDescription);
end;

procedure TBaseLinkGridToDataSourceControlManager.UpdateColumn(AIndex: Integer; ADataSource: TBaseLinkingBindSource; const AMemberName: string);
var
  LCreateDescription: TCreateColumnDescription;
begin
  LCreateDescription := TCreateColumnDescription.Create(ADataSource, AMemberName);
  UpdateColumn(AIndex, LCreateDescription);
end;

function TBaseLinkGridToDataSourceControlManager.AddColumn(
  const ADescription: TCreateColumnDescription): Integer;
var
  LColumn: TColumn;
begin
  LColumn := CreateColumn(ADescription, FCustomGrid);
  LColumn.Header := ADescription.Header;
  if ADescription.Width <> -1 then
    LColumn.Width := ADescription.Width
  else
    LColumn.Width := GetDefaultColumnWidth;
  LColumn.Visible := ADescription.Visible;
  LColumn.ReadOnly := ADescription.ReadOnly;
  FCustomGrid.AddObject(LColumn);
  Result := LColumn.Index;
end;

function TBaseLinkGridToDataSourceControlManager.CreateColumn(
  const ADescription: TCreateColumnDescription; AGrid: TCustomGrid): TColumn;
begin
  Result := TStringColumn.Create(AGrid);
  Result.Stored := False;
  Result.Locked := True;
end;

const
//  sUnknown = '''(unknown)''';
  sBlob = '''(blob)''';
  sSelf = 'Self';
  sSelectedText = 'SelectedText(Self)';

function TBaseLinkGridToDataSourceControlManager.CreateColumnDescription(
  AIndex: Integer;
  ADescription: TCreateColumnDescription): TLinkGridColumnDescription;
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
  LLiteralExpression: string;
begin
  LMemberName := ADescription.MemberName;
  LMemberType := ADescription.MemberType;
  LMemberGetter := ADescription.MemberGetter;
  LMemberSetter := ADescription.MemberSetter;
  FPairsList := TList<TLinkGridColumnExpressionPair>.Create;
  try
    FPairsList.Clear;
    LFormatColumnExpressions := FPairsList.ToArray;

    if not SupportsMemberType(LMemberType, LLiteralExpression) then
    begin
      Assert(LLiteralExpression <> '');
      LCellExpression := LLiteralExpression;
    end
    else
    begin
      LCellExpression := LMemberGetter;
      Assert(LMemberGetter <> '');
    end;

    if ADescription.CustomFormat <> '' then
      LCellExpression := Format(ADescription.CustomFormat, [LCellExpression]);
    FPairsList.Clear;
    if LCellExpression <> '' then
    begin
      LPair := TLinkGridColumnExpressionPair.Create(
        FormatCellDataExpression(AIndex), LCellExpression);
      FPairsList.Add(LPair);
      LFormatCellExpressions := FPairsList.ToArray;
    end;

    if ADescription.ReadOnly then
      // No parse expression
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

    LColumn := TLinkGridColumnDescription.Create(FCustomGrid.Columns[AIndex], '',
     AIndex, '', ADescription.MemberName, ADescription.ColumnStyle,
     LFormatColumnExpressions, LFormatCellExpressions, LParseCellExpressions);


    Result := LColumn;
  finally
    FPairsList.Free;
  end;

end;

function TBaseLinkGridToDataSourceControlManager.DescribeColumn(
  AIndex: Integer; const ADescription: TCreateColumnDescription): TLinkGridColumnDescription;
begin
  Result := CreateColumnDescription(AIndex, ADescription);
end;

function TBaseLinkGridToDataSourceControlManager.GetColumnClass(ADescription: TCreateColumnDescription): TComponentClass;
begin
  Result := TStringColumn;
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

function TBaseLinkGridToDataSourceControlManager.SupportsMemberType(
  AMemberType: TScopeMemberType; var ALiteralExpression: string): Boolean;
begin
  Result := True;
end;

procedure TBaseLinkGridToDataSourceControlManager.EndUpdate;
begin
  FCustomGrid.EndUpdate;
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
var
  I: Integer;
  {$IFDEF NEXTGEN}
  LColumn: TColumn;
  {$ENDIF}
begin
  FCustomGrid.BeginUpdate;
  try
    for I := FCustomGrid.ColumnCount - 1 downto 0 do
    begin
      {$IFDEF NEXTGEN}
      LColumn := FCustomGrid.Columns[I];
      LColumn.Parent := nil;
      if LColumn.Owner <> nil then
        LColumn.Owner.RemoveComponent(LColumn);
      {$ELSE}
      FCustomGrid.Columns[I].Free;
      {$ENDIF}
    end;
  finally
    FCustomGrid.EndUpdate;
  end;
end;

constructor TBaseLinkGridToDataSourceControlManager.Create(ACustomGrid: TCustomGrid);
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

{ TLinkTGridToDataSourceColumnFactory }


function TLinkTGridToDataSourceColumnFactory.CreateFactory(AIntf: TGuid;
  AGrid: TComponent): IInterface;
begin
  Result := TLinkGridToDataSourceControlManager.Create(TGrid(AGrid));
end;

function ExtractColumnStyle(AClass: TClass): string;
begin
  Result := AClass.ClassName.Substring(1, MaxInt);
end;


function TLinkTGridToDataSourceColumnFactory.GetColumnStyles: TArray<string>;
begin
  Result := TArray<string>.Create(
    ExtractColumnStyle(TStringColumn),
    ExtractColumnStyle(TCheckColumn),
    ExtractColumnStyle(TProgressColumn),
    ExtractColumnStyle(TImageColumn));
end;

function TLinkTGridToDataSourceColumnFactory.GridClasses: TArray<TComponentClass>;
begin
  Result := TArray<TComponentClass>.Create(TGrid);
end;

function TLinkTGridToDataSourceColumnFactory.Supports(AIntf: TGuid;
  AGrid: TComponent): Boolean;
begin
  Result := False;
  if AIntf = ILinkGridToDataSourceControlManager then
    if AGrid.InheritsFrom(TGrid) then
      Result := True;
end;

{ TBaseLinkGridToDataSourceColumnFactory }


function TBaseLinkGridToDataSourceColumnFactory.FrameworkExt: string;
const
  sFmx = 'FMX';
begin
  Result := sFmx;
end;

function TBaseLinkGridToDataSourceColumnFactory.UsesUnits: TArray<string>;
begin
  Result := TArray<string>.Create('Fmx.Bind.Grid'); // Do not localize
end;

{ TLinkStringGridToDataSourceControlManager }

constructor TLinkStringGridToDataSourceControlManager.Create(
  AStringGrid: TStringGrid);
begin
  FStringGrid := AStringGrid;
  inherited Create(AStringGrid);
end;

function TLinkStringGridToDataSourceControlManager.FormatCellDataExpression(
  AIndex: Integer): string;
begin
  Result := Format('Cells[%d]', [AIndex]);
end;

function TLinkStringGridToDataSourceControlManager.SupportsMemberType(
  AMemberType: TScopeMemberType; var ALiteralExpression: string): Boolean;
begin
  Result := True;
  case AMemberType of
// Support unknown types such as TField of type ftAggregate
//    mtUnknown:
//    begin
//      Result := False;
//      ALiteralExpression := sUnknown
//    end;
    mtBitmap,
    mtObject:
    begin
      Result := False;
      ALiteralExpression := sBlob
    end;
  end;
end;

{ TLinkGridToDataSourceControlManager }

constructor TLinkGridToDataSourceControlManager.Create(AGrid: TGrid);
begin
  FGrid := AGrid;
  inherited Create(AGrid);
end;

function TLinkGridToDataSourceControlManager.CreateColumn(
  const ADescription: TCreateColumnDescription; AGrid: TCustomGrid): TColumn;
begin
  Result := nil;
  if ADescription.ColumnStyle <> '' then
    if SameText(ADescription.ColumnStyle, ExtractColumnStyle(TStringColumn)) then
      Result := TStringColumn.Create(FCustomGrid)
    else if SameText(ADescription.ColumnStyle, ExtractColumnStyle(TCheckColumn)) then
      Result := TCheckColumn.Create(FCustomGrid)
    else if SameText(ADescription.ColumnStyle, ExtractColumnStyle(TPopupColumn)) then
      Result := TPopupColumn.Create(FCustomGrid)
    else if SameText(ADescription.ColumnStyle, ExtractColumnStyle(TProgressColumn)) then
      Result := TProgressColumn.Create(FCustomGrid)
    else if SameText(ADescription.ColumnStyle, ExtractColumnStyle(TImageColumn)) then
      Result := TImageColumn.Create(FCustomGrid);


  if Result = nil then
    case ADescription.MemberType of
      mtBitmap,
      mtObject:
        Result := TImageColumn.Create(FCustomGrid);
      mtBoolean:
        Result := TCheckColumn.Create(FCustomGrid)
    else
      Result := inherited CreateColumn(ADescription, AGrid);
    end;
  if Result <> nil then
  begin
    Result.Stored := False;
    Result.Locked := True;
  end;
end;

function TLinkGridToDataSourceControlManager.FormatCellDataExpression(
  AIndex: Integer): string;
begin
  Result := 'Data';
end;

function TLinkGridToDataSourceControlManager.SupportsMemberType(
  AMemberType: TScopeMemberType; var ALiteralExpression: string): Boolean;
begin
  Result := True;
//  case AMemberType of
//    mtUnknown:
//    begin
//      Result := False;
//      ALiteralExpression := sUnknown
//    end;
//  end;
end;


function TLinkGridToDataSourceControlManager.GetColumnClass(
  ADescription: TCreateColumnDescription): TComponentClass;
begin
  case ADescription.MemberType of
    mtBitmap,
    mtObject:
      Result := TImageColumn;
    mtBoolean:
      Result := TCheckColumn;
  else
    Result := inherited;
  end;
end;

initialization
  RegisterLinkGridToDataSourceColumnFactory([TLinkStringGridToDataSourceColumnFactory]);
  RegisterLinkGridToDataSourceColumnFactory([TLinkTGridToDataSourceColumnFactory]);
finalization
  UnregisterLinkGridToDataSourceColumnFactory([TLinkStringGridToDataSourceColumnFactory]);
  UnregisterLinkGridToDataSourceColumnFactory([TLinkTGridToDataSourceColumnFactory]);

end.
