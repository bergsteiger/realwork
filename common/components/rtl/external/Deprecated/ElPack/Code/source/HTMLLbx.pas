{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

12/20/2002

  Inheritance changed from TElAdvanced*Box to native Unicode-enabled TEl*Box controls

05/01/2002

  Fixed design-time setting of Style property

07/14/2001

  IsHTML property added.
  Now these controls act as ancestors for ElDBListBox and ElDBComboBox

============================== Version 2.78 ====================================

03/23/2001

  Images were not drawn. Fixed.

============================== Version 2.75 ====================================

10/26/2000

  Fixed item height when adding a combo box to the form in design-time

*)

unit HTMLLbx;  { TElHTMLListBox component. }

{ HTML-enabled listbox }

interface

uses
  {$ifdef MSWINDOWS}
  Windows,
  Graphics,
  Controls,
  Forms,
  Messages,
  Dialogs,
  Menus,
  StdCtrls,
  ExtCtrls,
{$ifdef VCL_6_USED}
Types,
{$endif}
  {$else}
  Types,
  QControls,
  QGraphics,
  QStdCtrls,
  Qt,
  QForms,
  {$endif}
  ElCombos,
  ElListBox,
  ElVCLUtils,

  SysUtils,
  Classes,
  HTMLRender,
  ElHintWnd,
  ElStrUtils,
  ElImgFrm;

