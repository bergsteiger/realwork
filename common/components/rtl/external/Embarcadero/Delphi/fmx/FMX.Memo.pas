{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Memo;

interface

uses
  System.Classes, System.Generics.Collections,
  System.Types, System.UITypes, System.Rtti,
  FMX.Types, FMX.StdCtrls, FMX.Layouts, FMX.Platform, FMX.Menus, FMX.Objects,
  FMX.Text, FMX.Controls, FMX.MagnifierGlass;

{$SCOPEDENUMS ON}

type

  TInsertOption = (ioSelected, ioMoveCaret, ioCanUndo, ioUndoPairedWithPrev);
  TInsertOptions = set of TInsertOption;
  TDeleteOption = (doMoveCaret, doCanUndo);
  TDeleteOptions = set of TDeleteOption;

  TActionType = (atDelete, atInsert);

  TLinesBegins = array of Integer;

  TCaretPosition = record
    Line, Pos: Integer;
  public
    class operator LessThanOrEqual(A, B: TCaretPosition): Boolean;
    class operator LessThan(A, B: TCaretPosition): Boolean;
    class operator GreaterThanOrEqual(A, B: TCaretPosition): Boolean;
    class operator GreaterThan(A, B: TCaretPosition): Boolean;
  end;

  TEditAction = record
    ActionType: TActionType;
    PairedWithPrev: Boolean;
    StartPosition: Integer;
    DeletedFragment: string; { For atDelete }
    Length: Integer; { For atInsert }
  end;

  TMemo = class;

{ TEditActionStack }

  TEditActionStack = class(TStack<TEditAction>)
  private
    FOwner: TMemo;
  public
    constructor Create(const AOwner: TMemo);
    destructor Destroy; override;

    procedure FragmentInserted(StartPos, FragmentLength: Integer;
      IsPairedWithPrev: Boolean);
    procedure FragmentDeleted(StartPos: Integer; const Fragment: string);
    procedure CaretMovedBy(Shift: Integer);

    function RollBackAction: Boolean;
  end;

{ TMemo }

  TSelectionPointType = (sptLeft, sptRight);
  TMemo = class(TScrollBox, ITextInput, ITextActions, IVirtualKeyboardControl,
                ITouchEvents, ITextSettings, ICaret)
  private
    FNeedChange: Boolean;
    FTextService: TTextService;
    FLMouseSelecting: Boolean;
    FDownMPt: TPointF;
    FOldMPt: TPointF;
    FCaretPosition: TCaretPosition;
    FMemoPopupMenu: TPopupMenu;
    FAutoSelect: Boolean;
    FCharCase: TEditCharCase;
    FHideSelection: Boolean;
    FMaxLength: Integer;
    FReadOnly: Boolean;
    FOnChange: TNotifyEvent;
    FActionStack: TEditActionStack;
    FLines: TStrings;
    FSelStart: TCaretPosition;
    FSelEnd: TCaretPosition;
    FSelected: Boolean;
    FSelectionFill: TBrush;
    FCursorFill: TBrush;
    FOnChangeTracking: TNotifyEvent;
    FContent: TControl;
    FKeyboardType: TVirtualKeyboardType;
    FLastVScrollBarValue: Single;
    FLockVerticalScroll: Boolean;
    FOldRect: TRectF;
    FStartAutoScrollTimer: TTimer;
    FAutoVScrollTimer: TTimer;
    FAutoHScrollTimer: TTimer;
    FNeedAutoVScroll: Boolean;
    FNeedAutoHScroll: Boolean;
    FFollowTheMouse: Boolean;
    FSaveReadOnly: Boolean;
    { Selection }
    FLeftSelPt: TSelectionPoint;
    FRightSelPt: TSelectionPoint;
    { Loupe }
    FLoupeService: ILoupeService;
    FCaret: TCaret;
    { ITextSettings }
    FTextSettings: TTextSettings;
    FLastTextSettings: TTextSettings;
    FDefaultTextSettings: TTextSettings;
    FStyledSettings: TStyledSettings;
    FIsDisableDesign: Boolean;
    FLineHeignt: Single;
    FSetFocusOnUp: Boolean;
    function GetSelBeg: TCaretPosition;
    function GetSelEnd: TCaretPosition;
    procedure ReadTextData(Reader: TReader);
    procedure SelectAtPos(APos: TCaretPosition);
    procedure SetCaretPosition(const Value: TCaretPosition);
    procedure SetSelLength(const Value: Integer);
    procedure SetSelStart(const Value: Integer);
    function GetSelStart: Integer;
    function GetSelLength: Integer;
    procedure UpdateHScrlBarByCaretPos;
    procedure UpdateVScrlBarByCaretPos;
    function GetSelText: string;
    procedure SetAutoSelect(const Value: Boolean);
    procedure SetCharCase(const Value: TEditCharCase);
    procedure SetHideSelection(const Value: Boolean);
    procedure SetMaxLength(const Value: Integer);
    function GetNextWordBegin(StartPosition: TCaretPosition): TCaretPosition;
    function GetPrevWordBegin(StartPosition: TCaretPosition): TCaretPosition;
    function GetPositionShift(APos: TCaretPosition; Delta: Integer { char count } ): TCaretPosition;
    procedure MoveCareteBy(Delta: Integer);
    procedure MoveCaretLeft;
    procedure MoveCaretRight;
    procedure MoveCaretVertical(LineDelta: Integer);
    procedure MoveCaretDown;
    procedure MoveCaretUp;
    procedure MoveCaretPageUp;
    procedure MoveCaretPageDown;
    procedure UpdateCaretPosition(UpdateScrllBars: Boolean);
    procedure SetLines(const Value: TStrings);
    // Returns Line without special symbols at the end.
    // Returns Line with special symbols at the end.
    procedure SetWordWrap(const Value: Boolean);
    function GetPageSize: Single;
    function GetShowSelection: Boolean;
    procedure SetFont(const Value: TFont);
    procedure SetTextAlign(const Value: TTextAlign);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(Value: Boolean);
    function GetImeMode: TImeMode; virtual;
    procedure SetImeMode(const Value: TImeMode); virtual;
    { ITextInput }
    function GetTextService: TTextService;
    procedure UpdateCaretPoint;
    function GetTargetClausePointF: TPointF;
    procedure StartIMEInput;
    procedure EndIMEInput;
    function ITextInput.GetSelection = GetSelText;
    function GetSelectionRect: TRectF;
    function HasText: Boolean;
    procedure Replace(const APos: Integer; const ALength: Integer; const AStr: string);
    { IVirtualKeyboardControl }
    procedure SetKeyboardType(Value: TVirtualKeyboardType);
    function GetKeyboardType: TVirtualKeyboardType;
    //
    procedure DoScroll(ADirection : Integer);
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure TextLineInserted(Sender: TObject; LineIndex: Integer;
      LineHeight: Single);
    procedure TextBoxSizeChanged(Sender: TObject);
    procedure ScrollLayout(const AVertialScroll: Single);
    function GetPositionPoint(ACaretPos: TCaretPosition): TPointF;
    procedure SetFontColor(const Value: TAlphaColor);
    procedure ReadFontFillColor(Reader: TReader);
    procedure ReadFontFillKind(Reader: TReader);
    { Selections }
    procedure BeginSelection;
    procedure EndSelection;
    procedure GetNormalizedSelectionRange(var ASelStart, ASelEnd: TCaretPosition);
    procedure SetNormalizedSelectionRange(const ASelStart, ASelEnd: TCaretPosition);
    function GetSelectionRegion: TRegion;
    function HaveSelectionPickers: Boolean;
    procedure UpdateSelectionPointPositions;
    procedure DoSelPtMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure DoLeftSelPtChangePosition(Sender: TObject; var X, Y: Single);
    procedure DoLeftSelPtMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure DoRightSelPtChangePosition(Sender: TObject; var X, Y: Single);
    procedure DoRightSelPtMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    { Loupe }
    procedure HideLoupe;
    procedure ShowLoupe;
    procedure SetLoupePosition(const ASelectionPointType: TSelectionPointType); overload;
    procedure SetLoupePosition(const X, Y: Single); overload;
    // Selection Autoscroll
    procedure StartAutoScroll(const X, Y: Single);
    procedure StopAutoScroll;
    procedure StartAutoScrollHandler(Sender: TObject);
    procedure AutoScrollUpHandler(Sender: TObject);
    procedure AutoScrollDownHandler(Sender: TObject);
    procedure AutoScrollLeftHandler(Sender: TObject);
    procedure AutoScrollRightHandler(Sender: TObject);
    procedure PutCaretTo(X, Y: Single; Select: Boolean = False; PositionByWord: Boolean = False);
    { ICaret }
    function ICaret.GetObject = GetCaret;
    function GetCaret: TCustomCaret;
    procedure SetCaret(const Value: TCaret);
    procedure ShowCaret;
    procedure HideCaret;
    { ITextSettings }
    function GetDefaultTextSettings: TTextSettings;
    function GetTextSettings: TTextSettings;
    function GetStyledSettings: TStyledSettings;
    function GetFont: TFont;
    function GetFontColor: TAlphaColor;
    function GetTextAlign: TTextAlign;
    function GetWordWrap: Boolean;
  protected
    //Animation mouse events
    procedure AniMouseDown(const Touch: Boolean; const X, Y: Single); override;
    procedure AniMouseMove(const Touch: Boolean; const X, Y: Single); override;
    procedure AniMouseUp(const Touch: Boolean; const X, Y: Single); override;

    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    function CanObserve(const ID: Integer): Boolean; override;
    procedure ObserverAdded(const ID: Integer; const Observer: IObserver); override;
    procedure ObserverToggle(const AObserver: IObserver; const Value: Boolean);
    function GetLineHeight: Single;
    function GetText: string; virtual;
    procedure SetText(const Value: string); virtual;
    procedure CreatePopupMenu; virtual;
    procedure UpdatePopupMenuItems; virtual;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure DoChange; virtual;
    function ValidText(const NewText: string): Boolean; virtual;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
    procedure DoChangeTracking; virtual;
    //
    procedure DoUndo(Sender: TObject);
    procedure DoCut(Sender: TObject);
    procedure DoCopy(Sender: TObject);
    procedure DoPaste(Sender: TObject);
    procedure DoDelete(Sender: TObject);
    procedure DoSelectAll(Sender: TObject);
    procedure RepaintEdit;
    { inherited }
    procedure ContextMenu(const ScreenPosition: TPointF); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                     const ContentSizeChanged: boolean); override;
    function IsOpaque: Boolean; override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    function DoCalcContentBounds: TRectF; override;
    function CreateCaret: TCaret; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; x, y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; x, y: Single); override;
    procedure MouseMove(Shift: TShiftState; x, y: Single); override;
    function GetCanFocus: Boolean; override;
    procedure DoRealign; override;
    procedure RecalcOpacity; override;
    { ITouchEvents }
    procedure LongTap(const X, Y: Single);
    procedure DblTap;
    { ITextSettings }
    procedure SetTextSettings(const Value: TTextSettings); virtual;
    procedure SetStyledSettings(const Value: TStyledSettings); virtual;
    function StyledSettingsStored: Boolean; virtual;
    procedure DoChanged; virtual;
    property DefaultTextSettings: TTextSettings read GetDefaultTextSettings;
    property TextSettings: TTextSettings read GetTextSettings write SetTextSettings;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    { ITextActions }
    procedure CopyToClipboard;
    procedure PasteFromClipboard;
    procedure CutToClipboard;
    procedure ClearSelection; deprecated 'Use DeleteSelection method instead';
    procedure DeleteSelection;
    procedure SelectAll;
    procedure SelectWord;
    procedure ResetSelection;
    procedure GoToTextEnd;
    procedure GoToTextBegin;
    procedure GoToLineEnd;
    procedure GoToLineBegin;
    procedure UnDo;
    procedure InsertAfter(APosition: TCaretPosition; const S: string; Options: TInsertOptions);
    procedure DeleteFrom(APosition: TCaretPosition; ALength: Integer; Options: TDeleteOptions);
    function TextPosToPos(APos: Integer): TCaretPosition;
    function PosToTextPos(APostion: TCaretPosition): Integer;
    property Action;
    property SelStart: Integer read GetSelStart write SetSelStart;
    property SelLength: Integer read GetSelLength write SetSelLength;
    property SelText: string read GetSelText;
    property Text: string read GetText write SetText;
    property CaretPosition: TCaretPosition read FCaretPosition write SetCaretPosition;
    { custom colors - only work when style was loaded }
    property SelectionFill: TBrush read FSelectionFill;
  published
    property AutoSelect: Boolean read FAutoSelect write SetAutoSelect default False;
    property CanFocus default True;
    property CanParentFocus;
    property CharCase: TEditCharCase read FCharCase write SetCharCase default TEditCharCase.ecNormal;
    property Cursor default crIBeam;
    property DisableFocusEffect;
    property Enabled;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default True;
    property ImeMode: TImeMode read GetImeMode write SetImeMode default TImeMode.imDontCare;
    property KeyboardType: TVirtualKeyboardType read GetKeyboardType write SetKeyboardType default TVirtualKeyboardType.vktDefault;
    property Lines: TStrings read FLines write SetLines;
    property MaxLength: Integer read FMaxLength write SetMaxLength default 0;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property StyleLookup;
    property TabOrder;
    property Caret: TCaret read FCaret write SetCaret;
    {text properties}
    property Font: TFont read GetFont write SetFont;
    property FontColor: TAlphaColor read GetFontColor write SetFontColor default TAlphaColorRec.Black;
    property TextAlign: TTextAlign read GetTextAlign write SetTextAlign default TTextAlign.taLeading;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default False;
    property StyledSettings: TStyledSettings read GetStyledSettings write SetStyledSettings stored StyledSettingsStored nodefault;
    {events}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChangeTracking: TNotifyEvent read FOnChangeTracking write FOnChangeTracking;
    property OnEnter;
    property OnExit;
    property OnKeyUp;
    property OnKeyDown;
  end;

function ComposeCaretPos(ALine, APos: Integer): TCaretPosition;

implementation

uses
  System.SysUtils, System.Variants, FMX.Consts, FMX.TextLayout, System.Math,
  System.UIConsts;

const
  LOUPE_OFFSET = 10;

type

{ TMemoLines }

  TMemoLines = class(TStringList)
  public type
    TInsertLineEvent = procedure(Sender: TObject; Index: Integer;
      Height: Single) of object;
  private
    FMemo: TMemo;
    FRenderLineFrom: Integer;
    FRenderLineTo: Integer;
    FOnInsert: TInsertLineEvent;
    FLayoutsHeight: Single;
    FLayoutsWidth: Single;
    FOnSizeChange: TNotifyEvent;
    FLinesSize: TList<TSizeF>;
    FXShift: Single;
    function CreateLayout(const S: string): TTextLayout;
    procedure DoInsert(Index: Integer; Height: Single);
    function GetHeight: Single;
    procedure DoSizeChange;
    function GetWidth: Single;
    function GetXShift: Single;
    procedure GetLayoutsWidth;
    procedure UpdateLayoutParams(Layout: TTextLayout);
  protected
    procedure Put(Index: Integer; const S: string); override;
    procedure InsertItem(Index: Integer; const S: string; AObject: TObject); override;
    function GetTextStr: string; override;
    procedure SetTextStr(const Value: string); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create; overload;
    destructor Destroy; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    //
    procedure UpdateLayoutsProperties;
    procedure UpdateLayoutsColor;
    procedure CheckScrollDown;
    procedure CheckScrollUp;
    procedure ScrollToLine(const ALine: Integer);
    procedure Realign;
    //Caret support
    function GetPointPosition(Pt: TPointF; RoundToWord: Boolean = False): TCaretPosition;
    function GetRegionForRange(const ALine, APos, ALength: Integer; RoundToWord: Boolean = False): TRegion;
    //
    property OnInsert: TInsertLineEvent read FOnInsert write FOnInsert;
    property OnSizeChange: TNotifyEvent read FOnSizeChange
        write FOnSizeChange;
    //
    property RenderLineFrom: Integer read FRenderLineFrom;
    property RenderLineTo: Integer read FRenderLineTo;
    property Height: Single read GetHeight;
    property Width: Single read GetWidth;
    property XShift: Single read GetXShift;
  end;

function ComposeCaretPos(ALine, APos: Integer): TCaretPosition;
begin
  Result.Line := ALine;
  Result.Pos := APos;
end;

function RemoveUnprintableCharacters(const S: string): string;
var
  Parts: TArray<string>;
