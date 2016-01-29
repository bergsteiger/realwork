{ --------------------------------------------------------- }
{ OPUS eDoc Integration                                     }
{ Copyright (c) 1986-2011 by gs-soft AG                     }
{                                                           }
{ All rights reserved.                                      }
{ --------------------------------------------------------- }

{.$DEFINE eDocExcelExportTracer}

unit opEDocExcelEngine;

interface

uses
  Classes, Graphics,
  gtXLSEng;

type
  TOpEDocExcelEngineGS = class(TgtExcelEngine)
  private
    FLayouts: TObject;
    FColumns: TObject;
    FPreProcessing: boolean;
    FLastPage: integer;
    FPreProcessCounter: integer;
  protected
    procedure ProcessMetafile(AX, AY: Double; AMetafile: TMetafile); override;
    procedure AdjustTextItemList(AList: TList); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure BeginDoc; override;
    procedure EndDoc; override;
  end;

implementation

uses
  SysUtils, Math, Contnrs,
{$IFDEF eDocExcelExportTracer}
  gsTracer,
{$ENDIF}
  gtConsts3, gtUtils3, gtCstSpdEng, gtCstDocEng;

type
  TMarginType = (mtLeft, mtRight);

  TExtTextItem = class(TgtFmTextItem)
  private
    FHeight: double;
    FWidth: double;
  public
    constructor Copy(AItem: TgtTextItem);

    property Height: double read FHeight write FHeight;
    property Width: double read FWidth write FWidth;

    function ToString: string; override;
  end;

  TRow = class(TObject)
  private
    FSorted: boolean;
    FOrigin: Double;
    FFields: TObjectList;
    FMaxHeight: double;
    function GetField(AIndex: integer): TExtTextItem;
    function GetFieldCount: integer;
  public
    constructor Create(AOrigin: Double);
    destructor Destroy; override;

    procedure AddField(AField: TExtTextItem);
    procedure DefineRowNo(ARowNo: integer);
    procedure SortFields;
    procedure FixConflicts;

    function ToString: string; override;

    property Origin: Double read FOrigin;

    property FieldCount: integer read GetFieldCount;
    property Field[AIndex: integer]: TExtTextItem read GetField;
  end;

  TColumn = class(TObject)
  private
    FMargins: array[TMarginType] of Double;
    FFields: TObjectList;
    FColumnNo: integer;
    function GetMargin(AMargin: TMarginType): Double;
    function GetField(AIndex: integer): TExtTextItem;
    function GetFieldCount: integer;
  public
    constructor Create(ALeft, ARight: Double);
    destructor Destroy; override;

    procedure AddField(AField: TExtTextItem);
    procedure IncludeMargins(const ALeft, ARigth: double);
    procedure DefineColumnNo;
    procedure RemoveAllFields;

    function ToString: string; override;

    property Margins[AMargin: TMarginType]: Double read GetMargin;
    property FieldCount: integer read GetFieldCount;
    property Field[AIndex: integer]: TExtTextItem read GetField;
    property ColumnNo: integer read FColumnNo write FColumnNo;
  end;

  TColumnLayout = class(TObject)
  private
    FId: integer;
    FColumns: TObjectList;
    function GetColumn(AIndex: integer): TColumn;
    function GetColumnCount: integer;
    function FindColumn(const ALeft, ARight: Double; ACreate, APartial: boolean): TColumn;
  public
    constructor Create(ARow: TRow; AId: integer);
    destructor Destroy; override;

    function TryMergeLayout(ALayout: TColumnLayout): boolean;
    function TryAddRow(ARow: TRow; AAllowExtendColumns: boolean): boolean;
    procedure ClearFields;
    procedure DefineColumnNo;

    function ToString: string; override;

    property ColumnCount: integer read GetColumnCount;
    property Columns[AIndex: integer]: TColumn read GetColumn;
    property Id: integer read FId;
  end;

  TColumnLink = class(TObject)
  private
    FOrigin: double;
    FColumns: TObjectList;
    FColumnNo: integer;
    function GetColumn(AIndex: integer): TColumn;
    function GetColumnCount: integer;
    procedure SetColumnNo(AValue: integer);
    function GetMaxWidth: double;
  public
    constructor Create(AOrigin: double);
    destructor Destroy; override;

    procedure AddColumn(AColumn: TColumn);

    property Origin: Double read FOrigin;
    property ColumnCount: integer read GetColumnCount;
    property Columns[AIndex: integer]: TColumn read GetColumn; default;

    property ColumnNo: integer read FColumnNo write SetColumnNo;
    property MaxWidth: double read GetMaxWidth;
  end;

  TColumnLinkList = class(TObject)
  private
    FColumnLinks: TObjectList;
    FTolerance: Double;
    function FindColumn(AOrigin: Double; ACreate: boolean; const ATolerance: double): TColumnLink;
    function GetColumnLink(AIndex: integer): TColumnLink;
    function GetColumnCount: integer;
  public
    constructor Create(ATolerance: Extended = 1);
    destructor Destroy; override;

    procedure AddLayout(ALayout: TColumnLayout);

    property ColumnCount: integer read GetColumnCount;
    property ColumnLinks[AIndex: integer]: TColumnLink read GetColumnLink; default;
  end;

  TLayoutList = class(TObject)
  private
    FLayouts: TObjectList;
    FNextId: integer;
    function GetLayout(AIndex: integer): TColumnLayout;
    function GetLayoutCount: integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddRow(ARow: TRow; AAllowNewLayouts: boolean; ARowIndex: integer);
    procedure ClearFields;
    procedure DefineColumnNo;
    procedure MergeLayouts;
    procedure TraceLayouts;

    property LayoutCount: integer read GetLayoutCount;
    property Layout[AIndex: integer]: TColumnLayout read GetLayout; default;
  end;

  TRowList = class(TObject)
  private
    FRows: TObjectList;
    FTolerance: Double;
    function FindRow(AOrigin: Double; const ACreate: boolean = false): TRow;
    function GetRow(AIndex: integer): TRow;
    function GetCount: integer;
  public
    constructor Create(ATolerance: Extended = 1);
    destructor Destroy; override;

    procedure AddField(AField: TExtTextItem);
    procedure ClearFields;
    procedure CheckForEmptyRows(ADefaultHeight: double);

    property Count: integer read GetCount;
    property Rows[AIndex: integer]: TRow read GetRow; default;
  end;

