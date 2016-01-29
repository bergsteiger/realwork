unit fcText;
{
//
// Common Text handling routines
//
// Copyright (c) 1999 by Woll2Woll Software
//
//
// 5/20/99 - Added to correct bug where text was not painted in the proper position when rotated.  -ksw
// 6/4/99 - Use font's charset
}

interface

uses Classes, Graphics, Windows, SysUtils, Math, fcCommon, Dialogs, Forms;

type
  TfcVAlignment = (vaTop, vaVCenter, vaBottom);

  TfcTextStyle = (fclsDefault, fclsLowered, fclsRaised,
    fclsOutline);

  TfcOrientation = (fcTopLeft, fcTopRight, fcBottomLeft, fcBottomRight,
    fcTop, fcRight, fcLeft, fcBottom);

  TfcTextOption = (toShowAccel, toShowEllipsis);
  TfcTextOptions = set of TfcTextOption;

type
  {
  // Any component that uses TfcText MUST implement this interface.
  // The Invalidate method can just be the one defined in TControl, so
  // it does not need to be redefined.
  //
  // If the component is Delphi 4 only, then GetTextEnabled can be
  // implemented as:
  //
  // function IfcTextControl.GetTextEnabled = GetEnabled;
  //
  // This works, because Delphi 4 declares a GetEnabled access method
  // that is available to descendant classes.  Otherwise, just implement
  // a method that returns the state of the Enabled property
  // (i.e. "result := Enabled;").
  //
  // AdjustBounds will be called whenever a property of TfcText is
  // manipulated such that the rect that the text uses changes.
  // TfcCustomLabel uses this method in conjunction with the AutoSize
  // property to resize the label if neccessary.
  }
{
  IfcTextControl = interface
    procedure Invalidate;
    procedure AdjustBounds;
    function GetTextEnabled: Boolean;
  end;
}
  TfcTextCallbacks = record
    Invalidate: TfcProcMeth;
    AdjustBounds: TfcProcMeth;
    GetTextEnabled: TfcBoolFunc;
  end;

  TfcText = class;

  {
  // Properties related to the Shadow effects of TfcText.
  //
  // Properties:
  // - Color:   The color of the shadow.
  //
  // - Enabled: Determines whether or not to actually display the
  //            shadow.
  //
  // - XOffset, YOffset: Determines how much and in what direction,
  //            the shadow is offset from the main text.  Negative
  //            values are valid.
  //
  // Methods:
  // - EffectiveOffset: Returns an empty point (x: 0, y: 0) if shadows
  //            are disabled, otherwise returns Point(XOffset, YOffset).
  }

  TfcShadowEffects = class(TPersistent)
  private
    FText: TfcText;

    // Property Storage Variables
    FColor: TColor;
    FEnabled: Boolean;
    FXOffset: Integer;
    FYOffset: Integer;

    // Property Access Methods
    procedure SetColor(Value: TColor);
    procedure SetEnabled(Value: Boolean);
    procedure SetXOffset(Value: Integer);
    procedure SetYOffset(Value: Integer);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Text: TfcText);
    function EffectiveOffset: TPoint;
  published
    // Published Properties
    property Color: TColor read FColor write SetColor default clBtnShadow;
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property XOffset: Integer read FXOffset write SetXOffset default 10;
    property YOffset: Integer read FYOffset write SetYOffset default 10;
  end;

  {
  // Properties related to 3d text effects such as embossing, extrusion,
  // etc.
  //
  // Properties:
  // - Color:    The color of the extrusion nearest to the actual
  //             text.
  //
  // - Depth:    How many pixels (layers) the extrusion is.  The larger
  //             this value, the more layers need to be painted and,
  //             therefore, the slower the algorithm.
  //
  // - Enabled:  Determines whether or not to paint the extrusion.
  //
  // - Orientation: Determines the direction that the extrusion points away from
  //             from the text.
  }

  TfcExtrudeEffects = class(TPersistent)
  private
    FText: TfcText;

    // Property Storage Variables
    FDepth: Integer;
    FEnabled: Boolean;
    FFarColor: TColor;
    FNearColor: TColor;
    FOrientation: TfcOrientation;
    FStriated: Boolean;

    // Property Access Methods
    procedure SetDepth(Value: Integer);
    procedure SetEnabled(Value: Boolean);
    procedure SetFarColor(Value: TColor);
    procedure SetNearColor(Value: TColor);
    procedure SetOrientation(Value: TfcOrientation);
    procedure SetStriated(Value: Boolean);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Text: TfcText);
    function EffectiveDepth(CheckOrient: Boolean): TSize;
  published
    // Published Properties
    property Depth: Integer read FDepth write SetDepth default 10;
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property FarColor: TColor read FFarColor write SetFarColor default clBlack;
    property NearColor: TColor read FNearColor write SetNearColor default clBlack;
    property Orientation: TfcOrientation read FOrientation write SetOrientation default fcBottomRight;
    property Striated: Boolean read FStriated write SetStriated default False;
  end;

  TfcDisabledColors = class(TPersistent)
  private
    FText: TfcText;
    FHighlightColor: TColor;
    FShadeColor: TColor;
    procedure SetHighlightColor(Value: TColor);
    procedure SetShadeColor(Value: TColor);
  public
    constructor Create(Text: TfcText);
  published
    property HighlightColor: TColor read FHighlightColor write SetHighlightColor default clBtnHighlight;
    property ShadeColor: TColor read FShadeColor write SetShadeColor default clBtnShadow;
  end;

  TfcText = class(TPersistent)
  private
    FRect: TRect;

    // Property storage variables
    FAlignment: TAlignment;
    FCanvas: TCanvas;
    FDisabledColors: TfcDisabledColors;
    FExtrudeEffects: TfcExtrudeEffects;
    FHighlightColor: TColor;
    FFlags: UINT;
    FFont: TFont;
    FLineSpacing: Integer;
    FOptions: TfcTextOptions;
    FOutlineColor: TColor;
    FRotation: Integer;
    FScaledFont: Boolean;
    FShadeColor: TColor;
    FShadow: TfcShadowEffects;
    FStyle: TfcTextStyle;
    FText: string;
    FCallbacks: TfcTextCallbacks;
    FTextRect: TRect;
    FVAlignment: TfcVAlignment;
    FWordWrap: Boolean;

    // Property access methods
    function GetAngle: Extended;
    procedure SetAlignment(Value: TAlignment);
    procedure SetHighlightColor(Value: TColor);
    procedure SetLineSpacing(Value: Integer);
    procedure SetOptions(Value: TfcTextOptions);
    procedure SetOutlineColor(Value: TColor);
    procedure SetRotation(Value: Integer);
    procedure SetScaledFont(Value: Boolean);
    procedure SetShadeColor(Value: TColor);
    procedure SetStyle(Value: TfcTextStyle);
    procedure SetText(Value: string);
    procedure SetTextRect(Value: TRect);
    procedure SetVAlignment(Value: TfcVAlignment);
    procedure SetWordWrap(Value: Boolean);
  protected
    // Protected methods
    function GetLogFont: TLogFont; virtual;
    function GetTextSize: TSize; virtual;
    function CalcTextSize(IgnoreRect: Boolean): TSize; virtual;
    function CalcRect(IgnoreRect: Boolean): TRect; virtual;
    procedure DrawHighlight; virtual;
    procedure DrawOutline; virtual;
    procedure DrawShadow(r: TRect); virtual;
    procedure DrawEmbossed(Raised: Boolean);
    procedure DrawText(r: TRect); virtual;

    procedure AssignTo(Dest: TPersistent); override;

    property Angle: Extended read GetAngle;
    property Font: TFont read FFont;
  public
    Patch: Variant;

    constructor Create(ACallbacks: TfcTextCallbacks; ACanvas: TCanvas; AFont: TFont);
    destructor Destroy; override;

    // Fancy Text Routines
    function CalcDrawRect(IgnoreRect: Boolean): TRect; virtual;
    procedure CallInvalidate; virtual;
    procedure Draw; virtual;
    procedure DrawStandardText; virtual;
    procedure DrawOutlineText; virtual;
    procedure DrawEmbossedText(Raised: Boolean); virtual;
    procedure DrawExtrusion;
    procedure PrepareCanvas; virtual;

    property Alignment: TAlignment read FAlignment write SetAlignment;
    property Canvas: TCanvas read FCanvas write FCanvas;
    property Callbacks: TfcTextCallbacks read FCallbacks write FCallbacks;
    property DisabledColors: TfcDisabledColors read FDisabledColors write FDisabledColors;
    property ExtrudeEffects: TfcExtrudeEffects read FExtrudeEffects write FExtrudeEffects;
    property Flags: UINT read FFlags write FFlags;
    property HighlightColor: TColor read FHighlightColor write SetHighlightColor default clBtnHighlight;
    property LineSpacing: Integer read FLineSpacing write SetLineSpacing default 5;
    property Options: TfcTextOptions read FOptions write SetOptions default [toShowAccel];
    property OutlineColor: TColor read FOutlineColor write SetOutlineColor default clBlack;
    property Rotation: Integer read FRotation write SetRotation default 0;
    property ScaledFont: Boolean read FScaledFont write SetScaledFont;
    property ShadeColor: TColor read FShadeColor write SetShadeColor default clBtnShadow;
    property Shadow: TfcShadowEffects read FShadow write FShadow;
    property Style: TfcTextStyle read FStyle write SetStyle default fclsDefault;
    property Text: string read FText write SetText;
    property TextRect: TRect read FTextRect write SetTextRect;
    property VAlignment: TfcVAlignment read FVAlignment write SetVAlignment;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
  end;

  TfcCaptionText = class(TfcText)
  published
    property Alignment;
    property DisabledColors;
    property ExtrudeEffects;
    property HighlightColor;
    property LineSpacing;
    property Options;
    property OutlineColor;
    property Rotation;
    property ShadeColor;
    property Shadow;
    property Style;
    property VAlignment;
    property WordWrap;
  end;

  function MakeCallbacks(InvalidateProc, AdjustBoundsProc: TfcProcMeth;
    GetTextEnabledProc: TfcBoolFunc): TfcTextCallbacks;

