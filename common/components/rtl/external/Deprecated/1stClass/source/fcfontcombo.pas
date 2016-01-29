unit fcFontCombo;
{
//
// Components : TfcFontCombo
//
// Copyright (c) 1999 by Woll2Woll Software
// 6/6/99 - RSW - Destroy gets called when DLL is unloaded
// 6/6/99 - Add screen fonts
}

interface

{$i fcIfDef.pas}

uses Graphics, Windows, Messages, Classes, SysUtils, Controls, fcCombo, Dialogs,
  fcTreeCombo, Forms, Printers, fcCommon, fcTreeView, fcToolTip
  {$ifdef fcDelphi4Up}
  ,ImgList
  {$endif};

type
  TfcCustomFontCombo = class;

  TfcComboFontType = (ftFontPrinter, ftFontTrueType, ftFontOther);

  TfcAddFontEvent = procedure(FontCombo: TfcCustomFontCombo; FontName: string;
    FontType: TfcComboFontType; EnumLogFont: TEnumLogFont; NewTextMetric: TNewTextMetric;
    var Accept: Boolean) of object;

  TfcFontHintEvent = procedure(FontCombo: TfcCustomFontCombo; FontName: string;
    var Hint: string; const Font: TFont) of object;


  TfcFontPopupNode = class(TfcTreeComboTreeNode)
  private
    FRecentFont: Boolean;
  public
    property RecentFont: Boolean read FRecentFont write FRecentFont;
  end;

  TfcFontPopupTreeView = class(TfcPopupTreeView)
  protected
    procedure EndItemPainting(Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates); override;
  public
    constructor Create(Owner: TComponent); override;
  end;

  {
  // TfcCustomFontCombo
  //
  // Properties:
  // - MaxMRU: This property specifies the maximum number of items
  //           that will be added to the most recently used section
  //           of the drop down tree view.  If this property is -1
  //           then MRU functionality is disabled.
  //
  // - PreLoad: When this property is set, the fonts are loaded into
  //           the combo upon creation.  However, when this property
  //           is false, the fonts are loaded in either when you
  //           enter the control or drop it down depending on whether
  //           ShowMatchText is true or false, respectively.
  //
  // - RecentFonts: A list of fonts that appear at the top of the
  //           font combo.  This property is automatically managed
  //           if the MaxMRU property contains a value other than
  //           -1.
  //
  // - ShowFontHints: When true, holding the mouse over a font
  //           selection in the drop-down list will pop-up a hint
  //           displaying the font name in that font's face.
  //
  // Methods:
  // - Reload: Causes the font combo to reload its fonts.  If
  //           RecentFontsOnly is true, then only reloads the
  //           items at the top corresponding to the values in
  //           the RecentFonts property.
  //
  // Events:
  // - OnAddFont: Occurs immediately before adding a font to the
  //           font combo.  Accept is initially true -- setting it
  //           to false will prevent the font from being added to
  //           the font combo.
  //
  // - OnGenerateFontHint: Occurs immediately before displaying a
  //           hint for a particular font.  Customization on the hint
  //           text and font can occur here.  Only occurs when the
  //           ShowFontHints property is true.
  }

  TfcFontType = (fcScreenFonts, fcPrinterFonts);
  TfcCustomFontCombo = class(TfcCustomTreeCombo)
  private
    FOldHintClass: THintWindowClass;
    FOldSelectedText: string;

    FCheckMRUChange: Boolean;
    FImmediateHints: Boolean;
    FMaxMRU: Integer;
    FOldHintPause: Integer;
    FPreLoad: Boolean;
    FRecentFonts: TStringList;
    FShowFontHint: Boolean;

    FOnAddFont: TfcAddFontEvent;
    FOnGenerateFontHint: TfcFontHintEvent;
    {$ifdef fcDelphi4Up}
    FFontSelections: TfcFontType;
    {$endif}

    // Property Access Methods
    function GetSelectedFont: string;
    procedure SetMaxMRU(Value: Integer);
    procedure SetRecentFonts(Value: TStringList);

    // Message Handlers
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure ChangeHint(HintClass: THintWindowClass);
  protected
    // Virtual Methods
    function FontCallBack(EnumLogFont: TEnumLogFont; NewTextMetric: TNewTextMetric;
      FontType: Integer): Integer; virtual;
    procedure GenerateFontHint(FontName: string; var AHint: string; AHintFont: TFont); virtual;
    procedure MaintainMaxMRU; virtual;
    procedure MRUChange(FontName: string); virtual;
    procedure RecentFontsChanging(Sender: TObject); virtual;
    procedure RecentFontsChange(Sender: TObject); virtual;
    procedure TreeViewMouseMove(TreeView: TfcCustomTreeView; Node: TfcTreeNode; Shift: TShiftState; X, Y: Integer); virtual;
    procedure TreeViewChange(Sender: TfcCustomTreeView; Node: TfcTreeNode); virtual;

    // Overridden Methods
    function CreatePopupTreeView: TfcPopupTreeView; override;
    function GetStartingNode: TfcTreeNode; override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
    procedure DoAddFont(
                AFontText: string; AFontType: TfcComboFontType;
                EnumLogFont: TEnumLogFont; NewTextMetric: TNewTextMetric;
                var Accept: boolean); virtual;
  public
    Patch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CloseUp(Accept: Boolean); override;
    procedure DropDown; override;
    procedure Reload(RecentFontsOnly: Boolean); virtual;

    property ImmediateHints: Boolean read FImmediateHints write FImmediateHints;
    property MaxMRU: Integer read FMaxMRU write SetMaxMRU;
    property PreLoad: Boolean read FPreLoad write FPreLoad;
    property RecentFonts: TStringList read FRecentFonts write SetRecentFonts;
    property ShowFontHint: Boolean read FShowFontHint write FShowFontHint;
    property SelectedFont: string read GetSelectedFont;
    {$ifdef fcDelphi4Up}
    property FontSelections: TfcFontType read FFontSelections write FFontSelections default fcScreenFonts;
    {$endif}

    property OnAddFont: TfcAddFontEvent read FOnAddFont write FOnAddFont;
    property OnGenerateFontHint: TfcFontHintEvent read FOnGenerateFontHint write FOnGenerateFontHint;
  end;

  TfcFontCombo = class(TfcCustomFontCombo)
  published
    {$ifdef fcDelphi4Up}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property ParentBiDiMode;    
    {$endif}
    property AllowClearKey;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property DropDownCount default 8;
    property DropDownWidth;
    property Enabled;
    property Font;
    property ImmediateHints;
    property MaxMRU default 6;
    property PreLoad default False;
    property ReadOnly;
    property RecentFonts;
    property ShowFontHint default True;
    property ShowHint;
    property ShowMatchText default True;
    property Sorted default True;
    property Style default csDropDownList;
    property TabOrder;
    property TreeOptions;
    property Visible;
    {$ifdef fcDelphi4Up}
    property FontSelections;
    {$endif}

    property OnAddFont;
    property OnCloseUp;
    property OnChange;
    property OnDropDown;
    property OnEnter;
    property OnExit;
    property OnGenerateFontHint;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnSelectionChange;
  end;

