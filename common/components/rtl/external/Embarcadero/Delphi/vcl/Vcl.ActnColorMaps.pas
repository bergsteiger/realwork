{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.ActnColorMaps;

interface

uses Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.ActnMan;

type

{ TStandardColorMap }

  TStandardColorMap = class(TCustomActionBarColorMap)
  protected
    procedure SetColor(const Value: TColor); override;
  public
    procedure UpdateColors; override;
  published
    // HighlightColor and UnusedColor should stream before Color
    property HighlightColor;
    property UnusedColor;
    property BtnFrameColor default clBtnFace;
    property BtnSelectedColor default clBtnFace;
    property BtnSelectedFont default clWindowText;
    property Color default clBtnFace;
    property DisabledFontColor default clGrayText;
    property DisabledFontShadow default clBtnHighlight;
    property FontColor default clWindowText;
    property HotColor default clDefault;
    property HotFontColor default clDefault;
    property MenuColor default clBtnFace;
    property FrameTopLeftInner default clBtnHighlight;
    property FrameTopLeftOuter default cl3DLight;
    property FrameBottomRightInner default clBtnShadow;
    property FrameBottomRightOuter default cl3DDkShadow;
    property DisabledColor default clDefault;
    property SelectedColor default clMenuHighlight;
    property SelectedFontColor default clHighlightText;
    property ShadowColor default clBtnShadow;
    property OnColorChange;
  end;

{ TXPColorMap }

const
  cXPFrameOuter = $007A868A;
  cXPBtnFrameColor = $00C66931;
  cXPSelectedColor = $00EFD3C6;

type
  TXPColorMap = class(TCustomActionBarColorMap)
  public
    procedure UpdateColors; override;
  published
    property ShadowColor default cl3DDkShadow;
    property Color default clBtnFace;
    property DisabledColor default clGray;
    property DisabledFontColor default clGrayText;
    property DisabledFontShadow default clBtnHighlight;
    property FontColor default clWindowText;
    property HighlightColor;
    property HotColor default clDefault;
    property HotFontColor default clDefault;
    property MenuColor default clWindow;
    property FrameTopLeftInner default clWhite;
    property FrameTopLeftOuter default cXPFrameOuter;
    property FrameBottomRightInner default clWhite;
    property FrameBottomRightOuter default cXPFrameOuter;
    property BtnFrameColor default cXPBtnFrameColor;
    property BtnSelectedColor default clWhite;
    property BtnSelectedFont default clWindowText;
    property SelectedColor default cXPSelectedColor;
    property SelectedFontColor default clBlack;
    property UnusedColor;
    property OnColorChange;
  end;

{ TTwilightColorMap }

  TTwilightColorMap = class(TCustomActionBarColorMap)
  public
    procedure UpdateColors; override;
  published
    property Color default clBlack;
    property DisabledFontColor default clGrayText;
    property DisabledFontShadow default clBlack;
    property FontColor default clWhite;
    property HighlightColor;
    property HotColor default clDefault;
    property HotFontColor default clWhite;
    property FrameTopLeftInner default clBlack;
    property FrameTopLeftOuter default cl3DDkShadow;
    property FrameBottomRightInner default clBlack;
    property FrameBottomRightOuter default cl3DDkShadow;
    property BtnFrameColor default cl3DDkShadow;
    property BtnSelectedColor default cl3DDkShadow;
    property BtnSelectedFont default clBlack;
    property MenuColor default clBlack;
    property DisabledColor default clDefault;
    property SelectedColor default cl3dDkShadow;
    property SelectedFontColor default clBlack;
    property ShadowColor default clBlack;
    property UnusedColor default clBlack;
    property OnColorChange;
  end;

  TThemedColorMap = class(TCustomActionBarColorMap)
  public
    procedure UpdateColors; override;
  published
    property ShadowColor default cl3DDkShadow;
    property Color default clMenuBar;
    property DisabledColor default clGray;
    property DisabledFontColor default clGrayText;
    property DisabledFontShadow default $00FCF7F4;
    property FontColor default clBlack;
    property HighlightColor;
    property HotColor default clDefault;
    property HotFontColor default clDefault;
    property MenuColor default clMenu;
    property FrameTopLeftInner default $00FCF7F4;
    property FrameTopLeftOuter default $00646464;
    property FrameBottomRightInner default $00FCF7F4;
    property FrameBottomRightOuter default $00646464;
    property BtnFrameColor default $00646464;
    property BtnSelectedColor default clMenuHighlight;
    property BtnSelectedFont default clWindowText;
    property SelectedColor default clMenuHighlight;
    property SelectedFontColor default clBlack;
    property UnusedColor;
    property OnColorChange;
  end;

implementation

uses Vcl.GraphUtil, Vcl.Themes, Winapi.UxTheme;

{ TStandardColorMap }

procedure TStandardColorMap.SetColor(const Value: TColor);
begin
  if Value <> Color then
  begin
    HighlightColor := GetHighlightColor(Value);
    UnusedColor := GetHighlightColor(Value, 10);
  end;
  inherited;
end;

procedure TStandardColorMap.UpdateColors;
var
  FlatMenus: BOOL;
begin
  inherited;
  FlatMenus := False;
  SystemParametersInfo(SPI_GETFLATMENU, 0, {$IFNDEF CLR}@{$ENDIF}FlatMenus, 0);
  BtnFrameColor := clBtnFace;
  BtnSelectedColor := clBtnFace;
  BtnSelectedFont := clWindowText;
  Color := clBtnFace;
  if FlatMenus then
    MenuColor := clMenu
  else
    MenuColor := clBtnFace;
  DisabledFontColor := clGrayText;
  DisabledFontShadow := clBtnHighlight;
  DisabledColor := clDefault;
  FontColor := clWindowText;
  FrameTopLeftInner := clBtnHighlight;
  FrameTopLeftOuter := cl3DLight;
  FrameBottomRightInner := clBtnShadow;
  FrameBottomRightOuter := cl3DDkShadow;
  HighlightColor := GetHighlightColor(Color);
  HotColor := clDefault;
  HotFontColor := clDefault;
  if FlatMenus then
    SelectedColor := clMenuHighlight
  else
    SelectedColor := clHighlight;
  SelectedFontColor := clHighlightText;
  ShadowColor := clBtnShadow;
  UnusedColor := GetHighlightColor(Color, 18);
end;

{ TXPColorMap }

procedure TXPColorMap.UpdateColors;
begin
  inherited;
  Color := clBtnFace;
  MenuColor := clWindow;
  BtnFrameColor := cXPBtnFrameColor;
  BtnSelectedColor := clBtnFace;
  BtnSelectedFont := clWindowText;
  DisabledFontColor := clGrayText;
  DisabledFontShadow := clBtnHighlight;
  DisabledColor := clGray;
  FontColor := clWindowText;
  FrameTopLeftInner := clWhite;
  FrameTopLeftOuter := cXPFrameOuter;
  FrameBottomRightInner := clWhite;
  FrameBottomRightOuter := cXPFrameOuter;
  HighlightColor := GetHighLightColor(clBtnFace, 15);
  HotColor := clDefault;
  HotFontColor := clDefault;
  SelectedColor := cXPSelectedColor;
  SelectedFontColor := clBlack;
  ShadowColor := cl3DDkShadow;
  UnusedColor := GetHighLightColor(clBtnFace, 15);
end;

{ TTwilightColorMap }

procedure TTwilightColorMap.UpdateColors;
begin
  inherited;
  Color := clBlack;
  MenuColor := clBlack;
  DisabledFontColor := clGrayText;
  DisabledFontShadow := clBlack;
  DisabledColor := cl3DDkShadow;
  FontColor := clWhite;
  FrameTopLeftInner := clBlack;
  FrameTopLeftOuter := cl3DDkShadow;
  FrameBottomRightInner := clBlack;
  FrameBottomRightOuter := cl3DDkShadow;
  HighlightColor := clBlack;
  HotColor := clDefault;
  HotFontColor := clWhite;
  BtnSelectedColor := cl3DDkShadow;
  BtnSelectedFont := clBlack;
  SelectedColor := cl3DDkShadow;
  SelectedFontColor := clBlack;
  ShadowColor := clBlack;
  UnusedColor := clBlack;
end;

{ TThemedColorMap }

procedure TThemedColorMap.UpdateColors;
var
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LDetails: TThemedElementDetails;
begin
  inherited;
  // Set default colors (based on Vista Aero Theme)
  Color := clMenuBar;
  MenuColor := clMenu;
  BtnFrameColor := $00646464;
  BtnSelectedColor := clMenuHighlight;
  BtnSelectedFont := clWindowText;
  DisabledFontColor := clGrayText;
  DisabledFontShadow := $00FCF7F4;
  DisabledColor := clGray;
  FontColor := clBlack;
  FrameTopLeftInner := $00FCF7F4;
  FrameTopLeftOuter := $00646464;
  FrameBottomRightInner := $00FCF7F4;
  FrameBottomRightOuter := $00646464;
  HighlightColor := GetHighLightColor(clBtnFace, 15);
  HotColor := clDefault;
  HotFontColor := clDefault;
  SelectedColor := clMenuHighlight;
  SelectedFontColor := clBlack;
  ShadowColor := cl3DDkShadow;
  UnusedColor := GetHighLightColor(clBtnFace, 15);

  // Retrieve themed button colors
  LStyle := StyleServices;

  LDetails := LStyle.GetElementDetails(tbPushButtonNormal);
  if LStyle.GetElementColor(LDetails, ecEdgeDkShadowColor, LColor) and (LColor <> clNone) then
    BtnFrameColor := LColor;
  if LStyle.GetElementColor(LDetails, ecTextColor, LColor) and (LColor <> clNone) then
    FontColor := LColor;

  // Retrieve themed menu colors
  LDetails := LStyle.GetElementDetails(tmMenuBarBackgroundActive);
  if LStyle.GetElementColor(LDetails, ecFillColor, LColor) and (LColor <> clNone) then
    Color := LColor;

  LDetails := LStyle.GetElementDetails(tmPopupItemHot);
  if LStyle.GetElementColor(LDetails, ecTextColor, LColor) and (LColor <> clNone) then
  begin
    BtnSelectedFont := LColor;
    SelectedFontColor := LColor;
  end;

  LDetails := LStyle.GetElementDetails(tmPopupItemDisabled);
  if LStyle.GetElementColor(LDetails, ecTextColor, LColor) and (LColor <> clNone) then
    DisabledFontColor := LColor;
  if LStyle.GetElementColor(LDetails, ecEdgeHighLightColor, LColor) and (LColor <> clNone) then
    DisabledFontShadow := LColor;

  LDetails := LStyle.GetElementDetails(tmPopupBackground);
  if LStyle.GetElementColor(LDetails, ecEdgeHighLightColor, LColor) and (LColor <> clNone) then
  begin
    FrameTopLeftInner := LColor;
    FrameBottomRightInner := LColor;
  end;
  if LStyle.GetElementColor(LDetails, ecEdgeDkShadowColor, LColor) and (LColor <> clNone) then
  begin
    FrameTopLeftOuter := LColor;
    FrameBottomRightOuter := LColor;
  end;
end;

end.