type

  TCustomElHTMLListBox = class(TElListBox)
  private
    { Private declarations }
    FDummyEvent : TNotifyEvent;  { Dummy field for hiding events. }

    FRender : TElHTMLRender;
    FOnLinkClick : TElHTMLLinkClickEvent;
    FOnImageNeeded : TElHTMLImageNeededEvent;
    FIsHTML: Boolean;
    FCursor: TCursor;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    // function GetItemHeight(Index: Integer): Integer; virtual;
  protected
    FStyle: TListBoxStyle;
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    function GetItemWidth(Index: Integer): Integer; override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState); override;
    procedure TriggerLinkClickEvent(Sender : TObject; HRef : TElFString); virtual;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TElFString; var Image :
        TBitmap); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SetCursor(newValue : TCursor); virtual;
    function CreateHintWindow: TElHintWindow; override;
    procedure SetStyle(Value: TListBoxStyle);
    procedure SetIsHTML(Value: Boolean); virtual;
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    procedure Loaded; override;
    destructor Destroy; override;
  published
    { Published properties and events }
    property OnLinkClick : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnDrawItem : TNotifyEvent read FDummyEvent;  { Hidden Event }
    property OnMeasureItem : TNotifyEvent read FDummyEvent;  { Hidden Event }
    property IsHTML: Boolean read FIsHTML write SetIsHTML;
    property Cursor: TCursor read FCursor write SetCursor;
    property Style: TListBoxStyle read FStyle write SetStyle default
        lbOwnerDrawVariable;
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle;
  end;  { TElHTMLListBox }

  TCustomElHTMLComboBox = class(TElComboBox)
  private
    { Private declarations }
    FDummyEvent : TNotifyEvent;  { Dummy field for hiding events. }

    FRender : TElHTMLRender;
    FOnLinkClick : TElHTMLLinkClickEvent;
    FOnImageNeeded : TElHTMLImageNeededEvent;
    FIsHTML: Boolean;
  protected
    FStyle: TComboBoxStyle;
    FLinkColor: TColor;
    FLinkStyle: TFontStyles;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState); override;

    procedure TriggerLinkClickEvent(Sender : TObject; HRef : TElFString); virtual;
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TElFString; var Image : TBitmap); virtual;
    {$warnings off}
    procedure SetStyle(Value: TComboBoxStyle); {$ifdef VCL_4_USED}reintroduce;{$endif}
    {$warnings on}
    procedure SetIsHTML(Value: Boolean); virtual;
    function GetTextFromItem(Index : integer): TElFString; override;
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;

    property OnLinkClick : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnDrawItem : TNotifyEvent read FDummyEvent;  { Hidden Event }
    property OnMeasureItem : TNotifyEvent read FDummyEvent;  { Hidden Event }
    property IsHTML: Boolean read FIsHTML write SetIsHTML;
    property Style: TComboBoxStyle read FStyle write SetStyle default
        csOwnerDrawVariable;
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
  published
    { Published properties and events }
  end;

  TElHTMLListBox = class(TCustomElHTMLListBox)
  published
    property AllowGrayed;
    property BorderStyle;
    property Columns;
    property ExtendedSelect;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property IntegralHeight;
    property IncrementalSearchTimeout;
    property ItemHeight;
    property MultiSelect;
    property ParentColor;
    property Sorted;
    property TabWidth;
    property ItemIndex;
    property Items;
    property SelCount;
    property TopIndex;
    property ShowCheckBox;
    property UseXPThemes;

    property ActiveBorderType;
    property Background;
    property BorderSides;
    property Flat;
    property Ctl3D;
    property ParentCtl3D;
    property Font;
    property FlatFocusedScrollBars;
    property HighlightAlphaLevel;
    property HorizontalScroll;
    property Images;
    property AlphaForImages;
    property ImageForm;
    property InactiveBorderType;
    property InvertSelection;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property SelectedFont;
    property ShowLineHint;
    property Transparent;
    property TransparentSelection;
    property UseBackground;
    property UseSelectedFont;
    property TabStop;
    property ParentFont;

    property OnClick;
    property OnCheckStateChange;
    //@+ 2/5/03
    property OnCheckBoxChange;
    //@- 2/5/03
    {$IFDEF VCL_5_USED}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    {$IFDEF VCL_4_USED}
    property OnEndDock;
    {$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF VCL_4_USED}
    property OnResize;
    property OnStartDock;
    {$ENDIF}
    property OnStartDrag;


    property Align;
    {$IFDEF VCL_4_USED}
    property Anchors;
    property BiDiMode;
    {$ENDIF}
    property Color;
    {$IFDEF VCL_4_USED}
    property Constraints;
    {$ENDIF}
    property DragCursor;
    {$IFDEF VCL_4_USED}
    property DragKind;
    {$ENDIF}
    property DragMode;
    property Enabled;
    {$IFDEF VCL_4_USED}
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    {$ENDIF}
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
    property Style;
    property OnDrawItem;
    property OnMeasureItem;
    {< ELSCROLLBAR}
    property UseCustomScrollBars;
    property HorzScrollBarStyles;
    property VertScrollBarStyles;
    {> ELSCROLLBAR}
    property RightAlignedView;
  end;

  TElHTMLComboBox = class(TCustomElHTMLComboBox)
    property OnLinkClick;
    property OnImageNeeded;
    property OnDrawItem;
    property OnMeasureItem;
    property IsHTML;
    property Style;
    property LinkColor;
    property LinkStyle;

    property ButtonArrowColor;

    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property ListTransparentSelection;
    property AutoCompletion;
    property Items;
    property ListColor;
    property ListImageForm;
    property ListInvertSelection;
    property Sorted;
    property UseBackground;
    property OnDropDown;
    property AdjustDropDownPos;
    property ItemIndex;
    property ShowLineHint;
    property HorizontalScroll;
    property ItemHeight;
    property DropDownAlignment;

    property AutoHistory;
    property AutoHistoryDirection;
    property AutoHistoryLimit;
    // property OnAutoCompletion;
    property OnAutoHistoryItemAdd;
    property OnAutoHistoryItemMove;

    // inherited from TCustomElButtonEdit
    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property ReadOnly;
    property MaxLength;
    property BorderSides;
    property Transparent;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

{$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm;
{$ENDIF}

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property Text;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    // inherited from TCustomElEdit
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseSystemMenu;

    property Alignment;
    property AutoSelect;

    property Background;
    property ButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;
{$ENDIF}
    property ButtonColor;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonHint;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
    property ButtonShowBorder;
    property ButtonVisible;
    property ButtonWidth;

    property AltButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;
{$ENDIF}
    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShowBorder;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
{$IFDEF VCL_4_USED}
    property OnEndDock;
{$ENDIF}
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF VCL_4_USED}
    property OnStartDock;
{$ENDIF}

