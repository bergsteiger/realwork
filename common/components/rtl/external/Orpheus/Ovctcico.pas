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
{*                  OVCTCICO.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTCIco;
  {-Orpheus Table Cell - Icon type}

interface

uses
  {$IFDEF Win32}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils, Messages,
  Graphics, Classes, Controls, Forms, StdCtrls, Menus,
  OvcData, OvcConst, OvcBase,
  OvcTCmmn, OvcTCell, OvcTGRes, OvcTable;

type
  TOvcTCCustomIcon = class(TOvcBaseTableCell)
    protected
      {.Z+}
      procedure tcPaint(TableCanvas : TCanvas;
                  const CellRect    : TRect;
                        RowNum      : TRowNum;
                        ColNum      : TColNum;
                  const CellAttr    : TOvcCellAttributes;
                        Data        : pointer); override;
      {.Z-}
    public
      {.Z+}
      procedure ResolveAttributes(RowNum : TRowNum; ColNum : TColNum;
                                  var CellAttr : TOvcCellAttributes); override;
      {.Z-}
  end;

  TOvcTCIcon = class(TOvcTCCustomIcon)
    published
      {properties inherited from custom ancestor}
      property AcceptActivationClick;
      property Access;
      property Adjust;
      property Color;
      property Margin;
      property Table;
      property TableColor;
      property OnOwnerDraw;
  end;


implementation


{===TOvcTCBaseBitMap=================================================}
procedure TOvcTCCustomIcon.tcPaint(TableCanvas : TCanvas;
                             const CellRect    : TRect;
                                   RowNum      : TRowNum;
                                   ColNum      : TColNum;
                             const CellAttr    : TOvcCellAttributes;
                                   Data        : pointer);
  var
    Icon              : TIcon absolute Data;
    Wd, Ht            : integer;
    CellWidth         : integer;
    CellHeight        : integer;
    Left, Top         : integer;
    CellAdj           : TOvcTblAdjust;
  begin
    {blank out the cell (also sets the brush color)}
    inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, Data);
    {nothing else to do if the data is nil or the cell in invisible}
    if (Data = nil) or
       (CellAttr.caAccess = otxInvisible) then
      Exit;
    {make a note of the adjustment, calc the cell width and height}
    CellAdj := CellAttr.caAdjust;
    CellWidth := CellRect.Right - CellRect.Left;
    CellHeight := CellRect.Bottom - CellRect.Top;
    {get the width/height of the icon}
    with Icon do
      begin
        Wd := Width;
        Ht := Height;
      end;
    {calculate the destination position}
    case CellAdj of
      otaTopLeft, otaCenterLeft, otaBottomLeft :
         Left := Margin;
      otaTopRight, otaCenterRight, otaBottomRight :
         Left := (CellWidth - Wd - Margin);
    else
      Left := (CellWidth - Wd) div 2;
    end;{case}
    inc(Left, CellRect.Left);
    case CellAdj of
      otaTopLeft, otaTopCenter, otaTopRight :
         Top := Margin;
      otaBottomLeft, otaBottomCenter, otaBottomRight :
         Top := (CellHeight - Ht - Margin);
    else
      Top := (CellHeight - Ht) div 2;
    end;{case}
    inc(Top, CellRect.Top);

    TableCanvas.Draw(Left, Top, Icon);
  end;
{--------}
procedure TOvcTCCustomIcon.ResolveAttributes(RowNum : TRowNum; ColNum : TColNum;
                                         var CellAttr : TOvcCellAttributes);
  begin
    inherited ResolveAttributes(RowNum, ColNum, CellAttr);
    case CellAttr.caAccess of
      otxDefault, otxNormal : CellAttr.caAccess := otxReadOnly;
    end;{case}
  end;
{====================================================================}


end.
