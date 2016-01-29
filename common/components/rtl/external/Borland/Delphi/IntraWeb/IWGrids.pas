unit IWGrids;
{PUBDIST}

interface

uses
  Classes,
  {$IFDEF Linux}QGraphics, {$ELSE}Graphics, {$ENDIF}
  {$IFDEF Linux}QControls, {$ELSE}Controls, {$ENDIF}
  IWControl, IWFont, IWTypes, IWLayoutMgr, IWHTMLTag;

type
  TIWGridCell = class;
  TIWGridLines = (tlAll, tlNone, tlRows, tlCols);
  TIWGridBorderStyle = (tfDefault, tfVoid, tfAbove, tfBelow, tvHorizSides, tfVertSides, tfLeft
    , tfRight);
  TIWGridVAlign = (vaMiddle, vaTop, vaBottom, vaBaseline);
  TIWCustomGrid = class;

  TIWGridBorderColors = class(TPersistent)
  protected
    FColor: TIWColor;
    FLight: TIWColor;
    FDark: TIWColor;
  public
    constructor Create;
  published
    property Color: TIWColor read FColor write FColor;
    property Light: TIWColor read FLight write FLight;
    property Dark: TIWColor read FDark write FDark;
  end;

  // This is a TCollectionItem so in the future it can be made visual easier later.
  TIWGridCell = class(TCollectionItem)
  //COLSPAN=Number (columns spanned by the cell)
  //ROWSPAN=Number (rows spanned by the cell)
  protected
    FAlignment: TAlignment;
    FBGColor: TIWColor;
    FClickable: Boolean;
    FControl: TIWControl;
    FDoSubmitValidation: Boolean;
    FFont: TIWFont;
    FHeader: Boolean;
    FHeight: string;
    FText: string;
    FVAlign: TIWGridVAlign;
    FVisible: Boolean;
    FWidth: string;
    FWrap: Boolean;
    FGrid: TIWCustomGrid;
    //
    procedure SetControl(const AValue: TIWControl);
    procedure SetFont(const AValue: TIWFont);
    procedure SetHeight(const AValue: string);
    procedure SetWidth(const AValue: string);
  public
    procedure AssignTo(ADest: TPersistent); override;
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    function RenderSelf(AGrid: TIWCustomGrid; const ARow: Integer;
      const AColumn: Integer; AText: string = ''): TIWHTMLTag;
    //
    //@@ Determines whether or not the cell is clickable. Not all Grid implementions support this.
    //TIWGrid does via the OnClick event. TIWDBGrid does not as it supports its own events in a
    //different manner.
    property Clickable: Boolean read FClickable write FClickable;
  published
    //@@ Alignment of cell.
    //+ taLeftJustify
    //+ taRightJustify
    //+ taCenter
    property Alignment: TAlignment read FAlignment write FAlignment;
    //@@ Background color for cell.
    property BGColor: TIWColor read FBGColor write FBGColor;
    //@@ Control can be used to insert controls into the cell. If data also exists in Text, the text
    // will be written out first. The visible property of the control is also ignored and all
    // controls are treated as visible.
    //
    //Setting the control property will also set the control's visible property to false so that
    //it will not also be displayed on the form and in the Grid.
    //
    //Note:
    //Do not use input controls while UseFrame = True as their values are not passed back to the
    //application. Submit controls such as buttons and links, and non-input / non-submit controls
    //such as labels and other display only controls are safe for use with UseFrame = True.
    //
    //Note for Netsape 4:
    //Netscape 4 has painting and other problems when buttons are embedded in a frame. If you
    //support Netscape 4 and use the control property it is advisable that you do not set
    //UseFrame = True, or you test it specifically with Netscape 4.
    property Control: TIWControl read FControl write SetControl;
    property DoSubmitValidation: Boolean read FDoSubmitValidation write FDoSubmitValidation;
    //@@ Specifies the font for the cell.
    property Font: TIWFont read FFont write SetFont;
    //@@ Specifies if cell is a header cell or not.
    property Header: Boolean read FHeader write FHeader;
    //@@ Height of cell. Height can be expressed in percentage by appending a % to the value.
    property Height: string read FHeight write SetHeight;
    //@@ Specifies the text to display.
    property Text: string read FText write FText;
    //@@ Specifies the vertical position of a cell's contents. Possible values are:
    //+ vaTop - Positions data at the top of the cell.
    //+ vaMiddle - Default. Centers the cell data vertically.
    //+ vaBottom - Positions data at the bottom of the cell.
    //+ vaBaseline - Specifies that the first line of each cell in the row with vaBaseline should occur on a common baseline.
    property VAlign: TIWGridVAlign read FVAlign write FVAlign;
    //@@ Specifies whether or not the cell is visible.
    property Visible: Boolean read FVisible write FVisible;
    //@@ Width of cell. Width can be expressed in percentage by appending a % to the value.
    property Width: string read FWidth write SetWidth;
    //@@ Specifies if a cell will wrap its contents or extend its width to accomodate them.
    property Wrap: Boolean read FWrap write FWrap;
  end;

  TIWGridCells = class(TOwnedCollection)
  public
    function Add: TIWGridCell;
    // All this is for compatibility with Delphi 5 becouese Owner property is not defined in
    // TOWnedCollection
    function Owner: TPersistent;
  end;

  TIWOnRenderCell = procedure(ACell: TIWGridCell; const ARow: Integer; const AColumn: Integer)
    of object;

  TIWCustomGrid = class(TIWControl)
  protected
    //Align is not supported because Grid is abosolutely positioned. Align has also been depricated
    //in HTML 4.
    FBorderColors: TIWGridBorderColors;
    FBorderSize: Integer;
    FBorderStyle: TIWGridBorderStyle;
    FBGColor: TIWColor;
    FCaption: string;
    FCells: array of array of TIWGridCell;
    FCellPadding: Integer;
    FCellSpacing: Integer;
    FFrameBuffer: Integer;
    FLines: TIWGridLines;
    FOnRenderCell: TIWOnRenderCell;
    FSummary: string;
    FUseWidth: Boolean;
    //
    procedure DoRenderCell(ACell: TIWGridCell; const ARow: Integer; const AColumn: Integer);
    procedure RenderCells(AGridTag: TIWHTMLTag); virtual; abstract;
    function IsValidCell(ACell: TIWGridCell): Boolean; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
  published
    //@@ Specifies the border colors for the table.
    property BorderColors: TIWGridBorderColors read FBorderColors write FBorderColors;
    //@@ Specifies background color of Grid.
    property BGColor: TIWColor read FBGColor write FBGColor;
    //@@ Specifies size of border in pixels to draw around Grid. 0 = No border.
    property BorderSize: Integer read FBorderSize write FBorderSize;
    //@@ Specifies the attributes for the outer border of the Grid.
    //+ tfDefault - Depends on BorderSize
    //+ tfVoid - No border
    //+ tvAbove - Top border only
    //+ tvBelow - Bottom border only
    //+ tvHorizSides for left and right borders only
    //+ tfVertSides for top and bottom borders only
    //+ tfLeft for a left border only
    //+ tfRight for a right border only
    //Note: Netsape 4 does not suppport this attribute.
    //SeeAlso: BorderSize
    property BorderStyle: TIWGridBorderStyle read FBorderStyle write FBorderStyle;
    //@@ Specifies the Grid caption.
    property Caption: string read FCaption write FCaption;
    //@@ Specifies size of padding in pixels to give cells. 0 = No padding.
    property CellPadding: Integer read FCellPadding write FCellPadding;
    //@@ Specifies size of spacing in pixels to give cells. 0 = No spacing.
    property CellSpacing: Integer read FCellSpacing write FCellSpacing;
    //@@ Specifies the default font for new cells.
    property Font;
    //@@ Some browsers render a margin around Grids when they are in a frame. If a Grid width
    //is the same as the frame, this will cause it to scroll horizontally. The verstical scrollbar
    //must also be accounted for. FrameBuffer will cause the Grid width to be reduced by this
    //amount so that it will fit into the frame with no horizontal scrolling.
    property FrameBuffer: Integer read FFrameBuffer write FFrameBuffer;
    //@@ Lines specifies how lines between the cells are drawn.
    //+ tlAll - Default, Lines will be drawn around all cells.
    //+ tlNone - No lines will be drawn around the cells. Only a border around the Grid itself will be drawn if BorderSize is non zero.
    //+ tlRows - Lines will be drawn horizontally between rows only.
    //+ tlCols - Lines will be drawn vertiacally between columns only.
    //Note: Netscape 4 does not support this attribute.
    //SeeAlso: BorderSize
    property Lines: TIWGridLines read FLines write FLines;
    //@@ OnRenderCell is fired immediately before the cell is rendered. This event can be used to
    //set or alter the Text and/or Control property.
    //
    //ARow and AColumn are both 0 based.
    //
    //For TIWDBGrid ARow has the following meaning:
    //+ 0  - Title Row. If not title row is present, row 0 will be skipped.
    //+ >0 - Data row constructed from data in the associated dataset.
    //+ <0 - Footer row for DB Grid. See FooterRowCount in TIWDBGrid.
    //
    //SeeAlso: FooterRowCount
    property OnRenderCell: TIWOnRenderCell read FOnRenderCell write FOnRenderCell;
    //@@ Specifies the Summary attribute for the Grid.
    property Summary: string read FSummary write FSummary;
    property UseFrame;
    //@@ Speicifies whether or not to write out the Grid width as an attribute of the Grid.
    property UseWidth: Boolean read FUseWidth write FUseWidth;
  end;

  TIWOnCellClick = procedure(const ARow: Integer; const AColumn: Integer) of object;

  TIWGrid = class(TIWCustomGrid)
  protected
    FCellCollection: TIWGridCells;
    FColumnCount: Integer;
    FOnCellClick: TIWOnCellClick;
    FRowCount: Integer;
    //
    procedure DoCellClick(const ARow: Integer; const AColumn: Integer);
    function GetCell(const ARow, AColumn: Integer): TIWGridCell;
    procedure RenderCells(AGridTag: TIWHTMLTag); override;
    procedure SetColumnCount(const AValue: Integer);
    procedure SetRowCount(const AValue: Integer);
    procedure Submit(const AValue: string); override;
    function GetInitProc: String; override;
    function GetIWCLInitProc: String; override;
    function GetJavaScriptOnce: string; override;
    function IsValidCell(ACell: TIWGridCell): Boolean; override; 
  public
    procedure Clear; override;
    //@@ Returns whether or not a cell exists.
    function CellExists(const ARow, AColumn: Integer): Boolean;
    constructor Create(AOwner: TComponent); override;
    //@@ Deletes the specified column from the Grid.
    procedure DeleteColumn(const AColumn: Integer);
    //@@ Deletes the specified row from the Grid.
    procedure DeleteRow(const ARow: Integer);
    destructor Destroy; override;
    //
    //@@ Cell is used to access individual cells in the Grid by row and column number. Rows and
    //columns are zero based and are only created if accessed. If a cell is not accessed, it is not
    //created and be rendered as an empty space in the Grid. To render an empty cell instead of an
    //empty space crate a cell and leave the Text property with an empty string.
    property Cell[const ARow: Integer; const AColumn: Integer]: TIWGridCell read GetCell;
  published
    //@@ Specifies number of columns in the Grid.
    property ColumnCount: Integer read FColumnCount write SetColumnCount;
    //@@ Occurs when the user clicks on a cell that has its Clickable property set to True.
    //SeeAlso: TIWGridCell.Clickable
    property OnCellClick: TIWOnCellClick read FOnCellClick write FOnCellClick;
    //@@ Specifies number of rows in the Grid.
    property RowCount: Integer read FRowCount write SetRowCount;
  end;

