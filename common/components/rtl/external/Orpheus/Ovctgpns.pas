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
{*                  OVCTGPNS.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTGPns;
  {-Orpheus Table - grid pens}

interface

uses
  Classes, Graphics;

type
  TGridEffect = (geNone, geVertical, geHorizontal, geBoth, ge3D);

type
  TOvcGridPen = class(TPersistent)
    protected {private}
      {.Z+}
      FNormalColor : TColor;
      FSecondColor : TColor;
      FEffect      : TGridEffect;
      FStyle       : TPenStyle;

      FOnCfgChanged  : TNotifyEvent;
      {.Z-}

    protected
      {.Z+}
      procedure SetNormalColor(C : TColor);
      procedure SetSecondColor(C : TColor);
      procedure SetEffect(E : TGridEffect);
      procedure SetStyle(S : TPenStyle);

      procedure DoCfgChanged;
      {.Z-}

    public {protected}
      {.Z+}
      property OnCfgChanged : TNotifyEvent
         read FOnCfgChanged write FOnCfgChanged;
      {.Z-}

    public
      constructor Create;
      procedure Assign(Source : TPersistent); override;

    published
      property NormalColor : TColor
         read FNormalColor write SetNormalColor;

      property SecondColor : TColor
         read FSecondColor write SetSecondColor;

      property Style : TPenStyle
         read FStyle write SetStyle;

      property Effect : TGridEffect
         read FEffect write SetEffect;
  end;

  TOvcGridPenSet = class(TPersistent)
    protected {private}
      {.Z+}
      FNormalGrid        : TOvcGridPen;
      FLockedGrid        : TOvcGridPen;
      FCellWhenFocused   : TOvcGridPen;
      FCellWhenUnfocused : TOvcGridPen;
      {.Z-}

    protected
      {.Z+}
      procedure SetOnCfgChanged(OC : TNotifyEvent);
      {.Z-}

    public {protected}
      {.Z+}
      property OnCfgChanged : TNotifyEvent
         write SetOnCfgChanged;
      {.Z-}

    public
      constructor Create;
      destructor Destroy; override;

      procedure Assign(Source : TPersistent); override;

    published
      property NormalGrid : TOvcGridPen
         read FNormalGrid write FNormalGrid;

      property LockedGrid : TOvcGridPen
         read FLockedGrid write FLockedGrid;

      property CellWhenFocused : TOvcGridPen
         read FCellWhenFocused write FCellWhenFocused;

      property CellWhenUnfocused : TOvcGridPen
         read FCellWhenUnfocused write FCellWhenUnfocused;
  end;

implementation


{===TOvcGridPen==========================================================}
constructor TOvcGridPen.Create;
  begin
    FNormalColor := clBtnShadow;
    FSecondColor := clBtnHighlight;
    FStyle := psSolid;
    FEffect := geBoth;
  end;
{--------}
procedure TOvcGridPen.Assign(Source : TPersistent);
  var
    Src : TOvcGridPen absolute Source;
  begin
    if (Source is TOvcGridPen) then
      begin
        FNormalColor := Src.NormalColor;
        FSecondColor := Src.SecondColor;
        FStyle := Src.Style;
        FEffect := Src.Effect;
        DoCfgChanged;
      end;
  end;
{--------}
procedure TOvcGridPen.DoCfgChanged;
  begin
    if Assigned(FOnCfgChanged) then
      OnCfgChanged(Self);
  end;
{--------}
procedure TOvcGridPen.SetNormalColor(C : TColor);
  begin
    if (C <> FNormalColor) then
      begin
        FNormalColor := C;
        DoCfgChanged;
      end;
  end;
{--------}
procedure TOvcGridPen.SetSecondColor(C : TColor);
  begin
    if (C <> FSecondColor) then
      begin
        FSecondColor := C;
        DoCfgChanged;
      end;
  end;
{--------}
procedure TOvcGridPen.SetStyle(S : TPenStyle);
  begin
    if (S <> FStyle) then
      begin
        FStyle := S;
        DoCfgChanged;
      end;
  end;
{--------}
procedure TOvcGridPen.SetEffect(E : TGridEffect);
  begin
    if (E <> FEffect) then
      begin
        FEffect := E;
        DoCfgChanged;
      end;
  end;
{=====================================================================}


{===TOvcGridPenSet=======================================================}
constructor TOvcGridPenSet.Create;
  begin
    FNormalGrid := TOvcGridPen.Create;
    with FNormalGrid do
      begin
        Style := psDot;
      end;
    FLockedGrid := TOvcGridPen.Create;
    with FLockedGrid do
      begin
        Effect := ge3D;
      end;
    FCellWhenFocused := TOvcGridPen.Create;
    with FCellWhenFocused do
      begin
        NormalColor := clBlack;
      end;
    FCellWhenUnfocused := TOvcGridPen.Create;
    with FCellWhenUnfocused do
      begin
        NormalColor := clBlack;
        Style := psDash;
      end;
  end;
{--------}
destructor TOvcGridPenSet.Destroy;
  begin
    FNormalGrid.Free;
    FLockedGrid.Free;
    FCellWhenFocused.Free;
    FCellWhenUnfocused.Free;
  end;
{--------}
procedure TOvcGridPenSet.Assign(Source : TPersistent);
  var
    Src : TOvcGridPenSet absolute Source;
  begin
    if (Source is TOvcGridPenSet) then
      begin
        FNormalGrid.Assign(Src.NormalGrid);
        FLockedGrid.Assign(Src.LockedGrid);
        FCellWhenFocused.Assign(Src.CellWhenFocused);
        FCellWhenUnfocused.Assign(Src.CellWhenUnfocused);
      end;
  end;
{--------}
procedure TOvcGridPenSet.SetOnCfgChanged(OC : TNotifyEvent);
  begin
    FNormalGrid.OnCfgChanged := OC;
    FLockedGrid.OnCfgChanged := OC;
    FCellWhenFocused.OnCfgChanged := OC;
    FCellWhenUnfocused.OnCfgChanged := OC;
  end;
{=====================================================================}


end.
