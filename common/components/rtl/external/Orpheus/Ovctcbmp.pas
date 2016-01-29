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
{*                  OVCTCBMP.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTCBmp;
  {-Orpheus Table Cell - Bitmap type}

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
  TOvcTCBaseBitMap = class(TOvcBaseTableCell)
    protected
      {.Z+}
      procedure tcPaint(TableCanvas : TCanvas;
                  const CellRect    : TRect;
                        RowNum      : TRowNum;
                        ColNum      : TColNum;
                  const CellAttr    : TOvcCellAttributes;
                        Data        : pointer); override;
      {.Z-}
    public                                                             {!!.16}
      function  EditHandle : THandle; override;                        {!!.16}
      procedure EditHide; override;                                    {!!.16}
      procedure EditMove(CellRect : TRect); override;                  {!!.16}
      procedure SaveEditedData(Data : pointer); override;              {!!.16}
      procedure StartEditing(RowNum : TRowNum; ColNum : TColNum;
                             CellRect : TRect;
                       const CellAttr : TOvcCellAttributes;
                             CellStyle: TOvcTblEditorStyle;
                             Data : pointer); override;                {!!.16}
      procedure StopEditing(SaveValue : boolean;
                            Data : pointer); override;                 {!!.16}
  end;

  TOvcTCCustomBitMap = class(TOvcTCBaseBitMap)
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

  TOvcTCBitMap = class(TOvcTCCustomBitMap)
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
procedure TOvcTCBaseBitMap.tcPaint(TableCanvas : TCanvas;
                             const CellRect    : TRect;
                                   RowNum      : TRowNum;
                                   ColNum      : TColNum;
                             const CellAttr    : TOvcCellAttributes;
                                   Data        : pointer);
  type
    LH = record cX, cY : word; end;
  var
    BMInfo            : PCellBitMapInfo absolute Data;
    Wd, Ht            : integer;
    DisplayWd         : integer;
    DisplayHt         : integer;
    CellWidth         : integer;
    CellHeight        : integer;
    SrcRect, DestRect : TRect;
    TransparentColor  : TColor;
    CellAdj           : TOvcTblAdjust;
  begin
    {blank out the cell (also sets the brush color)}
    inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, Data);
    {if there's no data, the index to the sub-bitmap is zero or
     the cell is invisible anyway, just exit}
    if (Data = nil) or
       (BMInfo^.Index = -1) or
       (CellAttr.caAccess = otxInvisible) then
      Exit;
    {make a note of the adjustment, and calc the cell width and height}
    CellAdj := CellAttr.caAdjust;
    CellWidth := CellRect.Right - CellRect.Left;
    CellHeight := CellRect.Bottom - CellRect.Top;
    {calculate data about the bitmap, including the source rectangle}
    with BMInfo^ do
      begin
        Wd := BM.Width;
        if (Count <= 1) then
          Index := 0
        else
          begin
            Wd := Wd div Count;
            if (Index >= Count) then
              Index := 0;
          end;
        Ht := BM.Height;
        DisplayWd := MinI(Wd, (CellWidth - 2*Margin));
        DisplayHt := MinI(Ht, (CellHeight - 2*Margin));
        with SrcRect do
          begin
            Left := Index * Wd;
            Right := Left + DisplayWd;
            Top := 0;
            Bottom := Top + DisplayHt;
          end;
        TransparentColor := BM.Canvas.Pixels[SrcRect.Left, Ht-1]
      end;
    {calculate the destination rectangle}
    with DestRect do
      begin
        case CellAdj of
          otaTopLeft, otaCenterLeft, otaBottomLeft :
             Left := Margin;
          otaTopRight, otaCenterRight, otaBottomRight :
             Left := (CellWidth - DisplayWd - Margin);
        else
          Left := (CellWidth - DisplayWd) div 2;
        end;{case}
        inc(Left, CellRect.Left);
        case CellAdj of
          otaTopLeft, otaTopCenter, otaTopRight :
             Top := Margin;
          otaBottomLeft, otaBottomCenter, otaBottomRight :
             Top := (CellHeight - DisplayHt - Margin);
        else
          Top := (CellHeight - DisplayHt) div 2;
        end;{case}
        inc(Top, CellRect.Top);
        Right := Left + DisplayWd;
        Bottom := Top + DisplayHt;
      end;
    {brush copy the bitmap onto the table}
    TableCanvas.BrushCopy(DestRect, BMInfo^.BM, SrcRect, TransparentColor);
  end;

{!!.16}
function  TOvcTCBaseBitMap.EditHandle : THandle;
begin
  {stub out abstract method so BCB doesn't see this as an abstract class}
  Result := 0;
end;

{!!.16}
procedure TOvcTCBaseBitMap.EditHide;
begin
  {stub out abstract method so BCB doesn't see this as an abstract class}
end;

{!!.16}
procedure TOvcTCBaseBitMap.EditMove(CellRect : TRect);
begin
  {stub out abstract method so BCB doesn't see this as an abstract class}
end;

{!!.16}
procedure TOvcTCBaseBitMap.SaveEditedData(Data : pointer);
begin
  {stub out abstract method so BCB doesn't see this as an abstract class}
end;

{!!.16}
procedure TOvcTCBaseBitMap.StartEditing(RowNum : TRowNum; ColNum : TColNum;
                        CellRect : TRect;
                  const CellAttr : TOvcCellAttributes;
                        CellStyle: TOvcTblEditorStyle;
                        Data : pointer);
begin
  {stub out abstract method so BCB doesn't see this as an abstract class}
end;

{!!.16}
procedure TOvcTCBaseBitMap.StopEditing(SaveValue : boolean;
                      Data : pointer);
begin
  {stub out abstract method so BCB doesn't see this as an abstract class}
end;


{====================================================================}

{===TOvcTCCustomBitMap===============================================}
procedure TOvcTCCustomBitMap.tcPaint(TableCanvas : TCanvas;
                               const CellRect    : TRect;
                                     RowNum      : TRowNum;
                                     ColNum      : TColNum;
                               const CellAttr    : TOvcCellAttributes;
                                     Data        : pointer);
  var
    BitMap : TBitmap absolute Data;
    BMInfo : TCellBitMapInfo;
  begin
    {if there's no bitmap, just let our ancestor deal with it}
    if (Data = nil) then
      inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, nil)
    {otherwise set up a bitmap info record, and let the ancestor paint it}
    else
      begin
        with BMInfo do
          begin
            BM := BitMap;
            Count := 1;
            ActiveCount := 1;
            Index := 0;
          end;
        inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, @BMInfo);
      end;
  end;
{--------}
procedure TOvcTCCustomBitMap.ResolveAttributes(RowNum : TRowNum; ColNum : TColNum;
                                           var CellAttr : TOvcCellAttributes);
  begin
    inherited ResolveAttributes(RowNum, ColNum, CellAttr);
    case CellAttr.caAccess of
      otxDefault, otxNormal : CellAttr.caAccess := otxReadOnly;
    end;{case}
  end;
{====================================================================}


end.
