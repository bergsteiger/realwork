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

{$r ElFontCombo.res}

(*

Version History


04/20/2003

  Fixed selection of fonts when the font names differ in case only

02/17/2003

  Fixed drawing of items in transparent/ImageForm background modes

Helloween

  Decreased twice time of control creation

10/10/2002

  Fixed calculation of item size (spoiled recently)

04/02/2002

  Added fsmNoSample sample mode to prevent the control from drawing text using the selected font
  Increased speed of component loading

09/26/2001

  Made SampleText property Unicode (optionally)
  Improved size calculation
  Added XP styles when drawing text

*)

unit ElFontCombo;

interface

uses Windows,
     Graphics,
     Printers,
     StdCtrls,

     SysUtils,
     Classes,

{$ifdef VCL_6_USED}
Types,
{$endif}
     ElTools,
     ElStrUtils,
     ElVCLUtils,
     ElTmSchema,
     ElUxTheme,
     ElCombos;

type

    TElFontSampleMode = (fsmFontName, fsmFontSample, fsmBoth, fsmNoSample);

    TElFontDevice = (efdScreen, efdPrinter, efdBoth);

    TElFontComboOption = (foAnsiOnly, foTrueTypeOnly, foIncludeOEMFonts,
                          foIncludeSymbolFonts, foOEMFontsOnly,
                          foScalableOnly);

    TElFontComboOptions = set of TElFontComboOption;

    TElFontComboBox = class(TCustomElComboBox)
    protected
      FOptions: TElFontComboOptions;
      FSampleText: TElFString;
      FFontPitch : TFontPitch;
      FSampleMode: TElFontSampleMode;
      FFontDevice: TElFontDevice;
      FFontName  : string;
      ListFilled : boolean;
      FManualEdit: Boolean;

      procedure SetFontName(Value: TFontName);
      procedure SetOptions(Value: TElFontComboOptions);
      procedure SetSampleText(Value: TElFString);
      procedure SetFontPitch(Value: TFontPitch);
      procedure SetSampleMode(Value: TElFontSampleMode);
      procedure CreateWnd; override;
      function GetItemText(index : integer): TElFString;
      function GetItemWidth(Index: Integer): Integer; override;

      procedure MeasureItem(Index: Integer; var Height: Integer); override;
      procedure DrawItem(Index: Integer; Rect: TRect; State: {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState); override;
      procedure SetFontDevice(Value: TElFontDevice);

      procedure AddFont(Font : TFontName; FontType : integer);
      function GetFontName: TFontName;
      procedure Loaded; override;
      procedure DefineProperties(Filer: TFiler); override;
      procedure SetManualEdit(Value: Boolean);
      procedure Paint; override;
      procedure SetEditRect(Value : TRect); override;
    public
      procedure RebuildFontList;
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure DoChange; override;
    published
      property FontName: TFontName read GetFontName write SetFontName;
      property Options: TElFontComboOptions read FOptions write SetOptions;
      property SampleText: TElFString read FSampleText write SetSampleText;
      property FontPitch: TFontPitch read FFontPitch write SetFontPitch;
      property SampleMode: TElFontSampleMode read FSampleMode write SetSampleMode;
      property FontDevice: TElFontDevice read FFontDevice write SetFontDevice;
      property ManualEdit: Boolean read FManualEdit write SetManualEdit default false;

      property ButtonArrowColor;

      property CanDrop;
      property DropDownCount;
      property DropDownWidth;
      property ListTransparentSelection;
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
      property DropDownAlignment;


      // inherited from TCustomElButtonEdit
      property AlignBottom;
      property TopMargin;
      property LeftMargin;
      property RightMargin;
      property AutoSize;
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

implementation

var FDeviceBmp,
    FTrueTypeBmp: TBitmap;


procedure TElFontComboBox.SetFontName(Value: TFontName);
var i : integer;
    s : string;
begin
  s := Uppercase(Value);
  if csLoading in ComponentState then
    FFontName := Value
  else
  for i := 0 to Items.Count - 1 do
  begin
    if Uppercase(Items[i]) = s then
    begin
      ItemIndex := i;
      exit;
    end;
  end;
end;

procedure TElFontComboBox.SetOptions(Value: TElFontComboOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    if ComponentState * [csReading, csLoading, csDestroying] = [] then
      RebuildFontList;
  end
end;

procedure TElFontComboBox.SetSampleText(Value: TElFString);
begin
  if FSampleText <> Value then
  begin
    FSampleText := Value;
    if SampleMode <> fsmFontName then
      Invalidate;
  end;
end;

function IsValidFont(Options : TElFontComboOptions; Pitch : TFontPitch; LogFont: TLogFont;
  FontType: Integer): Boolean;
begin
  Result := True;
  if (foAnsiOnly in Options) then
    Result := Result and (LogFont.lfCharSet = ANSI_CHARSET);
  if (foTrueTypeOnly in Options) then
    Result := Result and (FontType and TRUETYPE_FONTTYPE = TRUETYPE_FONTTYPE);

  if (Pitch = fpFixed) then
    Result := Result and (LogFont.lfPitchAndFamily and FIXED_PITCH = FIXED_PITCH)
  else
  if (Pitch = fpVariable) then
    Result := Result and (LogFont.lfPitchAndFamily and VARIABLE_PITCH = VARIABLE_PITCH);

  if (foOEMFontsOnly in Options) then
    Result := Result and (LogFont.lfCharSet = OEM_CHARSET);
  if (not (foIncludeOEMFonts in Options)) then
    Result := Result and (LogFont.lfCharSet <> OEM_CHARSET);
  if (not (foIncludeSymbolFonts in Options)) then
    Result := Result and (LogFont.lfCharSet <> SYMBOL_CHARSET);
  if (foScalableOnly in Options) then
    Result := Result and (FontType and RASTER_FONTTYPE = 0);
end;

function EnumFontsProc(var EnumLogFont: TEnumLogFont;
  var TextMetric: TNewTextMetric; FontType: Integer; Data: LPARAM): Integer; stdcall;
begin
  if IsValidFont(TElFontComboBox(Pointer(Data)).Options, TElFontComboBox(Pointer(Data)).FontPitch, EnumLogFont.elfLogFont, FontType) then
    TElFontComboBox(Pointer(Data)).AddFont(StrPas(@EnumLogFont.elfLogFont.lfFaceName), FontType);
  Result := 1;
end;

procedure TElFontComboBox.RebuildFontList;
var
  DC: HDC;
  S : string;
begin
  if not HandleAllocated then Exit;
  ListFilled := true;
  DC := GetDC(0);
  S := FontName;
  Items.Clear;
  Items.BeginUpdate;
  try
    if (FFontDevice = efdScreen) or (FFontDevice = efdBoth) then
        EnumFontFamilies(DC, nil, @EnumFontsProc, Longint(Self));
    if (FFontDevice = efdPrinter) or (FFontDevice = efdBoth) then
    try
      EnumFontFamilies(Printer.Handle, nil, @EnumFontsProc, Longint(Self));
    except
      { skip any errors }
    end;
  finally
    Items.EndUpdate;
    ReleaseDC(0, DC);
  end;
  FontName := S;
end;

procedure TElFontComboBox.SetFontPitch(Value: TFontPitch);
begin
  if FFontPitch <> Value then
  begin
    FFontPitch := Value;
    if ComponentState * [csReading, csLoading, csDestroying] = [] then
      RebuildFontList;
  end;
end;

procedure TElFontComboBox.SetSampleMode(Value: TElFontSampleMode);
begin
  if FSampleMode <> Value then
  begin
    FSampleMode := Value;
    Invalidate;
  end;
end;

function TElFontComboBox.GetItemText(index : integer): TElFString;
begin
  if SampleMode = fsmFontName then
    result := Items[Index]
  else
  if SampleMode = fsmFontSample then
    result := SampleText
  else
  if Length(SampleText) > 0 then
    result := TElFString(Items[Index] + ' - ') + SampleText
  else
    result := TElFString(Items[Index]);
end;

procedure TElFontComboBox.CreateWnd;
begin
  inherited;
  if (ComponentState * [csLoading, csReading] = []) then
    RebuildFontList;
end;

function TElFontComboBox.GetItemWidth(Index: Integer): Integer;
var S   : TElFString;
    R   : TRect;
    ATheme : HTheme;
    sid : integer;
begin
  if Index = -1 then
    Canvas.Font.Name := Font.Name
  else
    Canvas.Font.Name := Items[Index];

  S := GetItemText(Index);
  SetRectEmpty(R);

  if ThemesAvailable then
  begin
    Atheme := OpenThemeData(Handle, 'EDIT');
    if ATheme <> 0 then
    begin
      if not Enabled then
        sid := ETS_DISABLED
      else
        sid := ETS_NORMAL;

      GetThemeTextExtent(ATheme, Canvas.Handle, EP_EDITTEXT, sid, PWideChar(WideString(S)), Length(WideString(S)), DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_CALCRECT, nil, R);
      Result := R.Right - R.Left + 24;
      CloseThemeData(ATheme);
      exit;
    end;
  end;
  {$ifdef ELPACK_UNICODE}
  ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(S), Length(S), R, DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_CALCRECT);
  {$else}
  DrawText(Canvas.Handle, PChar(S), Length(S), R, DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_CALCRECT);
  {$endif}
  Result := R.Right - R.Left + 24;
end;

procedure TElFontComboBox.MeasureItem(Index: Integer; var Height:
    Integer);
var S : TElFString;
    R : TRect;
    Metrics : TTextMetric;
    //ATheme  : HTheme;
    //sid     : integer;
begin
  if (Index = -1) or (SampleMode = fsmNoSample) then
    Canvas.Font.Name := Font.Name
  else
    Canvas.Font.Name := Items[Index];

  if (Index <> -1) and (Index < Items.Count) then
  begin
    S := GetItemText(Index);
    SetRectEmpty(R);

    (*
    if ThemesAvailable then
    begin
      Atheme := OpenThemeData(Handle, 'EDIT');
      if ATheme <> 0 then
      begin
        if not Enabled then
          sid := ETS_DISABLED
        else
          sid := ETS_NORMAL;

        GetThemeTextExtent(ATheme, Canvas.Handle, EP_EDITTEXT, sid, PWideChar(WideString(S)), Length(WideString(S)), DT_SINGLELINE or DT_LEFT or DT_VCENTER, nil, R);
        {$ifdef CLX_USED}
        Width := R.Right - R.Left + 24;
        {$endif}
        Height := R.Bottom - R.Top;
        CloseThemeData(ATheme);
        exit;
      end;
    end;
    *)
    {$ifdef ELPACK_UNICODE}
    ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(S), Length(S), R, DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_CALCRECT);
    {$else}
    DrawText(Canvas.Handle, PChar(S), Length(S), R, DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_CALCRECT);
    {$endif}
    Height := R.Bottom - R.Top + 2;
  end
  else
  begin
    GetTextMetrics(Canvas.Handle, Metrics);
    Height := Abs(Metrics.tmHeight) + 2;
  end;