begin
  Parts := S.Split([#10,#13,#0]);
  if Length(Parts) > 0 then
    Result := ''.Join('', Parts)
  else
    Result := '';
end;

{ TMemoLines }

procedure TMemoLines.CheckScrollDown;
var
  P: TPointF;
  Index, I: Integer;
  Layout: TTextLayout;
begin
  P := TTextLayout(Objects[FRenderLineFrom]).TopLeft;
  Index := FRenderLineFrom;
  while (Index <= FRenderLineTo) and
        ((P.Y + TTextLayout(Objects[Index]).Height) < 0) do
  begin
    P.Offset(0, TTextLayout(Objects[Index]).Height);
    Inc(Index);
  end;
  if (P.Y < 0) and (Index > FRenderLineTo) and (Index < (Count - 1)) then
  begin
    for I := Index + 1 to Count - 1 do
    begin
      if (P.Y + FLinesSize[I].Height) > 0 then
        Break;
      P.Offset(0, FLinesSize[I].Height);
      Index := I;
    end;
  end;
  Index := Min(Index, Count - 1);
  if Index <> FRenderLineFrom then
  begin
    for I := FRenderLineFrom to Index - 1 do
    begin
      {$IFNDEF NEXTGEN}
      if Assigned(Objects[I]) then
        Objects[I].Free;
      {$ENDIF}
      Objects[I] := nil;
    end;
    FRenderLineFrom := Index;
    if FRenderLineFrom <= FRenderLineTo then
      //Updating layouts position
      for I := FRenderLineFrom to FRenderLineTo do
      begin
        TTextLayout(Objects[I]).TopLeft := P;
        P.Offset(0, TTextLayout(Objects[I]).Height);
      end
    else
    begin
      FRenderLineTo := FRenderLineFrom;
      if Assigned(Objects[FRenderLineTo]) then
        Layout := TTextLayout(Objects[FRenderLineTo])
      else
      begin
        Layout := CreateLayout(Strings[FRenderLineTo]);
        FLinesSize[FRenderLineTo] := TSizeF.Create(Layout.Width, Layout.Height);
        Objects[FRenderLineTo] := Layout;
      end;
      Layout.TopLeft := P;
    end;
  end;
  //Checking for expand render area
  P := TTextLayout(Objects[FRenderLineTo]).TopLeft;
  P.Offset(0, TTextLayout(Objects[FRenderLineTo]).Height);
  if P.Y < FMemo.ContentRect.Height then
    for I := (FRenderLineTo + 1) to Count - 1 do
    begin
      if P.Y < FMemo.ContentRect.Height then
      begin
        Layout := CreateLayout(Strings[I]);
        FLinesSize[I] := TSizeF.Create(Layout.Width, Layout.Height);
        Layout.TopLeft := P;
        Objects[I] := Layout;
        Inc(FRenderLineTo);
        P.Offset(0, Layout.Height);
      end
      else
        Break;
    end;
end;

procedure TMemoLines.CheckScrollUp;
var
  P: TPointF;
  Index, I: Integer;
  Layout: TTextLayout;
begin
  P := TTextLayout(Objects[FRenderLineTo]).TopLeft;
  Index := FRenderLineTo;
  while (Index >= FRenderLineFrom) and
        (TTextLayout(Objects[Index]).TopLeft.Y > FMemo.ContentRect.Height) do
  begin
    P := TTextLayout(Objects[Index]).TopLeft;
    Dec(Index);
  end;
  if (Index >= 0) and (Index < Count) then
    P.Offset(0, -FLinesSize[Index].Height);
  if (P.Y > FMemo.ContentRect.Height) and (Index < FRenderLineFrom) and (Index > 0) then
  begin
    for I := Index - 1 downto 0 do
    begin
      if (P.Y - FLinesSize[I].Height) < FMemo.ContentRect.Height then
        Break;
      P.Offset(0, -FLinesSize[I].Height);
      Index := I;
    end;
  end;
  Index := Max(0, Index);
  if Index <> FRenderLineTo then
  begin
    for I := Index + 1 to FRenderLineTo do
    begin
      {$IFNDEF NEXTGEN}
      if Assigned(Objects[I]) then
        Objects[I].Free;
      {$ENDIF}
      Objects[I] := nil;
    end;
    FRenderLineTo := Index;
    if FRenderLineFrom > FRenderLineTo then
    begin
      FRenderLineFrom := FRenderLineTo;
      if Assigned(Objects[FRenderLineFrom]) then
        Layout := TTextLayout(Objects[FRenderLineFrom])
      else
      begin
        Layout := CreateLayout(Strings[FRenderLineFrom]);
        FLinesSize[FRenderLineFrom] := TSizeF.Create(Layout.Width, Layout.Height);
        Objects[FRenderLineFrom] := Layout;
      end;
      Layout.TopLeft := P;
    end;
  end;
  //Checking for expand render area
  P := TTextLayout(Objects[FRenderLineFrom]).TopLeft;
  if P.Y > 0 then
    for I := (FRenderLineFrom - 1) downto 0 do
    begin
      if P.Y > 0 then
      begin
        Layout := CreateLayout(Strings[I]);
        FLinesSize[I] := TSizeF.Create(Layout.Width, Layout.Height);
        P.Offset(0, -Layout.Height);
        Layout.TopLeft := P;
        Objects[I] := Layout;
        Dec(FRenderLineFrom);
      end
      else
        Break;
    end;
end;

procedure TMemoLines.Clear;
begin
  FMemo.FNeedChange := (Count > 0);
  FRenderLineFrom := -1;
  FRenderLineTo := -1;
  FLayoutsHeight := 0;
  FLayoutsWidth := 0;
  FLinesSize.Clear;
  inherited;
  FMemo.DoChangeTracking;
  if UpdateCount = 0 then
  begin
    DoSizeChange;
    FMemo.DoChange;
  end;
end;

constructor TMemoLines.Create;
begin
  inherited Create(True);
  FRenderLineFrom := -1;
  FRenderLineTo := -1;
  FLinesSize := TList<TSizeF>.Create;
  FXShift := -1;
end;

procedure TMemoLines.UpdateLayoutParams(Layout: TTextLayout);
begin
  Layout.HorizontalAlign := FMemo.FLastTextSettings.HorzAlign;
  Layout.Font := FMemo.FLastTextSettings.Font;
  Layout.Color := FMemo.FLastTextSettings.FontColor;
  Layout.WordWrap := FMemo.FLastTextSettings.WordWrap or (Layout.HorizontalAlign <> TTextAlign.taLeading);
  if Layout.WordWrap or
     (Layout.HorizontalAlign in [TTextAlign.taCenter, TTextAlign.taTrailing]) then
    Layout.MaxSize := PointF(FMemo.ContentRect.Width, ClosePolygon.Y)
  else
    Layout.MaxSize := ClosePolygon;
  Layout.Opacity := FMemo.AbsoluteOpacity;
end;

function TMemoLines.CreateLayout(const S: string): TTextLayout;
begin
  Result := TTextLayoutManager.DefaultTextLayout.Create;
  Result.BeginUpdate;
  try
    UpdateLayoutParams(Result);
    if S.IsEmpty then
      //Setting some string if text is empty to recreate layout,
      //if other properties have default values
      Result.Text := ' ';
    Result.Text := S;
  finally
    Result.EndUpdate;
  end;
end;

procedure TMemoLines.Delete(Index: Integer);
var
  I: Integer;
  P: TPointF;
  LayoutSize: TSizeF;
begin
  if Count > 0 then
  begin
    LayoutSize := FLinesSize[Index];
    if (Index >= FRenderLineFrom) and (Index <= FRenderLineTo) then
      P := TTextLayout(Objects[Index]).TopLeft;
    FLinesSize.Delete(Index);
    if UpdateCount = 0 then
    begin
      FLayoutsHeight := FLayoutsHeight - LayoutSize.Height;
      GetLayoutsWidth;
    end;
  end;
  inherited;
  if Count > 0 then
  begin
    if Index < FRenderLineFrom then
    begin
      Dec(FRenderLineFrom);
      Dec(FRenderLineTo);
      P := TTextLayout(Objects[FRenderLineFrom]).TopLeft;
      P.Offset(0, -LayoutSize.Height);
      for I := FRenderLineFrom to FRenderLineTo do
      begin
        TTextLayout(Objects[I]).TopLeft := P;
        P.Offset(0, TTextLayout(Objects[I]).Height);
      end;
    end
    else
      if (Index >= FRenderLineFrom) and (Index <= FRenderLineTo) then
      begin
        if FRenderLineTo < Count then
          Objects[FRenderLineTo] := CreateLayout(Strings[FRenderLineTo])
        else
        begin
          Dec(FRenderLineTo);
          if FRenderLineTo < FRenderLineFrom then
          begin
            FRenderLineFrom := FRenderLineTo;
            Objects[FRenderLineFrom] := CreateLayout(Strings[FRenderLineFrom]);
          end;
        end;
        for I := Index to FRenderLineTo do
        begin
          TTextLayout(Objects[I]).TopLeft := P;
          P.Offset(0, TTextLayout(Objects[I]).Height);
        end;
      end;
  end
  else
  begin
    FRenderLineFrom := -1;
    FRenderLineTo := -1;
  end;
  FMemo.FNeedChange := True;
  if UpdateCount = 0 then
  begin
    DoSizeChange;
    FMemo.RepaintEdit;
  end;
end;

destructor TMemoLines.Destroy;
begin
  FreeAndNil(FLinesSize);
  inherited;
end;

procedure TMemoLines.DoInsert(Index: Integer; Height: Single);
begin
  if Assigned(FOnInsert) then
    FOnInsert(Self, Index, Height);
end;

procedure TMemoLines.DoSizeChange;
begin
  if Assigned(FOnSizeChange) then
    FOnSizeChange(Self);
end;

function TMemoLines.GetHeight: Single;
begin
  Result := FLayoutsHeight;
end;

procedure TMemoLines.GetLayoutsWidth;
var
  I: Integer;
begin
  if not FMemo.FLastTextSettings.WordWrap then
  begin
    FLayoutsWidth := 0;
    for I := 0 to FLinesSize.Count - 1 do
      FLayoutsWidth := Max(FLayoutsWidth, FLinesSize[I].Width);
  end;
end;

function TMemoLines.GetPointPosition(Pt: TPointF; RoundToWord: Boolean): TCaretPosition;
var
  I, LPos: Integer;
  LastPoint: TPointF;
  Rgn: TRegion;

  procedure CheckTextLayoutObject(const Index: Integer);
  var
    Layout: TTextLayout;
  begin
    if not Assigned(Objects[Index]) then
      Layout := CreateLayout(Strings[Index])
    else
      Layout := TTextLayout(Objects[Index]);
    Result.Pos := Layout.PositionAtPoint(LastPoint);
    if not Assigned(Objects[Index]) then
      FreeAndNil(Layout);
  end;

begin
  Result.Line := -1;
  Result.Pos := -1;
  if (FRenderLineFrom >= 0) and (FRenderLineTo >= 0) then
  begin
    for I := FRenderLineFrom to FRenderLineTo do
    begin
      LPos := TTextLayout(Objects[I]).PositionAtPoint(Pt, RoundToWord);
      if LPos >= 0 then
      begin
        if LPos > 0 then
        begin
          Rgn := TTextLayout(Objects[I]).RegionForRange(TTextRange.Create(LPos, 1), RoundToWord);
          if (Length(Rgn) > 0) and (Rgn[0].Top > Pt.Y) then
            Dec(LPos);
        end;
        Result.Line := I;
        Result.Pos := LPos;
        Break;
      end;
    end;
    if (Result.Line = -1) and (Result.Pos = -1) then
    begin
      LastPoint := Pt;
      if Pt.Y > TTextLayout(Objects[FRenderLineTo]).TopLeft.Y then
      begin
        //Looking line lower than visible line
        LastPoint.Offset(0, -TTextLayout(Objects[FRenderLineTo]).TopLeft.Y);
        LastPoint.Offset(0, -TTextLayout(Objects[FRenderLineTo]).Height);
        for I := FRenderLineTo + 1 to Count - 1 do
          if LastPoint.Y < FLinesSize[I].Height then
          begin
            Result.Line := I;
            CheckTextLayoutObject(I);
            Result.Pos := Max(0, Result.Pos);
            Break;
          end
          else
            LastPoint.Offset(0, -FLinesSize[I].Height);
        if (Result.Line = -1) and (Result.Pos = -1) then
        begin
          //Nothing to scroll. Returning last line.
          if Assigned(Objects[Count - 1]) then
            LastPoint.Y := TTextLayout(Objects[Count - 1]).TopLeft.Y + TTextLayout(Objects[Count - 1]).Height - FMemo.GetLineHeight / 2
          else
            LastPoint.Y := FLinesSize[Count - 1].Height - FMemo.GetLineHeight / 2;
          CheckTextLayoutObject(Count - 1);
          if Result.Pos >= 0 then
            Result.Line := Count - 1;
        end;
      end
      else
        begin
          //Looking for line upper than visible lines
          LastPoint.Offset(0, -TTextLayout(Objects[FRenderLineFrom]).TopLeft.Y);
          for I := FRenderLineFrom - 1 downto 0 do
            if (LastPoint.Y + FLinesSize[I].Height) > 0 then
            begin
              Result.Line := I;
              LastPoint.Offset(0, FLinesSize[I].Height);
              CheckTextLayoutObject(I);
              Result.Pos := Max(0, Result.Pos);
              Break;
            end
            else
              LastPoint.Offset(0, FLinesSize[I].Height);
          if (Result.Line = -1) and (Result.Pos = -1) then
          begin
            //Nothing to scroll. Returning first line.
            if Assigned(Objects[0]) then
              LastPoint.Y := TTextLayout(Objects[0]).TopLeft.Y + FMemo.GetLineHeight / 2
            else
              LastPoint.Y := FMemo.GetLineHeight / 2;
            CheckTextLayoutObject(0);
            if Result.Pos >= 0 then
              Result.Line := 0;
          end;
        end;
    end;
  end;
end;

function TMemoLines.GetRegionForRange(const ALine, APos, ALength: Integer; RoundToWord: Boolean): TRegion;
var
  I, J: Integer;
  LPos, RemainLength, LLength, LineLength: Integer;
  Layout: TTextLayout;
  LRegion: TRegion;
begin
  SetLength(Result, 0);
  if ALine > FRenderLineTo then
    Exit;
  LPos := APos;
  RemainLength := ALength;
  for I := ALine to FRenderLineTo do
  begin
    Layout := TTextLayout(Objects[I]);
    //Checking layout for contains a part of requested range
    if RemainLength > 0 then
    begin
      LineLength := Strings[I].Length;
      LLength := Min(RemainLength, LineLength - LPos);
      if Assigned(Layout) then
      begin
        LRegion := Layout.RegionForRange(TTextRange.Create(LPos, LLength), RoundToWord);
        for J := 0 to High(LRegion) do
        begin
          SetLength(Result, Length(Result) + 1);
          Result[High(Result)] := LRegion[J];
        end;
      end;
      Inc(LPos, LLength);
      if LPos >= LineLength then
      begin
        LPos := 0;
        Dec(RemainLength);
      end;
      Dec(RemainLength, LLength);
      if RemainLength <= 0 then
        Break;
    end
    else
      Break;
  end;
end;

function TMemoLines.GetTextStr: string;
begin
  Result := inherited GetTextStr;
  //Removing unneseccary last line break
  Result := Result.Remove(Result.Length - LineBreak.Length, LineBreak.Length);
end;

function TMemoLines.GetWidth: Single;
begin
  Result := FLayoutsWidth;
end;

function TMemoLines.GetXShift: Single;
var
  TextLayout: TTextLayout;
begin
  if FXShift < 0 then
    if FRenderLineFrom >= 0 then
      FXShift := TTextLayout(Objects[FRenderLineFrom]).TextRect.Left + FMemo.HScrollBarValue
    else
    begin
      TextLayout := CreateLayout('a');
      FXShift := TextLayout.TextRect.Left;
      FreeAndNil(TextLayout);
    end;
  Result := FXShift;
end;

procedure TMemoLines.InsertItem(Index: Integer; const S: string;
  AObject: TObject);
var
  Layout: TTextLayout;
  I: Integer;
  NeedLayoutUpdate: Boolean;
  LHeight, LLayoutsHeight: Single;
  LRenderLineTo: Integer;
  LP: TPointF;
  LayoutSize: TSizeF;
  LText: string;
begin
  LText := RemoveUnprintableCharacters(S);
  Layout := CreateLayout(LText);
  LayoutSize.Create(Layout.Width, Layout.Height);
  if UpdateCount = 0 then
  begin
    FLayoutsHeight := FLayoutsHeight + LayoutSize.Height;
    FLayoutsWidth := Max(FLayoutsWidth, LayoutSize.Width);
    LLayoutsHeight := FLayoutsHeight;
  end
  else
  begin
    LLayoutsHeight := 0;
    if Count > 0 then
      for I := FRenderLineFrom to FRenderLineTo do
        LLayoutsHeight := LLayoutsHeight + FLinesSize[I].Height;
    LLayoutsHeight := LLayoutsHeight + LayoutSize.Height;
  end;
  NeedLayoutUpdate := False;
  if Count = 0 then
  begin
    FRenderLineFrom := 0;
    FRenderLineTo := 0;
    if csLoading in FMemo.ComponentState then
      LP.Create(0, 0)
    else
      LP.Create(-FMemo.HScrollBarValue, -FMemo.VScrollBarValue);
    NeedLayoutUpdate := True;
    FLayoutsHeight := LayoutSize.Height;
  end
  else
    if (Index >= FRenderLineFrom) and (Index <= FRenderLineTo) then
    begin
      LP := TTextLayout(Objects[FRenderLineFrom]).TopLeft;
      //Checking can we expand render borders
      LHeight := 0;
      for I := FRenderLineFrom to Index - 1 do
        LHeight := LHeight + FLinesSize[I].Height;
      LHeight := LHeight + LayoutSize.Height;
      LRenderLineTo := FRenderLineTo;
      for I := Index to FRenderLineTo do
        if LHeight > FMemo.ContentRect.Height then
        begin
          LRenderLineTo := I - 1;
          Break;
        end
        else
          LHeight := LHeight + FLinesSize[I].Height;
      if LRenderLineTo <> FRenderLineTo then
      begin
        for I := (LRenderLineTo + 1) to FRenderLineTo do
        begin
          {$IFNDEF NEXTGEN}
          Objects[I].Free;
          {$ENDIF}
          Objects[I] := nil;
        end;
        FRenderLineTo := LRenderLineTo + 1;
      end
      else
        Inc(FRenderLineTo);
      NeedLayoutUpdate := True;
    end
    else
      if (Index = (FRenderLineTo + 1)) and (LLayoutsHeight < FMemo.ContentRect.Height) then
      begin
        LP := TTextLayout(Objects[FRenderLineFrom]).TopLeft;
        Inc(FRenderLineTo);
        NeedLayoutUpdate := True;
      end
      else
      begin
        if Index < FRenderLineFrom then
        begin
          //Text inserted before render area, so we need to shift bounds
          Inc(FRenderLineFrom);
          Inc(FRenderLineTo);
        end;
        FreeAndNil(Layout);
      end;
  FLinesSize.Insert(Index, LayoutSize);
  inherited InsertItem(Index, LText, Layout);
  FMemo.FNeedChange := True;
  DoInsert(Index, LayoutSize.Height);
  if NeedLayoutUpdate then
  begin
    for I := FRenderLineFrom to FRenderLineTo do
    begin
      TTextLayout(Objects[I]).TopLeft := LP;
      LP.Offset(0, TTextLayout(Objects[I]).Height);
    end;
  end;
  if (UpdateCount = 0) then
    DoSizeChange;
end;

procedure TMemoLines.Put(Index: Integer; const S: string);
var
  Layout: TTextLayout;
  LengthIncreased: Boolean;

  procedure ChangeSize;
  var
    LHeight, LWidth: Single;
    I: Integer;
    LP: TPointF;
  begin
    if UpdateCount = 0 then
    begin
      if FLinesSize[Index].Height <> Layout.Height then
      begin
        LP := Layout.TopLeft;
        LP.Offset(0, Layout.Height);
        for I := Index + 1 to FRenderLineTo do
        begin
          TTextLayout(Objects[I]).TopLeft := LP;
          LP.Offset(0, TTextLayout(Objects[I]).Height);
        end;
      end;
      LHeight := FLayoutsHeight;
      LWidth := FLayoutsWidth;
      FLayoutsHeight := FLayoutsHeight - FLinesSize[Index].Height;
      FLinesSize[Index] := TSizeF.Create(Layout.Width, Layout.Height);
      FLayoutsHeight := FLayoutsHeight + FLinesSize[Index].Height;
      if LengthIncreased then
        FLayoutsWidth := Max(FLayoutsWidth, Layout.Width)
      else
        GetLayoutsWidth;
      if (LHeight <> FLayoutsHeight) or (LWidth <> FLayoutsWidth) then
        DoSizeChange;
    end
    else
      FLinesSize[Index] := TSizeF.Create(Layout.Width, Layout.Height);
  end;

var
  LText: string;
begin
  LText := RemoveUnprintableCharacters(S);
  LengthIncreased := (Index >=0) and (Index < Count) and
                     (Strings[Index].Length < LText.Length);
  inherited;
  if Assigned(Objects[Index]) then
  begin
    Layout := TTextLayout(Objects[Index]);
    Layout.Text := LText;
    ChangeSize;
  end
  else
  begin
    Layout := CreateLayout(LText);
    ChangeSize;
    FreeAndNil(Layout);
  end;
  FMemo.FNeedChange := True;
end;

procedure TMemoLines.Realign;
var
  StartPoint, P: TPointF;
  I: Integer;
  Layout: TTextLayout;
  Changed: Boolean;
begin
  if (FRenderLineFrom = -1) or (Count = 0) then
    Exit;

  StartPoint := TTextLayout(Objects[FRenderLineFrom]).TopLeft;
  for I := FRenderLineFrom to FRenderLineTo do
  begin
    {$IFNDEF NEXTGEN}
    Objects[I].Free;
    {$ENDIF}
    Objects[I] := nil;
  end;
  //
  Changed := False;
  //Grow bottom
  P := StartPoint;
  FRenderLineTo := FRenderLineFrom;
  while FRenderLineTo < Count do
    if P.Y <= FMemo.ContentRect.Height then
    begin
      Layout := CreateLayout(Strings[FRenderLineTo]);
      Layout.TopLeft := P;
      FLayoutsHeight := FLayoutsHeight - FLinesSize[FRenderLineTo].Height;
      FLinesSize[FRenderLineTo] := TSizeF.Create(Layout.Width, Layout.Height);
      FLayoutsHeight := FLayoutsHeight + FLinesSize[FRenderLineTo].Height;
      P.Offset(0, Layout.Height);
      Objects[FRenderLineTo] := Layout;
      if P.Y <= FMemo.ContentRect.Height then
        Inc(FRenderLineTo);
      Changed := True;
    end
    else
      Break;
  FRenderLineTo := Min(FRenderLineTo, Count - 1);
  //Grow top
  P := StartPoint;
  while FRenderLineFrom > 0 do
    if P.Y > 0 then
    begin
      Layout := CreateLayout(Strings[FRenderLineFrom - 1]);
      Layout.TopLeft := P;
      FLayoutsHeight := FLayoutsHeight - FLinesSize[FRenderLineFrom].Height;
      FLinesSize[FRenderLineFrom] := TSizeF.Create(Layout.Width, Layout.Height);
      FLayoutsHeight := FLayoutsHeight + FLinesSize[FRenderLineFrom].Height;
      P.Offset(0, -Layout.Height);
      Objects[FRenderLineFrom - 1] := Layout;
      if P.Y > 0 then
        Dec(FRenderLineFrom);
      Changed := True;
    end
    else
      Break;
  FRenderLineFrom := Max(FRenderLineFrom, 0);
  //
  for I := 0 to FRenderLineFrom - 1 do
  begin
    Layout := CreateLayout(Strings[I]);
    FLayoutsHeight := FLayoutsHeight - FLinesSize[I].Height;
    FLinesSize[I] := TSizeF.Create(Layout.Width, Layout.Height);
    FLayoutsHeight := FLayoutsHeight + FLinesSize[I].Height;
    FreeAndNil(Layout);
  end;
  for I := FRenderLineTo + 1 to Count - 1 do
  begin
    Layout := CreateLayout(Strings[I]);
    FLayoutsHeight := FLayoutsHeight - FLinesSize[I].Height;
    FLinesSize[I] := TSizeF.Create(Layout.Width, Layout.Height);
    FLayoutsHeight := FLayoutsHeight + FLinesSize[I].Height;
    FreeAndNil(Layout);
  end;
  //
  if not Changed then
  begin
    P.Create(0, 0);
    for I := FRenderLineFrom to FRenderLineTo do
    begin
      Layout := TTextLayout(Objects[I]);
      if not Assigned(Layout) then
      begin
        Layout := CreateLayout(Strings[I]);
        Objects[I] := Layout;
        FLayoutsHeight := FLayoutsHeight - FLinesSize[I].Height;
        FLinesSize[I] := TSizeF.Create(Layout.Width, Layout.Height);
        FLayoutsHeight := FLayoutsHeight + FLinesSize[I].Height;
      end;
      Layout.TopLeft := P;
      P.Offset(0, Layout.Height);
    end;
    GetLayoutsWidth;
  end;
end;

procedure TMemoLines.ScrollToLine(const ALine: Integer);
var
  P: TPointF;
  I, Index: Integer;
  Layout: TTextLayout;
  MaxHeight: Single;
  LRegion: TRegion;
begin
  if (ALine < 0) or (ALine >= Count) then
    Exit;

  P := TTextLayout(Objects[FRenderLineFrom]).TopLeft;
  if ALine < FRenderLineFrom then
  begin
    //Moving up
    P.Create(-FMemo.HScrollBarValue, 0);
    //Top line, shifting only by last subline height
    if not Assigned(Objects[ALine]) then
    begin
      Layout := CreateLayout(Strings[ALine]);
      Objects[ALine] := Layout;
    end
    else
      Layout := TTextLayout(Objects[ALine]);
    LRegion := Layout.RegionForRange(TTextRange.Create(Layout.Text.Length - 1, 1));
    if Length(LRegion) > 0 then
    begin
      P.Offset(0, -LRegion[0].Top);
      Layout.TopLeft := P;
      P.Offset(0, Layout.Height);
      //
      Index := ALine + 1;
      MaxHeight := FMemo.ContentRect.Height;
      while (Index < Count) and (P.Y < MaxHeight) do
      begin
        if not Assigned(Objects[Index]) then
        begin
          Layout := CreateLayout(Strings[Index]);
          Objects[Index] := Layout;
        end
        else
          Layout := TTextLayout(Objects[Index]);
        Layout.TopLeft := P;
        P.Offset(0, Layout.Height);
        Inc(Index);
      end;
      for I := Index to FRenderLineTo do
      begin
        {$IFNDEF NEXTGEN}
        Objects[I].Free;
        {$ENDIF}
        Objects[I] := nil;
      end;
      //
      FRenderLineFrom := ALine;
      FRenderLineTo := Index - 1;
    end
    else
    begin
      FreeAndNil(Layout);
      Objects[ALine] := nil;
    end;
  end
  else
    if ALine > FRenderLineTo then
    begin
      //Moving down
      P.Create(-FMemo.HScrollBarValue, FMemo.ContentRect.Height);
      //Bottom line, shifting only by first subline height
      if not Assigned(Objects[ALine]) then
      begin
        Layout := CreateLayout(Strings[ALine]);
        Objects[ALine] := Layout;
      end
      else
        Layout := TTextLayout(Objects[ALine]);
      LRegion := Layout.RegionForRange(TTextRange.Create(0, 1));
      if Length(LRegion) > 0 then
      begin
        P.Offset(0, -LRegion[0].Bottom);
        Layout.TopLeft := P;
        //
        Index := ALine - 1;
        while (Index >= 0) and (P.Y > 0) do
        begin
          if not Assigned(Objects[Index]) then
          begin
            Layout := CreateLayout(Strings[Index]);
            Objects[Index] := Layout;
          end
          else
            Layout := TTextLayout(Objects[Index]);
          P.Offset(0, -Layout.Height);
          Layout.TopLeft := P;
          Dec(Index);
        end;
        for I := FRenderLineFrom to Index do
        begin
          {$IFNDEF NEXTGEN}
          Objects[I].Free;
          {$ENDIF}
          Objects[I] := nil;
        end;
        //
        FRenderLineFrom := Index + 1;
        FRenderLineTo := ALine;
      end
      else
      begin
        FreeAndNil(Layout);
        Objects[ALine] := nil;
      end;
    end;
end;

procedure TMemoLines.SetTextStr(const Value: string);
var
  LText: string;
begin
  FMemo.FNeedChange := FMemo.FNeedChange or (Count > 0);
  LText := Value;
  if LText.EndsWith(sLineBreak) and (LText <> sLineBreak) then
    LText := LText + sLineBreak;
  inherited SetTextStr(LText);
  if Count = 0 then
  begin
    FRenderLineFrom := -1;
    FRenderLineTo := -1;
  end;
  FMemo.DoChange;
end;

procedure TMemoLines.SetUpdateState(Updating: Boolean);
var
  LWidth, LHeight: Single;
  I: Integer;
  LP: TPointF;
begin
  inherited;
  if not Updating then
  begin
    if FRenderLineFrom >= 0 then
    begin
      LP := TTextLayout(Objects[FRenderLineFrom]).TopLeft;
      for I := FRenderLineFrom to FRenderLineTo do
      begin
        TTextLayout(Objects[I]).TopLeft := LP;
        LP.Offset(0, TTextLayout(Objects[I]).Height);
      end;
    end;
    LWidth := FLayoutsWidth;
    LHeight := FLayoutsHeight;
    GetLayoutsWidth;
    FLayoutsHeight := 0;
    for I := 0 to FLinesSize.Count - 1 do
      FLayoutsHeight := FLayoutsHeight + FLinesSize[i].Height;
    if (LHeight <> FLayoutsHeight) or (LWidth <> FLayoutsWidth) then
      DoSizeChange;
  end;
end;

procedure TMemoLines.UpdateLayoutsProperties;
var
  I: Integer;
  Layout: TTextLayout;
  LP: TPointF;
  LSize: TSizeF;
  SizeChanged: Boolean;
begin
  if (Count = 0) or (UpdateCount > 0) then
    Exit;

  SizeChanged := False;
  if FRenderLineFrom >= 0 then
    LP := TTextLayout(Objects[FRenderLineFrom]).TopLeft;
  for I := 0 to Count - 1 do
    if (I >= FRenderLineFrom) and (I <= FRenderLineTo) then
    begin
      Layout := TTextLayout(Objects[I]);
      Layout.BeginUpdate;
      try
        UpdateLayoutParams(Layout);
        Layout.TopLeft := LP;
      finally
        Layout.EndUpdate;
      end;
      LP.Offset(0, Layout.Height);
      LSize := TSizeF.Create(Layout.Width, Layout.Height);
      SizeChanged := SizeChanged or (LSize <> FLinesSize[I]);
      FLayoutsHeight := FLayoutsHeight - FLinesSize[I].Height;
      FLinesSize[I] := LSize;
      FLayoutsHeight := FLayoutsHeight + FLinesSize[I].Height;
    end
    else
    begin
      if Assigned(Objects[I]) then
        Layout := TTextLayout(Objects[I])
      else
        Layout := CreateLayout(Strings[I]);
      try
        Layout.BeginUpdate;
        try
          UpdateLayoutParams(Layout);
        finally
          Layout.EndUpdate;
        end;
        LSize := TSizeF.Create(Layout.Width, Layout.Height);
        SizeChanged := SizeChanged or (LSize <> FLinesSize[I]);
        FLayoutsHeight := FLayoutsHeight - FLinesSize[I].Height;
        FLinesSize[I] := LSize;
        FLayoutsHeight := FLayoutsHeight + FLinesSize[I].Height;
      finally
        Layout.Free;
        Objects[I] := nil;
      end;
    end;
  if SizeChanged then
  begin
    GetLayoutsWidth;
    DoSizeChange;
  end;
end;

procedure TMemoLines.UpdateLayoutsColor;
var
  I: Integer;
begin
  if Count = 0 then
    Exit;

  for I := FRenderLineFrom to FRenderLineTo do
  begin
    TTextLayout(Objects[I]).Opacity := FMemo.AbsoluteOpacity;
    TTextLayout(Objects[I]).Color := FMemo.FLastTextSettings.FontColor;
  end;
end;

type
  TMemoSettings = class (TTextSettings)
  private
    FMemo: TMemo;
  protected
    procedure DoChanged; override;
  public
    constructor Create(const AOwner: TPersistent); override;
    property Memo: TMemo read FMemo;
  end;

{ TMemoSettings }

constructor TMemoSettings.Create(const AOwner: TPersistent);
begin
  inherited;
  if AOwner is TMemo then
    FMemo := TMemo(AOwner);
end;

procedure TMemoSettings.DoChanged;
begin
  if Assigned(FMemo) then
    FMemo.DoChanged;
  inherited;
end;


{ TMemo }

constructor TMemo.Create(AOwner: TComponent);
var
  PlatformTextService: IFMXTextService;
begin
  inherited Create(AOwner);
  FNeedChange := True;
  EnableExecuteAction := False;
  FIsDisableDesign := True;
  FTextSettings := TMemoSettings.Create(self);
  FDefaultTextSettings := TTextSettings.Create(self);
  FLastTextSettings := TTextSettings.Create(self);
  FStyledSettings := DefaultStyledSettings;

  if TPlatformServices.Current.SupportsPlatformService(IFMXTextService, IInterface(PlatformTextService)) then
    FTextService := PlatformTextService.GetTextServiceClass.Create(Self, True);

  TPlatformServices.Current.SupportsPlatformService(ILoupeService, IInterface(FLoupeService));

  FSelectionFill := TBrush.Create(TBrushKind.bkSolid, $802A8ADF);
  FCursorFill := TBrush.Create(TBrushKind.bkSolid, FontColor);

  FLines := TMemoLines.Create;
  TMemoLines(FLines).OnInsert := TextLineInserted;
  TMemoLines(FLines).OnSizeChange := TextBoxSizeChanged;
  FKeyboardType := TVirtualKeyboardType.vktDefault;
  (FLines as TMemoLines).FMemo := Self;
  CanFocus := True;
  Cursor := crIBeam;

  CreatePopupMenu;

  FActionStack := TEditActionStack.Create(Self);

  FAutoSelect := False;
  FCharCase := TEditCharCase.ecNormal;
  FHideSelection := True;
  FMaxLength := 0;
  FReadOnly := False;

  FLMouseSelecting := False;
  FOldMPt := PointF(0, 0);

  FCaretPosition.Line := 0;
  FCaretPosition.Pos := 0;

  FTextService.ImeMode := TImeMode.imDontCare;

  FSelStart := ComposeCaretPos(0, 0);
  FSelEnd := ComposeCaretPos(0, 0);
  FSelected := False;

  AutoCapture := True;

  Width := 100;
  SetAcceptsControls(False);
  FOldRect.Create(0, 0, 0, 0);
  //Timer to start scrolling when selecting text and cursor is out of content
  FStartAutoScrollTimer := TTimer.Create(Self);
  FStartAutoScrollTimer.Enabled := False;
  FStartAutoScrollTimer.Interval := 500;
  FStartAutoScrollTimer.OnTimer := StartAutoScrollHandler;
  FAutoVScrollTimer := TTimer.Create(Self);
  FAutoVScrollTimer.Interval := 100;
  FAutoVScrollTimer.Enabled := False;
  FAutoHScrollTimer := TTimer.Create(Self);
  FAutoHScrollTimer.Interval := 100;
  FAutoHScrollTimer.Enabled := False;
  FCaret := CreateCaret;
end;

type
  TOpenCaret = class(TCaret)

  end;

function TMemo.CreateCaret: TCaret;
begin
  Result := TCaret.Create(Self);
  Result.Visible := True;
  Result.ReadOnly := ReadOnly;
end;

function TMemo.GetCaret: TCustomCaret;
begin
  Result := FCaret;
end;

procedure TMemo.SetCaret(const Value: TCaret);
begin
  if Assigned(Caret) then
    Caret.Assign(Value);
end;

procedure TMemo.ShowCaret;
begin
  TOpenCaret(Caret).Show;
end;

procedure TMemo.HideCaret;
begin
  TOpenCaret(Caret).Hide;
end;

destructor TMemo.Destroy;
begin
  FLoupeService := nil;
  FreeAndNil(FSelectionFill);
  FreeAndNil(FCursorFill);
  FreeAndNil(FActionStack);
  FreeAndNil(FCaret);
{$IFNDEF NOVCL}
  FreeAndNil(FMemoPopupMenu);
{$ENDIF}
  FreeAndNil(FLines);
  FreeAndNil(FTextService);

  FreeAndNil(FTextSettings);
  FreeAndNil(FDefaultTextSettings);
  FreeAndNil(FLastTextSettings);
  inherited;
end;

function TMemo.GetData: TValue;
begin
  Result := Text;
end;

procedure TMemo.SetData(const Value: TValue);
begin
  Text := Value.ToString;
end;

procedure TMemo.DoEnter;
begin
  inherited;
  FNeedChange := False;
  UpdateCaretPosition(False);
  if AutoSelect then
    SelectAll;
end;

procedure TMemo.DoExit;
begin
  DoChange;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    TLinkObservers.EditLinkUpdate(Observers);
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueUpdate(Observers);
  inherited;
  UpdateSelectionPointPositions;
end;

function TMemo.GetPositionPoint(ACaretPos: TCaretPosition): TPointF;
var
  Region: TRegion;
begin
  Region := TMemoLines(FLines).GetRegionForRange(ACaretPos.Line, ACaretPos.Pos,
    1);
  if Length(Region) > 0 then
  begin
    Result := Region[0].TopLeft;
    Result.Offset(HScrollBarValue, VScrollBarValue);
  end
  else
    Result := PointF(TMemoLines(FLines).XShift, 0);
end;

procedure TMemo.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
var
  TmpS: string;
  OldCaretPosition, LCaret: TCaretPosition;
  WasSelection, IsCtrlOrCmd: Boolean;
  LTmpOptions: TInsertOptions;
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
  begin
    if (Key = vkBack) or (Key = vkDelete) or ((Key = vkInsert) and (ssShift in Shift)) then
      if TLinkObservers.EditLinkEdit(Observers) then
        TLinkObservers.EditLinkModified(Observers)
      else
      begin
        TLinkObservers.EditLinkReset(Observers);
        Exit;
      end;

    if (KeyChar >= #32) and
      not TLinkObservers.EditLinkIsValidChar(Observers, KeyChar) then
    begin
      KeyChar := #0;
      Exit;
    end;
    case KeyChar of
      ^H, ^V, ^X, #32..High(Char):
        if not TLinkObservers.EditLinkEdit(Observers) then
        begin
          KeyChar := #0;
          TLinkObservers.EditLinkReset(Observers);
          Exit;
        end
        else
          TLinkObservers.EditLinkModified(Observers);
      #27:
        begin
          TLinkObservers.EditLinkReset(Observers);
          SelectAll;
          KeyChar := #0;
          Exit;
        end;
    end;
  end;

  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    if KeyChar <> #0 then
      TLinkObservers.ControlValueModified(Observers);

  inherited KeyDown(Key, KeyChar, Shift);
  OldCaretPosition := CaretPosition;
  if Key = vkReturn then
  begin
    WasSelection := SelLength > 0;
    if WasSelection then
      DeleteFrom(GetSelBeg, SelLength,
        [TDeleteOption.doMoveCaret, TDeleteOption.doCanUndo] { True,True, False } );
    if WasSelection then
      LTmpOptions := [TInsertOption.ioUndoPairedWithPrev]
    else
      LTmpOptions := [];
    TmpS := sLineBreak;
    InsertAfter(CaretPosition, TmpS, LTmpOptions + [TInsertOption.ioMoveCaret, TInsertOption.ioCanUndo]
      { False, True, True, WasSelection } );
    SelLength := 0;
    Key := 0;
    DoChange;
  end;
  IsCtrlOrCmd := (Shift = [ssCtrl]) or (Shift = [ssCommand]);
  case Key of
    Ord('A'):
      if IsCtrlOrCmd then
        SelectAll;
    Ord('C'):
      if IsCtrlOrCmd then
        CopyToClipboard;
    Ord('V'):
      if IsCtrlOrCmd then
        PasteFromClipboard;
    Ord('X'):
      if IsCtrlOrCmd and not ReadOnly then
        CutToClipboard;
    Ord('Z'):
      if IsCtrlOrCmd then
        UnDo;
    vkEnd:
      if IsCtrlOrCmd then
        GoToTextEnd
      else
        GotoLineEnd;
    vkHome:
      if IsCtrlOrCmd then
        GoToTextBegin
      else
        GoToLineBegin;
    vkLeft:
      if IsCtrlOrCmd then
        CaretPosition := GetPrevWordBegin(CaretPosition)
      else
        MoveCaretLeft;
    vkRight:
      if IsCtrlOrCmd then
        CaretPosition := GetNextWordBegin(CaretPosition)
      else
        MoveCaretRight;
    vkUp:
      if IsCtrlOrCmd then
        DoScroll(-1)
      else
        MoveCaretUp;
    vkDown:
      if IsCtrlOrCmd then
        DoScroll(1)
      else
        MoveCaretDown;
    vkPrior:
      MoveCaretPageUp;
    vkNext:
      MoveCaretPageDown;
    vkDelete:
      if not ReadOnly then
      begin
        if SelLength <> 0 then
        begin
          if ssShift in Shift then
            CutToClipboard
          else
            DeleteSelection;
        end
        else
          if IsCtrlOrCmd then
          begin
            DeleteFrom(CaretPosition, FMX.Text.GetNextLexemeBegin(FLines[CaretPosition.Line], CaretPosition.Pos) - CaretPosition.Pos, [TDeleteOption.doMoveCaret, TDeleteOption.doCanUndo])
          end
          else
            DeleteFrom(CaretPosition, 1, [TDeleteOption.doMoveCaret, TDeleteOption.doCanUndo]);
      end;
    vkBack:
      if not ReadOnly then
      begin
        if SelLength <> 0 then
          DeleteSelection
        else
          if IsCtrlOrCmd then
          begin
            //Deleting whole word
            LCaret := GetPrevWordBegin(CaretPosition);
            if (LCaret.Line < 0) or (LCaret.Pos < 0) then
              Exit;
            DeleteFrom(LCaret, PosToTextPos(CaretPosition) - PosToTextPos(LCaret),
              [TDeleteOption.doMoveCaret, TDeleteOption.doCanUndo]);
          end
          else
            //Deleting single character
            if PosToTextPos(CaretPosition) > 0 then
              DeleteFrom(GetPositionShift(CaretPosition, -1), 1,
                [TDeleteOption.doMoveCaret, TDeleteOption.doCanUndo]);
      end;
    vkInsert:
      if IsCtrlOrCmd then
        CopyToClipboard
      else
        if Shift = [ssShift] then
          PasteFromClipboard;
  end;

  if (Ord(KeyChar) >= 32) and (KeyChar <> #0) and not ReadOnly then
  begin
    WasSelection := SelLength > 0;
    if WasSelection then
      DeleteFrom(GetSelBeg, SelLength,
        [TDeleteOption.doMoveCaret, TDeleteOption.doCanUndo] { True,True, False } );
    if WasSelection then
      LTmpOptions := [TInsertOption.ioUndoPairedWithPrev]
    else
      LTmpOptions := [];
    if KeyChar <> #13 then
    begin
      InsertAfter(CaretPosition, KeyChar, LTmpOptions + [TInsertOption.ioMoveCaret, TInsertOption.ioCanUndo]
        { False, True, True, WasSelection } );
    end;
    SelLength := 0;
    KeyChar := #0;
  end
  else
    if (Key in [vkEnd, vkHome, vkLeft, vkRight, vkUp, vkDown, vkPrior, vkNext]) then
    begin
      if ssShift in Shift then
      begin
        if not FSelected then
          SelectAtPos(OldCaretPosition);
        SelectAtPos(CaretPosition);
        RepaintEdit;
      end
      else
        if FSelected then
        begin
          FSelected := False;
          RepaintEdit;
        end;
    end;
  UpdateCaretPosition(True);
  UpdateSelectionPointPositions;
end;

procedure TMemo.LongTap(const X, Y: Single);
begin
  if (not (csDesigning in ComponentState)) and (not IsFocused) then
    SetFocus;
  FLMouseSelecting := False;
  FFollowTheMouse := True;
  FSelected := False;
  Caret.Visible := True;
  PutCaretTo(X, Y);
  UpdateSelectionPointPositions;

  if Assigned(FLoupeService) then
  begin
    FLoupeService.SetLoupeMode(TLoupeMode.lmCircle);
    SetLoupePosition(X, Y);
    ShowLoupe;
  end;
end;

function TMemo.GetCanFocus: Boolean;
begin
  Result := (inherited GetCanFocus) and (not FSetFocusOnUp);
end;

procedure TMemo.MouseDown(Button: TMouseButton; Shift: TShiftState; x, y: Single);
begin
  FSetFocusOnUp := ([ssDouble, ssTouch] * Shift) = [ssTouch];
  inherited;
  FDownMPt := PointF(x, y);
  FOldMPt := PointF(x, y);
  if (Shift * [ssTouch]) = [] then
    //Not a touch UI
    if Button = TMouseButton.mbLeft then
    begin
      if ssDouble in Shift then
      begin
        FLMouseSelecting := False;
        SelectWord;
      end
      else
      begin
        FLMouseSelecting := True;
        FSelected := False;
        PutCaretTo(x, y);
      end;
    end;
end;

procedure TMemo.DoChangeTracking;
begin
  if Assigned(FOnChangeTracking) then
    FOnChangeTracking(Self);
end;

procedure TMemo.DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);

  procedure DrawSelection(const ARegion: TRegion);
  var
    RectLine: TRectF;
    I: Integer;
  begin
    for I := Low(ARegion) to High(ARegion) do
    begin
      RectLine := ARegion[I];
                                                                                                                                                                 
      {$IFDEF IOS}
      if (Length(ARegion) > 1) and (I <> High(ARegion)) then
        RectLine.Right := FContent.Width;
      {$ENDIF}
      Canvas.FillRect(RectLine, 0, 0, [], 1, FSelectionFill);
    end;
  end;

  procedure DrawLeftAndRightSelectionSide(const ARegion: TRegion);
  var
    SelectionRect: TRectF;
    HalfCaretWidth: Single;
    SideRect: TRectF;
  begin
    if Length(ARegion) <= 0 then
      Exit;

    HalfCaretWidth := Caret.Flasher.Size.Width / 2;
    FCursorFill.Color := Caret.Flasher.Color;
    // Draw Left selection side
    SelectionRect := ARegion[0];
    SideRect := RectF(SelectionRect.Left - HalfCaretWidth, SelectionRect.Top,
                      SelectionRect.Left + HalfCaretWidth, SelectionRect.Bottom);
    Canvas.FillRect(SideRect, 0, 0, AllCorners, AbsoluteOpacity, FCursorFill);
    // Draw Right selection side
    SelectionRect := ARegion[High(ARegion)];
    SideRect := RectF(SelectionRect.Right - HalfCaretWidth, SelectionRect.Top,
                      SelectionRect.Right + HalfCaretWidth, SelectionRect.Bottom);
    Canvas.FillRect(SideRect, 0, 0, AllCorners, AbsoluteOpacity, FCursorFill);
  end;

var
  TmpRect: TRectF;
  Rng: TRegion;
  State: TCanvasSaveState;
  I: Integer;
begin
  State := Canvas.SaveState;
  try
    Canvas.IntersectClipRect(ARect);
    //text
    if (FLines.Count > 0) and (TMemoLines(FLines).RenderLineFrom >= 0) then
      if FTextService.HasMarkedText then
      begin
        Canvas.Fill.Color := FLastTextSettings.FontColor;
        for I := TMemoLines(FLines).RenderLineFrom to TMemoLines(FLines).RenderLineTo do
          if I = FTextService.CaretPosition.Y then
          begin
            TmpRect := TRectF.Create(
              TTextLayout(FLines.Objects[I]).TopLeft,
              TTextLayout(FLines.Objects[I]).MaxSize
            );
            FTextService.DrawSingleLine(Canvas,
              TmpRect, 1, FLastTextSettings.Font, AbsoluteOpacity,
              FillTextFlags, TextAlign, TTextAlign.taLeading, WordWrap)
          end
          else
            TTextLayout(FLines.Objects[I]).RenderLayout(Canvas)
      end
      else
        for I := TMemoLines(FLines).RenderLineFrom to TMemoLines(FLines).RenderLineTo do
          TTextLayout(FLines.Objects[I]).RenderLayout(Canvas);
    // selection
    if FSelected and GetShowSelection and (SelLength > 0) then
    begin
      Rng := GetSelectionRegion;
      DrawSelection(Rng);
      if HaveSelectionPickers then
        DrawLeftAndRightSelectionSide(Rng);
    end;
  finally
    Canvas.RestoreState(State);
  end;
end;

procedure TMemo.ScrollLayout(const AVertialScroll: Single);
var
  I: Integer;
  P: TPointF;
begin
  if TMemoLines(FLines).RenderLineFrom = -1 then
    TMemoLines(FLines).ScrollToLine(0)
  else
    if (TMemoLines(FLines).RenderLineFrom >= 0) then
    begin
      P.Create(-HScrollBarValue, TTextLayout(FLines.Objects[TMemoLines(FLines).RenderLineFrom]).TopLeft.Y - AVertialScroll);
      for I := TMemoLines(FLines).RenderLineFrom to TMemoLines(FLines).RenderLineTo do
      begin
        TTextLayout(FLines.Objects[I]).TopLeft := P;
        P.Offset(0, TTextLayout(FLines.Objects[I]).Height);
      end;
      UpdateSelectionPointPositions;
    end;
end;

procedure TMemo.ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                       const ContentSizeChanged: boolean);
var
  ScrollToUp: Integer;
begin
  inherited;
  if not FLockVerticalScroll then
  try
    ScrollToUp := System.Math.CompareValue(OldViewportPosition.Y, NewViewportPosition.Y, Epsilon);
    if FLines.Count > 0 then
      ScrollLayout(NewViewportPosition.Y - FLastVScrollBarValue);
    if FLines.Count > 0 then
    begin
      if ScrollToUp = 1 then
        TMemoLines(FLines).CheckScrollUp
      else
        if ScrollToUp = -1 then
          TMemoLines(FLines).CheckScrollDown;
    end;
  finally
    FLastVScrollBarValue := NewViewportPosition.Y;
  end;
end;

procedure TMemo.AniMouseDown(const Touch: Boolean; const X, Y: Single);
begin
  if Touch then
    inherited;
end;

procedure TMemo.AniMouseMove(const Touch: Boolean; const X, Y: Single);
begin
  if Touch then
    inherited;
end;

procedure TMemo.AniMouseUp(const Touch: Boolean; const X, Y: Single);
begin
  if Touch then
    inherited;
end;

procedure TMemo.ApplyStyle;
var
  T: TFmxObject;
begin
  FTextSettings.BeginUpdate;
  try
    FIsDisableDesign := True;
    inherited;
    T := FindStyleResource('content');
    if Assigned(T) and (T is TControl) then
    begin
      FContent := TControl(T);
      FContent.OnPaint := DoContentPaint;
    end;
    T := FindStyleResource('selection');
    if Assigned(T) and (T is TBrushObject) then
      FSelectionFill.Assign(TBrushObject(T).Brush);
    // Default Text settings
    T := FindStyleResource('foreground');
    // apply the font fill style only if the user hasn't changed the font fill anteriorly
    if Assigned(T) and
       (T is TBrushObject) then
      FDefaultTextSettings.FontColor := TBrushObject(T).Brush.Color;
    T := FindStyleResource('font');
    if Assigned(T) and
       Supports(T, IFontObject) and
       (not Font.IsSizeStored) then
      FDefaultTextSettings.Font := (T as IFontObject).Font;
    FDefaultTextSettings.HorzAlign := TTextAlign.taLeading;
    // Caret Color
    T := FindStyleResource('caretcolor');
    if Assigned(T) and (T is TColorObject) then
      TOpenCaret(Caret).SetDefaultColor((T as TColorObject).Color)
    else
      TOpenCaret(Caret).SetDefaultColor(TAlphaColorRec.Null);
    // Load selection points
    T := FindStyleResource('leftselectionpoint');
    if Assigned(T) and (T is TSelectionPoint) then
    begin
      FLeftSelPt := T as TSelectionPoint;
      FLeftSelPt.OnTrack := DoLeftSelPtChangePosition;
      FLeftSelPt.OnMouseUp := DoSelPtMouseUp;
      FLeftSelPt.OnMouseDown := DoLeftSelPtMouseDown;
      FLeftSelPt.Visible := False;
    end;
    T := FindStyleResource('rightselectionpoint');
    if Assigned(T) and (T is TSelectionPoint) then
    begin
      FRightSelPt := T as TSelectionPoint;
      FRightSelPt.OnTrack := DoRightSelPtChangePosition;
      FRightSelPt.OnMouseUp := DoSelPtMouseUp;
      FRightSelPt.OnMouseDown := DoRightSelPtMouseDown;
      FRightSelPt.Visible := False;
    end;
    FTextSettings.Change;
  finally
    FTextSettings.EndUpdate;
    FIsDisableDesign := False;
  end;
end;

procedure TMemo.RepaintEdit;
begin
  if Assigned(FContent) then
    FContent.Repaint;
end;

procedure TMemo.Replace(const APos, ALength: Integer; const AStr: string);
begin
  DeleteFrom(TextPosToPos(APos), ALength, []);
  InsertAfter(TextPosToPos(APos), AStr, [TInsertOption.ioMoveCaret]);
end;

procedure TMemo.ResetSelection;
begin
  SelLength := 0;
end;

procedure TMemo.UpdateHScrlBarByCaretPos;
var
  LEdiTRect: TRectF;
  LRegion: TRegion;
begin
  if (Lines.Count <= 0) {and (not FTextService.HasMarkedText)} then
    Exit;
  if not Assigned(Canvas) then
    Exit;

  LRegion := TMemoLines(FLines).GetRegionForRange(CaretPosition.Line,
    CaretPosition.Pos, 1);
  if Length(LRegion) > 0 then
  begin
    LRegion[0].Offset(Caret.Flasher.Size.Width, 0);
    LEdiTRect := ContentRect;
    if LRegion[0].Left > ContentRect.Width then
      HScrollBar.Value := HScrollBarValue + (LRegion[0].Left - ContentRect.Width)
    else
      if LRegion[0].Left < 0 then
        HScrollBar.Value := 0;
  end;
end;

procedure TMemo.MouseMove(Shift: TShiftState; x, y: Single);
begin
  if not FFollowTheMouse then
    inherited;
  FOldMPt := PointF(x, y);
  if FLMouseSelecting or FFollowTheMouse then
  begin
    if FFollowTheMouse then
    begin
      FLMouseSelecting := False;
      FSelected := False;
      if Assigned(FLoupeService) then
      begin
        FLoupeService.SetLoupeMode(TLoupeMode.lmCircle);
        SetLoupePosition(X, Y);
        ShowLoupe;
      end;
    end;
    PutCaretTo(x, y, FLMouseSelecting);
    UpdateSelectionPointPositions;
    StartAutoScroll(x, y);
  end;
end;

procedure TMemo.MouseUp(Button: TMouseButton; Shift: TShiftState; x, y: Single);
begin
  inherited;
  if FSetFocusOnUp and (not AniCalculations.Moved) then
  begin
    FSetFocusOnUp := False;
    if (not (csDesigning in ComponentState)) and (not IsFocused) then
      SetFocus;
  end;
  if FFollowTheMouse then
    FTextService.EndSelection;
  if (Shift * [ssTouch]) = [] then
  begin
    //Not a touch UI
    FLMouseSelecting := False;
    if SelLength = 0 then
      FSelected := False;
  end
  else
  begin
    //It's a touch UI
    if FDownMPt = FOldMPt then
    begin
      //if position was not changed - acivating caret
      Caret.Visible := True;
      FLMouseSelecting := False;
      FSelected := False;
      //
      PutCaretTo(x, y, True, True);
    end;
    FFollowTheMouse := False;
  end;
  StopAutoScroll;
  HideLoupe;
  UpdateSelectionPointPositions;
end;

procedure TMemo.CopyToClipboard;
var
  ClipService: IFMXClipboardService;
begin
  if FSelected and
     TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(ClipService)) then
    ClipService.SetClipboard(SelText);
end;

procedure TMemo.PasteFromClipboard;
var
  WasSelection: Boolean;
  ClipService: IFMXClipboardService;
  LCaret: TCaretPosition;
  ST: TStrings;
  I: Integer;
begin
  if ReadOnly then
    Exit;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if not TLinkObservers.EditLinkEdit(Observers) then
    begin
      TLinkObservers.EditLinkReset(Observers);
      Exit;
    end
    else
      TLinkObservers.EditLinkModified(Observers);

  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueModified(Observers);

  if not TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(ClipService)) then
    Exit;
  Self.BeginUpdate;
  try
    WasSelection := SelLength > 0;
    if WasSelection then
    begin
      DeleteFrom(GetSelBeg, SelLength, [TDeleteOption.doCanUndo]);
      LCaret := GetSelBeg;
    end
    else
      LCaret := CaretPosition;
    ST := TStringList.Create;
    try
      ST.Text := ClipService.GetClipboard.ToString;
      for I := 0 to ST.Count - 1 do
      begin
        InsertAfter(LCaret, ST[I], [TInsertOption.ioCanUndo, TInsertOption.ioUndoPairedWithPrev]);
        Inc(LCaret.Pos, ST[I].Length);
        if I < ST.Count - 1 then
        begin
          InsertAfter(LCaret, sLineBreak, [TInsertOption.ioCanUndo, TInsertOption.ioUndoPairedWithPrev]);
          LCaret.Pos := 0;
          Inc(LCaret.Line);
        end;
      end;
      CaretPosition := LCaret;
    finally
      FreeAndNil(ST);
    end;
    FNeedChange := True;
    DoChange;
  finally
    Self.EndUpdate;
  end;
