{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCRLBL.PAS 2.17                     *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcRLbl;
  {-Rotated label component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Forms, Graphics, Menus, Messages, SysUtils,
  OvcConst, OvcData, OvcExcpt, OvcMisc, OvcVer;

const
  {default property values}
  rlDefAlignment      = taLeftJustify;
  rlDefAutoSizeHeight = False;
  rlDefAutoSizeWidth  = False;
  rlDefFontAngle      = 0;
  rlDefFontName       = 'Courier New';
  rlDefHeight         = 20;
  rlDefShadowColor    = clBtnShadow;
  rlDefShadowedText   = False;
  rlDefTransparent    = False;
  rlDefWidth          = 130;
  rlDefOriginX        = 0;
  rlDefOriginY        = 0;

type
  TOvcCustomRotatedLabel = class(TGraphicControl)
  {.Z+}
  protected {private}
    {property instance variables}
    FAlignment      : TAlignment;
    FAutoSizeHeight : Boolean;
    FAutoSizeWidth  : Boolean;
    FCaption        : string;
    FFontAngle      : Integer;
    FOriginX        : Integer;
    FOriginY        : Integer;
    FShadowColor    : TColor;       {color for text shadowing}
    FShadowedText   : Boolean;      {true to draw shadowed text}

    {property methods}
    function GetTransparent : Boolean;
    function GetVersion : string;                                      {!!.13}
    procedure SetAlignment(Value : TAlignment);
    procedure SetAutoSizeHeight(Value : Boolean);
    procedure SetAutoSizeWidth(Value : Boolean);
    procedure SetCaption(const Value : string);
    procedure SetOriginX(Value : Integer);
    procedure SetOriginY(Value : Integer);
    procedure SetShadowColor(const Value : TColor);
    procedure SetShadowedText(Value : Boolean);
    procedure SetTransparent(Value : Boolean);
    procedure SetFontAngle(Value : Integer);
    procedure SetVersion(Value : string);                              {!!.13}

    {internal methods}
    procedure lblAdjustSize;
      {-adjust horizontal and/or vertical size of control}
    procedure lblDrawText(var R : TRect; Flags : Word);
      {-draw the label text}

    {VCL message handling methods}
    procedure CMFontChanged(var Msg : TMessage);
      message CM_FONTCHANGED;

    {windows message response methods}
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd);
      message WM_ERASEBKGND;

  protected
    procedure Loaded;
      override;
    procedure Paint;
      override;
    procedure SetName(const NewName : TComponentName);
      override;
  {.Z-}

    property Alignment : TAlignment
      read FAlignment
      write SetAlignment
      default rlDefAlignment;

    property AutoSizeHeight : Boolean
      read FAutoSizeHeight
      write SetAutoSizeHeight
      default rlDefAutoSizeHeight;

    property AutoSizeWidth : Boolean
      read FAutoSizeWidth
      write SetAutoSizeWidth
      default rlDefAutoSizeWidth;

    property Caption : string
      read FCaption
      write SetCaption;

    property FontAngle : Integer
      read FFontAngle
      write SetFontAngle
      default rlDefFontAngle;

    property OriginX : Integer
      read FOriginX
      write SetOriginX;

    property OriginY : Integer
      read FOriginY
      write SetOriginY;

    property ShadowColor : TColor
      read FShadowColor
      write SetShadowColor
      default rlDefShadowColor;

    property ShadowedText : Boolean
      read FShadowedText
      write SetShadowedText
      default rlDefShadowedText;

    property Transparent  : Boolean
      read GetTransparent
      write SetTransparent
      default rlDefTransparent;

  public
    constructor Create(AOwner: TComponent);
      override;

    {public properties}
    property Canvas;

  published                                                            {!!.13}
    property Version : string                                          {!!.13}
      read GetVersion                                                  {!!.13}
      write SetVersion                                                 {!!.13}
      stored False;                                                    {!!.13}
  end;

  TOvcRotatedLabel = class(TOvcCustomRotatedLabel)
  published
    property Align;
    property Alignment;
    property AutoSizeHeight;
    property AutoSizeWidth;
    property Caption;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property FontAngle;
    property OriginX;
    property OriginY;
    property ParentColor;
    {property ParentFont;}                                             {!!.10}
    property ParentShowHint;
    property PopupMenu;
    property ShadowColor;
    property ShadowedText;
    property ShowHint;
    property Transparent;
    property Visible;

    {events}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


{*** TOvcCustomRotatedLabel ***}

procedure TOvcCustomRotatedLabel.CMFontChanged(var Msg : TMessage);
var
  TM  : TTextMetric;
begin
  inherited;

  if csLoading in ComponentState then
    Exit;

  if FontAngle <> 0 then begin
    {check if the current font can be rotated}
    Canvas.Font := Self.Font;
    GetTextMetrics(Canvas.Handle, TM);
    if (TM.tmPitchAndFamily and TMPF_TRUETYPE) = 0 then
      {force zero font angle}
      FontAngle := 0;
  end;
  lblAdjustSize;
end;

constructor TOvcCustomRotatedLabel.Create(AOwner : TComponent);
{$IFDEF TRIALRUN}
var
    X : Integer;
{$ENDIF}
begin
  inherited Create(AOwner);

  {$IFDEF Win32}
  ControlStyle := ControlStyle + [csReplicatable];
  {$ENDIF}

  if rlDefTransparent then
    ControlStyle := ControlStyle - [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque];

  {default property values}
  FAlignment      := rlDefAlignment;
  FAutoSizeHeight := rlDefAutoSizeHeight;
  FAutoSizeWidth  := rlDefAutoSizeWidth;
  FFontAngle      := rlDefFontAngle;
  FOriginX        := rlDefOriginX;
  FOriginY        := rlDefOriginY;
  FShadowColor    := rlDefShadowColor;
  FShadowedText   := rlDefShadowedText;

  Font.Name       := rlDefFontName;
  Height          := rlDefHeight;
  Width           := rlDefWidth;

  if csDesigning in ComponentState then
    lblAdjustSize;

{$IFDEF TRIALRUN}
  X := _CC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
  X := _VC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
{$ENDIF}
end;

function TOvcCustomRotatedLabel.GetTransparent : Boolean;
begin
  Result := not (csOpaque in ControlStyle);
end;

{!!.13}
function TOvcCustomRotatedLabel.GetVersion : string;
begin
  Result := OvcVersionStr;
end;

procedure TOvcCustomRotatedLabel.lblAdjustSize;
  {-adjust horizontal and/or vertical size of control}
var
  DC : hDC;
  R  : TRect;
begin
  if not (csLoading in ComponentState) and (FontAngle = 0) and
     (FAutoSizeHeight or FAutoSizeWidth) then begin
    R := ClientRect;
    DC := GetDC(0);

    try
      Canvas.Handle := DC;
      try
        lblDrawText(R, DT_CALCRECT);
      finally
        Canvas.Handle := 0;
      end;
    finally
      ReleaseDC(0, DC);
    end;

    if not FAutoSizeHeight then
      R.Bottom := Height;
    if not FAutoSizeWidth then
      R.Right := Width;

    SetBounds(Left, Top, R.Right, R.Bottom);
  end;
end;

procedure TOvcCustomRotatedLabel.lblDrawText(var R : TRect; Flags : Word);
  {-paint the controls display or calculate a TRect to fit text}
var
  HoldColor : TColor;
  T         : string;
  XO, YO    : Integer;
  A         : Integer;
  Buf       : array[0..255] of Char;
begin
  T := Caption;
  if (Flags and DT_CALCRECT <> 0) and (T = '') then
    T := ' ';

  Flags := Flags or DT_NOPREFIX;

  {use our font}
  Canvas.Font := Font;

  {create the rotated font}
  if FontAngle <> 0 then
    Canvas.Font.Handle := CreateRotatedFont(Font, FontAngle);

  {force disabled text color, if not enabled}
  if not Enabled then
    Canvas.Font.Color := clGrayText;

  {draw the text}
  StrPLCopy(Buf, T, 255);
  if FontAngle = 0 then begin
    {draw shadow first, if selected}
    if FShadowedText then begin
      HoldColor := Canvas.Font.Color;
      Canvas.Font.Color := FShadowColor;
      if not Transparent then begin
        SetBkMode(Canvas.Handle, OPAQUE);
        Canvas.Brush.Color := Color;
      end;
      OffsetRect(R, +2, +1);
      DrawText(Canvas.Handle, @Buf, -1, R, Flags);
      Canvas.Font.Color := HoldColor;
      {$IFDEF Win32}
      SetBkMode(Canvas.Handle, Windows.TRANSPARENT);
      {$ELSE}
      SetBkMode(Canvas.Handle, WinTypes.TRANSPARENT);
      {$ENDIF}
      OffsetRect(R, -2, -1);
      DrawText(Canvas.Handle, @Buf, -1, R, Flags);
    end else begin
      DrawText(Canvas.Handle, @Buf, -1, R, Flags)
    end;
  end else begin
    if FShadowedText then begin
      HoldColor := Canvas.Font.Color;
      Canvas.Font.Color := FShadowColor;
      if not Transparent then begin
        {$IFDEF Win32}
        SetBkMode(Canvas.Handle, Windows.OPAQUE);
        {$ELSE}
        SetBkMode(Canvas.Handle, WinTypes.OPAQUE);
        {$ENDIF}
        Canvas.Brush.Color := Color;
      end;
      {calculate the shadow offset based on the quadrant the text is in}
      {        |          }  { 1 -- X+2, Y+1}
      {     2  |  1       }  { 2 -- X-1, Y-2}
      { -------+--------- }  { 3 -- X+2, Y+1}
      {     3  |  4       }  { 4 -- X-1, Y-2}
      {        |          }
      A := FontAngle;
      if A < 0 then A := 360 + A;
      if A >= 270 then begin
        XO :=  2; YO :=  1;  {Quad=4}
      end else if A >= 180 then begin
        XO :=  2; YO :=  1;  {Quad=3}
      end else if A >= 90 then begin
        XO :=  2; YO :=  1;  {Quad=2}
      end else begin
        XO :=  2; YO :=  1;  {Quad=1}
      end;
      ExtTextOut(Canvas.Handle, OriginX+XO, OriginY+YO, ETO_CLIPPED,
        @R, Buf, StrLen(Buf), nil);
      Canvas.Font.Color := HoldColor;
      {$IFDEF Win32}
      SetBkMode(Canvas.Handle, Windows.TRANSPARENT);
      {$ELSE}
      SetBkMode(Canvas.Handle, WinTypes.TRANSPARENT);
      {$ENDIF}
      ExtTextOut(Canvas.Handle, OriginX, OriginY, ETO_CLIPPED,
        @R, Buf, StrLen(Buf), nil);
    end else begin
      ExtTextOut(Canvas.Handle, OriginX, OriginY, ETO_CLIPPED,
        @R, Buf, StrLen(Buf), nil);
    end;
  end;
end;

procedure TOvcCustomRotatedLabel.Loaded;
begin
  inherited Loaded;

  lblAdjustSize;
end;

procedure TOvcCustomRotatedLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  R : TRect;
begin
  R := ClientRect;
  with Canvas do begin
    if not Transparent then begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(R);
    end;
    Brush.Style := bsClear;
    lblDrawText(R, Alignments[FAlignment])
  end;
end;

procedure TOvcCustomRotatedLabel.SetAlignment(Value : TAlignment);
  {-set the text alignment option}
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TOvcCustomRotatedLabel.SetAutoSizeHeight(Value : Boolean);
  {-set the auto size height option}
begin
  if Value <> FAutoSizeHeight then begin
    FAutoSizeHeight := Value;
    lblAdjustSize;
  end;
end;

procedure TOvcCustomRotatedLabel.SetAutoSizeWidth(Value : Boolean);
  {-set the auto size width option}
begin
  if Value <> FAutoSizeWidth then begin
    FAutoSizeWidth := Value;
    lblAdjustSize;
  end;
end;

procedure TOvcCustomRotatedLabel.SetCaption(const Value : string);
begin
  if Value <> FCaption then begin
    FCaption := Value;
    lblAdjustSize;
    Repaint;
  end;
end;

procedure TOvcCustomRotatedLabel.SetOriginX(Value : Integer);
begin
  if Value <> FOriginX then begin
    FOriginX := Value;
    Invalidate;
  end;
end;

procedure TOvcCustomRotatedLabel.SetOriginY(Value : Integer);
begin
  if Value <> FOriginY then begin
    FOriginY := Value;
    Invalidate;
  end;
end;

procedure TOvcCustomRotatedLabel.SetShadowColor(const Value : TColor);
begin
  if Value <> FShadowColor then begin
    FShadowColor := Value;
    invalidate;
  end;
end;

procedure TOvcCustomRotatedLabel.SetShadowedText(Value : Boolean);
begin
  if Value <> FShadowedText then begin
    FShadowedText := Value;
    Invalidate;
  end;
end;

procedure TOvcCustomRotatedLabel.SetTransparent(Value : Boolean);
begin
  if Transparent <> Value then begin
    if Value then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

procedure TOvcCustomRotatedLabel.SetFontAngle(Value : Integer);
var
  Neg : Integer;
  TM  : TTextMetric;
begin
  if Value <> FFontAngle then begin
    {check if the current font can be rotated}
    if not (csLoading in ComponentState) then begin
      if Value <> 0 then begin
        Canvas.Font := Self.Font;
        GetTextMetrics(Canvas.Handle, TM);
        if (TM.tmPitchAndFamily and TMPF_TRUETYPE) = 0 then
          {force true-type font}
          Font.Name := rlDefFontName;
      end;
    end;
    if Value < 0 then Neg := -1 else Neg := 1;
    FFontAngle := (Abs(Value) mod 360) * Neg;

    {repaint with new font}
    Invalidate;
  end;
end;

procedure TOvcCustomRotatedLabel.SetName(const NewName : TComponentName);
begin
  inherited SetName(NewName);
  if (csDesigning in ComponentState) and (FCaption = '') then
    FCaption := Self.Name;
end;

{!!.13}
procedure TOvcCustomRotatedLabel.SetVersion(Value : string);
begin
end;

procedure TOvcCustomRotatedLabel.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  Msg.Result := 1;  {don't erase background}
end;



end.