{ ---------------------------------------------------------------------------- }
{ local helpers }
{ ---------------------------------------------------------------------------- }
function TextItemCompare(AItem1, AItem2: Pointer): integer;
begin
  Result := Sign(TgtFmTextItem(AItem1).RowNo - TgtFmTextItem(AItem2).RowNo);
  if Result = 0 then
    Result := Sign(TgtFmTextItem(AItem1).ColumnNo - TgtFmTextItem(AItem2).ColumnNo);
end;

{ ---------------------------------------------------------------------------- }
function OpEDocUnitToPixels(AValue: double; AUnit: TgtUnitType): integer;
var
  dPixels: Extended;
const
  InchPerPoint = 1 / CInchesToPoints;
  InchPerTwip  = InchPerPoint * CTwipsToPoints;
begin
  case AUnit of
  muInches: dPixels := AValue * CPixelsPerInch;
  muMM:     dPixels := AValue * CPixelsPerInch * CMMToInches;
  muPoints: dPixels := AValue * CPixelsPerInch * InchPerPoint;
  muTwips:  dPixels := AValue * CPixelsPerInch * InchPerTwip;
  else
    dPixels := AValue;
  end;

  Result := Trunc(dPixels + 0.5);
end;

{ ---------------------------------------------------------------------------- }
{ TOpEDocExcelEngineGS }
{ ---------------------------------------------------------------------------- }
constructor TOpEDocExcelEngineGS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Preferences.ContinuousMode := true;
  FLastPage := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TOpEDocExcelEngineGS.AdjustTextItemList(AList: TList);
var
  iIndex, iSpaceIndex, iCurrentPage: integer;
  dWidth: double;
  oItem: TgtTextItem;
  oLayouts: TLayoutList;
  oExtItem: TExtTextItem;
  oRows: TRowList;
  oItemList: TList;

  function CalcCurrentPage: integer;
  begin
    if FPreProcessing then
      Result := FPreProcessCounter - 4 //header, footer, watermarks and stamps come before actual pages
    else
      Result := CurrentPage;

    if Result <= 0 then
      Result := -1;
  end;