implementation

{$r fcFont.res}

type
   TFontImageList = class(TImageList)
      public
         destructor Destroy; override;
   end;
var fcFontImages: TImageList = nil;

destructor TFontImageList.Destroy; { 6/6/99 - RSW - Destroy gets called when DLL is unloaded }
begin
   inherited Destroy;
   fcFontImages:= nil;
end;

function GetFontImages: TImageList;
var bm: Graphics.TBitmap;
begin
  if fcFontImages = nil then
  begin
    bm := Graphics.TBitmap.Create;
    bm.Transparent := True;
    bm.LoadFromResourceName(HINSTANCE, 'FCFONTTRUETYPE');
    fcFontImages := TFontImageList.Create(nil);
    fcFontImages.Width := bm.Width;
    fcFontImages.Height := bm.Height;
    fcFontImages.AddMasked(bm, bm.TransparentColor);
    bm.LoadFromResourceName(HINSTANCE, 'FCFONTPRINTER');
    fcFontImages.AddMasked(bm, bm.TransparentColor);
    fcFontImages.BlendColor := clHighlight;
    bm.Free;
  end;
  result := fcFontImages;
end;

constructor TfcFontPopupTreeView.Create(Owner: TComponent);
begin
  inherited;
  NodeClass := TfcFontPopupNode;