end;

procedure TMemo.CreatePopupMenu;
var
  LMenuItem: TMenuItem;
begin
  FMemoPopupMenu := TPopupMenu.Create(Self);
  FMemoPopupMenu.Stored := False;
  FMemoPopupMenu.Parent := Self;

  LMenuItem := TMenuItem.Create(FMemoPopupMenu);
  LMenuItem.Parent := FMemoPopupMenu;
  LMenuItem.Text := SEditCut;
  LMenuItem.StyleName := 'cut';
  LMenuItem.OnClick := DoCut;

  LMenuItem := TMenuItem.Create(FMemoPopupMenu);
  LMenuItem.Parent := FMemoPopupMenu;
  LMenuItem.Text := SEditCopy;
  LMenuItem.StyleName := 'copy';
  LMenuItem.OnClick := DoCopy;

  LMenuItem := TMenuItem.Create(FMemoPopupMenu);
  LMenuItem.Parent := FMemoPopupMenu;
  LMenuItem.Text := SEditPaste;
  LMenuItem.StyleName := 'paste';
  LMenuItem.OnClick := DoPaste;

  LMenuItem := TMenuItem.Create(FMemoPopupMenu);
  LMenuItem.Parent := FMemoPopupMenu;
  LMenuItem.Text := SEditDelete;
  LMenuItem.StyleName := 'delete';
  LMenuItem.OnClick := DoDelete;

  LMenuItem := TMenuItem.Create(FMemoPopupMenu);
  LMenuItem.Parent := FMemoPopupMenu;
  LMenuItem.Text := '-';

  LMenuItem := TMenuItem.Create(FMemoPopupMenu);
  LMenuItem.Parent := FMemoPopupMenu;
  LMenuItem.Text := SEditSelectAll;
  LMenuItem.StyleName := 'selectall';
  LMenuItem.OnClick := DoSelectAll;