end;

procedure TElFontComboBox.DrawItem(Index: Integer; Rect: TRect; State:
    {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState);
var Bitmap : TBitmap;
    R      : TRect;
    //sid    : integer;
    S      : TElFString;
    fillback : boolean;
    w        : integer;
begin
  Canvas.Font.Assign(Font);

  if (Index = -1) or (SampleMode = fsmNoSample) then
    Canvas.Font.Name := Font.Name
  else
    Canvas.Font.Name := Items[Index];

  if odSelected in State then
  begin
    Canvas.Brush.Color := FocusedSelectColor;
    Canvas.Font.Color := FocusedSelectTextColor;
  end
  else
    Canvas.Brush.Color := Color;

  Move(State, w, 2);

  FillBack := (not Self.Transparent) and
              (UseBackground = false) {$ifdef ELPACK_USE_IMAGEFORM}and
              ((ImageForm = nil) or (csDesigning in ComponentState)){$endif} or
              ((not (w and 4096 = 4096 )));

  if (((not (odSelected in State)) and FillBack) or ((odSelected in State) and (HighlightAlphaLevel = 255))) then
    Canvas.FillRect(Rect);

  Canvas.Brush.Style := bsClear;

  if (Integer(Items.Objects[Index]) and TRUETYPE_FONTTYPE) <> 0 then
    Bitmap := FTrueTypeBmp
  else
  if (Integer(Items.Objects[Index]) and DEVICE_FONTTYPE) <> 0 then
    Bitmap := FDeviceBmp
  else
    Bitmap := nil;
  if Bitmap <> nil then
  begin
    R.Left := Rect.Left;
    R.Right := R.Left + 20;
    R.Top := Rect.Top + (Rect.Bottom - Rect.Top - 12) div 2;
    R.Bottom := R.Top + 12;
    Canvas.BrushCopy(R, Bitmap, Classes.Rect(0, 0, 20, 12), clFuchsia);
  end;
  s := GetItemText(Index);

  Inc(Rect.Left, 20);

  Canvas.Brush.Style := bsClear;
  {$ifdef ELPACK_UNICODE}
  ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(S), Length(S), Rect, DT_SINGLELINE or DT_VCENTER or DT_LEFT);
  {$else}
  DrawText(Canvas.Handle, PChar(String(S)), Length(S), Rect, DT_SINGLELINE or DT_VCENTER or DT_LEFT);
  {$endif}

  if (odSelected in State) and (HighlightAlphaLevel < 255) then
  begin
    AlphaFillRect(Canvas, Rect, FocusedSelectColor, HighlightAlphaLevel);
  end;