end;

procedure TfcFontPopupTreeView.EndItemPainting(Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates);
var r: TRect;
begin
  inherited;

  r := Node.DisplayRect(False);

  { RSW - Separated logic to allow lines to moved down by 1}
  with (TreeCombo as TfcCustomFontCombo).RecentFonts do
    if (Count > 0) and TfcFontPopupNode(Node).RecentFont and (TfcFontPopupNode(Node).GetNext <> nil) and not TfcFontPopupNode(Node.GetNext).RecentFont then
  begin
    Canvas.Pen.Color := clBtnShadow;
//    Canvas.PolyLine([Point(0, r.Bottom - 0), Point(Width, r.Bottom - 0)]);
    Canvas.PolyLine([Point(0, r.Bottom - 2), Point(Width, r.Bottom - 2)]);
  end;

  with (TreeCombo as TfcCustomFontCombo).RecentFonts do
    if (Count > 0) and
       not TfcFontPopupNode(Node).RecentFont and (Node.GetPrev <> nil) and TfcFontPopupNode(Node.GetPrev).RecentFont then
  begin
    Canvas.Pen.Color := clBtnShadow;
    Canvas.PolyLine([Point(0, r.Top), Point(Width, r.Top)]);
  end;
end;

constructor TfcCustomFontCombo.Create(AOwner: TComponent);
begin
  inherited;
  Sorted := True;
  FMaxMRU := 6;
  FShowFontHint := True;
  TreeView.ShowHint := True;
  TreeView.OnMouseMove := TreeViewMouseMove;
  TreeView.OnChange := TreeViewChange;
  FRecentFonts := TStringList.Create;
  FRecentFonts.OnChanging := RecentFontsChanging;
  FRecentFonts.OnChange := RecentFontsChange;
  FCheckMRUChange := True;
  TreeOptions := TreeOptions - [tvoShowLines, tvoShowRoot] + [tvoRowSelect];
  Style:= csDropDownList;
//  {$ifdef fcDelphi4Up}
//  FFontTypes:= fcScreenFonts;
//  {$endif}
end;

destructor TfcCustomFontCombo.Destroy;
begin
  FRecentFonts.Free;
  inherited;
end;

procedure TfcCustomFontCombo.CreateWnd;
begin
  inherited;
  Images := GetFontImages;
  if PreLoad then Reload(False);
end;

function fcFontCallBack(lpelf: PEnumLogFont; lpntm: PNewTextMetric; FontType: Integer;
  FontCombo: TfcCustomFontCombo): Integer; stdcall;
begin
  result := FontCombo.FontCallBack(lpelf^, lpntm^, FontType);
end;

function TfcCustomFontCombo.CreatePopupTreeView: TfcPopupTreeView;
begin
  result := TfcFontPopupTreeView.Create(self);
end;

procedure TfcCustomFontCombo.DoAddFont(
  AFontText: string; AFontType: TfcComboFontType;
  EnumLogFont: TEnumLogFont; NewTextMetric: TNewTextMetric;
  var Accept: boolean);