begin
  if FPreProcessing then
    Inc(FPreProcessCounter);

  iCurrentPage := CalcCurrentPage;
  if FLastPage <> iCurrentPage then
  begin
    FLastPage := iCurrentPage;
{$IFDEF eDocExcelExportTracer}
    if FPreProcessing then
      TracerGS.AddTraceMsg(Format('Pre-Process Page %d', [FLastPage]))
    else
      TracerGS.AddTraceMsg(Format('Process Page %d', [FLastPage]));
{$ENDIF}
  end;

  oItemList := TList.Create;
  try
    for iIndex := AList.Count - 1 downto 0 do
    begin
      oItem := TgtTextItem(AList[iIndex]);
      if oItem is TExtTextItem then
        oItemList.Add(oItem)
      else if not (oItem is TgtSheetTextItem) then
      begin
        oExtItem := TExtTextItem.Copy(oItem);
        if Trim(oExtItem.ToString) <> '' then
        begin
          oExtItem.Alignment := haLeft;
          with TextSize(oExtItem.Lines[0], oExtItem.Font) do
          begin
            oExtItem.Width := cx;
            oExtItem.Height := cy;
          end;
          if oExtItem.FCharSpaceArray <> nil then
          begin
            dWidth := 0;
            for iSpaceIndex := Low(oExtItem.FCharSpaceArray) to High(oExtItem.FCharSpaceArray) do
              dWidth := dWidth + oExtItem.FCharSpaceArray[iSpaceIndex];
            oExtItem.Width := Ceil(dWidth);
          end;

          AList[iIndex] := oExtItem;
          oItemList.Add(oExtItem);
        end else
        begin
          AList.Delete(iIndex);
          FreeAndNil(oExtItem);
        end;
        FreeAndNil(oItem);
      end;
    end;

    if (oItemList.Count = 0) then
      exit;

    oLayouts := TLayoutList(FLayouts);
    oRows := TRowList.Create(1);
    try
      //we inverted the list above. Now we invert it again...
      for iIndex := oItemList.Count - 1 downto 0 do
        oRows.AddField(TExtTextItem(oItemList[iIndex]));

      try
        for iIndex := 0 to oRows.Count - 1 do
          oLayouts.AddRow(oRows[iIndex], FPreProcessing, iIndex);
      except
        on E: Exception do
        begin
          if FLastPage > 0 then
            raise Exception.CreateFmt('Page %d: %s', [FLastPage, E.Message])
          else
            raise;
        end;
      end;

      if not FPreProcessing then
      begin
        oLayouts.DefineColumnNo;

        oRows.CheckForEmptyRows(FYFactor);
        for iIndex := 0 to oRows.Count - 1 do
          oRows[iIndex].DefineRowNo(iIndex);

        AList.Sort(TextItemCompare);
      end;
      FPrevRowNo := oRows.Count - 1;
    finally
      oLayouts.ClearFields;
      FreeAndNil(oRows);
    end;
  finally
    FreeAndNil(oItemList);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TOpEDocExcelEngineGS.BeginDoc;
{$IFDEF eDocExcelExportTracer}
var
  sPath: string;
{$ENDIF}
begin
{$IFDEF eDocExcelExportTracer}
  sPath := ExtractFilePath(ParamStr(0));
  StartTracerGS(sPath + 'ExcelExportLayout.trc');
{$ENDIF}
  inherited BeginDoc;
end;

{ ---------------------------------------------------------------------------- }
procedure TOpEDocExcelEngineGS.EndDoc;
begin
{$IFDEF eDocExcelExportTracer}
  TracerGS.AddTraceMsg('Finalize Document');
{$ENDIF}
  FColumns := TColumnLinkList.Create(TextWidth('W'));
  FLayouts := TLayoutList.Create;
  try
    inherited EndDoc;
  finally
    FreeAndNil(FLayouts);
    FreeAndNil(FColumns);
{$IFDEF eDocExcelExportTracer}
    StopTracerGS;
{$ENDIF}
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TOpEDocExcelEngineGS.ProcessMetafile(AX, AY: Double;
  AMetafile: TMetafile);
var
  oColumns: TColumnLinkList;
  oColumn: TColumnLink;
  oLayouts: TLayoutList;
  dOrigin, dPrevOrigin, dFactor: double;
  iIndex: integer;
begin
  inherited ProcessMetafile(AX, AY, AMetafile);

  if FLayouts <> nil then
  begin
    FPreProcessCounter := 0;
    FLastPage := -1;
    FPreProcessing := true;
    try
      PreProcessPages;

      dFactor := 1 / OpEDocUnitToPixels(1, muMM);

      oColumns := TColumnLinkList(FColumns);
      oLayouts := TLayoutList(FLayouts);

{$IFDEF eDocExcelExportTracer}
      TracerGS.AddTraceMsg('Existing Layouts (Before Merge)');
      oLayouts.TraceLayouts;
{$ENDIF}

      oLayouts.MergeLayouts;