end;

procedure TElFontComboBox.SetFontDevice(Value: TElFontDevice);
begin
  if FFontDevice <> Value then
  begin
    FFontDevice := Value;
    if ComponentState * [csReading, csLoading, csDestroying] = [] then
      RebuildFontList;
  end;
end;

{$O-}
procedure TElFontComboBox.AddFont(Font : TFontName; FontType : integer);
var i : integer;
begin
  if Items.IndexOf(Font) = -1 then
  begin
    if Sorted then
      Items.AddObject(Font, TObject(Pointer(FontType)))
    else
    for i := 0 to Items.Count do
    begin
      if (i = Items.Count) or (AnsiCompareStr(Font, Items[i]) < 0) then
      begin
        Items.InsertObject(i, Font, TObject(Pointer(FontType)));
        exit;
      end;
    end;
  end
end;

function TElFontComboBox.GetFontName: TFontName;
begin
  if ItemIndex = -1 then
    Result := Text
  else
    Result := Items[ItemIndex];
end;

constructor TElFontComboBox.Create(AOwner : TComponent);
{ Creates an object of type TElHTMLComboBox, and initializes properties. }
begin
  inherited Create(AOwner);
  FFontDevice := efdBoth;
  FOptions := [foIncludeOEMFonts, foIncludeSymbolFonts];
  Style := csOwnerDrawFixed;
  ReadOnly := true;