begin
  if Assigned(FOnAddFont) then
    FOnAddFont(self, AFontText, AFontType, EnumLogFont, NewTextMetric, Accept);
end;

function TfcCustomFontCombo.FontCallBack(EnumLogFont: TEnumLogFont; NewTextMetric: TNewTextMetric;
  FontType: Integer): Integer;
var Accept: Boolean;
    FontText: string;
    AFontType: TfcComboFontType;
begin
  result := 1;

//  AFontType := fcGetFontType(FontType);

  Accept := True;
  FontText := EnumLogFont.elfLogFont.lfFaceName;

  { Map to type that is declared in this unit so that developer does not need to add
    an additional unit to the uses clause }
  if FontType = DEVICE_FONTTYPE then AFontType := ftFontPrinter
  else if FontType and TRUETYPE_FONTTYPE <> 0 then AFontType := ftFontTrueType
  else AFontType := ftFontOther;

  DoAddFont(FontText, AFontType, EnumLogFont, NewTextMetric, Accept);

  if Accept and (EnumLogFont.elfLogFont.lfFaceName <> '') then
    with Items.Add(nil, FontText) do
  begin
    case AFontType of
      ftFontTrueType: ImageIndex := 0;
      ftFontPrinter: ImageIndex := 1;
      ftFontOther: ImageIndex := -1;
    end;
  end;
end;

function TfcCustomFontCombo.GetStartingNode: TfcTreeNode;
begin
  result := nil;
  if Items.Count > RecentFonts.Count then result := TreeView.Items[RecentFonts.Count];
end;

function TfcCustomFontCombo.GetSelectedFont: string;
begin
  result := '';
  if TreeView.Selected <> nil then result := TreeView.Selected.Text;
end;

procedure TfcCustomFontCombo.SetMaxMRU(Value: Integer);
begin
  if FMaxMRU <> Value then
  begin
    FMaxMRU := Value;
    MaintainMaxMRU;
  end;
end;

procedure TfcCustomFontCombo.SetRecentFonts(Value: TStringList);
begin
  FRecentFonts.Assign(Value);
end;

procedure TfcCustomFontCombo.CMEnter(var Message: TCMEnter);
begin
  inherited;
//  if not PreLoad and (TreeView.Items.Count <= RecentFonts.Count) then Reload(False);
end;

procedure TfcCustomFontCombo.ChangeHint(HintClass: THintWindowClass);
begin
  if HintClass = nil then Exit;
  if (HintWindowClass <> HintClass) and ImmediateHints then
  begin
    if (HintClass = TfcToolTip) then
    begin
      FOldHintPause := Application.HintPause;
      Application.HintPause := 0
    end else Application.HintPause := FOldHintPause;
  end;
  HintWindowClass := HintClass;
end;

procedure TfcCustomFontCombo.CloseUp(Accept: Boolean);
begin
  inherited;
  ChangeHint(FOldHintClass);

  if Accept and (MaxMRU <> -1) and (TreeView.Selected <> nil) then
  begin
    MRUChange(Text);
    TreeView.Selected := TreeView.Items.FindNode(Text, False);
  end;
end;

procedure TfcCustomFontCombo.DropDown;
begin
  if not PreLoad and (TreeView.Items.Count <= RecentFonts.Count) then Reload(False); { 4/5/99 - RSW }
  inherited;
  FOldHintClass := HintWindowClass;
  ChangeHint(TfcToolTip);
end;

procedure TfcCustomFontCombo.GenerateFontHint(FontName: string; var AHint: string; AHintFont: TFont);
begin
  if Assigned(FOnGenerateFontHint) then FOnGenerateFontHint(self, FontName, AHint, AHintFont);
end;

procedure TfcCustomFontCombo.MaintainMaxMRU;
begin
  if (MaxMRU <> -1) then while RecentFonts.Count > MaxMRU do
    RecentFonts.Delete(RecentFonts.Count - 1);
end;