var
  IWGridAlignments: array[TAlignment] of string = ('left', 'right', 'center');

implementation

uses
  IWApplication, IWForm, IWAppForm, IWServerControllerBase, IWResourceStrings, 
  SysUtils, SWSystem, SWStrings;

{ TIWGridCell }

procedure TIWGridCell.AssignTo(ADest: TPersistent);
begin
  if ADest is TIWGridCell then begin
    with TIWGridCell(ADest) do begin
      Alignment := Self.Alignment;
      BGColor := Self.BGColor;
      Font.Assign(Self.Font);
      Header := Self.Header;
      Height := Self.Height;
      Text := Self.Text;
      VAlign := Self.VAlign;
      Width := Self.Width;
      Wrap := Self.Wrap;
      Visible := Self.Visible;
      Control := Self.Control;
    end;
  end else begin
    inherited;
  end;
end;

constructor TIWGridCell.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FBGColor := clNone;
  FDoSubmitValidation := True;
  FFont := TIWFont.Create;
  // Copy from Grids font.
  FFont.Assign(Font);
  FHeight := '0';
  FVisible := True;
  FWidth := '0';
  FControl := nil;
end;

destructor TIWGridCell.Destroy;
begin
  FreeAndNil(FFont);
  {if Assigned(FControl) and not Assigned(FControl.Owner) then begin
    FreeAndNil(FControl);
  end;}
  inherited Destroy;