{$IFDEF eDocExcelExportTracer}
      TracerGS.AddTraceMsg('Existing Layouts (AfterMerge)');
      oLayouts.TraceLayouts;
{$ENDIF}

      for iIndex := 0 to oLayouts.LayoutCount - 1 do
        oColumns.AddLayout(oLayouts[iIndex]);

      oColumn := oColumns[0];
      dPrevOrigin := 0;
      oColumn.ColumnNo := 0;

      for iIndex := 1 to oColumns.ColumnCount - 1 do
      begin
        oColumn := oColumns[iIndex];
        oColumn.ColumnNo := iIndex;
        dOrigin := oColumn.Origin;
        SetColumnWidth(iIndex - 1, (dOrigin - dPrevOrigin) * dFactor);
        dPrevOrigin := dOrigin;
      end;
      SetColumnWidth(oColumn.ColumnNo, (oColumn.MaxWidth + 1) * dFactor);
    finally
      FPreProcessing := false;
      FLastPage := -1;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ TColumn }
{ ---------------------------------------------------------------------------- }
constructor TColumn.Create(ALeft, ARight: Double);
begin
  inherited Create;
  FMargins[mtLeft]  := ALeft;
  FMargins[mtRight] := ARight;
  FFields := TObjectList.Create(false);
  FColumnNo := -1;
end;

{ ---------------------------------------------------------------------------- }
destructor TColumn.Destroy;
begin
  FreeAndNil(FFields);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TColumn.GetField(AIndex: integer): TExtTextItem;