end;  { Create }

destructor TElFontComboBox.Destroy;
begin
  inherited Destroy;
end;  { Destroy }

procedure TElFontComboBox.Loaded;
begin
  inherited;
  // if not ListFilled then
  if HandleAllocated then
    RebuildFontList;
  FontName := FFontName;
end;

procedure TElFontComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('ItemHeight', FakeInteger, nil, false);
    Filer.DefineProperty('AutoCompletion', FakeBoolean, nil, false);
    Filer.DefineProperty('Text', FakeStr, nil, false);
  end;
end;

procedure TElFontComboBox.SetManualEdit(Value: Boolean);
begin
  if FManualEdit <> Value then
  begin
    FManualEdit := Value;
    ReadOnly := not FManualEdit;
  end;
end;

procedure TElFontComboBox.Paint;
var R : TRect;
    Bitmap : TBitmap;
    Canvas : TCanvas;
    i : integer;
begin
  if ManualEdit then
  begin
    i := FItemIndex;
    FItemIndex := -1;
    inherited;
    FItemIndex := i;
  end
  else
    inherited;

  if ManualEdit and (ItemIndex <> -1) then
  begin
    Canvas := TCanvas.Create;
    Canvas.Handle := GetDC(Handle);

    if (Integer(Items.Objects[ItemIndex]) and TRUETYPE_FONTTYPE) <> 0 then
      Bitmap := FTrueTypeBmp
    else
    if (Integer(Items.Objects[ItemIndex]) and DEVICE_FONTTYPE) <> 0 then
      Bitmap := FDeviceBmp
    else
      Bitmap := nil;
    if Bitmap <> nil then
    begin
      R.Left := 0;
      R.Right := 20;
      R.Top := (ClientHeight - 12) div 2;
      R.Bottom := R.Top + 12;

      DrawTransparentBitmapEx(Canvas.Handle, Bitmap, R.Left, R.Top, Classes.Rect(0, 0, 20, 12), clFuchsia);
      // Canvas.BrushCopy(R, Bitmap, Classes.Rect(0, 0, 20, 12), clFuchsia);
    end;
    ReleaseDC(Handle, Canvas.Handle);
    Canvas.Handle := 0;
    Canvas.Free;
  end;
end;

procedure TElFontComboBox.SetEditRect(Value : TRect);
begin
  LeftMargin := 20;
  inherited SetEditRect(Value);
end;

procedure TElFontComboBox.DoChange;
var i : integer;
    b : boolean;
    s : TElFString;
begin
  b := false;
  i := Items.IndexOf(Text);
  if i <> -1 then
    b := true
  else
  begin
    {$ifdef ELPACK_UNICODE}
    s := WideLowercase(Text);
    {$else}
    s := lowercase(Text);
    {$endif}
    for i := 0 to Items.Count - 1 do
    begin
      {$ifdef ELPACK_UNICODE}
      if s = WideLowercase(Items[i]) then
      {$else}
      if s = lowercase(Items[i]) then
      {$endif}
      begin
        b := true;
        break;
      end;
    end;
  end;
  if b and (ItemIndex <> i) then
    ItemIndex := i
  else
  if (not b) and (ItemIndex <> -1) then
    ItemIndex := -1;
  inherited;
end;

initialization

  FTrueTypeBmp := TBitmap.Create;
  FDeviceBmp := TBitmap.Create;
  FTrueTypeBmp.LoadFromResourceName(HInstance, 'ELFONTCOMBOTRUETYPEBITMAP');
  FDeviceBmp.LoadFromResourceName(HInstance, 'ELFONTCOMBODEVICEBITMAP');

finalization

  FTrueTypeBmp.Free;
  FDeviceBmp.Free;

end.