end;

procedure TIWCustomGrid.DoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if Assigned(OnRenderCell) then begin
    OnRenderCell(ACell, ARow, AColumn);
  end;
end;

function TIWGridCell.RenderSelf(AGrid: TIWCustomGrid; const ARow: Integer;
  const AColumn: Integer; AText: string = ''): TIWHTMLTag;
var
  LControlRenderData: TIWHTMLTag;
  LVAlign: string;
  LTmp: String;
begin
  if not Visible then begin
    Result := TIWHTMLTag.CreateTag('TD'); try
      Result.Contents.AddText('&nbsp;');
    except FreeAndNil(Result); raise; end;
  end else begin
    FGrid := AGrid; try
      AGrid.DoRenderCell(Self, ARow, AColumn);
      LControlRenderData := nil;
      if Control <> nil then begin
        Control.Clear;
        LControlRenderData := Control.RenderHTML;
        if Assigned(LControlRenderData) then begin
          LTmp := Control.RenderStyle;
          if LControlRenderData.Params.Values['ID'] = '' then begin
            LControlRenderData.AddStringParam('ID', Control.HTMLName);
          end;
          if LControlRenderData.Params.Values['NAME'] = '' then begin
            LControlRenderData.AddStringParam('NAME', Control.HTMLName);
          end;
          if Control.Visible and (LControlRenderData.Params.Values['CLASS'] = '') then begin
            LControlRenderData.AddStringParam('CLASS', Control.RenderCSSClass);
          end;
          if not Control.Visible or not AnsiSameText(Control.RenderCSSClass, Control.HTMLName + 'CSS') then begin
            LControlRenderData.AddStringParam('STYLE', LTmp);
          end;
          Control.RenderScripts(LControlRenderData, false);
        end;
        TIWForm(AGrid.Form).AddToControlList(Control, nil); 
      end;
      // VAlign
      LVAlign := '';
      case FVAlign of
        vaMiddle: LVAlign := 'VAlign=middle';
        vaTop: LVAlign := 'VAlign=top';
        vaBottom: LVAlign := 'VAlign=bottom';
        vaBaseline: LVAlign := 'VAlign=baseline';
      end;
      //
      if Length(AText) = 0 then begin
        AText := Text;
      end;

      AText := iif((Trim(AText) = '') and (LControlRenderData = nil), '&nbsp;', AText);

      Result := TIWHTMLTag.CreateTag(iif(Header, 'TH', 'TD')); try
        Result.Add(LVAlign);
        // Always render alignment, default is different or TH and TD
        Result.AddStringParam('align', IWGridAlignments[Alignment]);
        Result.Add(iif(not Wrap, 'NOWRAP'));
        Result.Add(iif((Width <> '') and (Width <> '0'), 'Width=' + Width));
        Result.Add(iif((Height <> '') and (Height <> '0'), 'Height=' + Height));
        Result.Add(TIWControl.HTMLColor(BGColor, 'BGColor'));
        Result.Add(iif(Length(Font.CSSStyle) > 0, 'CLASS=' + Font.CSSStyle));

        // FontToString checks Font.Enabled
        if Font.CSSStyle = '' then begin
          if Result.Contents.AddTagAsObject(Font.FontToStringTag(AText)) = nil then
            Result.Contents.AddText(AText);
        end
        else begin
          Result.Contents.AddText(AText);
        end;

        if Assigned(LControlRenderData) then begin
          Result.Contents.AddTagAsObject(LControlRenderData);
        end;
      except FreeAndNil(Result); raise; end;
    finally FGrid := nil; end;
  end;