{$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
{$ENDIF}
  end;

implementation

const SideOffset = 2;

procedure TCustomElHTMLListBox.MeasureItem(Index: Integer; var Height: Integer);
{$ifdef MSWINDOWS}
var R : TRect;
{$endif}
{$ifndef MSWINDOWS}
var PX : TSize;
    AL : Integer;
{$endif}
begin
  if IsHTML then
  begin
    if Index >= Items.Count then
    begin
      Height := ItemHeight;
      Width := 0;
    end
    else
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight:= Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := FLinkColor;
      FRender.Data.LinkStyle := FLinkStyle;

      FRender.PrepareText(Items[Index], 0, false);
      Height := FRender.Data.TextSize.cy;
    end;
  end
  else
  begin
    {$ifdef MSWINDOWS}
    R := Rect(0, 0, MaxInt, MaxInt);
    {$ifdef ELPACK_UNICODE}
    DrawTextW(Canvas.Handle, PWideChar(Items[Index]), Length(Items[Index]), R,
             DT_LEFT or DT_TOP or DT_NOPREFIX or DT_CALCRECT);
    {$else}
    DrawText(Canvas.Handle, PChar(Items[Index]), Length(Items[Index]), R,
             DT_LEFT or DT_TOP or DT_NOPREFIX or DT_CALCRECT);
    {$endif}
    Height := R.Bottom;
    {$else}
    if not FMultiline then
      AL := Integer(AlignmentFlags_SingleLine) or Integer(AlignmentFlags_AlignLeft)
    else
      AL := Integer(AlignmentFlags_AlignLeft);
    R := Rect(0, 0, MaxInt, MaxInt);
    PX := Canvas.TextExtent(Caption, Al);
    Width := PX.cx;
    Height:= PX.cy;
    {$endif}
  end;
end;

procedure TCustomElHTMLListBox.DrawItem(Index: Integer; Rect: TRect; State:
    {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState);
var fillback : boolean;
    w        : word;
begin
  if IsHTML then
  begin
    if ([odFocused, odSelected] * State) <> [] then
    begin
      Canvas.Brush.Color := FocusedSelectColor;
      FRender.Data.DefaultColor := FocusedSelectTextColor;
    end else
    if ([odGrayed, odDisabled] * State) <> [] then
    begin
      Canvas.Brush.Color := clBtnFace;
      FRender.Data.DefaultColor := clBtnShadow;
    end
    else
    begin
      Canvas.Brush.Color := Color;
      FRender.Data.DefaultColor := Font.Color;
    end;

    Move(State, w, 2);

    FillBack := (not Self.Transparent) and
                (UseBackground = false) and
                ((ImageForm = nil) or (csDesigning in ComponentState)) or
                ((not ({odComboBoxEdit in State} (w and 4096) = 4096 )));

    if (((not (odSelected in State)) and FillBack) or (HighlightAlphaLevel = 255) ) then
      Canvas.FillRect(Rect);

    Canvas.Brush.Style := bsClear;
    FRender.Data.DefaultBgColor := clNone;

    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight:= Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.LinkColor := LinkColor;
    FRender.Data.LinkStyle := LinkStyle;

    FRender.PrepareText(Items[Index], 0, false);
    FRender.DrawText(Canvas, Point(0, 0), Rect, FRender.Data.DefaultBgColor);

    if (odSelected in State) and (HighlightAlphaLevel < 255) then
    begin
      AlphaFillRect(Canvas, Rect, FocusedSelectColor, HighlightAlphaLevel);
    end;

    if odFocused in State then
    begin
      {$ifdef MSWINDOWS}
      Canvas.DrawFocusRect(Rect);
      {$else}
      QStyle_DrawFocusRect(Application.Style.Handle,
                                      Canvas.Handle,
                                      @Rect,
                                      QWidget_colorGroup(Handle),
                                      nil, false);
      {$endif}
    end;
  end
  else
    inherited;

end;

{ Event triggers: }
procedure TCustomElHTMLListBox.TriggerLinkClickEvent(Sender : TObject; HRef :
    TElFString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

procedure TCustomElHTMLListBox.TriggerImageNeededEvent(Sender : TObject; Src :
    TElFString; var Image : TBitmap);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src , Image );
end;  { TriggerImageNeededEvent }

procedure TCustomElHTMLListBox.DoLinkPopup(MousePos : TPoint);
begin
  if (FLinkPopupMenu <> nil) and FLinkPopupMenu.AutoPopup then
  begin
    SendCancelMode(nil);
    FLinkPopupMenu.PopupComponent := Self;
    if MousePos.X < 0 then
      MousePos := ClientToScreen(Point(0,0));
    FLinkPopupMenu.Popup(MousePos.X, MousePos.Y);
  end;
end;

procedure TCustomElHTMLListBox.Loaded;
begin
  inherited;
  {$ifdef MSWINDOWS}
  if HandleAllocated then
    RecreateWnd;
  {$endif}
end;

destructor TCustomElHTMLListBox.Destroy;
begin
  FRender.Free;
  inherited Destroy;
end;  { Destroy }

constructor TCustomElHTMLListBox.Create(AOwner : TComponent);
{ Creates an object of type TElHTMLListBox, and initializes properties. }
begin
  inherited Create(AOwner);
  inherited Style := lbOwnerDrawVariable;  { New default. }
  FRender := TElHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FLinkColor := clBlue;
  FLinkStyle := [fsUnderline];
end;  { Create }

procedure TCustomElHTMLListBox.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if FIsHTML then
      inherited Style := lbOwnerDrawVariable
    else
      inherited Style := FStyle;
    RecreateWnd;
  end;
end;

procedure TCustomElHTMLListBox.CMMouseLeave(var Msg : TMessage);
begin
  inherited Cursor := FCursor;
  inherited;
end;  { CMMouseLeave }

procedure TCustomElHTMLListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var href : TElFString;
    i : integer;
    R : TRect;
begin
  begin
    i := SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(X,Y));
    SendMessage(Handle, LB_GETITEMRECT, i, Integer(@R));
    if PtInRect(R, Point(X,Y)) and (i >= 0) and (i < Items.Count) then
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := FLinkColor;
      FRender.Data.LinkStyle := FLinkStyle;

      FRender.PrepareText(Items[i], 0, false);

      if FRender.IsCursorOverLink(Point(X, Y - R.Top), Point(0, 0), Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top), href) then
      begin
        if (Button = mbRight) and (FLinkPopupMenu <> nil) then
          DoLinkPopup(ClientToScreen(Point(X, Y)))
        else
          TriggerLinkClickEvent(Self, href);
        exit;
      end;
    end;
  end;
  inherited;