begin
  Result := TExtTextItem(FFields[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TColumn.GetFieldCount: integer;
begin
  Result := FFields.Count;
end;

{ ---------------------------------------------------------------------------- }
function TColumn.GetMargin(AMargin: TMarginType): Double;
begin
  Result := FMargins[AMargin];
end;

{ ---------------------------------------------------------------------------- }
procedure TColumn.IncludeMargins(const ALeft, ARigth: double);
begin
  FMargins[mtLeft]  := Min(FMargins[mtLeft] , ALeft);
  FMargins[mtRight] := Max(FMargins[mtRight], ARigth);
end;

{ ---------------------------------------------------------------------------- }
procedure TColumn.RemoveAllFields;
begin
  FFields.Clear;
end;

{ ---------------------------------------------------------------------------- }
function TColumn.ToString: string;
begin
  Result := Format('|%g - %g|', [FMargins[mtLeft], FMargins[mtRight]]);
end;

{ ---------------------------------------------------------------------------- }
procedure TColumn.AddField(AField: TExtTextItem);
begin
  FFields.Add(AField);
  FMargins[mtLeft]  := Min(FMargins[mtLeft] , AField.X);
  FMargins[mtRight] := Max(FMargins[mtRight], AField.X + AField.Width);
end;

{ ---------------------------------------------------------------------------- }
procedure TColumn.DefineColumnNo;
var
  iIndex: integer;
begin
  if FColumnNo = -1 then
    exit;
    
  for iIndex := 0 to FFields.Count - 1 do
    TgtFmTextItem(FFields[iIndex]).ColumnNo := FColumnNo;
end;

{ ---------------------------------------------------------------------------- }
{ TColumnLayout }
{ ---------------------------------------------------------------------------- }
constructor TColumnLayout.Create(ARow: TRow; AId: integer);
var
  iIndex: integer;
  oField: TExtTextItem;
  oColumn: TColumn;
begin
  inherited Create;
  FId := AId;
  
  FColumns := TObjectList.Create(true);

  for iIndex := 0 to ARow.FieldCount - 1 do
  begin
    oField := ARow.Field[iIndex];
    oColumn := FindColumn(oField.X, oField.X + oField.Width, true, false);
    oColumn.AddField(oField);
  end;
end;

{ ---------------------------------------------------------------------------- }
destructor TColumnLayout.Destroy;
begin
  FreeAndNil(FColumns);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TColumnLayout.ToString: string;
var
  iIndex: integer;
begin
  Result := Format('Layout %d:', [FId]);
  for iIndex := 0 to ColumnCount - 1 do
    Result := Result + ' ' + Columns[iIndex].ToString;
end;

{ ---------------------------------------------------------------------------- }
function TColumnLayout.TryAddRow(ARow: TRow; AAllowExtendColumns: boolean): boolean;
var
  oField: TExtTextItem;
  oColumns: array of TColumn;
  oColumn: TColumn;
  iIndex, iCheck: integer;
begin
  Result := false;
  if ARow.FieldCount > ColumnCount then
    exit;

  SetLength(oColumns, ARow.FieldCount);
  for iIndex := 0 to ARow.FieldCount - 1 do
  begin
    oField := ARow.Field[iIndex];
    oColumn := FindColumn(oField.X, oField.X + oField.Width, false, AAllowExtendColumns);
    if oColumn = nil then
      exit;
    for iCheck := 0 to iIndex - 1 do
    begin
      if oColumn = oColumns[iCheck] then
        exit;
    end;
    oColumns[iIndex] := oColumn;
  end;

  Result := true;
  for iIndex := 0 to ARow.FieldCount - 1 do
    oColumns[iIndex].AddField(ARow.Field[iIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TColumnLayout.TryMergeLayout(ALayout: TColumnLayout): boolean;
var
  oColumns: array of TColumn;
  oColumn, oOrigColumn: TColumn;
  iIndex, iFieldIndex, iCheck: integer;
begin
  Result := false;
  if ALayout = self then
    exit;

  SetLength(oColumns, ALayout.ColumnCount);
  for iIndex := 0 to ALayout.ColumnCount - 1 do
  begin
    oOrigColumn := ALayout.Columns[iIndex];
    oColumn := FindColumn(oOrigColumn.Margins[mtLeft], oOrigColumn.Margins[mtRight], false, true);
    if oColumn = nil then
      exit;
    for iCheck := 0 to iIndex - 1 do
    begin
      if oColumn = oColumns[iCheck] then
        exit;
    end;
    oColumns[iIndex] := oColumn;
  end;

  Result := true;
  for iIndex := 0 to ALayout.ColumnCount - 1 do
  begin
    oOrigColumn := ALayout.Columns[iIndex];
    oColumns[iIndex].IncludeMargins(oOrigColumn.Margins[mtLeft], oOrigColumn.Margins[mtRight]);
    for iFieldIndex := 0 to oOrigColumn.FieldCount - 1 do
      oColumns[iIndex].AddField(oOrigColumn.Field[iFieldIndex]);
    oOrigColumn.RemoveAllFields;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TColumnLayout.ClearFields;
var
  iIndex: integer;
begin
  for iIndex := 0 to ColumnCount - 1 do
    Columns[iIndex].RemoveAllFields;
end;

{ ---------------------------------------------------------------------------- }
procedure TColumnLayout.DefineColumnNo;
var
  iIndex: integer;
begin
  for iIndex := 0 to ColumnCount - 1 do
    Columns[iIndex].DefineColumnNo;
end;

{ ---------------------------------------------------------------------------- }
function TColumnLayout.FindColumn(const ALeft, ARight: Double; ACreate, APartial: boolean): TColumn;
var
  iLow, iHigh, iIndex: Integer;
  oTmp: TColumn;
begin
  iLow := 0;
  iHigh := ColumnCount - 1;

  while iLow <= iHigh do
  begin
    iIndex := (iLow + iHigh) div 2;
    Result := Columns[iIndex];
    //no overlap, searched column is to the right
    if (Result.Margins[mtRight] <= ALeft) then
      iLow  := iIndex + 1
    //no overlap, searched column is to the left
    else if Result.Margins[mtLeft] >= ARight then
      iHigh := iIndex - 1
    //overlap exists
    else
    begin
      //searched column extends to the left
      if (ALeft < Result.Margins[mtLeft]) then
      begin
        //column needs to be contained -> no match
        if not APartial then
          break
        //check if next column to the left overlaps too -> no match
        else if (iIndex > iLow) then
        begin
          oTmp := Columns[iIndex - 1];
          if oTmp.Margins[mtRight] > ALeft then
            break;
        end;
      end;

      //searched column extends to the right
      if (ARight > Result.Margins[mtRight]) then
      begin
        //column needs to be contained -> no match
        if not APartial then
          break
        //check if next column to the right overlaps too -> no match
        else if(iIndex < iHigh) then
        begin
          oTmp := Columns[iIndex + 1];
          if oTmp.Margins[mtLeft] < ARight then
            break;
        end;
      end;

      //we have a match
      exit;
    end;
  end;
  //no match was found
  Result := nil;

  //create a new column if allowed
  if ACreate then
  begin
    Result := TColumn.Create(ALeft, ARight);
    FColumns.Insert(iLow, Result);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TColumnLayout.GetColumn(AIndex: integer): TColumn;
begin
  Result := TColumn(FColumns[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TColumnLayout.GetColumnCount: integer;
begin
  Result := FColumns.Count;
end;

{ ---------------------------------------------------------------------------- }
{ TColumnList }
{ ---------------------------------------------------------------------------- }
constructor TColumnLinkList.Create(ATolerance: Extended);
begin
  inherited Create;
  FTolerance := ATolerance;
  FColumnLinks := TObjectList.Create(true);
  FindColumn(0, true, 0);
end;

{ ---------------------------------------------------------------------------- }
destructor TColumnLinkList.Destroy;
begin
  FreeAndNil(FColumnLinks);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TColumnLinkList.AddLayout(ALayout: TColumnLayout);
var
  iIndex: integer;
  oColumns: array of TColumnLink;
  oOrigColumn: TColumn;
  dLeftMargin, dPrevLeftMargin: double;
  oColumn, oPrevColumn: TColumnLink;
begin
  oPrevColumn := nil;
  dPrevLeftMargin := 0;
  SetLength(oColumns, ALayout.ColumnCount);
  for iIndex := 0 to ALayout.ColumnCount - 1 do
  begin
    oOrigColumn := ALayout.Columns[iIndex];
    dLeftMargin := oOrigColumn.Margins[mtLeft];
    oColumn := FindColumn(dLeftMargin, true, FTolerance);
    if oColumn = oPrevColumn then
    begin
      if Abs(dPrevLeftMargin - oColumn.Origin) <= Abs(dLeftMargin - oPrevColumn.Origin) then
        oColumn := FindColumn(dLeftMargin, true, 0)
      else
      begin
        oPrevColumn := FindColumn(dPrevLeftMargin, true, 0);
        Assert(oPrevColumn <> oColumn);
        oColumns[iIndex - 1] := oPrevColumn;
      end;
    end;

    oColumns[iIndex] := oColumn;
    oPrevColumn := oColumn;
    dPrevLeftMargin := dLeftMargin;
  end;

  for iIndex := 0 to ALayout.ColumnCount - 1 do
    oColumns[iIndex].AddColumn(ALayout.Columns[iIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TColumnLinkList.FindColumn(AOrigin: Double; ACreate: boolean; const ATolerance: double): TColumnLink;
var
  iLow, iHigh, iIndex: Integer;
begin
  iLow := 0;
  iHigh := ColumnCount - 1;

  while iLow <= iHigh do
  begin
    iIndex := (iLow + iHigh) div 2;
    Result := ColumnLinks[iIndex];
    case CompareValue(Result.Origin, AOrigin, ATolerance) of
    -1: iLow  := iIndex + 1;
    1 : iHigh := iIndex - 1;
    else
      exit;
    end;
  end;

  if ACreate then
  begin
    Result := TColumnLink.Create(AOrigin);
    FColumnLinks.Insert(iLow, Result);
  end else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TColumnLinkList.GetColumnLink(AIndex: integer): TColumnLink;
begin
  Result := TColumnLink(FColumnLinks[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TColumnLinkList.GetColumnCount: integer;
begin
  Result := FColumnLinks.Count;
end;

{ ---------------------------------------------------------------------------- }
{ TLayoutList }
{ ---------------------------------------------------------------------------- }
constructor TLayoutList.Create;
begin
  inherited Create;
  FLayouts := TObjectList.Create(true);
  FNextId := 0;
end;

{ ---------------------------------------------------------------------------- }
destructor TLayoutList.Destroy;
begin
  FreeAndNil(FLayouts);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLayoutList.AddRow(ARow: TRow; AAllowNewLayouts: boolean; ARowIndex: integer);
var
  oLayout: TColumnLayout;
  iIndex: integer;
begin
  ARow.FixConflicts;
  
  for iIndex := 0 to LayoutCount - 1 do
  begin
    oLayout := Layout[iIndex];
    if oLayout.TryAddRow(ARow, AAllowNewLayouts) then
    begin
{$IFDEF eDocExcelExportTracer}
      TracerGS.AddTraceMsg(Format('Add Row %d to existing Layout %d: %s', [ARowIndex, oLayout.Id, ARow.ToString]));
{$ENDIF}
      if (iIndex > 0) then
        FLayouts.Move(iIndex, 0);
      exit;
    end;
  end;

  if not AAllowNewLayouts then
  begin
{$IFDEF eDocExcelExportTracer}
    TracerGS.AddTraceMsg(Format('No Layout found for Row %d: %s', [ARowIndex, ARow.ToString]));
{$ENDIF}
    raise Exception.CreateFmt('Adding Row %d: New Column Layouts not allowed!', [ARowIndex]);
  end;

  oLayout := TColumnLayout.Create(ARow, FNextId);
{$IFDEF eDocExcelExportTracer}
  TracerGS.AddTraceMsg(Format('Add Row %d to new Layout %d: %s', [ARowIndex, oLayout.Id, ARow.ToString]));
{$ENDIF}
  Inc(FNextId);
  FLayouts.Insert(0, oLayout);
end;

{ ---------------------------------------------------------------------------- }
procedure TLayoutList.DefineColumnNo;
var
  iIndex: integer;
begin
  for iIndex := 0 to LayoutCount - 1 do
    Layout[iIndex].DefineColumnNo;
end;

{ ---------------------------------------------------------------------------- }
procedure TLayoutList.ClearFields;
var
  iIndex: integer;
begin
  for iIndex := 0 to LayoutCount - 1 do
    Layout[iIndex].ClearFields;
end;

{ ---------------------------------------------------------------------------- }
function TLayoutList.GetLayout(AIndex: integer): TColumnLayout;
begin
  Result := TColumnLayout(FLayouts[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TLayoutList.GetLayoutCount: integer;
begin
  Result := FLayouts.Count;
end;

{ ---------------------------------------------------------------------------- }
procedure TLayoutList.MergeLayouts;
var
  iSource: integer;

  function TryMerge(ASource: TColumnLayout): boolean;
  var
    iTarget: integer;
    oTarget: TColumnLayout;
  begin
    Result := false;
    for iTarget := 0 to LayoutCount - 1 do
    begin
      oTarget := Layout[iTarget];
      Result := oTarget.TryMergeLayout(ASource);
      if Result then
      begin
{$IFDEF eDocExcelExportTracer}
        TracerGS.AddTraceMsg(Format('Merge Layout %d into Layout %d', [ASource.Id, oTarget.Id]));
{$ENDIF}
        exit;
      end;
    end;
  end;
begin
  for iSource := LayoutCount - 1 downto 1 do
  begin
    if TryMerge(Layout[iSource]) then
      FLayouts.Delete(iSource);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLayoutList.TraceLayouts;
{$IFDEF eDocExcelExportTracer}
var
  iIndex: integer;
{$ENDIF}
begin
{$IFDEF eDocExcelExportTracer}
  with TracerGS do
  begin
    for iIndex := 0 to LayoutCount - 1 do
      AddTraceMsg(Layout[iIndex].ToString);
  end;
{$ENDIF}
end;

{ ---------------------------------------------------------------------------- }
{ TExtTextItem }
{ ---------------------------------------------------------------------------- }
constructor TExtTextItem.Copy(AItem: TgtTextItem);
var
  iIndex: integer;
begin
  inherited Create;

  X := AItem.X;
  Y := AItem.Y;
  for iIndex := 0 to AItem.Lines.Count - 1 do
    Lines.Add(AItem.Lines.Strings[iIndex]);
  Font := AItem.Font;
  Brush := AItem.Brush;
  RotationAngle := AItem.RotationAngle;
  IsClipRect := AItem.IsClipRect;
  ClipRect := gtRect(AItem.ClipRect, 1);
  Alignment := AItem.Alignment;
  FCharSpaceArray := AItem.FCharSpaceArray;
end;

{ ---------------------------------------------------------------------------- }
{ TRow }
{ ---------------------------------------------------------------------------- }
constructor TRow.Create(AOrigin: Double);
begin
  inherited Create;
  FOrigin := AOrigin;
  FFields := TObjectList.Create(false);
  FMaxHeight := 0;
  FSorted := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TRow.DefineRowNo(ARowNo: integer);
var
  iIndex: integer;
begin
  for iIndex := 0 to FFields.Count - 1 do
    TExtTextItem(FFields[iIndex]).RowNo := ARowNo;
end;

{ ---------------------------------------------------------------------------- }
destructor TRow.Destroy;
begin
  FreeAndNil(FFields);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TRow.FixConflicts;
var
  iIndex: integer;
  oPrevField, oField: TExtTextItem;
begin
  if FieldCount > 1 then
  begin
    SortFields;
    oPrevField := Field[0];
    for iIndex := 1 to FieldCount - 1 do
    begin
      oField := Field[iIndex];
      oPrevField.Width := Min(oPrevField.Width, oField.X - oPrevField.X);
      oPrevField := oField;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TRow.GetField(AIndex: integer): TExtTextItem;
begin
  Result := TExtTextItem(FFields[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TRow.GetFieldCount: integer;
begin
  Result := FFields.Count;
end;

{ ---------------------------------------------------------------------------- }
function CompareFieldOrigins(AItem1, AItem2: Pointer): integer;
begin
  Result := CompareValue(TExtTextItem(AItem1).X, TExtTextItem(AItem2).X);
end;

{ ---------------------------------------------------------------------------- }
procedure TRow.SortFields;
begin
  if FSorted then
    exit;

  FFields.Sort(CompareFieldOrigins);
  FSorted := true;
end;

{ ---------------------------------------------------------------------------- }
function TRow.ToString: string;
var
  iIndex: integer;
  function FieldDimToString(AField: TExtTextItem): string;
  begin
    Result := Format('|%g - %g| (%s)', [AField.X, AField.X + AField.Width, AField.ToString]);
  end;
begin
  Result := '';
  for iIndex := 0 to FieldCount - 1 do
    Result := Result + FieldDimToString(Field[iIndex]) + ' ';

  if Result <> '' then
    SetLength(Result, Length(Result) - 1);
end;

{ ---------------------------------------------------------------------------- }
procedure TRow.AddField(AField: TExtTextItem);
begin
  FFields.Add(AField);
  if FMaxHeight < AField.Height then
    FMaxHeight := AField.Height;
  FSorted := false;
end;

{ ---------------------------------------------------------------------------- }
{ TRowList }
{ ---------------------------------------------------------------------------- }
constructor TRowList.Create(ATolerance: Extended);
begin
  inherited Create;
  FTolerance := ATolerance;
  FRows := TObjectList.Create(true);
end;

{ ---------------------------------------------------------------------------- }
destructor TRowList.Destroy;
begin
  FreeAndNil(FRows);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TRowList.AddField(AField: TExtTextItem);
var
  oRow: TRow;
begin
  oRow := FindRow(AField.Y, true);
  oRow.AddField(AField);
end;

{ ---------------------------------------------------------------------------- }
procedure TRowList.CheckForEmptyRows(ADefaultHeight: double);
var
  iRowIndex, iRows, iAdd: integer;
  oNextRow, oPrevRow: TRow;
begin
  if FRows.Count = 0 then
    exit;

  oNextRow := Rows[Count - 1];
  for iRowIndex := Count - 2 downto 0 do
  begin
    oPrevRow := Rows[iRowIndex];
    iRows := Trunc((oNextRow.Origin - oPrevRow.Origin - oPrevRow.FMaxHeight) / ADefaultHeight);
    for iAdd := 1 to iRows do
      FindRow(oNextRow.Origin - iAdd * ADefaultHeight, true);
    oNextRow := oPrevRow;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TRowList.ClearFields;
var
  iIndex: integer;
begin
  for iIndex := 0 to Count - 1 do
    Rows[iIndex].FFields.Clear;
end;

{ ---------------------------------------------------------------------------- }
function TRowList.FindRow(AOrigin: Double; const ACreate: boolean): TRow;
var
  iLow, iHigh, iIndex: Integer;
begin
  iLow := 0;
  iHigh := Count - 1;

  while iLow <= iHigh do
  begin
    iIndex := (iLow + iHigh) div 2;
    Result := Rows[iIndex];
    case CompareValue(Result.Origin, AOrigin, FTolerance) of
    -1: iLow  := iIndex + 1;
    1 : iHigh := iIndex - 1;
    else
      exit;
    end;
  end;

  if ACreate then
  begin
    Result := TRow.Create(AOrigin);
    FRows.Insert(iLow, Result);
  end else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TRowList.GetCount: integer;
begin
  Result := FRows.Count;
end;

{ ---------------------------------------------------------------------------- }
function TRowList.GetRow(AIndex: integer): TRow;
begin
  Result := TRow(FRows[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
{ TColumnLink }
{ ---------------------------------------------------------------------------- }
constructor TColumnLink.Create(AOrigin: double);
begin
  inherited Create;
  FOrigin := AOrigin;
  FColumns := TObjectList.Create(false);
end;

{ ---------------------------------------------------------------------------- }
destructor TColumnLink.Destroy;
begin
  FreeAndNil(FColumns);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TColumnLink.AddColumn(AColumn: TColumn);
begin
  FColumns.Add(AColumn);
  AColumn.ColumnNo := FColumnNo;
end;

{ ---------------------------------------------------------------------------- }
function TColumnLink.GetColumn(AIndex: integer): TColumn;
begin
  Result := TColumn(FColumns[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TColumnLink.GetColumnCount: integer;
begin
  Result := FColumns.Count;
end;

{ ---------------------------------------------------------------------------- }
function TColumnLink.GetMaxWidth: double;
var
  iIndex: integer;
  oColumn: TColumn;
begin
  Result := 0;
  for iIndex := 0 to ColumnCount - 1 do
  begin
    oColumn := Columns[iIndex];
    Result := Max(Result, oColumn.Margins[mtRight] - oColumn.Margins[mtLeft]);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TColumnLink.SetColumnNo(AValue: integer);
var
  iIndex: integer;
begin
  FColumnNo := AValue;
  for iIndex := 0 to ColumnCount - 1 do
    Columns[iIndex].ColumnNo := AValue;
end;

{ ---------------------------------------------------------------------------- }
{ TExtTextItem }
{ ---------------------------------------------------------------------------- }
function TExtTextItem.ToString: string;
var
  iIndex: integer;
begin
  if Lines.Count > 1 then
  begin
    Result := '';
    for iIndex := 0 to Lines.Count - 1 do
      Result := Result + Lines.Strings[iIndex] + sLineBreak;
    SetLength(Result, Length(Result) - Length(sLineBreak));
  end else
    Result := Lines.Strings[0];
end;

end.