end;

procedure TIWGridCell.SetControl(const AValue: TIWControl);
begin
  if AValue <> nil then begin
    if not (csDesigning in AValue.ComponentState) then begin
      AValue.Visible := False;
      AValue.Parent := nil;
    end;

    if AValue is TIWCustomGrid then begin
      if FGrid = AValue then begin
        raise Exception.Create(RSCanSetControlToSelf);
      end;
      with TIWCustomGrid(AValue) do begin
        if IsValidCell(self) then begin
          raise Exception.Create(RSCanSetControlToSelf);
        end;
      end;
    end;
  end;
  FControl := AValue;
end;

procedure TIWGridCell.SetFont(const AValue: TIWFont);
begin
  FFont.Assign(AValue);
end;

procedure TIWGridCell.SetHeight(const AValue: string);
var
  s: string;

  procedure InvalidHeight;
  begin
    raise Exception.Create(Format(RSInvalidHeight, [s]));
  end;

begin
  s := Trim(AValue);
  if Length(s) = 0 then begin
    InvalidHeight;
  // Percentage must be >0
  end else if (s[Length(s)] = '%') and (StrToIntDef(Copy(s, 1, Length(s) - 1), 0) > 0) then begin
    FHeight := AValue;
  end else if StrToIntDef(s, -1) >= 0 then begin
    FHeight := AValue;
  end else begin
    InvalidHeight;
  end;