end;

procedure TMemo.DoCut(Sender: TObject);
begin
  CutToClipboard;
end;

procedure TMemo.DoCopy(Sender: TObject);
begin
  CopyToClipboard;
end;

procedure TMemo.DoDelete(Sender: TObject);
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if not TLinkObservers.EditLinkEdit(Observers) then
    begin
      TLinkObservers.EditLinkReset(Observers);
      Exit;
    end
    else
      TLinkObservers.EditLinkModified(Observers);

  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueModified(Observers);

  DeleteSelection;
end;

procedure TMemo.DoPaste(Sender: TObject);
begin
  PasteFromClipboard;
end;

procedure TMemo.DoRealign;
var
  LRect: TRectF;
  Again: Boolean;
  LHeight: Single;
begin
  inherited;
  Again := False;
  LRect.Create(Position.X, Position.Y,
    Position.X + ContentRect.Width, Position.Y + ContentRect.Height);
  if LRect <> FOldRect then
  begin
    LHeight := TMemoLines(FLines).Height;
    TMemoLines(FLines).Realign;
    Again := TMemoLines(FLines).Height <> LHeight;
    FOldRect := LRect;
  end;
  if Again then
    inherited;
end;

procedure TMemo.UpdatePopupMenuItems;
var
  SelTextEmpty: Boolean;
  ClipService: IFMXClipboardService;

  procedure SetParam(AParamName : string; AValue : Boolean) ;
  var
    LMI : TMenuItem;
  begin
    LMI := TMenuItem(FMemoPopupMenu.FindStyleResource(AParamName));
    if Assigned(LMI) then
      LMI.Enabled := AValue ;
  end;

