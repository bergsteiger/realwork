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

03/06/2002

  Added unicode hint

12/02/2001

  Fixed painting in Windows XP with styles disabled

*)

unit ElDriveCombo;

interface

uses

  Controls,
  Messages,
  Windows,
  Graphics,
  ShellApi,
  StdCtrls,
  Forms,

  SysUtils,
  Classes,
{$ifdef VCL_6_USED}
Types,
{$endif}

  ElStrUtils,
  ElTmSchema,
  ElUxTheme,
  ElTools,
  ElVCLUtils,
  ElCombos;

type

  TElDriveComboOption = (dcoDisplayFloppy,
                         dcoDisplayNetwork,
                         dcoDisplayHard,
                         dcoDisplayCD,
                         dcoDisplayRAM);

  TElDriveComboOptions = set of TElDriveComboOption;

  TElDriveComboBox = class(TCustomElComboBox)
  private
    FDummyChar  : char;
  protected
    FDrive: Char;
    FTextCase: TElTextCase;
    FOptions: TElDriveComboOptions;

    procedure DrawItem(Index: Integer; Rect: TRect; State: {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState); override;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure FillItems;
    procedure SetDrive(Value: Char);
    procedure CreateWnd; override;
    procedure SetTextCase(Value: TElTextCase);
    procedure SetOptions(Value: TElDriveComboOptions);
    procedure DoChange; override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner :TComponent); override;
    property Drive: Char read FDrive write SetDrive;
    property ItemIndex : char read FDummyChar;
  published
    property TextCase: TElTextCase read FTextCase write SetTextCase default etcLowercase;
    property Options: TElDriveComboOptions read FOptions write SetOptions;

    property ButtonArrowColor;

    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property ListTransparentSelection;
    property ListColor;
    property ListImageForm;
    property ListInvertSelection;
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

implementation