end;

procedure TIWGridCell.SetWidth(const AValue: string);
var
  s: string;

  procedure InvalidWidth;
  begin
    raise Exception.Create(Format(RSInvalidWidth, [s]));
  end;

begin
  s := Trim(AValue);
  if Length(s) = 0 then begin
    InvalidWidth;
  // Percentage must be >0
  end else if (s[Length(s)] = '%') and (StrToIntDef(Copy(s, 1, Length(s) - 1), 0) > 0) then begin
    FWidth := AValue;
  end else if StrToIntDef(s, -1) >= 0 then begin
    FWidth := AValue;
  end else begin
    InvalidWidth;
  end;
end;

{ TIWCustomGrid }

constructor TIWCustomGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorderColors := TIWGridBorderColors.Create;
  FBGColor := clNone;
  FBorderSize := 1;
  FFrameBuffer := 40;
  FNeedsFormTag := True;
  FUseWidth := True;

  Width := 300;
  Height := 150;
end;

function TIWCustomGrid.RenderHTML: TIWHTMLTag;
begin
  // If Control property is used.
  Result := TIWHTMLTag.CreateTag('TABLE');  try
    Result.AddStringParam('ID', HTMLName);
    if BorderSize >= 0 then begin
      Result.AddIntegerParam('Border', BorderSize);
    end;
    Result.AddColor('BGColor', BGColor);
    Result.AddIntegerParam('CELLPADDING', CellPadding);
    Result.AddIntegerParam('CELLSPACING', CellSpacing);
    if UseWidth then begin
      Result.AddIntegerParam('WIDTH', iif(UseFrame, Width - FrameBuffer, Width));
    end;
    FRenderSize := UseWidth;
    if BorderSize > 0 then begin
      Result.AddColor('BORDERCOLOR', BorderColors.Color);
      Result.AddColor('BORDERCOLORLIGHT', BorderColors.Light);
      Result.AddColor('BORDERCOLORDARK', BorderColors.Dark);
    
      case Lines of
        tlNone: Result.AddStringParam('RULES', 'none');
        tlRows: Result.AddStringParam('RULES', 'rows');
        tlCols: Result.AddStringParam('RULES', 'cols');
      end;

      case BorderStyle of
        tfVoid: Result.AddStringParam('frame', 'void');
        tfAbove: Result.AddStringParam('frame', 'above');
        tfBelow: Result.AddStringParam('frame', 'below');
        tvHorizSides: Result.AddStringParam('frame', 'hsides');
        tfVertSides: Result.AddStringParam('frame', 'vsides');
        tfLeft: Result.AddStringParam('frame', 'lhs');
        tfRight: Result.AddStringParam('frame', 'rhs');
      end;
    end;
    Result.Contents.AddText(iif(Caption, '<CAPTION>' + Caption + '</CAPTION>'));
    Result.Contents.AddText(iif(Summary, '<SUMMARY>' + Caption + '</SUMMARY>'));
    RenderCells(Result);
  except FreeAndNil(Result); raise; end;
end;

destructor TIWCustomGrid.Destroy;
begin
  FreeAndNil(FBorderColors);
  inherited;