implementation

const
  OFFSETCOORD: array[TfcOrientation] of TPoint = (
    (x: 1; y: 1) {TopLeft}, (x: -1; y: 1) {TopRight},
    (x: 1; y: -1) {BottomLeft}, (x: -1; y: -1) {BottomRight},
    (x: 0; y: 1) {Top}, (x: -1; y: 0) {Right},
    (x: 1; y: 0) {Left}, (x: 0; y: -1) {Bottom}
  );

{ RSW - Trunc has problems in C++ Builder during compile time }
function fcTrunc(val: Extended): Longint;
begin
   result:= Round(Val-0.4999); { Changed from -0.5 }
end;

function MakeCallbacks(InvalidateProc, AdjustBoundsProc: TfcProcMeth;
  GetTextEnabledProc: TfcBoolFunc): TfcTextCallbacks;
begin
  result.Invalidate := InvalidateProc;
  result.AdjustBounds := AdjustBoundsProc;
  result.GetTextEnabled := GetTextEnabledProc;
end;

constructor TfcDisabledColors.Create(Text: TfcText);
begin
  inherited Create;
  FText := Text;
  FHighlightColor := clBtnHighlight;
  FShadeColor := clBtnShadow;
end;

procedure TfcDisabledColors.SetHighlightColor(Value: TColor);
begin
  if FHighlightColor <> Value then
  begin
    FHighlightColor := Value;
    FText.Callbacks.Invalidate;
  end;