procedure TfcCustomFontCombo.MRUChange(FontName: string);
var FontNameIndex: Integer;
begin
  FontNameIndex := RecentFonts.IndexOf(FontName);
  if FontNameIndex <> -1 then RecentFonts.Move(FontNameIndex, 0)
  else begin
    RecentFonts.Insert(0, FontName);
    MaintainMaxMRU;
  end;
end;

procedure TfcCustomFontCombo.Reload(RecentFontsOnly: Boolean);
var OldCursor: TCursor;
begin
  if RecentFontsOnly then
    RecentFontsChanging(RecentFonts)
  else begin
    OldCursor:= Cursor;
    if Focused then
      Screen.Cursor:= crHourGlass;

    if Items.Count > 0 then Items.Clear;
    {$ifdef fcDelphi4Up}
    if FFontSelections = fcPrinterFonts then
       EnumFontFamilies(Printers.Printer.Handle, nil, @fcFontCallback, LPARAM(self))
    else
    {$endif}
       EnumFontFamilies(Canvas.Handle, nil, @fcFontCallback, LPARAM(self)); { 6/6/97 - RSW }
    if Sorted then TreeView.AlphaSort;

    Screen.Cursor:= OldCursor;
  end;
  RecentFontsChange(RecentFonts);    // Add the RecentFonts list back into the tree view
end;

procedure TfcCustomFontcombo.RecentFontsChanging(Sender: TObject);
var Node: TfcTreeNode;
begin
  if TreeView.Selected <> nil then FOldSelectedText := TreeView.Selected.Text;
  Node := TreeView.Items.GetFirstNode;
  while (Node <> nil) and TfcFontPopupNode(Node).RecentFont do
  begin
    Node.Free;
    Node := TreeView.Items.GetFirstNode;
  end;
end;

procedure TfcCustomFontCombo.RecentFontsChange(Sender: TObject);
var i: Integer;
    s: string;
begin
  for i := RecentFonts.Count - 1 downto 0 do
    with TfcFontPopupNode(TreeView.Items.AddFirst(nil, RecentFonts[i])) do
    begin
      RecentFont := True;
      s := ItemsList.Values[Text];
      if s <> '' then ImageIndex := StrToInt(s)
    end;
  if (FOldSelectedText <> '') and ((TreeView.Selected = nil) or
    ((TreeView.Selected <> nil) and (TreeView.Selected.Text <> FOldSelectedText))) then
  begin
    TreeView.Selected := TreeView.Items.FindNode(FOldSelectedText, False);
    FOldSelectedText := ''
  end;
end;

procedure TfcCustomFontCombo.TreeViewChange(Sender: TfcCustomTreeView; Node: TfcTreeNode);
var AHint: string;
begin
  if ShowFontHint then with (Sender as TfcTreeView) do
  begin
    Node := Selected;
    if Node <> nil then with fcHintFont do
    begin
      Application.CancelHint;
      AHint := Node.Text;
      Name := Node.Text;
      Size := 12;
      GenerateFontHint(Node.Text, AHint, fcHintFont);
      TreeView.Hint := AHint;
    end;
  end;
end;

procedure TfcCustomFontCombo.TreeViewMouseMove(TreeView: TfcCustomTreeView;
   Node: TfcTreeNode; Shift: TShiftState; X, Y: Integer);
begin
  if ShowFontHint then
  begin
    if not PtInRect(Rect(0, 0, TreeView.Width, TreeView.Height), Point(x, y)) then
      ChangeHint(FOldHintClass)
    else ChangeHint(TfcToolTip);
  end;
end;

procedure TfcCustomFontCombo.KeyPress(var Key: Char);
begin
  if not PreLoad and (TreeView.Items.Count <= RecentFonts.Count) then Reload(False); { 4/5/99 - RSW }
  inherited;
end;

initialization
finalization
  fcFontImages.Free;
  fcFontImages := nil;
end.