end;

function TIWGrid.GetInitProc: String;
Var
  i, j: Integer;
begin
  result := inherited GetInitProc;
  for i := Low(FCells) to High(FCells) do begin
    for j := Low(FCells[i]) to High(FCells[i]) do begin
      if CellExists(i, j) then begin
        if Assigned(FCells[i, j].Control) then begin
          result := result + FCells[i, j].Control.InitProcCode;
        end;
      end;
    end;
  end;
end;

function TIWGrid.GetIWCLInitProc: String;
Var
  i, j: Integer;
begin
  result := inherited GetIWCLInitProc;
  for i := Low(FCells) to High(FCells) do begin
    for j := Low(FCells[i]) to High(FCells[i]) do begin
      if CellExists(i, j) then begin
        if Assigned(FCells[i, j].Control) then begin
          result := result + FCells[i, j].Control.IWCLInitProc;
        end;
      end;
    end;
  end;
end;

function TIWGrid.GetJavaScriptOnce: string;
Var
  i, j: Integer;
begin
  result := inherited GetJavaScriptOnce;
  for i := Low(FCells) to High(FCells) do begin
    for j := Low(FCells[i]) to High(FCells[i]) do begin
      if CellExists(i, j) then begin
        if Assigned(FCells[i, j].Control) then begin
          result := result + FCells[i, j].Control.JavaScriptOnce;
        end;
      end;
    end;
  end;
end;

{ TIWGridCells }

function TIWGridCells.Add: TIWGridCell;
begin
  Result := TIWGridCell(inherited Add);
end;

constructor TIWGrid.Create(AOwner: TComponent);
begin
  inherited;
  FSupportsSubmit := True;
  FCellCollection := TIWGridCells.Create(Self, TIWGridCell);
  // Bypass setter routines
  FColumnCount := 1;
  FRowCount := 1;
  if not DesignMode then begin
    SetLength(FCells, 1);
    SetLength(FCells[0], 1);
  end;
end;

destructor TIWGrid.Destroy;
begin
  FreeAndNil(FCellCollection);
  inherited;
end;

function TIWGrid.CellExists(const ARow, AColumn: Integer): Boolean;
begin
  if (AColumn >= ColumnCount) or (ARow >= RowCount) or (AColumn < 0) or (ARow < 0) then begin
    raise Exception.Create(RSIndexOutOfBounds);
  end;
  Result := FCells[ARow, AColumn] <> nil;
end;

function TIWGrid.GetCell(const ARow, AColumn: Integer): TIWGridCell;
begin
  if not CellExists(ARow, AColumn) then begin
    FCells[ARow, AColumn] := FCellCollection.Add;
    // this will copy current Grid font settings to all cells after they were created
    // Later in OnRenderCell the user program can change these settings by loading different values in
    // GridCell.Font
    FCells[ARow, AColumn].Font.Assign(Self.Font);
  end;
  Result := FCells[ARow, AColumn];
end;

procedure TIWGrid.RenderCells(AGridTag: TIWHTMLTag);
var
  i: Integer;
  j: Integer;
  LText: String;
begin
  for i := 0 to RowCount - 1 do begin
    with AGridTag.Contents.AddTag('TR') do begin
      for j := 0 to ColumnCount - 1 do begin
        if CellExists(i, j) then begin
          with FCells[i, j] do begin
            if Clickable then begin
              with SubmitLink(Text, IntToStr(i) + '_' + IntToStr(j)) do begin
                LText := Render;
                Free;
              end;
              Contents.AddTagAsObject(RenderSelf(Self, i, j, LText));
            end else begin
              Contents.AddTagAsObject(RenderSelf(Self, i, j));
            end;
          end;
        end else begin
          // Not &nbsp; - only if cell exists but is empty
          with Contents.AddTag('TD') do
            Contents.AddText('');
        end;
      end;
    end;
  end;
end;

procedure TIWGrid.SetColumnCount(const AValue: Integer);
var
  i: Integer;
  j: Integer;