end;

procedure TfcDisabledColors.SetShadeColor(Value: TColor);
begin
  if FShadeColor <> Value then
  begin
    FShadeColor := Value;
    FText.Callbacks.Invalidate;
  end;
end;

// TfcShadowEffects

procedure TfcShadowEffects.AssignTo(Dest: TPersistent);
begin
  with Dest as TfcShadowEffects do
  begin
    Color := self.Color;
    Enabled := self.Enabled;
    XOffset := self.XOffset;
    YOffset := self.YOffset;
  end;
end;

constructor TfcShadowEffects.Create(Text: TfcText);
begin
  inherited Create;

  FText := Text;

  FColor := clBtnShadow;
  FXOffset := 10;
  FYOffset := 10;
end;

function TfcShadowEffects.EffectiveOffset: TPoint;
begin
  result := Point(0,0);
  if Enabled then result := Point(XOffset, YOffset);
  if FText.ExtrudeEffects.Enabled then with OFFSETCOORD[FText.ExtrudeEffects.Orientation] do
  begin
    if not ((x >= 0) = (result.x > 0)) then
      result.x := 0;
    if not ((y >= 0) = (result.y > 0)) then
      result.y := 0;
  end;
end;

procedure TfcShadowEffects.SetColor(Value:TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FText.CallInvalidate;
  end;
end;

procedure TfcShadowEffects.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

procedure TfcShadowEffects.SetXOffset(Value: Integer);
begin
  if FXOffset <> Value then
  begin
    FXOffset := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

procedure TfcShadowEffects.SetYOffset(Value: Integer);
begin
  if FYOffset <> Value then
  begin
    FYOffset := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

// TfcExtrudeEffects

constructor TfcExtrudeEffects.Create(Text: TfcText);
begin
  inherited Create;
  FText := Text;

  FDepth := 10;
  FOrientation := fcBottomRight;
end;

procedure TfcExtrudeEffects.AssignTo(Dest: TPersistent);
begin
  with Dest as TfcExtrudeEffects do
  begin
    Depth := self.Depth;
    Enabled := self.Enabled;
    FarColor := self.FarColor;
    NearColor := self.NearColor;
    Orientation := self.Orientation;
    Striated := self.Striated;
  end;
end;

function TfcExtrudeEffects.EffectiveDepth(CheckOrient: Boolean): TSize;
begin
  result := fcSize(Depth, Depth);
  if Enabled then with OFFSETCOORD[FText.ExtrudeEffects.Orientation] do
  begin
    if CheckOrient then
      result := fcSize(Depth * Abs(x), Depth * Abs(y));
  end else result := fcSize(0,0);
end;

procedure TfcExtrudeEffects.SetDepth(Value: Integer);
begin
  if FDepth <> Value then
  begin
    FDepth := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

procedure TfcExtrudeEffects.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

procedure TfcExtrudeEffects.SetFarColor(Value: TColor);
begin
  if FFarColor <> Value then
  begin
    FFarColor := Value;
    FText.CallInvalidate;
  end;
end;

procedure TfcExtrudeEffects.SetNearColor(Value: TColor);
begin
  if FNearColor <> Value then
  begin
    FNearColor := Value;
    FText.CallInvalidate;
  end;
end;

procedure TfcExtrudeEffects.SetOrientation(Value: TfcOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    FText.Callbacks.AdjustBounds;
    FText.CallInvalidate;
  end;
end;

procedure TfcExtrudeEffects.SetStriated(Value: Boolean);
begin
  if FStriated <> Value then
  begin
    FStriated := Value;
    FText.CallInvalidate;
  end;
end;

constructor TfcText.Create(ACallbacks: TfcTextCallbacks; ACanvas: TCanvas; AFont: TFont);
begin
  inherited Create;
  FCallbacks := ACallbacks;

  FCanvas := ACanvas;
  FFont := AFont;

  FExtrudeEffects := TfcExtrudeEffects.Create(self);
  FHighlightColor := clBtnHighlight;
  FLineSpacing := 5;
  FOptions := [toShowAccel];
  FShadeColor := clBtnShadow;
  FShadow := TfcShadowEffects.Create(self);
  FDisabledColors := TfcDisabledColors.Create(self);

  FFlags := DT_NOCLIP;
end;

destructor TfcText.Destroy;
begin
  FExtrudeEffects.Free;
  FShadow.Free;
  FDisabledColors.Free;
  inherited;
end;

procedure TfcText.AssignTo(Dest: TPersistent);
begin
  with Dest as TfcText do
  begin
    ExtrudeEffects.Assign(self.ExtrudeEffects);
    HighlightColor := self.HighlightColor;
    LineSpacing := self.LineSpacing;
    Options := self.Options;
    OutlineColor := self.OutlineColor;
    Rotation := self.Rotation;
    ShadeColor := self.ShadeColor;
    Shadow.Assign(self.Shadow);
    Style := self.Style;
    Text := self.Text;
  end;
end;

function TfcText.GetAngle: Extended;
begin
  result := DegToRad(Rotation);
end;

procedure TfcText.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    CallInvalidate;
  end;
end;

procedure TfcText.SetLineSpacing(Value: Integer);
begin
  if Value <> FLineSpacing then
  begin
    FLineSpacing := Value;
    Callbacks.AdjustBounds;
    CallInvalidate;
  end;
end;

procedure TfcText.SetHighlightColor(Value: TColor);
begin
  if FHighlightColor <> Value then
  begin
    FHighlightColor := Value;
    CallInvalidate;
  end;
end;

procedure TfcText.SetOptions(Value: TfcTextOptions);
begin
  if Value <> FOptions then
  begin
    FOptions := Value;
    fcAdjustFlag(not (toShowAccel in FOptions), FFlags, DT_NOPREFIX);
    fcAdjustFlag(toShowEllipsis in FOptions, FFlags, DT_END_ELLIPSIS);
    Callbacks.AdjustBounds;
    CallInvalidate;
  end;
end;

procedure TfcText.SetOutlineColor(Value: TColor);
begin
  if Value <> FOutlineColor then
  begin
    FOutlineColor := Value;
    CallInvalidate;
  end;
end;

procedure TfcText.SetRotation(Value: Integer);
begin
  if (Value < 0) then FRotation := 360 - (Abs(Value) mod 360)
  else FRotation := Value mod 360;
  Callbacks.AdjustBounds;
  CallInvalidate;
end;

procedure TfcText.SetScaledFont(Value: Boolean);
begin
  if FScaledFont <> Value then
  begin
    FScaledFont := Value;
    CallInvalidate;
  end;
end;

procedure TfcText.SetShadeColor(Value: TColor);
begin
  if FShadeColor <> Value then
  begin
    FShadeColor := Value;
    CallInvalidate;
  end;
end;

procedure TfcText.SetStyle(Value: TfcTextStyle);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    Callbacks.AdjustBounds;
    CallInvalidate;
  end;
end;

procedure TfcText.SetText(Value: string);
begin
  if Value <> FText then
  begin
    FText := Value;
//    CallInvalidate;
  end;
end;

procedure TfcText.SetTextRect(Value: TRect);
begin
  FTextRect := Value;
end;

procedure TfcText.SetVAlignment(Value: TfcVAlignment);
begin
  if FVAlignment <> Value then
  begin
    FVAlignment := Value;
    CallInvalidate;
  end;
end;

procedure TfcText.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    fcAdjustFlag(WordWrap, FFlags, DT_WORDBREAK);
    CallInvalidate;
  end;
end;

function TfcText.GetLogFont: TLogFont;
const TRUETYPE: array[Boolean] of Integer = (OUT_TT_PRECIS, OUT_TT_ONLY_PRECIS);
begin
  with result do begin
    lfHeight := Font.Height;
    if ScaledFont then lfHeight := fcTrunc(lfHeight * (Screen.PixelsPerInch / 96));
    lfWidth := 0;
    lfEscapement := Rotation * 10;
    lfOrientation := Rotation * 10;

    if fsBold in Font.Style then lfWeight := FW_BOLD else lfWeight := FW_NORMAL;
    if fsItalic in Font.Style then lfItalic := 1 else lfItalic := 0;
    if fsUnderline in Font.Style then lfUnderline := 1 else lfUnderline := 0;
    if fsStrikeOut in Font.Style then lfStrikeout := 1 else lfStrikeout := 0;

    lfCharSet := ANSI_CHARSET;              {Default}

    if Font.CharSet <> DEFAULT_CHARSET then
       lfCharSet := Font.CharSet; { 6/4/99 - Use font's charset }

    lfOutPrecision := TRUETYPE[Rotation <> 0];
    lfClipPrecision := CLIP_DEFAULT_PRECIS; {Default}
    lfQuality := PROOF_QUALITY;             {Windows gets a better one if available}
    lfPitchAndFamily := VARIABLE_PITCH;     {Default}
    StrPCopy(lfFaceName, Font.Name);        {Canvas's font name}
  end;
end;

function TfcText.CalcTextSize(IgnoreRect: Boolean): TSize;
var Angle: Extended;
    TextSize: TSize;
begin
  Angle := self.Angle;
  TextSize := GetTextSize;

  // Correct for Extrusion
  with ExtrudeEffects.EffectiveDepth(True) do result := fcSize(
    TextSize.cx + cx,
    TextSize.cy + cy);

  with Shadow.EffectiveOffset do begin
    inc(result.cx, Abs(x));
    inc(result.cy, Abs(y));
  end;

  // Correct for Outline
  if Style = fclsOutline then begin
    inc(result.cx, 2);
    inc(result.cy, 2);
  end;

  // Correct for Rotation
  with result do result := fcSize(
    fcTrunc(cx * Abs(Cos(Angle)) + cy * Abs(Sin(Angle))),
    fcTrunc(cx * Abs(Sin(Angle)) + cy * Abs(Cos(Angle))));

//  IgnoreRect := False;

  // Correct for TextRect
  if not IgnoreRect then with result do result := fcSize(
    fcMin(cx, fcRectWidth(TextRect)),
    fcMin(cy, fcRectHeight(TextRect)));
end;

function TfcText.CalcRect(IgnoreRect: Boolean): TRect;
var Angle: Extended;
    TextSize: TSize;
begin
  Angle := Self.Angle;

  result.Left := TextRect.Left + fcRectWidth(TextRect) div 2;   // Place initial position in
  result.Top := TextRect.Top + fcRectHeight(TextRect) div 2;    // dead center.

  with Shadow.EffectiveOffset do
  begin
    dec(result.Left, x div 2);                 // Correct for shadow offsets.
    dec(result.Top, y div 2);
  end;

  with ExtrudeEffects.EffectiveDepth(False) do begin
    dec(result.Left, cx div 2); // Correct for extrusion
    dec(result.Top, cy div 2);
  end;

  // Now correct for rotation
  TextSize := GetTextSize;
  with TextSize do
  begin
    dec(result.Left, fcTrunc(Cos(Angle) * cx) div 2);
    inc(result.Top, fcTrunc(Sin(Angle) * cx) div 2);
    dec(result.Top, fcTrunc(Cos(Angle) * cy) div 2);
    dec(result.Left, fcTrunc(Sin(Angle) * cy) div 2);
  end;

  with CalcTextSize(IgnoreRect), result do
    result := Rect(Left, Top, Left + cx, Top + cy);

  // Make sure the point is at least at (0, 0);
//  with result do
//    OffsetRect(result, Abs(fcMin(0, Left)), Abs(fcMin(0, Top)));
  with TextRect do
    OffsetRect(result, Abs(fcMin(0, result.Left - Left)), Abs(fcMin(0, result.Top - Top)));
end;

function TfcText.GetTextSize: TSize;
var s: string;
begin
  if toShowAccel in Options then
    s := fcStripAmpersands(Text)
  else s := Text;
  with fcMultiLineTextSize(Canvas, s, LineSpacing, ord(WordWrap) * fcRectWidth(TextRect), Flags) do
    result := fcSize(cx, cy);
end;

procedure TfcText.DrawHighlight;
var r: TRect;
begin
  r := FRect;
  with OFFSETCOORD[ExtrudeEffects.Orientation] do OffsetRect(r, -x, -y);

  Canvas.Font.Color := HighlightColor;
  DrawText(r);
  Canvas.Font.Color := Font.Color;
  DrawText(FRect);
end;

procedure TfcText.DrawShadow(r: TRect);
begin
  if not Shadow.Enabled then Exit;
  OffsetRect(r, Shadow.XOffset, Shadow.YOffset);
  Canvas.Font.Color := fcThisThat(Callbacks.GetTextEnabled, Shadow.Color, DisabledColors.ShadeColor);
  DrawText(r);
end;

procedure TfcText.DrawOutline;
var i: TfcOrientation;
    r: TRect;
begin
  for i := Low(OFFSETCOORD) to HIGH(OFFSETCOORD) do with OFFSETCOORD[i] do
  begin
    r := FRect;
    OffsetRect(r, x, y);
    Canvas.Font.Color := fcThisThat(Callbacks.GetTextEnabled, OutlineColor, DisabledColors.ShadeColor);
    DrawText(r);
  end;
  r := FRect;
  Canvas.Font.Color := fcThisThat(Callbacks.GetTextEnabled, Font.Color, DisabledColors.HighlightColor);
  DrawText(r);
end;

procedure TfcText.DrawEmbossed(Raised: Boolean);
var r: TRect;
    HighlightColor, ShadeColor: TColor;
begin
  HighlightColor := fcThisThat(Callbacks.GetTextEnabled, self.HighlightColor, DisabledColors.HighlightColor);
  ShadeColor := fcThisThat(Callbacks.GetTextEnabled, self.ShadeColor, DisabledColors.ShadeColor);//clBtnShadow);

  if Callbacks.GetTextEnabled and not
    (((ShadeColor = clNone) and not Raised) or
     ((HighlightColor = clNone) and Raised)) then
  begin
    r := FRect;
    OffsetRect(r, -1, -1);
    Canvas.Font.Color := fcThisThat(Raised, HighlightColor, ShadeColor);
    DrawText(r);
  end;

  if not (((HighlightColor = clNone) and not Raised) or
      ((ShadeColor = clNone) and Raised)) then
  begin
    r := FRect;
    OffsetRect(r, 1, 1);
    Canvas.Font.Color := fcThisThat(Raised, ShadeColor, HighlightColor);
    DrawText(r);
  end;

  r := FRect;
  Canvas.Font.Color := fcThisThat(Callbacks.GetTextEnabled, Font.Color, DisabledColors.ShadeColor);
  DrawText(r);
end;

procedure TfcText.DrawText(r: TRect);
var i: Integer;
    s: string;
    Angle: Extended;
    CurLineHeight: Integer;
begin
  Angle := self.Angle;
  for i := 0 to fcCountTokens(Text, #13#10) - 1 do
  begin
    s := fcGetToken(Text, #13#10, i);
    DrawTextEx(Canvas.Handle, PChar(s), Length(s), r, Flags, nil);
    CurLineHeight := fcLineHeight(Canvas, Flags, fcRectWidth(r), s) + LineSpacing;
    OffsetRect(r,
      fcTrunc(Sin(Angle) * CurLineHeight),
      fcTrunc(Cos(Angle) * CurLineHeight)
    );
  end;
end;

// Initializes the Canvas's font using the rotation passed in.  Also
// set's the Canvas' font color to the passed in Font.Color.  The result
// is essentially the rectangle that should be used for any subsequent
// call to DrawTextEx as the position and size are calculated here.
//
// Always remember to "DeleteObject" the Canvas.Font.Handle when done.
//
// - ksw (9/28/98)

procedure TfcText.PrepareCanvas;
begin
  // Must Free This!
  Canvas.Font.Handle := CreateFontIndirect(GetLogFont);

  Canvas.Font.Color := Font.Color;

  FRect := CalcRect(False);
end;

function TfcText.CalcDrawRect(IgnoreRect: Boolean): TRect;
begin
  Canvas.Font.Handle := CreateFontIndirect(GetLogFont);
  try
    result := CalcRect(IgnoreRect);
  finally
    DeleteObject(Canvas.Font.Handle);
  end;
end;

procedure TfcText.CallInvalidate;
begin
  if Assigned(Callbacks.Invalidate) then Callbacks.Invalidate;
end;

procedure TfcText.Draw;
begin
  if Rotation mod 360 = 0 then with TextRect do
  begin
    if Alignment = taCenter then Flags := Flags or DT_CENTER else Flags := Flags and not DT_CENTER;
    if Alignment = taRightJustify then Flags := Flags or DT_RIGHT else Flags := Flags and not DT_RIGHT;
    case Alignment of
      taLeftJustify: TextRect := Rect(Left, Top, Left + fcRectWidth(CalcDrawRect(False)), Bottom);
      taRightJustify: TextRect := Rect(Right - fcRectWidth(CalcDrawRect(False)), Top, Right, Bottom);
    end;
    case VAlignment of
      vaTop: TextRect := Rect(Left, Top, Right, fcRectHeight(CalcDrawRect(False)));
      vaBottom: TextRect := Rect(Left, Bottom - fcRectHeight(CalcDrawRect(False)), Right, Bottom);
    end;
  end else Flags := Flags and not DT_CENTER and not DT_RIGHT;  // Added to correct bug where text was not painted in the proper position when rotated.  -ksw (5/20/99)

  case Style of
    fclsDefault: DrawStandardText;
    fclsLowered: DrawEmbossedText(False);
    fclsRaised: DrawEmbossedText(True);
    fclsOutline: DrawOutlineText;
  end;
end;

procedure TfcText.DrawStandardText;
begin
  // If disabled, draw the standard embossed (disabled) text.
  if not Callbacks.GetTextEnabled then
  begin
    DrawEmbossedText(False);
    Exit;
  end;

  PrepareCanvas;

  try
    DrawExtrusion;
    DrawShadow(FRect);
    Canvas.Font.Color := Font.Color;
    DrawText(FRect);
  finally
    DeleteObject(Canvas.Font.Handle);
  end;
end;

procedure TfcText.DrawOutlineText;
begin
  PrepareCanvas;
  try
    DrawExtrusion;
    DrawShadow(FRect);
    DrawOutline;
  finally
    DeleteObject(Canvas.Font.Handle);
  end;
end;

procedure TfcText.DrawEmbossedText(Raised: Boolean);
begin
  PrepareCanvas;
  try
    DrawExtrusion;
    DrawShadow(FRect);
    DrawEmbossed(Raised);
  finally
    DeleteObject(Canvas.Font.Handle);
  end;
end;

procedure TfcText.DrawExtrusion;
var ExtrudeColor, ShadeColor: TRGBQuad;
    i: Integer;
begin
  with ExtrudeEffects do
  begin
    if not Enabled then Exit;

    with ExtrudeColor do
      fcColorToByteValues(ExtrudeEffects.NearColor, rgbReserved, rgbBlue, rgbGreen, rgbRed);
    with ShadeColor do
      fcColorToByteValues(ExtrudeEffects.FarColor, rgbReserved, rgbBlue, rgbGreen, rgbRed);

    with ExtrudeEffects.EffectiveDepth(True) do
    begin
      OffsetRect(FRect, cx div 2, cy div 2);
      with OFFSETCOORD[ExtrudeEffects.Orientation] do
        OffsetRect(FRect, -x * (cx div 2), -y * (cy div 2));
    end;

    // Draw Gradiated Extrusion
    for i := 1 to Depth do
    begin
      with OFFSETCOORD[Orientation] do
        OffsetRect(FRect, x, y);

      if not Striated then Canvas.Font.Color := RGB(
        fcTrunc(ShadeColor.rgbRed + ((ExtrudeColor.rgbRed - ShadeColor.rgbRed) / (Depth / i))),
        fcTrunc(ShadeColor.rgbGreen + ((ExtrudeColor.rgbGreen - ShadeColor.rgbGreen) / (Depth / i))),
        fcTrunc(ShadeColor.rgbBlue + ((ExtrudeColor.rgbBlue - ShadeColor.rgbBlue) / (Depth / i)))
      )
      else Canvas.Font.Color := RGB(
        i * (ShadeColor.rgbRed + ((ExtrudeColor.rgbRed - ShadeColor.rgbRed) div Depth)) div (ord(i mod 2 = 0) * 3 + 1),
        i * (ShadeColor.rgbGreen + ((ExtrudeColor.rgbGreen - ShadeColor.rgbGreen) div Depth)) div (ord(i mod 2 = 0) * 3 + 1),
        i * (ShadeColor.rgbBlue + ((ExtrudeColor.rgbBlue - ShadeColor.rgbBlue) div Depth)) div (ord(i mod 2 = 0) * 3 + 1)
      );

      DrawText(FRect);
    end;
  end;
end;

end.
