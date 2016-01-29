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
{*                  OVCMETER.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcMeter;
  {-Meter component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Graphics, Forms, Messages, SysUtils,
  OvcBase, OvcConst, OvcData;

type
  TMeterOrientation = (moHorizontal, moVertical);

const
  DefMeterBorderStyle  = bsNone;
  DefMeterCtl3D        = True;
  DefMeterDividerColor = clBlack;
  DefMeterOrientation  = moHorizontal;
  DefMeterParentCtl3D  = True;
  DefMeterPercent      = 33;
  DefMeterShowPercent  = False;
  DefMeterUsedColor    = clLime;
  DefMeterUsedShadow   = clGreen;
  DefMeterUnusedColor  = clWindow;
  DefMeterUnusedShadow = clWindowFrame;

type
  TOvcCustomMeter = class(TOvcBase)
  {.Z+}
  protected {private}
    {Property fields}
    FBorderStyle  : TBorderStyle;
    FDividerColor : TColor;
    FOrientation  : TMeterOrientation;
    FPercent      : Byte;
    FShowPercent  : Boolean;
    FUsedColor    : TColor;
    FUsedShadow   : TColor;
    FUnusedColor  : TColor;
    FUnusedShadow : TColor;

    ValueString   : string[5];

    {Property access methods}
    procedure SetBorderStyle(const BS : TBorderStyle);
    procedure SetDividerColor(const C : TColor);
    procedure SetOrientation(const O : TMeterOrientation);
    procedure SetPercent(const V : byte);
    procedure SetShowPercent(const SP : boolean);
    procedure SetUnusedColor(const C : TColor);
    procedure SetUnusedShadow(const C : TColor);
    procedure SetUsedColor(const C : TColor);
    procedure SetUsedShadow(const C : TColor);

    {VCL control messages}
    procedure CMCtl3DChanged(var Msg : TMessage);
      message CM_CTL3DCHANGED;

  protected
    {VCL methods}
    procedure CreateParams(var Params: TCreateParams);
      override;
    procedure Paint;
      override;
  {.Z-}

  public
    {VCL methods}
    constructor Create(AOwner : TComponent);
      override;

    {public properties}
    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default DefMeterBorderStyle;

    property Canvas;

    property DividerColor : TColor
       read FDividerColor
       write SetDividerColor
       default DefMeterDividerColor;

    property Orientation : TMeterOrientation
      read FOrientation
      write SetOrientation
      default DefMeterOrientation;

    property ShowPercent : boolean
      read FShowPercent
      write SetShowPercent
      default DefMeterShowPercent;

    property UnusedColor : TColor
      read FUnusedColor
      write SetUnusedColor
      default DefMeterUnusedColor;

    property UnusedShadow : TColor
      read FUnusedShadow
      write SetUnusedShadow
      default DefMeterUnusedShadow;

    property UsedColor : TColor
      read FUsedColor
      write SetUsedColor
      default DefMeterUsedColor;

    property UsedShadow : TColor
      read FUsedShadow
      write SetUsedShadow
      default DefMeterUsedShadow;

    property Percent : Byte
      read FPercent
      write SetPercent
      default DefMeterPercent;
  end;

  TOvcMeter = class(TOvcCustomMeter)
  published
    property BorderStyle;
    property DividerColor;
    property Orientation;
    property Percent;
    property ShowPercent;
    property UnusedColor;
    property UnusedShadow;
    property UsedColor;
    property UsedShadow;

    {inherited properties}
    property Align;
    property Ctl3D;
    property Font;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;

    {inherited events}
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


{*** TOvcMeter ***}

procedure TOvcCustomMeter.CMCtl3DChanged(var Msg : TMessage);
begin
  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {$IFDEF Win32}
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;
  {$ENDIF}

  inherited;
end;

constructor TOvcCustomMeter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {$IFDEF Win32}
  if NewStyleControls then
    ControlStyle := ControlStyle + [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque, csFramed];
  {$ELSE}
    ControlStyle := ControlStyle + [csOpaque, csFramed];
  {$ENDIF}

  {defaults}
  FBorderStyle  := DefMeterBorderStyle;
  FOrientation  := DefMeterOrientation;
  FPercent      := DefMeterPercent;
  FShowPercent  := DefMeterShowPercent;
  FUnusedColor  := DefMeterUnusedColor;
  FUnusedShadow := DefMeterUnusedShadow;
  FUsedColor    := DefMeterUsedColor;
  FUsedShadow   := DefMeterUsedShadow;

  ValueString   := Format('%d%%', [FPercent]);

  Width         := 200;
  Height        := 24;
  Ctl3D         := DefMeterCtl3D;
  ParentCtl3D   := DefMeterParentCtl3D;
end;

procedure TOvcCustomMeter.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do
    Style := LongInt(Style) or BorderStyles[FBorderStyle];             {!!.D4}

  {$IFDEF Win32}
  if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  {$ENDIF}
end;

procedure TOvcCustomMeter.Paint;
var
  MemBM      : TBitMap;
  TextWd     : Integer;
  TextHt     : Integer;
  UsedLen    : Integer;
  UnusedLen  : Integer;
  MeterLen   : Integer;
  DividerPos : Integer;
  WideShadow : boolean;
begin
  MemBM := TBitMap.Create;
  try
    MemBM.Width := ClientWidth;
    MemBM.Height := ClientHeight;

    {calculate dimensions of both sides, position of divider, etc}
    WideShadow := (ClientWidth > 5) and (ClientHeight > 5);
    if (FOrientation = moVertical) then
      MeterLen := ClientHeight
    else
      MeterLen := ClientWidth;
    DividerPos := (longint(FPercent) * MeterLen) div 100;
    if (DividerPos < 3) then begin
      UsedLen := 0;
      UnusedLen := MeterLen;
    end else if (DividerPos = MeterLen) then begin
      UsedLen := MeterLen;
      UnusedLen := 0;
    end else begin
      if (DividerPos > MeterLen-3) then
        DividerPos := MeterLen-3;
      UsedLen := DividerPos;
      UnusedLen := MeterLen - UsedLen - 1; {1 for the divider}
    end;

    {draw the meter based on the orientation}
    if (Orientation = moHorizontal) then begin
      with MemBM.Canvas do begin
        {draw the used side of the meter}
        if (UsedLen > 0) then begin
          Brush.Color := UsedColor;
          FillRect(Rect(0, 0, UsedLen, ClientHeight));
          Pen.Color := UsedShadow;
          MoveTo(0, ClientHeight-1);
          LineTo(0, 0);
          LineTo(UsedLen, 0);
          if WideShadow then begin
            MoveTo(1, ClientHeight-1);
            LineTo(1, 1);
            LineTo(UsedLen, 1);
          end;
        end;

        {draw the divider}
        Pen.Color := DividerColor;
        MoveTo(UsedLen, 0);
        LineTo(UsedLen, ClientHeight);

        {draw the unused side}
        if (UnusedLen > 0) then begin
          Brush.Color := UnusedColor;
          FillRect(Rect(UsedLen+1, 0, ClientWidth, ClientHeight));
          Pen.Color := UnusedShadow;
          MoveTo(UsedLen+1, 0);
          LineTo(ClientWidth, 0);
          if WideShadow then begin
            MoveTo(UsedLen+1, 1);
            LineTo(ClientWidth, 1);
          end;
        end;
      end
    end else begin {it's vertical}
      with MemBM.Canvas do begin
        {draw the unused side of the meter}
        if (UnusedLen > 0) then begin
          Brush.Color := UnusedColor;
          FillRect(Rect(0, 0, ClientWidth, UnusedLen));
          Pen.Color := UnusedShadow;
          MoveTo(0, UnusedLen-1);
          LineTo(0, 0);
          LineTo(ClientWidth, 0);
          if WideShadow then begin
            MoveTo(1, UnusedLen-1);
            LineTo(1, 1);
            LineTo(ClientWidth, 1);
          end;
        end;

        {draw the divider}
        Pen.Color := DividerColor;
        MoveTo(0, UnusedLen);
        LineTo(ClientWidth, UnusedLen);

        {draw the used side}
        if (UsedLen > 0) then begin
          Brush.Color := UsedColor;
          FillRect(Rect(0, UnusedLen+1, ClientWidth, ClientHeight));
          Pen.Color := UsedShadow;
          MoveTo(0, UnusedLen+1);
          LineTo(0, ClientHeight);
          if WideShadow then begin
            MoveTo(1, UnusedLen+1);
            LineTo(1, ClientHeight);
          end;
        end;
      end;
    end;

    if ShowPercent then
      with MemBM.Canvas do begin
        Font := Self.Font;
        Brush.Style := bsClear;
        TextHt := TextHeight(ValueString);
        TextWd := TextWidth(ValueString);
        TextOut((ClientWidth-TextWd) div 2, (ClientHeight-TextHt) div 2, ValueString);
      end;

    Canvas.Draw(0, 0, MemBM);
  finally
    MemBM.Free;
  end;
end;

procedure TOvcCustomMeter.SetBorderStyle(const BS : TBorderStyle);
begin
  if (BS <> BorderStyle) then begin
    FBorderStyle := BS;
    RecreateWnd;
  end;
end;

procedure TOvcCustomMeter.SetDividerColor(const C : TColor);
begin
  if (C <> FDividerColor) then begin
    FDividerColor := C;
    Invalidate;
  end;
end;

procedure TOvcCustomMeter.SetOrientation(const O : TMeterOrientation);
var
  TempVar : Integer;
begin
  if (O <> FOrientation) then begin
    FOrientation := O;

    {when switching orientation, make the new meter have the same
     origin, but swap the width and height values}
    if not (csLoading in ComponentState) then begin
      TempVar := Width;
      Width := Height;
      Height := TempVar;
    end;
    Invalidate;
  end;
end;

procedure TOvcCustomMeter.SetShowPercent(const SP : boolean);
begin
  if (SP <> FShowPercent) then begin
    FShowPercent := SP;
    Invalidate;
  end;
end;

procedure TOvcCustomMeter.SetUnusedColor(const C : TColor);
begin
  if (C <> FUnusedColor) then begin
    FUnusedColor := C;
    Invalidate;
  end;
end;

procedure TOvcCustomMeter.SetUnusedShadow(const C : TColor);
begin
  if (C <> FUnusedShadow) then begin
    FUnusedShadow := C;
    Invalidate;
  end;
end;

procedure TOvcCustomMeter.SetUsedColor(const C : TColor);
begin
  if (C <> FUsedColor) then begin
    FUsedColor := C;
    Invalidate;
  end;
end;

procedure TOvcCustomMeter.SetUsedShadow(const C : TColor);
begin
  if (C <> FUsedShadow) then begin
    FUsedShadow := C;
    Invalidate;
  end;
end;

procedure TOvcCustomMeter.SetPercent(const V : byte);
var
  NewValue : Integer;
begin
  {Validate the new value to range 0..100}
  if (V > 100) then
    NewValue := 100
  else
    NewValue := V;

  if (NewValue <> FPercent) then begin
    FPercent := NewValue;
    ValueString := Format('%d%%', [V]);
    Repaint;
  end;
end;



end.