begin
  SelTextEmpty := SelText <> '';
  SetParam('cut', SelTextEmpty and not ReadOnly);
  SetParam('copy', SelTextEmpty);
  SetParam('paste',
    TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(ClipService))
    and (not ClipService.GetClipboard.IsEmpty) and (not ReadOnly));
  SetParam('delete', SelTextEmpty and not ReadOnly);
  SetParam('selectall', SelText <> Text);
end;

procedure TMemo.UpdateSelectionPointPositions;

  function GetLeftSelectionPointPos: TPointF;
  var
    Region: TRegion;
  begin
    Region := GetSelectionRegion;
    if Length(Region) > 0 then
      Result := Region[Low(Region)].TopLeft
    else
      Result := GetPositionPoint(CaretPosition);
    Result.Y := Result.Y - 2 * FLeftSelPt.GripSize;
    Result := Result + ContentRect.TopLeft;
  end;

  function GetRightSelectionPointPos: TPointF;
  var
    Region: TRegion;
  begin
    Region := GetSelectionRegion;
    if Length(Region) > 0 then
      Result := Region[High(Region)].BottomRight
    else
      Result := GetPositionPoint(CaretPosition);

    Result.Y := Result.Y + 2 * FRightSelPt.GripSize;
    Result := Result + ContentRect.TopLeft;
  end;

  function GetVisibleLeftPoint: Boolean;
  var
    RegionStart: TCaretPosition;
    LP: TPointF;
    Region: TRegion;
    SelStartTmp: TCaretPosition;
    SelEndTmp: TCaretPosition;
  begin
    Region := GetSelectionRegion;
    Result := FSelected and GetShowSelection and (SelLength > 0) and (Length(Region) > 0);
    if Length(Region) > 0 then
    begin
      LP := Region[0].TopLeft;
      LP.Offset(0, GetLineHeight / 2);
      RegionStart := TMemoLines(FLines).GetPointPosition(LP);
      GetNormalizedSelectionRange(SelStartTmp, SelEndTmp);
      if SelStartTmp < RegionStart then
        Result := False
      else
        Result := Result and (LP.Y > ContentRect.Top) and (0 <= LP.X) and (LP.X <= ContentRect.Width);
    end;
  end;

  function GetVisibleRightPoint: Boolean;
  var
    RegionEnd: TCaretPosition;
    LP: TPointF;
    Region: TRegion;
    SelEndTmp: TCaretPosition;
    SelStartTmp: TCaretPosition;
  begin
    Region := GetSelectionRegion;
    Result := FSelected and GetShowSelection and (SelLength > 0) and (Length(Region) > 0);
    if Length(Region) > 0 then
    begin
      LP := Region[High(Region)].BottomRight;
      LP.Offset(0, -GetLineHeight / 2);
      RegionEnd := TMemoLines(FLines).GetPointPosition(LP);
      GetNormalizedSelectionRange(SelStartTmp, SelEndTmp);
      if SelEndTmp > RegionEnd then
        Result := False
      else
        Result := Result and (LP.Y < ContentRect.Height) and (0 <= LP.X) and (LP.X <= ContentRect.Width);
    end;
  end;

begin
  if not HaveSelectionPickers then
    Exit;

  Caret.TemporarilyHidden := FSelected and (SelLength > 0);

  FLeftSelPt.Visible := GetVisibleLeftPoint;
  FRightSelPt.Visible := GetVisibleRightPoint;
  FLeftSelPt.Position.Point := GetLeftSelectionPointPos;
  FRightSelPt.Position.Point := GetRightSelectionPointPos;
end;

function TMemo.GetNextWordBegin(StartPosition: TCaretPosition): TCaretPosition;
var
  CurPos: Integer;
  CurLine: Integer;
begin
  CurPos := StartPosition.Pos;
  CurLine := StartPosition.Line;

  if FLines.Count > 0 then
    if StartPosition.Pos < FLines[StartPosition.Line].Length then
      CurPos := FMX.Text.GetNextLexemeBegin(FLines[CurLine], CurPos)
    else
      if StartPosition.Line < Lines.Count - 1 then
      begin
        Inc(CurLine);
        CurPos := 0;
      end;

  Result.Line := CurLine;
  Result.Pos := CurPos;
end;

function TMemo.GetPrevWordBegin(StartPosition: TCaretPosition): TCaretPosition;
var
  CurPos: Integer;
  CurLine: Integer;
begin
  CurPos := StartPosition.Pos;
  CurLine := StartPosition.Line;

  if FLines.Count > 0 then
    if StartPosition.Pos > 0 then
      CurPos := FMx.Text.GetPrevLexemeBegin(FLines[CurLine], CurPos)
    else
      if (StartPosition.Line - 1 >= 0) and
        (StartPosition.Line - 1 <= Lines.Count - 1) then
      begin
        CurLine := CurLine - 1;
        CurPos := FLines[CurLine].Length;
      end;

  Result.Line := CurLine;
  Result.Pos := CurPos;
