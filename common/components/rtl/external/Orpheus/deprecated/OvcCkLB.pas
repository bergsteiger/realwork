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
{*                  OVCCKLB.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcCkLb;
  {-Checked listbox control}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Forms, Graphics, Menus, Messages, StdCtrls,
  SysUtils, OvcVer;

const
  DefBoldX          = False;
  DefBoxBackColor   = clWindow;
  DefBoxClickOnly   = True;
  DefBoxFrameColor  = clWindowText;
  DefBoxMargin      = 2;
  DefCheckMark      = False;
  DefCheckXColor    = clWindowText;
  DefGlyphMaskColor = clWhite;
  DefShowGlyphs     = False;
  DefWantDblClicks  = True;

type
  TOvcCheckList = class(TCustomListBox)
  {.Z+}
  protected {private}
    {property variables}
    FBoldX          : Boolean;      {true for bold X in box}
    FBoxBackColor   : TColor;       {box background color}
    FBoxClickOnly   : Boolean;      {true for state change in box only}
    FBoxFrameColor  : TColor;       {box frame color}
    FBoxMargin      : Integer;      {margin around the box}
    FCheckMark      : Boolean;      {true to draw a check instead of an X}
    FCheckXColor    : TColor;       {color of check or X}
    FGlyphMaskColor : TColor;       {hidden color for glyphs}
    FShowGlyphs     : Boolean;      {true to display glyphs}
    FWantDblClicks  : Boolean;      {true to include cs_dblclks style}

    {property methods}
    function GetGlyphs(Index : Integer) : TBitmap;
    function GetVersion : string;                                      {!!.13}
    procedure SetBoxBackColor(Value : TColor);
    procedure SetBoxFrameColor(Value : TColor);
    procedure SetBoxMargin(Value : Integer);
    procedure SetCheckMark(Value : Boolean);
    procedure SetGlyphMaskColor(Value : TColor);
    procedure SetGlyphs(Index : Integer; Glyph : TBitmap);
    procedure SetShowGlyphs(Value : Boolean);
    procedure SetWantDblClicks(Value : Boolean);
    procedure SetVersion(Value : string);                              {!!.13}

    {windows message response methods}
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;
    procedure WMNCHitTest(var Msg : TMessage);
      message WM_NCHITTEST;

    {VCL message response methods}
    procedure CNDrawItem(var Msg : TWMDrawItem);
      message CN_DRAWITEM;

  protected
    procedure CreateParams(var Params : TCreateParams);
      override;
    procedure DrawItem(Index : Integer; Rect : TRect; State : TOwnerDrawState);
      override;

    {protected properties}
    property ExtendedSelect
      default False;
    property MultiSelect
      default True;
    property Style
      default lbOwnerDrawFixed;

  public
    constructor Create(AOwner : TComponent);
      override;
  {.Z-}

    {public properties}
    property Canvas;

    property Glyphs[Index : Integer] : TBitmap
      read GetGlyphs
      write SetGlyphs;

  published
    property BoldX : Boolean
      read FBoldX
      write FBoldX
      default DefBoldX;

    property BoxBackColor  : TColor
      read FBoxBackColor
      write SetBoxBackColor
      default DefBoxBackColor;

    property BoxClickOnly : Boolean
      read FBoxClickOnly
      write FBoxClickOnly
      default DefBoxClickOnly;

    property BoxFrameColor : TColor
      read FBoxFrameColor
      write SetBoxFrameColor
      default DefBoxFrameColor;

    property BoxMargin : Integer
      read FBoxMargin
      write SetBoxMargin
      default DefBoxMargin;

    property CheckMark : Boolean
      read FCheckMark
      write SetCheckMark
      default DefCheckMark;

    property CheckXColor : TColor
      read FCheckXColor
      write FCheckXColor
      default DefCheckXColor;

    property GlyphMaskColor : TColor
      read FGlyphMaskColor
      write SetGlyphMaskColor
      default DefGlyphMaskColor;

    property ShowGlyphs : Boolean
      read FShowGlyphs
      write SetShowGlyphs
      default DefShowGlyphs;

    property WantDblClicks : Boolean
      read FWantDblClicks
      write SetWantDblClicks
      default DefWantDblClicks;

    property Version : string                                          {!!.13}
      read GetVersion                                                  {!!.13}
      write SetVersion                                                 {!!.13}
      stored False;                                                    {!!.13}

    {inherited properties}
    property Align;
    property BorderStyle;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property IntegralHeight;
    property Items;
    property ItemHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    {$IFDEF Win32}
    property TabWidth;
    {$ENDIF}
    property TabStop;
    property Visible;

    {inherited events}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
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


{*** TOvcCheckList ***}

procedure TOvcCheckList.CNDrawItem(var Msg : TWMDrawItem);
var
  State : TOwnerDrawState;
  G     : TBitmap;
begin
  with Msg.DrawItemStruct^ do begin
    {$IFDEF Win32}
    //State := TOwnerDrawState(WordRec(LongRec(itemState).Lo).Lo);
    {$ELSE}
    State := TOwnerDrawState(WordRec(itemState).Lo);
    {$ENDIF}
    Canvas.Handle := hDC;
    Canvas.Font := Font;
    Canvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (odSelected in State) then begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
      Canvas.FillRect(rcItem);
    if odFocused in State then begin
      rcItem.Left := rcItem.Left + rcItem.Bottom-rcItem.Top - BoxMargin div 2;
      Dec(rcItem.Left);

      if ShowGlyphs and (Items.Objects[ItemID] <> nil) then begin
        if Items.Objects[ItemID] is TBitmap then begin
          G := TBitmap(Items.Objects[ItemID]);
          if not G.Empty then
            rcItem.Left := rcItem.Left + BoxMargin + G.Width;
        end;
      end;

      DrawFocusRect(hDC, rcItem);
    end;
    Canvas.Handle := 0;
  end;
end;

constructor TOvcCheckList.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {must have multi-select}
  ExtendedSelect  := False;
  MultiSelect     := True;
  Style           := lbOwnerDrawFixed;

  FBoldX          := DefBoldX;
  FBoxBackColor   := DefBoxBackColor;
  FBoxClickOnly   := DefBoxClickOnly;
  FBoxFrameColor  := DefBoxFrameColor;
  FBoxMargin      := DefBoxMargin;
  FCheckMark      := DefCheckMark;
  FCheckXColor    := DefCheckXColor;
  FGlyphMaskColor := DefGlyphMaskColor;
  FWantDblClicks  := DefWantDblClicks;
end;

procedure TOvcCheckList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  {set style to reflect desire for double clicks}
  if FWantDblClicks then
    ControlStyle := ControlStyle + [csDoubleClicks]
  else
    ControlStyle := ControlStyle - [csDoubleClicks];
end;

procedure TOvcCheckList.DrawItem(Index : Integer; Rect : TRect;
          State : TOwnerDrawState);
var
  W : Integer;
  X : Integer;
  Y : Integer;
  M : Integer;
  G : TBitmap;
  B : array[0..255] of Char;
begin
  {set colors and clear area}
  Canvas.Font.Color := Font.Color;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(Rect);

  M := BoxMargin;

  {determine width/height of the rectangle}
  W := Rect.Bottom - Rect.Top - 2*M;
  if not Odd(W) then
    Dec(W);

  {draw the box}
  Canvas.Brush.Color := BoxBackColor;
  Canvas.Pen.Color := BoxFrameColor;
  Canvas.Rectangle(Rect.Left + M, Rect.Top + M, Rect.Left + W + M, Rect.Top + W + M);

  {check/X pen color}
  Canvas.Pen.Color := CheckXColor;

  if CheckMark then begin
    {draw the check mark}
    if odSelected in State then begin
      Y := W div 2 + 1;
      for X := 2 to (W div 3) do begin
        Canvas.MoveTo(Rect.Left + M + X, Rect.Top + M + Y - 1);
        Canvas.LineTo(Rect.Left + M + X, Rect.Top + M + Y + 2);
        Inc(Y);
      end;
      Dec(Y, 2);
      for X := (W div 3) + 1 to W - 3 do begin
        Canvas.MoveTo(Rect.Left + M + X, Rect.Top + M + Y - 1);
        Canvas.LineTo(Rect.Left + M + X, Rect.Top + M + Y + 2);
        Dec(Y);
      end;
    end;
  end else begin
    {draw the X mark?}
    if odSelected in State then begin
      if BoldX then begin
        Canvas.MoveTo(Rect.Left + M + 1, Rect.Top + M + 2);
        Canvas.LineTo(Rect.Left + W + M - 2, Rect.Top + W + M - 1);
        Canvas.MoveTo(Rect.Left + M + 2, Rect.Top + M + 1);
        Canvas.LineTo(Rect.Left + W + M - 1, Rect.Top + W + M - 2);
      end;
      Canvas.MoveTo(Rect.Left + M + 1, Rect.Top + M + 1);
      Canvas.LineTo(Rect.Left + W + M - 1, Rect.Top + W + M - 1);
      if BoldX then begin
        Canvas.MoveTo(Rect.Left + M + 1, Rect.Top + W + M - 3);
        Canvas.LineTo(Rect.Left + W + M - 2, Rect.Top + M);
        Canvas.MoveTo(Rect.Left + M + 2, Rect.Top + W + M - 2);
        Canvas.LineTo(Rect.Left + W + M - 1, Rect.Top + M + 1);
      end;
      Canvas.MoveTo(Rect.Left + M + 1, Rect.Top + W + M - 2);
      Canvas.LineTo(Rect.Left + W + M - 1, Rect.Top + M);
    end;
  end;

  {draw glyphs if enabled}
  if ShowGlyphs and (Items.Objects[Index] <> nil) then begin
    if Items.Objects[Index] is TBitmap then begin
      G := TBitmap(Items.Objects[Index]);
      if not G.Empty then begin
        X := Rect.Left + M + W + M;
        Y := Rect.Top + ((Rect.Bottom - Rect.Top) - G.Height) div 2;
        if Y < 0 then
          Y := 0;

        Canvas.Brush.Color := Color;
        Canvas.BrushCopy(Classes.Rect(X, Y, X + G.Width, Y + G.Height),
          G, Classes.Rect(0, 0, G.Width, G.Height), GlyphMaskColor);

        {adjust width to account for glyph}
        W := W + M + G.Width;
      end;
    end;
  end;

  {draw the text}
  Canvas.Brush.Color := Color;
  Canvas.Pen.Color := Font.Color;
  if (Index > -1) and (Index < Items.Count) then begin
    Y := Canvas.TextHeight(Items[Index]);
    Y := Rect.Top + ((Rect.Bottom - Rect.Top) - Y) div 2;
    StrPLCopy(B, Items[Index], 255);
    ExtTextOut(Canvas.Handle, Rect.Left + M + W + M, Y, ETO_CLIPPED,
      @Rect, B, StrLen(B), nil);
  end;

  {redraw top item to avoid windows bug}                               {!!.16}
  if FShowGlyphs and (Index <> TopIndex) then begin                    {!!.16}
    State := [];                                                       {!!.16}
    if SendMessage(Handle, LB_GETSEL, TopIndex, 0) > 0 then            {!!.16}
      State := [odSelected];                                           {!!.16}
    if (ItemIndex = TopIndex) and Focused then                         {!!.16}
      State := State + [odFocused];                                    {!!.16}
    SendMessage(Handle, LB_GETITEMRECT, TopIndex, LongInt(@Rect));     {!!.16}
    DrawItem(TopIndex, Rect, State);                                   {!!.16}
  end;                                                                 {!!.16}
end;

function TOvcCheckList.GetGlyphs(Index : Integer) : TBitmap;
begin
  Result := nil;
  if (Index > -1) and (Index < Items.Count) then
    if Items.Objects[Index] is TBitmap then
      Result := TBitmap(Items.Objects[Index]);
end;

{!!.13}
function TOvcCheckList.GetVersion : string;
begin
  Result := OvcVersionStr;
end;

procedure TOvcCheckList.SetBoxBackColor(Value : TColor);
begin
  if (Value <> FBoxBackColor) then begin
    FBoxBackColor := Value;
    Refresh;
  end;
end;

procedure TOvcCheckList.SetBoxFrameColor(Value : TColor);
begin
  if (Value <> FBoxFrameColor) then begin
    FBoxFrameColor := Value;
    Refresh;
  end;
end;

procedure TOvcCheckList.SetBoxMargin(Value : Integer);
begin
  if (Value <> FBoxMargin) and (Value >= 0) and (ItemHeight - 2*Value > 0) then begin
    FBoxMargin := Value;
    Refresh;
  end;
end;

procedure TOvcCheckList.SetCheckMark(Value : Boolean);
begin
  if (Value <> FCheckMark) then begin
    FCheckMark := Value;
    Refresh;
  end;
end;

procedure TOvcCheckList.SetGlyphMaskColor(Value : TColor);
begin
  if (Value <> FGlyphMaskColor) then begin
    FGlyphMaskColor := Value;
    Refresh;
  end;
end;

procedure TOvcCheckList.SetGlyphs(Index : Integer; Glyph : TBitmap);
begin
  if (Index > -1) and (Index < Items.Count) then
    Items.Objects[Index] := Glyph;
end;

procedure TOvcCheckList.SetShowGlyphs(Value : Boolean);
begin
  if (Value <> FShowGlyphs) then begin
    FShowGlyphs := Value;
    Refresh;
  end;
end;

procedure TOvcCheckList.SetWantDblClicks(Value : Boolean);
  {-set the WantDblClicks property value}
begin
  if Value <> FWantDblClicks then begin
    FWantDblClicks := Value;
    RecreateWnd;
  end;
end;

{!!.13}
procedure TOvcCheckList.SetVersion(Value : string);
begin
end;

{!!.12} {revised}
procedure TOvcCheckList.WMLButtonDown(var Msg : TWMLButtonDown);
var
  I : Integer;
  P : TPoint;
  R : TRect;
begin
  if not Focused then
    SetFocus;

  P.X := Msg.XPos;
  P.Y := Msg.YPos;
  I := ItemAtPos(P, True);
  if I > -1 then begin
    FillChar(R, SizeOf(R), #0);
    SendMessage(Handle, LB_GETITEMRECT, I, LongInt(@R));
    if (not BoxClickOnly) or ((Msg.XPos >= R.Left) and
       (Msg.XPos <= R.Left + ItemHeight - BoxMargin div 2)) then
      inherited
    else
      SendMessage(Handle, LB_SETCARETINDEX, I, 0);
  end else
    inherited;
end;

procedure TOvcCheckList.WMNCHitTest(var Msg : TMessage);
begin
  if (csDesigning in ComponentState) then
    DefaultHandler(Msg)
  else
    inherited;
end;


end.