end;

procedure TCustomElHTMLListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var href : TElFString;
    i : integer;
    R : TRect;
begin
  inherited;
  begin
    i := SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(X,Y));
    SendMessage(Handle, LB_GETITEMRECT, i, Integer(@R));
    if PtInRect(R, Point(X,Y)) and (i >= 0) and (i < Items.Count) then
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := FLinkColor;
      FRender.Data.LinkStyle := FLinkStyle;

      FRender.PrepareText(Items[i], 0, false);

      if FRender.IsCursorOverLink(Point(X, Y - R.Top), Point(0, 0), Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top), href) then
         inherited Cursor := crHandPoint
      else
         inherited Cursor := FCursor;
    end;
  end;
end;  { MouseMove }

procedure TCustomElHTMLListBox.SetCursor(newValue : TCursor);
var P : TPoint;
begin
  if (FCursor <> newValue) then
  begin
    FCursor := newValue;
    GetCursorPos(P);
    P := ScreenToClient(P);
    SendMessage(Handle, WM_MOUSEMOVE, 0, MakeLParam(P.X, P.Y));
  end;  { if }
end;  { SetCursor }

function TCustomElHTMLListBox.GetItemWidth(Index: Integer): Integer;
begin
  if not IsHTML then
    result := inherited GetItemWidth(Index)
  else
  begin
    if Index >= Items.Count then
      Result := 0
    else
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := FLinkColor;
      FRender.Data.LinkStyle := FLinkStyle;
      FRender.PrepareText(Items[Index], 0, false);

      Result := FRender.Data.TextSize.cx + 4;
    end;
  end;