end;

function TMemo.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

procedure TMemo.DeleteSelection;
begin
  if not ReadOnly then
    DeleteFrom(GetSelBeg, SelLength, [TDeleteOption.doMoveCaret, TDeleteOption.doCanUndo]);
end;

procedure TMemo.CutToClipboard;
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if not TLinkObservers.EditLinkEdit(Observers) then
    begin
      TLinkObservers.EditLinkReset(Observers);
      Exit;
    end
    else
      TLinkObservers.EditLinkModified(Observers);

  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueModified(Observers);

  CopyToClipboard;
  DeleteSelection;
end;


procedure TMemo.SelectAll;
begin
  FSelStart := ComposeCaretPos(0, 0);
  FSelEnd.Line := FLines.Count;
  if FSelEnd.Line = 0 then
    FSelEnd.Pos := 0
  else
  begin
    Dec(FSelEnd.Line);
    FSelEnd.Pos := FLines[FSelEnd.Line].Length;
  end;
  FSelected := True;
  GoToTextEnd;
  UpdateSelectionPointPositions;
  RepaintEdit;
end;

procedure TMemo.DoScroll(ADirection: Integer);
var
  LLineHeight : Single;
begin
  if (Self.Lines.Count > 0) and VScrollBar.Visible then
  begin
    LLineHeight := VScrollBar.Value / Self.Lines.Count;
    VScrollBar.Value := VScrollBar.Value + ADirection * LLineHeight;
    if VScrollBar.Value <0 then
      VScrollBar.Value := 0;
    if VScrollBar.Value > VScrollBar.Max then
      VScrollBar.Value := VScrollBar.Max;
  end;
end;

procedure TMemo.DoSelectAll(Sender: TObject);
begin
  SelectAll;
end;

procedure TMemo.DoSelPtMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  StopAutoScroll;
  EndSelection;
end;

procedure TMemo.EndIMEInput;
begin
  if FLines.Count > 0 then
    CaretPosition := ComposeCaretPos(CaretPosition.Line,
      Min(CaretPosition.Pos, FLines[CaretPosition.Line].Length));
end;

procedure TMemo.EndSelection;
begin
  HideLoupe;
  FTextService.EndSelection;
end;

procedure TMemo.AutoScrollDownHandler(Sender: TObject);
begin
  if CaretPosition.Line >= (FLines.Count - 1) then
  begin
    FAutoVScrollTimer.Enabled := False;
    Exit;
  end;
  CaretPosition := ComposeCaretPos(CaretPosition.Line + 1, CaretPosition.Pos);
  SelectAtPos(CaretPosition);  
  UpdateSelectionPointPositions;
end;

procedure TMemo.AutoScrollLeftHandler(Sender: TObject);
begin
  if CaretPosition.Pos >= 0 then
  begin
    FAutoHScrollTimer.Enabled := False;
    Exit;
  end;
  CaretPosition := ComposeCaretPos(CaretPosition.Line, CaretPosition.Pos - 1);
  SelectAtPos(CaretPosition);
  UpdateSelectionPointPositions;
end;

procedure TMemo.AutoScrollRightHandler(Sender: TObject);
begin
  if CaretPosition.Pos >= FLines[CaretPosition.Line].Length then
  begin
    FAutoHScrollTimer.Enabled := False;
    Exit;
  end;
  CaretPosition := ComposeCaretPos(CaretPosition.Line, CaretPosition.Pos + 1);
  SelectAtPos(CaretPosition);
  UpdateSelectionPointPositions;
end;

procedure TMemo.AutoScrollUpHandler(Sender: TObject);
begin
  if CaretPosition.Line <= 0 then
  begin
    FAutoVScrollTimer.Enabled := False;
    Exit;
  end;
  CaretPosition := ComposeCaretPos(CaretPosition.Line - 1, CaretPosition.Pos);
  SelectAtPos(CaretPosition);
  UpdateSelectionPointPositions;
end;

procedure TMemo.BeginSelection;
begin
  if Assigned(FLoupeService) then
    FLoupeService.SetLoupeMode(TLoupeMode.lmRectangle);
  FTextService.BeginSelection;
end;

procedure TMemo.BeginUpdate;
begin
  inherited;
  FLines.BeginUpdate;
end;

procedure TMemo.EndUpdate;
begin
  FLines.EndUpdate;
  inherited;
end;

function TMemo.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
  NewHeight := round(GetLineHeight + ContentRect.Top * 2);
end;

procedure TMemo.SelectWord;
var
  IndexEndingWord: Integer;
  IndexBeginingWord: Integer;
begin
  if FLines.Count = 0 then
    Exit;

  FindWordBound(FLines[CaretPosition.Line], CaretPosition.Pos, IndexBeginingWord, IndexEndingWord);
  FSelStart := ComposeCaretPos(CaretPosition.Line, IndexBeginingWord);
  FSelEnd := ComposeCaretPos(CaretPosition.Line, IndexEndingWord);
  FSelEnd.Pos := Min(FLines[CaretPosition.Line].Length, FSelEnd.Pos + 1);
  FSelected := True;
  UpdateSelectionPointPositions;
  RepaintEdit;
end;

procedure TMemo.DoChange;
begin
  if FNeedChange then
  begin
    FNeedChange := False;
    if not (csLoading in ComponentState) then
    begin
      if FLines.Count = 0 then
        FLastVScrollBarValue := 0;
      if Assigned(FOnChange) then
        FOnChange(Self);
    end;
  end;
end;

{$REGION 'ITextSettings'}

procedure TMemo.DoChanged;
var
  Tmp: TTextSettings;
begin
  if ([csDesigning, csLoading] * ComponentState = [csDesigning]) and
     (not FIsDisableDesign) then
    UpdateStyleSettings(FTextSettings,
                        FLastTextSettings,
                        FDefaultTextSettings,
                        FStyledSettings);
  FLastTextSettings.BeginUpdate;
  try
    Tmp := TTextSettings.Create(nil);
    try
      Tmp.Assign(FDefaultTextSettings);
      Tmp.AssignNoStyled(FTextSettings, FStyledSettings);
      FLastTextSettings.Assign(Tmp);
    finally
      FreeAndNil(Tmp);
    end;
    if FLastTextSettings.IsAdjustChanged then
      FLineHeignt := 0;
    if ((FLastTextSettings.IsChanged) or
       (FLastTextSettings.IsAdjustChanged)) and
       (not (csLoading in ComponentState)) then
    begin
      if FLastTextSettings.IsChanged then
      begin
        TMemoLines(FLines).UpdateLayoutsColor;
      end;
      if FLastTextSettings.IsAdjustChanged then
      begin
        TMemoLines(FLines).UpdateLayoutsProperties;
      end;
      UpdateCaretPosition(False);
      RepaintEdit;
    end;
  finally
    FIsDisableDesign := False;
    FLastTextSettings.EndUpdate;
  end;
end;

function TMemo.GetDefaultTextSettings: TTextSettings;
begin
  Result := FDefaultTextSettings;
end;

function TMemo.GetFont: TFont;
begin
  Result := FTextSettings.Font;
end;

procedure TMemo.SetFont(const Value: TFont);
begin
  FTextSettings.Font.Assign(Value);
end;

function TMemo.GetFontColor: TAlphaColor;
begin
  Result := FTextSettings.FontColor;
end;

procedure TMemo.SetFontColor(const Value: TAlphaColor);
begin
  FTextSettings.FontColor := Value;
end;

function TMemo.GetWordWrap: Boolean;
begin
  Result := FTextSettings.WordWrap;
end;

procedure TMemo.SetWordWrap(const Value: Boolean);
begin
  FTextSettings.WordWrap := Value;
end;

function TMemo.GetTextAlign: TTextAlign;
begin
  Result := FTextSettings.HorzAlign;
end;

procedure TMemo.SetTextAlign(const Value: TTextAlign);
begin
  FTextSettings.HorzAlign := Value;
end;

function TMemo.GetTextSettings: TTextSettings;
begin
  Result := FTextSettings;
end;

procedure TMemo.SetTextSettings(const Value: TTextSettings);
begin
  FTextSettings.Assign(Value);
end;

function TMemo.GetStyledSettings: TStyledSettings;
begin
  Result := FStyledSettings;
end;

procedure TMemo.SetStyledSettings(const Value: TStyledSettings);
begin
  if FStyledSettings <> Value then
  begin
    FStyledSettings := Value;
    FIsDisableDesign := True;
    DoChanged;
  end;
end;

function TMemo.StyledSettingsStored: Boolean;
begin
  Result := FStyledSettings <> DefaultStyledSettings;
end;

{$ENDREGION}

procedure TMemo.DoLeftSelPtChangePosition(Sender: TObject; var X, Y: Single);

  procedure CalculateNewSelStart;
  var
    NewSelStart: TCaretPosition;
    SelStartTmp: TCaretPosition;
    SelEndTmp: TCaretPosition;
  begin
    NewSelStart := (FLines as TMemoLines).GetPointPosition(PointF(X, Y + FLeftSelPt.GripSize * 2));
    GetNormalizedSelectionRange(SelStartTmp, SelEndTmp);
    if NewSelStart < SelEndTmp then
      SelStartTmp := NewSelStart
    else
    begin
      SelStartTmp := SelEndTmp;
      if SelStartTmp.Pos > 0 then
        SelStartTmp.Pos := SelStartTmp.Pos - 1
      else
      begin
        Inc(SelStartTmp.Line, -1);
        SelStartTmp.Pos := FLines[SelStartTmp.Line].Length - 1;
      end;
    end;
    SetNormalizedSelectionRange(SelStartTmp, SelEndTmp);
  end;

  procedure UpdateLeftPointPosition;
  var
    PointTmp: TPointF;
    Region: TRegion;
    SelEndTmp: TCaretPosition;
    SelStartTmp: TCaretPosition;
  begin
    GetNormalizedSelectionRange(SelStartTmp, SelEndTmp);
    Region := TMemoLines(FLines).GetRegionForRange(SelStartTmp.Line, SelStartTmp.Pos, 1);
    if Length(Region) > 0 then
      PointTmp := Region[0].TopLeft
    else
      PointTmp := PointF(0, 0);
    X := PointTmp.X + ContentRect.Left;
    Y := PointTmp.Y - 2 * FLeftSelPt.GripSize + ContentRect.Top;
  end;

begin
  CalculateNewSelStart;
  UpdateLeftPointPosition;
  RepaintEdit;
  StartAutoScroll(X, Y);
  SetLoupePosition(TSelectionPointType.sptLeft);
end;

procedure TMemo.DoLeftSelPtMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  BeginSelection;
  SetLoupePosition(TSelectionPointType.sptLeft);
  ShowLoupe;
end;

procedure TMemo.DoRightSelPtChangePosition(Sender: TObject; var X, Y: Single);

  procedure CalculateNewSelEnd;
  var
    NewSelEnd: TCaretPosition;
    SelStartTmp: TCaretPosition;
    SelEndTmp: TCaretPosition;
  begin
    NewSelEnd := (FLines as TMemoLines).GetPointPosition(PointF(X, Y - 2 * FLeftSelPt.GripSize));
    GetNormalizedSelectionRange(SelStartTmp, SelEndTmp);
    if NewSelEnd > SelStartTmp then
      SelEndTmp := NewSelEnd;
    if (SelEndTmp.Pos = 0) and (SelEndTmp.Line > 0) then
    begin
      Inc(SelEndTmp.Line, -1);
      SelEndTmp.Pos := FLines[SelEndTmp.Line].Length;
    end;
    SetNormalizedSelectionRange(SelStartTmp, SelEndTmp);
  end;

  procedure UpdateRightPointPosition;
  var
    PointTmp: TPointF;
    Region: TRegion;
    SelStartTmp: TCaretPosition;
    SelEndTmp: TCaretPosition;
  begin
    GetNormalizedSelectionRange(SelStartTmp, SelEndTmp);

    Region := TMemoLines(FLines).GetRegionForRange(SelEndTmp.Line, SelEndTmp.Pos, 1);
    if Length(Region) > 0 then
      PointTmp := Region[0].TopLeft
    else
      PointTmp := PointF(0, 0);
    X := PointTmp.X + ContentRect.Left;
    Y := PointTmp.Y + GetLineHeight + 2 * FRightSelPt.GripSize + ContentRect.Top;
  end;

begin
  CalculateNewSelEnd;
  UpdateRightPointPosition;
  RepaintEdit;
  StartAutoScroll(X, Y);
  SetLoupePosition(TSelectionPointType.sptRight);
end;

procedure TMemo.DoRightSelPtMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  BeginSelection;
  SetLoupePosition(TSelectionPointType.sptRight);
  ShowLoupe;
end;

procedure TMemo.ClearSelection;
begin
  DeleteSelection;
end;

procedure TMemo.ContextMenu(const ScreenPosition: TPointF);
begin
  inherited;
  if csDesigning in ComponentState then
    Exit;
  if Not Assigned(PopupMenu) then
  begin
    UpdatePopupMenuItems;
    FMemoPopupMenu.PopupComponent := Self;
    FMemoPopupMenu.Popup(round(ScreenPosition.X), round(ScreenPosition.Y));
  end;
end;

procedure TMemo.FreeStyle;
begin
  inherited;
  FContent := nil;
  FLeftSelPt := nil;
  FRightSelPt := nil;
end;

function TMemo.GetText: string;
begin
  Result := FLines.Text;
end;

procedure TMemo.SetText(const Value: string);
begin
  if not ValidText(Value) then
    Exit;

  if Value <> Text then
  begin
    FLines.Text := Value;
    DoChangeTracking;
    RealignContent;
    CaretPosition := TMemoLines(FLines).GetPointPosition(GetPositionPoint(CaretPosition));
  end;
end;

procedure TMemo.SetCaretPosition(const Value: TCaretPosition);
begin
  if (FCaretPosition.Line = Value.Line) and (FCaretPosition.Pos = Value.Pos) then
    Exit;

  if (Value.Line < 0) or (Value.Pos < 0) then
    FCaretPosition := ComposeCaretPos(0, 0)
  else
  begin
    FCaretPosition := Value;
    if FCaretPosition.Line > Lines.Count - 1 then
    begin
      FCaretPosition.Line := Lines.Count;
      if Lines.Count > 0 then
        FCaretPosition.Pos := Lines[FCaretPosition.Line].Length
      else
        FCaretPosition.Pos := 0;
    end;

    if (Lines.Count > 0) and
       (FCaretPosition.Pos > Lines[FCaretPosition.Line].Length) then
      FCaretPosition.Pos := Lines[FCaretPosition.Line].Length ;
  end;

  UpdateCaretPosition(True);
  RepaintEdit;
end;

procedure TMemo.SetNormalizedSelectionRange(const ASelStart, ASelEnd: TCaretPosition);
begin
  if FSelStart <= FSelEnd then
  begin
    FSelStart := ASelStart;
    FSelEnd := ASelEnd;
  end
  else
  begin
    FSelStart := ASelEnd;
    FSelEnd := ASelStart;
  end;
end;

procedure TMemo.SetSelLength(const Value: Integer);
begin
  FSelected := Value > 0;
  FSelEnd := TextPosToPos(PosToTextPos(FSelStart) + Value);
  UpdateSelectionPointPositions;
  RepaintEdit;
end;

procedure TMemo.SetSelStart(const Value: Integer);
begin
  FSelStart := TextPosToPos(Value);
  CaretPosition := FSelStart;
  SelLength := 0;
end;

procedure TMemo.SetAutoSelect(const Value: Boolean);
begin
  if FAutoSelect <> Value then
    FAutoSelect := Value;
end;

function TMemo.GetSelStart: Integer;
begin
  if FSelected then
    Result := PosToTextPos(GetSelBeg)
  else
    Result := PosToTextPos(CaretPosition);
end;

function TMemo.GetSelLength: Integer;
var
  EndPos: TCaretPosition;
begin
  if FSelected then
  begin
    EndPos := GetSelEnd;
    Result := PosToTextPos(EndPos) - PosToTextPos(GetSelBeg);
  end
  else
    Result := 0;
end;

procedure TMemo.ReadFontFillColor(Reader: TReader);
var
  LFontColor: TAlphaColor;
begin
  IdentToAlphaColor(Reader.ReadIdent, Longint(LFontColor));
  FontColor := LFontColor;
end;

procedure TMemo.ReadFontFillKind(Reader: TReader);
begin
  Reader.ReadIdent;
end;

procedure TMemo.ReadTextData(Reader: TReader);
begin
  Text := Reader.ReadString;
end;

procedure TMemo.RecalcOpacity;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    TMemoLines(FLines).UpdateLayoutsColor;
    UpdateCaretPosition(False);
    RepaintEdit;
  end;
