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

{

Version History

01/05/2003

  Ancestor changed to ElCombobox

10/27/2002

  Fixed handling of custom colors

03/06/2002

  Added unicode hint

12/28/2201

  It was possible to select clNone color only on second attempt. Fixed.

12/02/2001

  Added OnAddMoreColors event
  Fixed painting in Windows XP with styles disabled

11/05/2001

  Improved alignment of the text

10/24/2001

  ! Now OnChange event is fired ONLY when the user changes this color.

10/12/2001

  Options were not taken into account when combo was loaded. Fixed

07/24/2001

  Control has been completely rewritten.

}

unit ElClrCmb;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Forms,
  Classes,
  Graphics,
  Controls,
  ExtCtrls,
  Dialogs,
  StdCtrls,
{$ifdef VCL_6_USED}
Types,
{$endif}
  ElStrUtils,
  ElTools,
  ElTmSchema,
  ElUxTheme,
  {$ifdef ELPACK_UNICODE}
  ElUnicodeStrings,
  {$endif}
  ElListBox,
  ElCombos;

type

  TColorComboOption = (ccoNoColor, cco4BitColors, ccoSystemColors, ccoCustomChoice, ccoShowNames);
  TColorComboOptions = set of TColorComboOption;

  TTranslateColorNameEvent = procedure(Sender : TObject; Color : TColor; var ColorName : TElFString) of object;
  TColorComboAddMoreColorsEvent = procedure(Sender : TObject; Items : TElFStrings) of object;
  TColorDialogShowEvent = procedure(Sender : TObject; AfterShow : boolean) of object;

  TElColorCombo = class(TCustomElComboBox)
  private
    //internally used
    FDown : Boolean;
    FMouseInControl : boolean;
    //storage for properties
    FDialogOptions : TColorDialogOptions;
    FSelectedColor : TColor;
    FOptions: TColorComboOptions;
    FOnTranslateColorName: TTranslateColorNameEvent;
    FOnAddMoreColors: TColorComboAddMoreColorsEvent;
    FOnColorDialogShow : TColorDialogShowEvent;
    FInDialog: boolean;
    FIgnoreCustomValue : boolean;
    //msg handlers
    procedure CMMouseEnter(var Message : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message : TMessage); message CM_MOUSELEAVE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetOptions(Value: TColorComboOptions);
  protected
    procedure SetSelectedColor(aColor : TColor);
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState); override;
    procedure FillItems;
    procedure DoChange; override;
    procedure TriggerTranslateColorName(Color : TColor; var ColorName : TElFString); virtual;
    procedure Loaded; override;
    procedure DoAddMoreColors(Items : TElFStrings); virtual;
    procedure TriggerColorDialogShow(AfterShow : boolean); virtual;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Options: TColorComboOptions read FOptions write SetOptions;
    property DialogOptions : TColorDialogOptions read FDialogOptions write FDialogOptions default [cdFullOpen];
    property SelectedColor : TColor read FSelectedColor write SetSelectedColor default clLime;
    property OnTranslateColorName: TTranslateColorNameEvent read FOnTranslateColorName
                                                            write FOnTranslateColorName;
    property OnAddMoreColors: TColorComboAddMoreColorsEvent read FOnAddMoreColors write FOnAddMoreColors;
    property OnColorDialogShow : TColorDialogShowEvent read FOnColorDialogShow write FOnColorDialogShow;

    property ButtonArrowColor;
    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property UseBackground;
    property OnDropDown;
    property AdjustDropDownPos;
    property ShowLineHint;
    property HorizontalScroll;
    property OnDrawItem;
    property OnMeasureItem;
    property DropDownAlignment;

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
    property ButtonOldStyled;
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
    property AltButtonOldStyled;
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

var s_Custom : string;

implementation

{$R *.res}

uses ElVCLUtils;

resourcestring sCustom = 'Custom ...';

constructor TElColorCombo.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FDown := false;
  FMouseInControl := false;
  Width := 50;
  Height := 21;
  inherited Style := csOwnerDrawFixed;
  inherited ItemHeight := Abs(Font.Height) + GetSystemMetrics(SM_CXEDGE) * 2;
  FSelectedColor := clLime;
  FDialogOptions := [cdFullOpen];
  FOptions := [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames, ccoCustomChoice];
  TabStop := true;
end;