end;

function TCustomElHTMLListBox.CreateHintWindow: TElHintWindow;
begin
  Result := TElHintWindow.Create(nil);
{$ifdef HAS_HTML_RENDER}
  TElHintWindow(Result).IsHTML := IsHTML;
  TElHintWindow(Result).OnLinkClick := TriggerLinkClickEvent;
{$endif}
end;

procedure TCustomElHTMLListBox.SetStyle(Value: TListBoxStyle);
begin
  if (FStyle <> Value) and (Value in [Low(TListBoxStyle)..High(TListBoxStyle)]) then
  begin
    FStyle := Value;
    if not IsHTML then
    begin
      inherited Style := Value;
    end;
  end;
end;

procedure TCustomElHTMLListBox.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkColor }

procedure TCustomElHTMLListBox.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if FLinkPopupMenu <> nil then
      if not (csDestroying in FLinkPopupMenu.ComponentState) then
        FLinkPopupMenu.RemoveFreeNotification(Self);
    {$endif}
    FLinkPopupMenu := newValue;
    if (newValue <> nil) then
       newValue.FreeNotification(Self);
  end;  { if }
end;  { SetLinkPopupMenu }

procedure TCustomElHTMLListBox.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkStyle }


(*
function TCustomElHTMLListBox.GetItemHeight(Index: Integer): Integer;
begin
  if not IsHTML then
    Result := ItemHeight
  else
  begin
    if Index >= Items.Count then
      Result := ItemHeight
    else
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultSize := Font.Size;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.PrepareText(Items[Index], 0, false);
      Result := FRender.Data.TextSize.cy;
    end;
  end;
end;
*)

procedure TCustomElHTMLComboBox.MeasureItem(Index: Integer; var Height:
    Integer);
{$ifdef MSWINDOWS}
var R : TRect;
{$endif}
{$ifndef MSWINDOWS}
var PX : TSize;
    AL : Integer;
{$endif}
begin
  if Index = -1 then
    Height := ItemHeight
  else
  if IsHTML then
  begin
    if Index >= Items.Count then
    begin
      Height := ItemHeight;
      Width := 0;
    end
    else
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := FLinkColor;
      FRender.Data.LinkStyle := FLinkStyle;

      FRender.PrepareText(Items[Index], 0, false);
      Height := FRender.Data.TextSize.cy;
    end;
  end
  else
  begin
    {$ifdef MSWINDOWS}
    R := Rect(0, 0, MaxInt, MaxInt);
    {$ifdef ELPACK_UNICODE}
    DrawTextW(Canvas.Handle, PWideChar(Items[Index]), Length(Items[Index]), R,
             DT_LEFT or DT_TOP or DT_NOPREFIX or DT_CALCRECT);
    {$else}
    DrawText(Canvas.Handle, PChar(Items[Index]), Length(Items[Index]), R,
             DT_LEFT or DT_TOP or DT_NOPREFIX or DT_CALCRECT);
    {$endif}
    Height := R.Bottom;
    {$else}
    if not FMultiline then
      AL := Integer(AlignmentFlags_SingleLine) or Integer(AlignmentFlags_AlignLeft)
    else
      AL := Integer(AlignmentFlags_AlignLeft);
    R := Rect(0, 0, MaxInt, MaxInt);
    PX := Canvas.TextExtent(Caption, Al);
    Width := PX.cx;
    Height:= PX.cy;
    {$endif}
  end;
end;