end;

procedure TMemo.GetNormalizedSelectionRange(var ASelStart, ASelEnd: TCaretPosition);
begin
  if FSelStart <= FSelEnd then
  begin
    ASelStart := FSelStart;
    ASelEnd := FSelEnd;
  end
  else
  begin
    ASelStart := FSelEnd;
    ASelEnd := FSelStart;
  end;
end;

procedure TMemo.DblTap;
begin
  Caret.Visible := True;
  FLMouseSelecting := False;
  SelectWord;
  UpdateSelectionPointPositions;
end;

procedure TMemo.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Text', ReadTextData, nil, False);
  // Only for backward compatibility with XE2
  Filer.DefineProperty('FontFill.Color', ReadFontFillColor, nil, False);
  Filer.DefineProperty('FontFill.Kind', ReadFontFillKind, nil, False);
end;

function TMemo.GetSelText: string;
var
  LSelStart, LSelLength, Line, LLength: Integer;
  LText: string;
begin
  if FSelected then
  begin
    LText := EmptyStr;
    LSelStart := GetSelBeg.Pos;
    LSelLength := SelLength;
    Line := GetSelBeg.Line;
    while LSelLength > 0 do
    begin
      LLength := Min(LSelLength, FLines[Line].Length - LSelStart);
      LText := LText + FLines[Line].Substring(LSelStart, LSelLength);
      Dec(LSelLength, LLength);
      Inc(Line);
      if LSelLength > 0 then
      begin
        LText := LText + sLineBreak;
        LSelStart := 0;
        Dec(LSelLength);
      end;
    end;
    Result := LText;
  end
  else
    Result := '';
end;

procedure TMemo.SetCharCase(const Value: TEditCharCase);
var
  I: Integer;
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    for I := 0 to FLines.Count - 1 do
      case FCharCase of
        TEditCharCase.ecUpperCase:
          FLines[I] := FLines[I].ToUpperInvariant;
        TEditCharCase.ecLowerCase:
          FLines[I] := FLines[I].ToLowerInvariant;
      end;
    if FLines.Count > 0 then
      FTextService.Text := FLines[CaretPosition.Line];
    RepaintEdit;
  end;
end;