procedure TElDriveComboBox.DrawItem(Index: Integer; Rect: TRect; State:
    {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState);
var S : string;
    fi : TSHFileInfo;
    iw,
    ih : integer;
    sid: integer;
    fillback : boolean;
    w : word;
begin
  Canvas.Brush.Style := bsSolid;

  if odSelected in State then
    Canvas.Brush.Color := FocusedSelectColor
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

  if ItemHeight < GetSystemMetrics(SM_CXICON) then
  begin
    SHGetFileInfo(PChar(inherited Items[Index][1] + ':\'), 0, fi, sizeof(fi), SHGFI_ICON or SHGFI_SMALLICON);
    iw := GetSystemMetrics(SM_CXSMICON);
    ih := GetSystemMetrics(SM_CYSMICON);
  end
  else
  begin
    SHGetFileInfo(PChar(inherited Items[Index][1] + ':\'), 0, fi, sizeof(fi), SHGFI_ICON or SHGFI_LARGEICON);
    iw := GetSystemMetrics(SM_CXICON);
    ih := GetSystemMetrics(SM_CYICON);
  end;

  DrawIconEx(Canvas.Handle, Rect.Left, Rect.Top + (Rect.Bottom - Rect.Top - ih) div 2, fi.hIcon, Min(ItemHeight, ih), Min(ItemHeight, iw), 0, 0, DI_NORMAL);

  Inc(Rect.Left, iw + iw div 4);

  S := inherited Items[Index];
  case TextCase of
    etcLowercase: S := Lowercase(S);
    etcUppercase: S := Uppercase(S);
  end;
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
    DrawThemeTextTo('EDIT', Canvas.Handle, EP_EDITTEXT, sid, PWideChar(WideString(s)), Length(WideString(s)), DT_VCENTER or DT_NOPREFIX or DT_LEFT or DT_SINGLELINE, 0, Rect);
  end
  else
    DrawText(Canvas.Handle, PChar(S), Length(S), Rect, DT_VCENTER or DT_NOPREFIX or DT_LEFT or DT_SINGLELINE);

  if (odSelected in State) and (HighlightAlphaLevel < 255) then
  begin
    AlphaFillRect(Canvas, Rect, FocusedSelectColor, HighlightAlphaLevel);
  end;

end;

procedure TElDriveComboBox.FillItems;
var
{$ifdef VCL_4_USED}
    i : Cardinal;
{$else}
    i : integer;
{$endif}
    c : char;
    sv: integer;
    Drives: set of 0..25;
    Name  : string;
    dt : DWORD;

    function GetVolumeName(Volume : string) : string;
    var NameBuf: array[0..255] of char;
    begin
      GetVolumeInformation(PChar(Volume), NameBuf, 255, @i, i, i, nil, 0);
      SetString(Result, NameBuf, StrLen(NameBuf));
    end;

    function GetNetworkVolumeName(Volume : string) : string;
    var
      Buf : array [0..MAX_PATH] of Char;
      Drv : array [0..3] of Char;
{$ifdef VCL_4_USED}
      BufSize: Cardinal;
{$else}
      BufSize: Integer;
{$endif}
    begin
      BufSize := sizeof(buf);
      StrPCopy(Drv, Volume);

      if WNetGetConnection(Drv, Buf, BufSize) = WN_SUCCESS then
        result := StrPas(Buf)
      else
        result := '';
    end;

begin
  inherited Items.Clear;
  sv := Windows.SetErrorMode(SEM_FAILCRITICALERRORS);
  Integer(Drives) := GetLogicalDrives;
  for c := 'A' to 'Z' do
  begin
    if Ord(C) - Ord('A') in Drives then
    begin
      dt := GetDriveType(PChar(C + ':\'));
      if (dt = DRIVE_REMOVABLE) and not (dcoDisplayFloppy in Options) then
        Continue;
      if (dt = DRIVE_REMOTE) and not (dcoDisplayNetwork in Options) then
        Continue;
      if (dt = DRIVE_CDROM) and not (dcoDisplayCD in Options) then
        Continue;
      if (dt = DRIVE_FIXED) and not (dcoDisplayHard in Options) then
        Continue;
      if (dt = DRIVE_RAMDISK) and not (dcoDisplayRAM in Options) then
        Continue;
      if dt = DRIVE_REMOVABLE then
        Name := ''
      else
      if dt = DRIVE_REMOTE then
        Name := GetNetworkVolumeName(C + ':')
      else
        Name := GetVolumeName(C + ':\');

      inherited Items.Add(Format('%s: [%s]', [C, Name]));
    end;
  end;
  Windows.SetErrorMode(sv);

end;

procedure TElDriveComboBox.SetDrive(Value: Char);
var i, j : integer;
begin
  if FDrive <> Value then
  begin
    Value := Upcase(Value);
    if Value in ['A'..'Z'] then
    begin
      j := inherited Items.Count - 1;
      for i := 0 to j do
      begin
        if (inherited Items[i])[1] = TElFChar(Value) then
        begin
          FDrive := Value;
          inherited ItemIndex := i;
          exit;
        end;
      end;
    end;
  end;
end;

constructor TElDriveComboBox.Create(AOwner :TComponent);
begin
  inherited;
  FDrive := 'C';
  inherited Style := csOwnerDrawFixed;
  FTextCase  := etcLowercase;
  FOptions := [dcoDisplayFloppy, dcoDisplayNetwork, dcoDisplayHard, dcoDisplayCD, dcoDisplayRAM];
  inherited ItemHeight := Max(Abs(Font.Height) + 2 + GetSystemMetrics(SM_CXEDGE) * 2, Max(ItemHeight, GetSystemMetrics(SM_CYSMICON)));
end;

procedure TElDriveComboBox.CreateWnd;
var D : Char;
    b : array[0..MAX_PATH] of char;
begin
  inherited;
  FillItems;
  D := FDrive;
  GetCurrentDirectory(MAX_PATH, b);
  FDrive := B[0];
  SetDrive(D);
end;

procedure TElDriveComboBox.SetTextCase(Value: TElTextCase);
begin
  if FTextCase <> Value then
  begin
    FTextCase := Value;
    FillItems;
  end;
end;

procedure TElDriveComboBox.SetOptions(Value: TElDriveComboOptions);
var D : Char;
    b : array[0..MAX_PATH] of char;
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    D := FDrive;
    FillItems;
    GetCurrentDirectory(MAX_PATH, b);
    FDrive := B[0];
    SetDrive(D);
  end;
end;

procedure TElDriveComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  inherited ItemHeight := Max(Abs(Font.Height) + 2 + GetSystemMetrics(SM_CXEDGE) * 2, Max(ItemHeight, GetSystemMetrics(SM_CYSMICON)));
end;

procedure TElDriveComboBox.DoChange;
begin
  inherited;
  if inherited ItemIndex = -1 then
    FDrive := #0
  else
    FDrive := Char(inherited Items[inherited ItemIndex][1]);
end;

procedure TElDriveComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('ItemHeight', FakeInteger, nil, false);
    Filer.DefineProperty('AutoCompletion', FakeBoolean, nil, false);
    Filer.DefineProperty('Text', FakeStr, nil, false);
  end;
end;

end.