procedure TCustomElHTMLComboBox.DrawItem(Index: Integer; Rect: TRect; State:
    {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState);
var fillback : boolean;
    w        : word;
begin
  if IsHTML then
  begin
    if ([odFocused, odSelected] * State) <> [] then
    begin
      Canvas.Brush.Color := FocusedSelectColor;
      FRender.Data.DefaultColor := FocusedSelectTextColor;
    end
    else
    if ([odGrayed, odDisabled] * State) <> [] then
    begin
      Canvas.Brush.Color := clBtnFace;
      FRender.Data.DefaultColor := clBtnShadow;
    end
    else
    begin
      Canvas.Brush.Color := Color;
      FRender.Data.DefaultColor := Font.Color;
    end;

    Move(State, w, 2);

    FillBack := (not Self.Transparent) and
                (UseBackground = false) {$ifdef ELPACK_USE_IMAGEFORM}and
                ((ImageForm = nil) or (csDesigning in ComponentState)){$endif} or
                ((not ({odComboBoxEdit in State} (w and 4096) = 4096 )));

    if (((not (odSelected in State)) and FillBack) or (HighlightAlphaLevel = 255) ) then
      Canvas.FillRect(Rect);

    Canvas.Brush.Style := bsClear;
    FRender.Data.DefaultBgColor := clNone;

    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.LinkColor := FLinkColor;
    FRender.Data.LinkStyle := FLinkStyle;

    InflateRect(Rect, -SideOffset div 2, 0);
    FRender.PrepareText(Items[Index], 0, false);
    FRender.DrawText(Canvas, Point(0, 0), Rect, clNone);

    if (odSelected in State) and (HighlightAlphaLevel < 255) then
    begin
      AlphaFillRect(Canvas, Rect, FocusedSelectColor, HighlightAlphaLevel);
    end;
  end
  else
    inherited;

end;

{ Event triggers: }
procedure TCustomElHTMLComboBox.TriggerLinkClickEvent(Sender : TObject; HRef :
    TElFString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

procedure TCustomElHTMLComboBox.TriggerImageNeededEvent(Sender : TObject; Src :
    TElFString; var Image : TBitmap);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src , Image );
end;  { TriggerImageNeededEvent }

procedure TCustomElHTMLComboBox.Loaded;
begin
  inherited;
  if IsHTML then
    inherited Style := csOwnerDrawVariable
  else
    inherited Style := Style;
  {$ifdef MSWINDOWS}
  if HandleAllocated then
    RecreateWnd;
  {$endif}
end;

destructor TCustomElHTMLComboBox.Destroy;
begin
  FRender.Free;
  inherited Destroy;
end;  { Destroy }

constructor TCustomElHTMLComboBox.Create(AOwner : TComponent);
{ Creates an object of type TElHTMLComboBox, and initializes properties. }
begin
  inherited Create(AOwner);
  //inherited Style := csOwnerDrawVariable;  { New default. }
  FRender := TElHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FLinkColor := clBlue;
  FLinkStyle := [fsUnderline];
end;  { Create }

procedure TCustomElHTMLComboBox.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if FIsHTML then
      inherited Style := csOwnerDrawVariable
    else
      inherited Style := FStyle;
    if ComponentState * [csLoading, csReading, csDestroying] = [] then
      RecreateWnd;
  end;
end;

procedure TCustomElHTMLComboBox.SetStyle(Value: TComboBoxStyle);
begin
  if (FStyle <> Value) and (Value in [Low(TComboBoxStyle)..High(TComboBoxStyle)]) then
  begin
    FStyle := Value;
    if not IsHTML then
    begin
      inherited Style := Value;
      if ComponentState * [csLoading, csReading, csDestroying] = [] then
        RecreateWnd;
    end;
  end;
end;

function TCustomElHTMLComboBox.GetTextFromItem(Index : integer): TElFString;
begin
  FRender.PrepareText(Items[Index], 0, false);
  Result := FRender.AsText;
end;

procedure TCustomElHTMLComboBox.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkColor }

procedure TCustomElHTMLComboBox.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkStyle }


end.