procedure TElColorCombo.DrawItem(Index: Integer; Rect: TRect; State:
    {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState);
var C : TColor;
    CName, S : TElFString;
    SaveRect : TRect;
    sid      : integer;
    fillback : boolean;
    w        : word;
begin
  Canvas.Brush.Style := bsSolid;
  if odSelected in State then
    Canvas.Brush.Color := FocusedSelectColor
  else
    Canvas.Brush.Color := Color;

  Move(State, w, 2);

  FillBack := (not Self.Transparent) and
              (UseBackground = false)
              {$ifdef ELPACK_USE_IMAGEFORM}and ((ImageForm = nil) or (csDesigning in ComponentState)){$endif} or
              ((not ({odComboBoxEdit in State} (w and 4096) = 4096 )));

  if (((not (odSelected in State)) and FillBack) or ((odSelected in State) and (HighlightAlphaLevel = 255))) then
    Canvas.FillRect(Rect);

  //InflateRect(Rect, -1, -1);
  if (ccoCustomChoice in Options) and (Index = inherited Items.Count - 1) then
    C := SelectedColor
  else
  try
    C := StringToColor(inherited Items[Index]);
  except
    C := SelectedColor;
  end;
  if ccoShowNames in Options then
  begin
    SaveRect := Rect;
    Rect.Right := Rect.Left + (Rect.Bottom - Rect.Top);
    SaveRect.Left := Rect.Right + 2;
  end;
  with Canvas do
  if C = clNone then
  begin
    Brush.Color := Color;
    FillRect(Rect);
    Brush.Color := clWindowText;
    Pen.Color := clWindowText;
    InflateRect(Rect, -1, -1);
    FrameRect(Rect);
    MoveTo(Rect.Left, Rect.Top);
    LineTo(Rect.Right - 1, Rect.Bottom - 1);
    MoveTo(Rect.Left, Rect.Bottom - 1);
    LineTo(Rect.Right - 1, Rect.Top);
    InflateRect(Rect, 1, 1);
  end
  else
  begin
    Brush.Color := C;
    InflateRect(Rect, -1, -1);
    FillRect(Rect);
    Brush.Color := clWindowText;
    Pen.Color := clWindowText;
    FrameRect(Rect);
    InflateRect(Rect, 1, 1);
  end;

  if ccoShowNames in Options then
  begin
    if (ccoCustomChoice in Options) and (Index = inherited Items.Count - 1) then
    begin
      CName := s_Custom
    end
    else
      CName := inherited Items[Index];

    if Uppercase(Copy(CName, 1, 2)) = 'CL' then
      CName := Copy(CName, 3, Length(CName) - 2);

    TriggerTranslateColorName(C, CName);
    Canvas.Font.Assign(Font);
    Canvas.Brush.Style := bsClear;
    Rect := SaveRect;
    if odSelected in State then
      Canvas.Font.Color := FocusedSelectTextColor;

    if (ThemesAvailable and IsThemeActive) then
    begin
      if not Enabled then
        sid := ETS_DISABLED
      else
      if odSelected in State then
        sid := ETS_SELECTED
      else
      if FMouseOver then
        sid := ETS_HOT
      else
        sid := ETS_NORMAL;
      s := CName;
      DrawThemeTextTo('EDIT', Canvas.Handle, EP_EDITTEXT, sid, PWideChar(WideString(s)), Length(WideString(s)), DT_VCENTER or DT_NOPREFIX or DT_LEFT or DT_SINGLELINE, 0, Rect);
    end
    else
    begin
      s := CName;
      {$ifdef ELPACK_UNICODE}
      DrawTextW(Canvas.Handle, PWideChar(S), Length(S), Rect, DT_SINGLELINE or DT_VCENTER or DT_LEFT);
      {$else}
      DrawText(Canvas.Handle, PChar(S), Length(S), Rect, DT_SINGLELINE or DT_VCENTER or DT_LEFT);
      {$endif}
      // Canvas.TextRect(Rect, Rect.Left, Rect.Top, CName);
    end;
  end;

  if (odSelected in State) and (HighlightAlphaLevel < 255) then
  begin
    AlphaFillRect(Canvas, Rect, FocusedSelectColor, HighlightAlphaLevel);
  end;

  (*
  if odFocused in State then
  begin
    InflateRect(Rect, 2, 2);
    DrawFocusRect(Canvas.Handle, Rect);
  end;
  *)
end;

procedure TElColorCombo.CMMouseEnter(var Message : TMessage);
begin
  inherited;
  if FMouseInControl or (not Enabled) then exit;
  FMouseInControl := True;
end;

procedure TElColorCombo.CMMouseLeave(var Message : TMessage);
begin
  inherited;
  if (not FMouseInControl) or (not Enabled) then exit;
  FMouseInControl := False;
end;

procedure TElColorCombo.SetSelectedColor(aColor : TColor);
var S  : String;
    idx: integer;
    SC : TColor;
begin
  if (aColor = FSelectedColor) and (inherited ItemIndex >= 0) then exit;
  sc := FSelectedColor;
  FSelectedColor := aColor;

  S := ColorToString(aColor);
  idx := inherited Items.IndexOf(S);
  if idx <> -1 then
  begin
    inherited ItemIndex := idx;
    Invalidate;
  end
  else
  if ccoCustomChoice in FOptions then
  begin
    FIgnoreCustomValue := true;
    inherited ItemIndex := inherited Items.Count - 1;
    FIgnoreCustomValue := false;
    FSelectedColor := StrToIntDef(S, aColor);
    Invalidate;
  end
  else
    FSelectedColor := SC;
end;

destructor TElColorCombo.Destroy;  { public }
begin
  inherited;
end;  { Destroy }

procedure TElColorCombo.FillItems;
const
  c4BitColors : array[0..15] of TColor =
    (clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clDkGray,
    clLtGray, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite);
  cSystemColors : array[0..24] of TColor =
    (clScrollBar, clBackground, clActiveCaption, clInactiveCaption, clMenu,
     clWindow, clWindowFrame, clMenuText, clWindowText, clCaptionText,
     clActiveBorder, clInactiveBorder, clAppWorkSpace, clHighlight,
     clHighlightText, clBtnFace, clBtnShadow, clGrayText, clBtnText,
     clInactiveCaptionText, clBtnHighlight, cl3DDkShadow, cl3DLight,
     clInfoText, clInfoBk);

var i : integer;
    s : string;
    SC: TColor;
begin
  SC := FSelectedColor;
  FIgnoreCustomValue := true;
  inherited Items.Clear;
  FIgnoreCustomValue := false;
  if ccoNoColor in FOptions then
    inherited Items.AddObject('clNone', TObject(Pointer(clNone)));
  if cco4BitColors in FOptions then
  begin
    for i := 0 to 16 - 1 do
    begin
      if ColorToIdent(c4BitColors[i], s) then
        inherited Items.AddObject(s, TObject(Pointer(c4BitColors[i])))
      else
        inherited Items.AddObject(ColorToString(c4BitColors[i]), TObject(Pointer(c4BitColors[i])));
    end;
  end;
  if ccoSystemColors in FOptions then
  begin
    for i := 0 to 25 - 1 do
    begin
      if ColorToIdent(cSystemColors[i], s) then
        inherited Items.AddObject(s, TObject(Pointer(cSystemColors[i])))
      else
        inherited Items.AddObject(ColorToString(cSystemColors[i]), TObject(Pointer(cSystemColors[i])));
    end;
  end;
  DoAddMoreColors(inherited Items);
  if ccoCustomChoice in FOptions then
  begin
    inherited Items.AddObject(s_Custom, TObject(Pointer(SC)));
  end;
  FSelectedColor := SC;
end;

procedure TElColorCombo.CreateWnd;
var SC : TColor;
begin
  inherited;
  SC := FSelectedColor;
  FillItems;
  SetSelectedColor(SC);
end;

procedure TElColorCombo.SetOptions(Value: TColorComboOptions);
var SC : TColor;
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    if csLoading in ComponentState then exit;
    inherited Items.Clear;
    SC := FSelectedColor;
    FillItems;
    SetSelectedColor(SC);
  end;
end;

procedure TElColorCombo.TriggerTranslateColorName(Color : TColor; var ColorName : TElFString);
begin
  if assigned(FOnTranslateColorName) then
    FOnTranslateColorName(Self, Color, ColorName);
end;

procedure TElColorCombo.DoChange;
var SC : TColor;
begin
  if (ccoCustomChoice in Options) and (inherited Items.Count > 0) and (inherited ItemIndex = inherited Items.Count - 1) and (not FIgnoreCustomValue) then
  begin
    if (not FInDialog) and (not (csLoading in ComponentState)) then
    begin
      FInDialog := true;
      with TColorDialog.Create(self) do
      begin
        try
          Options := FDialogOptions;
          Color := FSelectedColor;
          TriggerColorDialogShow(false);
          if Execute and (Color <> FSelectedColor) then
          begin
            SetSelectedColor(Color);
            Change;
          end
          else
          begin
            SC := FSelectedColor;
            FSelectedColor := TColor(-2);
            SetSelectedColor(SC);
          end;
          TriggerColorDialogShow(true);
        finally
          Free;
        end;
      end;
      FInDialog := false;
    end;
  end
  else
  begin
    if ItemIndex = -1 then
    begin
      FSelectedColor := -1;
    end
    else
    try
      SetSelectedColor(Integer(Pointer(inherited Items.Objects[inherited ItemIndex])));
    except
      on E : EConvertError do ;
    end;
  end;
  inherited;
end;

procedure TElColorCombo.Loaded;
var SC : TColor;
begin
  FInDialog := true;
  SC := FSelectedColor;
  FSelectedColor := sc - 1;
  inherited;
  FillItems;
  SetSelectedColor(SC);
  FInDialog := false;
end;

procedure TElColorCombo.CMFontChanged(var Message: TMessage);
begin
  inherited;
  inherited ItemHeight := Abs(Font.Height) + GetSystemMetrics(SM_CXEDGE) * 2;
end;

procedure TElColorCombo.DoAddMoreColors(Items : TElFStrings);
begin
  if assigned(FOnAddMoreColors) then FOnAddMoreColors(Self, Items);
end;

procedure TElColorCombo.TriggerColorDialogShow(AfterShow : boolean);
begin
  if assigned(FOnColorDialogShow) then
  begin
    FOnColorDialogShow(Self, AfterShow);
  end;
end;

procedure TElColorCombo.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('AutoCompletion', FakeBoolean, nil, false);
    Filer.DefineProperty('AutoSelect', FakeBoolean, nil, false);
    Filer.DefineProperty('Style', FakeIdent, nil, false);
    Filer.DefineProperty('ItemHeight', FakeInteger, nil, false);
    Filer.DefineProperty('ItemIndex', FakeInteger, nil, false);
    Filer.DefineProperty('Text', FakeStr, nil, false);
  end;
end;

initialization

  s_Custom := sCustom;

end.