procedure TMemo.SetHideSelection(const Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    RepaintEdit;
  end;
end;

procedure TMemo.SetKeyboardType(Value: TVirtualKeyboardType);
begin
  FKeyboardType := Value;
end;

function TMemo.GetTextService: TTextService;
begin
  Result := FTextService;
end;

procedure TMemo.UpdateCaretPoint;
var
  LCaret: TCaretPosition;
begin
  LCaret := ComposeCaretPos(FTextService.TargetClausePosition.Y,
    FTextService.TargetClausePosition.X);
  if (LCaret.Line < 0) or (LCaret.Line >= FLines.Count) then
    LCaret.Line := 0;
  if FLines.Count = 0 then
  begin
    FLines.Insert(LCaret.Line, FTextService.CombinedText);
    CaretPosition := ComposeCaretPos(LCaret.Line, FTextService.CombinedText.Length);
  end
  else
    if FLines[LCaret.Line] <> FTextService.CombinedText then
    begin
      FLines[LCaret.Line] := FTextService.CombinedText;
      CaretPosition := LCaret;
    end
    else
      CaretPosition := LCaret;
end;

function TMemo.GetTargetClausePointF: TPointF;
var
  TmpPt: TPointF;
begin
  TmpPt := GetPositionPoint(ComposeCaretPos(FTextService.TargetClausePosition.Y,
    FTextService.TargetClausePosition.X));
  TmpPt.Offset(0, GetLineHeight + 2);// 2 is small space between conrol and IME window
  Result := LocalToAbsolute(TmpPt);
end;

function TMemo.GetImeMode: TImeMode;
begin
  Result := FTextService.ImeMode;
end;

procedure TMemo.SetImeMode(const Value: TImeMode);
begin
  if FTextService.ImeMode <> Value then
    FTextService.ImeMode := Value;
end;

procedure TMemo.SetMaxLength(const Value: Integer);
begin
  if FMaxLength <> Value then
  begin
    FMaxLength := Value;
  end;
end;

procedure TMemo.SetReadOnly(Value: Boolean);
begin
  FSaveReadOnly := Value;
  FReadOnly := Value;
  Caret.ReadOnly := FReadOnly;
end;

function TMemo.ValidText(const NewText: string): Boolean;
begin
  Result := True;
end;

procedure TMemo.UpdateCaretPosition(UpdateScrllBars: Boolean);
var
  TmpPt: TPointF;
begin
  if UpdateScrllBars and not (csLoading in ComponentState) then
  begin
    UpdateVScrlBarByCaretPos;
    UpdateHScrlBarByCaretPos;
  end;
  TmpPt := GetPositionPoint(CaretPosition);
  Caret.BeginUpdate;
  try
    Caret.Pos := TmpPt;
    Caret.Size := PointF(Caret.Size.cx, GetLineHeight);
  finally
    Caret.EndUpdate;
  end;
end;

procedure TMemo.InsertAfter(APosition: TCaretPosition; const S: string; Options: TInsertOptions);
var
  LText: string;
  Insertion: string;
  TmpS: string;
  R: Integer;
begin
  R := PosToTextPos(CaretPosition);
  LText := Text;
  case FCharCase of
    TEditCharCase.ecNormal:
      Insertion := S;
    TEditCharCase.ecUpperCase:
      Insertion := S.ToUpperInvariant;
    TEditCharCase.ecLowerCase:
      Insertion := S.ToLowerInvariant;
  end;
 
  if MaxLength > 0 then
    Insertion := Insertion.Substring(0, MaxLength - LText.Length);
 
  if Insertion.IsEmpty then
    Exit;
 
  if TInsertOption.ioCanUndo in Options then
    if Insertion = sLineBreak then
      FActionStack.FragmentInserted(PosToTextPos(APosition), 1,
        TInsertOption.ioUndoPairedWithPrev in Options)
    else
      FActionStack.FragmentInserted(PosToTextPos(APosition), Insertion.Length,
        TInsertOption.ioUndoPairedWithPrev in Options);

  if Insertion = sLineBreak then
  begin
    if APosition.Line >= FLines.Count then
    begin
      if FLines.Count = 0 then
        FLines.Insert(APosition.Line, EmptyStr);
      FLines.Insert(APosition.Line, EmptyStr);
    end
    else
    begin
      TmpS := FLines[APosition.Line].Substring(APosition.Pos, FLines[APosition.Line].Length);
      FLines[APosition.Line] := FLines[APosition.Line].Substring(0, APosition.Pos);
      FLines.Insert(APosition.Line + 1, TmpS);
    end;
  end
  else
    if APosition.Line >= FLines.Count then
    begin
      if APosition.Line > FLines.Count then
        FLines.Insert(FLines.Count, EmptyStr);
      FLines.Insert(APosition.Line, Insertion)
    end
    else
      FLines[APosition.Line] := FLines[APosition.Line].Insert(
        IfThen(FLines[APosition.Line].Length > 0, APosition.Pos, -1), Insertion);
  DoChangeTracking;
 
  if TInsertOption.ioSelected in Options then
  begin
    FSelStart := APosition;
    FSelEnd := GetPositionShift(APosition, Insertion.Length);
    FSelected := True;
    CaretPosition := FSelEnd;
  end
  else
  begin
    if not (csLoading in ComponentState) and (TInsertOption.ioMoveCaret in Options) then
    begin
      if Insertion = sLineBreak then
        CaretPosition := TextPosToPos(R + 1)
      else
        CaretPosition := TextPosToPos(R + Insertion.Length);
      UpdateCaretPosition(False);
    end;
  end;
 
  RealignContent;
end;

function TMemo.IsOpaque: Boolean;
begin
  Result := True;
end;

procedure TMemo.DeleteFrom(APosition: TCaretPosition; ALength: Integer;
  Options: TDeleteOptions);
var
  LText: string;
  TmpPos, TmpLength, TmpLine: Integer;
  TmpS: string;
begin
  if ((APosition.Line = (FLines.Count - 1)) and (APosition.Pos = FLines[FLines.Count - 1].Length))
     or (FLines.Count = 0) or (ALength = 0) then
    Exit;

  LText := Text;

  TmpLength := ALength;
  TmpPos := PosToTextPos(APosition);

  TmpS := LText.Substring(TmpPos, TmpLength);
  if (TDeleteOption.doCanUndo in Options) and (TmpLength > 0) then
    FActionStack.FragmentDeleted(TmpPos, TmpS);

  TMemoLines(FLines).BeginUpdate;
  TmpPos := APosition.Pos;
  TmpLine := APosition.Line;
  while ALength > 0 do
  begin
    TmpLength := Min(FLines[TmpLine].Length - TmpPos, ALength);
    Dec(ALength, TmpLength);
    if (TmpLength = 0) and (TmpPos = FLines[TmpLine].Length) and (TmpLine < (FLines.Count - 1)) then
    begin
      TmpS := FLines[TmpLine + 1];
      FLines.Delete(TmpLine + 1);
      FLines[TmpLine] := FLines[TmpLine] + TmpS;
      Dec(ALength);
    end
    else
    begin
      TmpS := FLines[TmpLine].Remove(TmpPos, TmpLength);
      if TmpS.IsEmpty and (ALength > 0) then
      begin
        FLines.Delete(TmpLine);
        Dec(ALength);
      end
      else
        if (TmpLine < (FLines.Count - 1)) and (ALength > 0) then
        begin
          FLines[TmpLine] := TmpS + FLines[TmpLine + 1];
          FLines.Delete(TmpLine + 1);
          Dec(ALength);
        end
        else
        begin
          FLines[TmpLine] := TmpS;
          Inc(TmpLine);
        end;
    end;
  end;
  TMemoLines(FLines).EndUpdate;
  DoChangeTracking;

  if (TDeleteOption.doMoveCaret in Options) or (SelLength <> 0) then
  begin
    FSelected := False;
    CaretPosition := APosition;
  end;

  RealignContent;
end;

procedure TMemo.DoUndo(Sender: TObject);
begin
  UnDo;
end;

procedure TMemo.UnDo;
begin
  FActionStack.RollBackAction;
end;

function TMemo.DoCalcContentBounds: TRectF;
var
  LHeight, LWidth, FlasherWidth: Single;
begin
  Result := inherited DoCalcContentBounds;
  LWidth := TMemoLines(FLines).XShift;
  if Lines.Count > 0 then
  begin
    LHeight := TMemoLines(FLines).Height;
    if not WordWrap then
      LWidth := TMemoLines(FLines).Width;
  end
  else
    LHeight := GetLineHeight;
  if Assigned(Caret) and Assigned(Caret.Flasher) then
    FlasherWidth := Caret.Flasher.Size.Width
  else
    FlasherWidth := 0;
  Result.Width := LWidth + Max(1, FlasherWidth);
  if LHeight > 0 then
    Result.Height := LHeight;
end;

procedure TMemo.SetLines(const Value: TStrings);
begin
  FLines.Assign(Value);
end;

procedure TMemo.SetLoupePosition(const ASelectionPointType: TSelectionPointType);

  function GetSelectionRect: TRectF;
  var
    SelStartTmp: TCaretPosition;
    SelEndTmp: TCaretPosition;
    Region: TRegion;
  begin
    GetNormalizedSelectionRange(SelStartTmp, SelEndTmp);
    case ASelectionPointType of
      TSelectionPointType.sptLeft:
      begin
        Region := TMemoLines(FLines).GetRegionForRange(SelStartTmp.Line, SelStartTmp.Pos, 1);
        if Length(Region) > 0 then
          Result := TRectF.Create(Region[0].TopLeft, Region[0].Width, Region[0].Height)
        else
          Result := TRectF.Create(0, 0, 0, 0);
      end;
      TSelectionPointType.sptRight:
      begin
        Region := TMemoLines(FLines).GetRegionForRange(SelEndTmp.Line, SelEndTmp.Pos, 1);
        if Length(Region) > 0 then
          Result := TRectF.Create(Region[0].TopLeft, Region[0].Width, Region[0].Height)
        else
          Result := TRectF.Create(0, 0, 0, 0);
      end;
    end;
  end;

var
  ZoomCenter: TPointF;
  LoupePos: TPointF;
  SelRect: TRectF;
begin
  SelRect := GetSelectionRect;
  if Assigned(FLoupeService) then
  begin
    case ASelectionPointType of
      TSelectionPointType.sptLeft:
      begin
        ZoomCenter := PointF(SelRect.Left, SelRect.Top + SelRect.Height / 2);
        LoupePos := SelRect.TopLeft + PointF(-FLoupeService.GetWidth / 2, -FLoupeService.GetHeight) + PointF(0, -LOUPE_OFFSET);
      end;
      TSelectionPointType.sptRight:
      begin
        ZoomCenter := PointF(SelRect.Right, SelRect.Top + SelRect.Height / 2);
        LoupePos := PointF(SelRect.Right, SelRect.Top) + PointF(-FLoupeService.GetWidth / 2, -FLoupeService.GetHeight) + PointF(0, -LOUPE_OFFSET);
      end;
    end;
    ZoomCenter := LocalToAbsolute(ZoomCenter);
    LoupePos := LocalToAbsolute(LoupePos);

    FLoupeService.SetZoomRegionCenter(ZoomCenter);
    FLoupeService.SetPosition(LoupePos);
  end;
end;

procedure TMemo.SetLoupePosition(const X, Y: Single);
var
  LoupePos: TPointF;
  ZoomPos: TPointF;
begin
  if Assigned(FLoupeService) then
  begin
    LoupePos := PointF(X - FLoupeService.GetWidth / 2, Y - FLoupeService.GetHeight);
    LoupePos := LocalToAbsolute(LoupePos);
    ZoomPos := LocalToAbsolute(PointF(X, Y));
    FLoupeService.SetZoomRegionCenter(ZoomPos);
    FLoupeService.SetPosition(LoupePos);
    ShowLoupe;
  end;
end;

procedure TMemo.TextBoxSizeChanged(Sender: TObject);
begin
  if FUpdating = 0 then
    RealignContent;
end;

procedure TMemo.TextLineInserted(Sender: TObject; LineIndex: Integer;
  LineHeight: Single);
begin
  if FUpdating = 0 then
  begin
    if LineIndex < TMemoLines(FLines).RenderLineFrom then
    begin
      RealignContent;
      FLockVerticalScroll := True;
      VScrollBar.Value := VScrollBarValue + LineHeight;
      FLastVScrollBarValue := VScrollBarValue;
      FLockVerticalScroll := False;
    end;
  end;
  FNeedChange := True;
end;

function TMemo.TextPosToPos(APos: Integer): TCaretPosition;
begin
  Result.Line := 0;
  Result.Pos := 0;

  if FLines.Count = 0 then
    Exit;

  while (APos > 0) and (Result.Line < FLines.Count) do
  begin
    if APos > FLines[Result.Line].Length then
    begin
      Dec(APos, FLines[Result.Line].Length + 1);
      Inc(Result.Line);
    end
    else
    begin
      if APos >= 0 then
        Result.Pos := APos
      else
        Result.Pos := FLines[Result.Line].Length;
      APos := 0;
    end;
  end;
  if Result.Line >= FLines.Count then
  begin
    Result.Line := FLines.Count - 1;
    Result.Pos := FLines[FLines.Count - 1].Length;
  end;
end;

procedure TMemo.MoveCaretLeft;
begin
  MoveCareteBy(-1);
end;

procedure TMemo.MoveCaretRight;
begin
  MoveCareteBy(1);
end;

procedure TMemo.MoveCareteBy(Delta: Integer);
begin
  CaretPosition := GetPositionShift(CaretPosition, Delta);
end;

function TMemo.GetLineHeight: Single;
begin
  if FLineHeignt <= 0 then
  begin
    TCanvasManager.MeasureCanvas.Font.Assign(FLastTextSettings.Font);
    FLineHeignt := Round(TCanvasManager.MeasureCanvas.TextHeight('Ply|'));
    //FLineHeignt := Round(FLastTextSettings.Font.Size * (1.25));
  end;
  Result := FLineHeignt;
end;

procedure TMemo.UpdateVScrlBarByCaretPos;
var
  LEdiTRect: TRectF;
  R: TRegion;
  BeforeHeight: Single;
  I: Integer;
  LPoint: TPointF;
begin
  if (Lines.Count <= 0) {and (not FTextService.HasMarkedText)} then
    Exit;
  if not Assigned(Canvas) then
    Exit;

  if (CaretPosition.Line >= TMemoLines(FLines).RenderLineFrom) and
     (CaretPosition.Line <= TMemoLines(FLines).RenderLineTo) then
  begin
    R := TMemoLines(FLines).GetRegionForRange(CaretPosition.Line,
      CaretPosition.Pos, 1);
    LEdiTRect := ContentRect;
    if Length(R) > 0 then
    begin
      LPoint := ViewportPosition;
      if R[0].Bottom > LEdiTRect.Height then
      begin
        LPoint.Y := LPoint.Y + (R[0].Bottom - LEdiTRect.Bottom);
        ViewportPosition := LPoint;
      end
      else if R[0].Top < 0 then
      begin
        LPoint.Y := LPoint.Y - Abs(R[0].Top);
        ViewportPosition := LPoint;
      end;
    end;
  end
  else
  begin
    FLockVerticalScroll := True;
    TMemoLines(FLines).ScrollToLine(CaretPosition.Line);
    BeforeHeight := 0;
    for I := 0 to TMemoLines(FLines).RenderLineFrom - 1 do
      BeforeHeight := BeforeHeight + TMemoLines(FLines).FLinesSize[I].Height;
    FLastVScrollBarValue := BeforeHeight +
      Abs(TTextLayout(FLines.Objects[TMemoLines(FLines).FRenderLineFrom]).TopLeft.Y);
    VScrollBar.Value := FLastVScrollBarValue;
    FLockVerticalScroll := False;
  end;
end;

procedure TMemo.ShowLoupe;
begin
  if Assigned(FLoupeService) then
  begin
    FLoupeService.SetLoupeScale(DEFAULT_LOUPE_SCALE);
    FLoupeService.ShowFor(Self);
  end;
end;

procedure TMemo.StartAutoScroll(const X, Y: Single);
begin
  FStartAutoScrollTimer.Enabled := False;
  FAutoVScrollTimer.Enabled := False;
  FAutoHScrollTimer.Enabled := False;
  FNeedAutoVScroll := False;
  FNeedAutoHScroll := False;
  if FLines.Count > 0 then
  begin
    if (Y < ContentRect.Top) or (Y > ContentRect.Bottom) then
    begin
      FNeedAutoVScroll := True;
      if Y < ContentRect.Top then
        FAutoVScrollTimer.OnTimer := AutoScrollUpHandler
      else
        FAutoVScrollTimer.OnTimer := AutoScrollDownHandler;
    end;
    if (X < ContentRect.Left) or (X > ContentRect.Right) then
    begin
      FNeedAutoHScroll := True;
      if X < ContentRect.Left then
        FAutoHScrollTimer.OnTimer := AutoScrollLeftHandler
      else
        FAutoHScrollTimer.OnTimer := AutoScrollRightHandler;
    end;
    FStartAutoScrollTimer.Enabled := FNeedAutoVScroll or FNeedAutoHScroll;
  end;
end;

procedure TMemo.StartAutoScrollHandler(Sender: TObject);
begin
  FStartAutoScrollTimer.Enabled := False;
  FAutoVScrollTimer.Enabled := FNeedAutoVScroll;
  FAutoHScrollTimer.Enabled := FNeedAutoHScroll;
end;

procedure TMemo.StartIMEInput;
begin
 if FLines.Count > 0 then
    FTextService.Text := FLines[CaretPosition.Line];
  FTextService.CaretPosition := Point(CaretPosition.Pos, CaretPosition.Line);
end;

procedure TMemo.StopAutoScroll;
begin
  FStartAutoScrollTimer.Enabled := False;
  FAutoVScrollTimer.Enabled := False;
  FAutoHScrollTimer.Enabled := False;
end;

function TMemo.GetPageSize: Single;
begin
  Result := (ContentRect.Bottom - ContentRect.Top) / GetLineHeight;
end;

function TMemo.PosToTextPos(APostion: TCaretPosition): Integer;
var
  I: Integer;
begin
  Result := 0;
  if FLines.Count = 0 then
    Exit;

  for I := 0 to Min(APostion.Line, FLines.Count) - 1 do
    Inc(Result, FLines[I].Length + 1);
  Inc(Result, APostion.Pos);
end;

procedure TMemo.PutCaretTo(X, Y: Single; Select: Boolean; PositionByWord: Boolean);
var
  R: TRectF;
begin
  R := ContentRect;
  X := Min(Max(X, R.Left), R.Right);
  Y := Min(Max(Y, R.Top), R.Bottom);
  CaretPosition := TMemoLines(FLines).GetPointPosition(PointF(X - R.Left, Y - R.Top), PositionByWord);
  if Select then
    SelectAtPos(CaretPosition);
end;

procedure TMemo.GoToTextEnd;
begin
  if Lines.Count = 0 then
  begin
    FCaretPosition.Line := 0;
    FCaretPosition.Pos := 0;
  end
  else
  begin
    FCaretPosition.Line := Lines.Count - 1;
    FCaretPosition.Pos := Lines[FCaretPosition.Line].Length;
  end;
  UpdateCaretPosition(True);
end;

function TMemo.HasText: Boolean;
begin
  Result := Text.Length > 0;
end;

function TMemo.HaveSelectionPickers: Boolean;
begin
  Result := Assigned(FLeftSelPt) and Assigned(FRightSelPt);
end;

procedure TMemo.HideLoupe;
begin
  if Assigned(FLoupeService) then
    FLoupeService.Hide;
end;

procedure TMemo.GoToTextBegin;
begin
  FCaretPosition.Line := 0;
  FCaretPosition.Pos := 0;
  UpdateCaretPosition(True);
end;

procedure TMemo.GoToLineEnd;
var
  LP: TPointF;
begin
  if FLines.Count = 0 then
    Exit;
  if (CaretPosition.Line < TMemoLines(FLines).RenderLineFrom) or
     (CaretPosition.Line > TMemoLines(FLines).RenderLineTo) then
    UpdateCaretPosition(True);
  LP.Create(TTextLayout(FLines.Objects[CaretPosition.Line]).TextRect.Right,
    Caret.Pos.Y - VScrollBarValue + GetLineHeight / 2);
  CaretPosition := TMemoLines(FLines).GetPointPosition(LP);
end;

procedure TMemo.GoToLineBegin;
var
  LP: TPointF;
begin
  if FLines.Count = 0 then
    Exit;
  if (CaretPosition.Line < TMemoLines(FLines).RenderLineFrom) or
     (CaretPosition.Line > TMemoLines(FLines).RenderLineTo) then
    UpdateCaretPosition(True);
  LP.Create(TMemoLines(FLines).XShift - HScrollBarValue,
    Caret.Pos.Y - VScrollBarValue + GetLineHeight / 2);
  CaretPosition := TMemoLines(FLines).GetPointPosition(LP);
end;

function TMemo.GetSelBeg: TCaretPosition;
begin
  if FSelStart.Line < FSelEnd.Line then
    Result := FSelStart
  else
    if FSelEnd.Line < FSelStart.Line then
      Result := FSelEnd
    else
      if FSelStart.Pos < FSelEnd.Pos then
        Result := FSelStart
      else
        Result := FSelEnd;
end;

function TMemo.GetSelectionRect: TRectF;
var
  TmpRect, R: TRectF;
  Region: TRegion;
  I: Integer;
  TmpPt: TPointF;
begin
  Region := TMemoLines(FLines).GetRegionForRange(CaretPosition.Line, CaretPosition.Pos,
    1);
  if Length(Region) > 0 then
    TmpPt := Region[0].TopLeft
  else
    TmpPt := ContentRect.TopLeft;
  Result := TRectF.Create(TmpPt, 1, GetLineHeight);
  if FSelected and GetShowSelection and (SelLength > 0) then
  begin
    Region := GetSelectionRegion;
    if Length(Region) > 0 then
      Result := Region[0];
    R := Self.ContentRect;
    for I := Low(Region) to High(Region) do
    begin
      IntersectRect(TmpRect, Region[I], R);
      Result := TRectF.Union(Result, TmpRect);
    end;
  end;
  if Assigned(FContent) then
    Result.TopLeft := AbsoluteToLocal(FContent.LocalToAbsolute(Result.TopLeft))
end;

function TMemo.GetSelectionRegion: TRegion;
var
  LCaret: TCaretPosition;
begin
  LCaret := GetSelBeg;
  if FTextService.HasMarkedText and
     ((FTextService.CaretPosition.Y <> LCaret.Line) or
      (FTextService.CaretPosition.X <= LCaret.Pos)) then
    LCaret := TextPosToPos(PosToTextPos(LCaret) +
      (FTextService.CombinedText.Length - FTextService.Text.Length));
  Result := TMemoLines(FLines).GetRegionForRange(LCaret.Line, LCaret.Pos,
    SelLength);
end;

function TMemo.GetSelEnd: TCaretPosition;
begin
  if FSelStart.Line > FSelEnd.Line then
    Result := FSelStart
  else if FSelEnd.Line > FSelStart.Line then
    Result := FSelEnd
  else if FSelStart.Pos > FSelEnd.Pos then
    Result := FSelStart
  else
    Result := FSelEnd;
end;

procedure TMemo.SelectAtPos(APos: TCaretPosition);
begin
  if not FSelected then
  begin
    FSelStart := APos;
    FSelEnd := APos;
    FSelected := True;
  end
  else
  begin
    FSelEnd := APos;
  end;
end;

function TMemo.GetPositionShift(APos: TCaretPosition; Delta: Integer)
  : TCaretPosition;
begin
  Result := APos;
  Inc(Result.Pos, Delta);
  if Result.Pos < 0 then
    while Result.Pos < 0 do
    begin
      Inc(Result.Pos, FLines[Result.Line].Length + 1);
      Dec(Result.Line);
      if Result.Line < 0 then
      begin
        Result.Line := 0;
        Result.Pos := 0;
        Break;
      end
      else
        Result.Pos := FLines[Result.Line].Length;
    end
  else
    while Result.Pos > FLines[Result.Line].Length do
    begin
      Inc(Result.Line);
      if Result.Line >= FLines.Count then
      begin
        Result.Line := FLines.Count - 1;
        Result.Pos := FLines[FLines.Count - 1].Length;
        Break;
      end;
      Dec(Result.Pos, FLines[Result.Line - 1].Length + 1);
    end;
end;

procedure TMemo.MoveCaretVertical(LineDelta: Integer);
var
  Pt: TPointF;
  LCaret: TCaretPosition;
begin
  Pt := Caret.Pos;
  Pt.Offset(0, GetLineHeight / 2);
  Pt.Offset(-HScrollBarValue, -VScrollBarValue);
  Pt.Offset(0, LineDelta * GetLineHeight);
  LCaret := TMemoLines(FLines).GetPointPosition(Pt);
  if (LCaret.Line = -1) or (LCaret.Pos = -1) then
    Exit;
  FCaretPosition := LCaret;
  UpdateCaretPosition(True);
end;

function TMemo.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True;
  if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

procedure TMemo.ObserverAdded(const ID: Integer; const Observer: IObserver);
begin
  if ID = TObserverMapping.EditLinkID then
    Observer.OnObserverToggle := ObserverToggle;
end;

procedure TMemo.ObserverToggle(const AObserver: IObserver; const Value: Boolean);
var
  LEditLinkObserver: IEditLinkObserver;
  LSaveReadOnly: Boolean;
begin
  if Supports(AObserver, IEditLinkObserver, LEditLinkObserver) then
  begin
    if Value then
    begin
      LSaveReadOnly := ReadOnly;
      if LEditLinkObserver.IsReadOnly then
        ReadOnly := True;
      FSaveReadOnly := LSaveReadOnly;
    end
    else
      if not (csDestroying in ComponentState) then
        ReadOnly := FSaveReadOnly;
  end;
end;

procedure TMemo.MoveCaretDown;
begin
  MoveCaretVertical(1);
end;

procedure TMemo.MoveCaretUp;
begin
  MoveCaretVertical(-1);
end;

procedure TMemo.MoveCaretPageDown;
var
  ScrollLineNumber: Integer;
begin
  ScrollLineNumber := Trunc(GetPageSize);
  if ScrollLineNumber < 1 then
    ScrollLineNumber := 1;
  MoveCaretVertical(ScrollLineNumber);
end;

procedure TMemo.MoveCaretPageUp;
var
  ScrollLineNumber: Integer;
begin
  ScrollLineNumber := Trunc(GetPageSize);
  if ScrollLineNumber < 1 then
    ScrollLineNumber := 1;
  MoveCaretVertical(-ScrollLineNumber);
end;

function TMemo.GetShowSelection: Boolean;
begin
  Result := IsFocused or not HideSelection;
end;

function TMemo.GetKeyboardType: TVirtualKeyboardType;
begin
  Result := FKeyboardType;
end;

{ TEditActionStack }

constructor TEditActionStack.Create(const AOwner: TMemo);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TEditActionStack.Destroy;
begin
  inherited;
end;

procedure TEditActionStack.FragmentDeleted(StartPos: Integer; const Fragment: string);
var
  TmpItem: TEditAction;
begin
  if Fragment = '' then
    Exit;

  if (not (Count > 0)) or not((Peek.ActionType = TActionType.atDelete) and
    (Peek.StartPosition - StartPos - Fragment.Length <= 1) and
    (Peek.StartPosition - StartPos >= 0)) then
  begin
    TmpItem.ActionType := TActionType.atDelete;
    TmpItem.StartPosition := StartPos;
    TmpItem.DeletedFragment := Fragment;
    TmpItem.PairedWithPrev := False;
    Push(TmpItem);
  end
  else
    case Peek.ActionType of
      TActionType.atDelete:
        begin
          if StartPos > 0 then
          begin
            TmpItem := Pop;
            if StartPos < TmpItem.StartPosition then
              TmpItem.DeletedFragment := Fragment + TmpItem.DeletedFragment
            else
              TmpItem.DeletedFragment := TmpItem.DeletedFragment + Fragment;
            TmpItem.StartPosition := StartPos;
            Push(TmpItem);
          end;
        end;
    end;
end;

procedure TEditActionStack.FragmentInserted(StartPos, FragmentLength: Integer; IsPairedWithPrev: Boolean);
var
  TmpItem: TEditAction;
begin
  if FragmentLength = 0 then
    Exit;

  if (not (Count > 0)) or not(Peek.ActionType = TActionType.atInsert) and
    (Peek.StartPosition + Peek.Length = StartPos) then
  begin
    TmpItem.ActionType := TActionType.atInsert;
    TmpItem.StartPosition := StartPos;
    TmpItem.Length := FragmentLength;
    TmpItem.PairedWithPrev := IsPairedWithPrev;
    Push(TmpItem);
  end
  else
    case Peek.ActionType of
      TActionType.atInsert:
      begin
        TmpItem := Pop ;
        TmpItem.Length := TmpItem.Length + FragmentLength;
        Push(TmpItem);
      end;
    end;
end;

procedure TEditActionStack.CaretMovedBy(Shift: Integer);
begin
end;

function TEditActionStack.RollBackAction: Boolean;
var
  TmpItem: TEditAction;
  WasPaired: Boolean;
  LTmpOptions: TInsertOptions;
begin
  Result := (Count > 0);
  if not(Result and Assigned(FOwner)) then
    Exit;

  repeat
    TmpItem := Pop;

    if TmpItem.DeletedFragment <> sLineBreak then
      LTmpOptions := [TInsertOption.ioSelected]
    else
      LTmpOptions := [];

    case TmpItem.ActionType of
      TActionType.atDelete:
        FOwner.InsertAfter(FOwner.TextPosToPos(TmpItem.StartPosition - 1), TmpItem.DeletedFragment,
          LTmpOptions + [TInsertOption.ioMoveCaret]
          { DeletedFragment<>#13+#10, True, False, False } );
      TActionType.atInsert:
        FOwner.DeleteFrom(FOwner.TextPosToPos(TmpItem.StartPosition), TmpItem.Length, [TDeleteOption.doMoveCaret]);
    end;

    WasPaired := TmpItem.PairedWithPrev;
  until (not (Count > 0)) or (not WasPaired);
end;

{ TCaretPosition }

class operator TCaretPosition.GreaterThan(A, B: TCaretPosition): Boolean;
begin
  Result := (A.Line > B.Line) or (A.Line = B.Line) and (A.Pos > B.Pos);
end;

class operator TCaretPosition.GreaterThanOrEqual(A, B: TCaretPosition): Boolean;
begin
  Result := (A.Line > B.Line) or (A.Line = B.Line) and (A.Pos >= B.Pos);
end;

class operator TCaretPosition.LessThan(A, B: TCaretPosition): Boolean;
begin
  Result := (A.Line < B.Line) or (A.Line = B.Line) and (A.Pos < B.Pos);
end;

class operator TCaretPosition.LessThanOrEqual(A, B: TCaretPosition): Boolean;
begin
  Result := (A.Line < B.Line) or (A.Line = B.Line) and (A.Pos <= B.Pos);
end;

initialization
  RegisterFmxClasses([TMemo]);

end.