begin
  if (AValue <> FColumnCount) and (AValue > 0) then begin
    if not DesignMode then begin
      for i := 0 to High(FCells) do begin
        if AValue < FColumnCount then begin
          for j := ColumnCount - 1 downto AValue do begin
            if Assigned(FCells[i, j]) then begin
              FCellCollection.Delete(FCells[i,j].Index);
            end;
          end;
        end;
        SetLength(FCells[i], AValue);
        if AValue > FColumnCount then begin
          for j := FColumnCount to AValue - 1 do begin
            FCells[i, j] := nil;
          end;
        end;
      end;
    end;
    FColumnCount := AValue;
  end;
end;

procedure TIWGrid.SetRowCount(const AValue: Integer);
var
  i: Integer;
  j: Integer;
begin
  if (AValue <> FRowCount) and (AValue > 0) then begin
    if not DesignMode then begin
      if AValue < FRowCount then begin
        for i := FRowCount - 1 downto AValue do begin
          for j := ColumnCount - 1 downto 0 do begin
            if Assigned(FCells[i, j]) then begin
              FCellCollection.Delete(FCells[i, j].Index);
            end;
          end;
        end;
      end;
      SetLength(FCells, AValue);
      if AValue > FRowCount then begin
        for i := FRowCount to AValue - 1 do begin
          SetLength(FCells[i], FColumnCount);
          for j := 0 to High(FCells[i]) do begin
            FCells[i, j] := nil;
          end;
        end;
      end;
    end;
    FRowCount := AValue;
  end;
end;

procedure TIWGrid.DoCellClick(const ARow, AColumn: Integer);
begin
  if Assigned(OnCellClick) then begin
    OnCellClick(ARow, AColumn);
  end;
end;

procedure TIWGrid.Submit(const AValue: string);
var
  s: string;
  LColumn: Integer;
  LRow: Integer;
begin
  s := AValue;
  LRow := StrToInt(Fetch(s, '_'));
  LColumn := StrToInt(s);
  DoCellClick(LRow, LColumn);
end;

procedure TIWGrid.DeleteRow(const ARow: Integer);
var
  i, j: Integer;
begin
  if (ARow < 0) or (ARow >= RowCount) then begin
    raise Exception.Create(RSIndexOutOfBounds);
  end;
  for i := High(FCells[ARow]) downto 0 do begin
    if CellExists(ARow, i) then begin
      FCellCollection.Delete(FCells[ARow, i].Index);
    end;
  end;
  for i := ARow to High(FCells) - 1 do begin
    for j := 0 to High(FCells[i]) do begin
      FCells[i, j] := FCells[i + 1, j];
    end;
  end;
  for i := 0 to High(FCells[RowCount - 1]) do begin
    FCells[RowCount - 1, i] := nil;
  end;
  // This will call SetRowCount
  RowCount := RowCount - 1;
end;

procedure TIWGrid.DeleteColumn(const AColumn: Integer);
var
  i: Integer;
  j: Integer;
begin
  if (AColumn < 0) or (AColumn >= ColumnCount) then begin
    raise Exception.Create(RSIndexOutOfBounds);
  end;

  for i := 0 to High(FCells) do begin
    for j := AColumn to High(FCells[i]) - 1 do begin
      if (j = AColumn) and CellExists(i, j) then begin
        FCells[i, j].Free;
      end;
      FCells[i, j] := FCells[i, j + 1];
    end;
  end;

  for i := 0 to High(FCells) do begin
    FCells[i, ColumnCount - 1] := nil;
  end;
  // This will call SetColumnCount
  ColumnCount := ColumnCount - 1;
end;

function TIWGridCells.Owner: TPersistent;
begin
  result := inherited GetOwner;
end;

{ TIWGridBorderColors }

constructor TIWGridBorderColors.Create;
begin
  inherited;
  Color := clNone;
  Light := clNone;
  Dark := clNone;
end;

procedure TIWGrid.Clear;
Var
  i, j: Integer;
begin
  inherited Clear;
  for i := Low(FCells) to High(FCells) do begin
    for j := Low(FCells[i]) to High(FCells[i]) do begin
      if CellExists(i, j) then begin
        if Assigned(FCells[i, j].Control) then begin
          FCells[i, j].Control.Clear;
        end;
      end;
    end;
  end;
end;

function TIWGrid.IsValidCell(ACell: TIWGridCell): Boolean;
Var
  LCell: TCollectionItem;
begin
  LCell := FCellCollection.FindItemID(ACell.ID);
  result := LCell = ACell; 
end;

end.

